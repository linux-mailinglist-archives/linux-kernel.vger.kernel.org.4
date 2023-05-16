Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E51704D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjEPLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjEPLwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:52:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 027425BBC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:51:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F6B32F4;
        Tue, 16 May 2023 04:52:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.59.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4B83F663;
        Tue, 16 May 2023 04:51:51 -0700 (PDT)
Date:   Tue, 16 May 2023 12:51:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
Message-ID: <ZGNuUjG9cnzSkXEN@FVFF77S0Q05N>
References: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
 <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
 <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
 <9d976db8-b800-ad84-9c67-0afb942934d9@bytedance.com>
 <ZFpZAGeEXomG/eKS@FVFF77S0Q05N.cambridge.arm.com>
 <fd8bda4b-32ee-d06d-af77-12e30e70c0bf@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd8bda4b-32ee-d06d-af77-12e30e70c0bf@bytedance.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:47:16PM +0800, Gang Li wrote:
> Hi,
> 
> On 2023/5/9 22:30, Mark Rutland wrote:
> > For example, early in D8.13 we have the rule:
> > 
> > | R_SQBCS
> > |
> > |   When address translation is enabled, a translation table entry for an
> > |   in-context translation regime that does not cause a Translation fault, an
> > |   Address size fault, or an Access flag fault is permitted to be cached in a
> > |   TLB or intermediate TLB caching structure as the result of an explicit or
> > |   speculative access.
> > 
> 
> Thanks a lot!
> 
> I looked up the x86 manual and found that the x86 TLB cache mechanism is
> similar to arm64 (but the x86 guys haven't reply me yet):
> 
> Intel® 64 and IA-32 Architectures Software Developer Manuals:
> > 4.10.2.3 Details of TLB Use
> > Subject to the limitations given in the previous paragraph, the
> > processor may cache a translation for any linear address, even if that
> > address is not used to access memory. For example, the processor may
> > cache translations required for prefetches and for accesses that result
> > from speculative execution that would never actually occur in the
> > executed code path.
> 
> Both architectures have similar TLB cache policies, why arm64 flush all
> and x86 flush local in ghes_map and ghes_unmap?
> 
> I think flush all may be unnecessary.
> 
> 1. Before accessing ghes data. Each CPU needs to call ghes_map, which
> will create the mapping and flush their own TLb to make sure the current
> CPU is using the latest mapping.
> 
> 2. And there is no need to flush all in ghes_unmap, because the ghes_map
> of other CPUs will flush their own TLBs before accessing the memory.

This is not sufficient. Regardless of whether CPUs *explicitly* access the VA
range, any CPU which can reach the live translation table entry is allowed to
fetch that and allocate it into a TLB at any time.

When a Break-Before-Make sequence isn't followed, the architecture permits a
number of resulting behaviours, including "amalgamation", where the TLB entries
are combined in some arbitrary IMPLEMENTATION DEFINED way. The architecture
isn't very clear here, but doesn't rule out two entries being combined such
that it generates an atbirary physical address and/or such tha the MMU thinks
the entry is from an intermediate walk. In either of those cases, the CPU might
speculative access device memory (which could change the state of the system,
or cause fatal SErrors), and/or allocate further junk into TLBs.

So per the architecture, broadcast maintenance is necessary on arm64.  The only
way to avoid it would be to have a local set of translation tables which are
not shared with other CPUs.

I suspect x86 might not have the same issue with amalgamation.

Thanks,
Mark.
