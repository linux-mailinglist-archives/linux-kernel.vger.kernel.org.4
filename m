Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520DF6FC905
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjEIOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjEIOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:30:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B910C170B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:30:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F16D3FEC;
        Tue,  9 May 2023 07:31:12 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1C73F663;
        Tue,  9 May 2023 07:30:27 -0700 (PDT)
Date:   Tue, 9 May 2023 15:30:24 +0100
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
Message-ID: <ZFpZAGeEXomG/eKS@FVFF77S0Q05N.cambridge.arm.com>
References: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
 <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
 <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
 <9d976db8-b800-ad84-9c67-0afb942934d9@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d976db8-b800-ad84-9c67-0afb942934d9@bytedance.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 10:51:23AM +0800, Gang Li wrote:
> Hi,
> 
> On 2023/4/28 17:27, Mark Rutland wrote:> The architecture allows a CPU to
> allocate TLB entries at any time for any
> > reason, for any valid translation table entries reachable from the root
> > in TTBR{0,1}_ELx. That can be due to speculation, prefetching, and/or other
> > reasons.
> 
> TLB will be allocated due to prefetching or branch prediction. Will it
> be invalidated when the prediction fails?

No; once allocated they're allowed to remain until explicitly invalidated.

See below for more detail.

> > Due to that, it doesn't matter whether or not a CPU explicitly accesses a
> > memory location -- TLB entries can be allocated regardless.
> > Consequently, the
> > spinlock doesn't make any difference.
> 
> And is there any kind of ARM manual or guide that explains these details to
> help us programming better?

There's no guide that I am aware of, but this is described in the ARM ARM. The
current relase (ARM DDI 0487J.a) can be found at:

  https://developer.arm.com/documentation/ddi0487/ja

... and in future, the latest version should be available at:

  https://developer.arm.com/documentation/ddi0487/latest

In the latest release (ARM DDI 0487J.a) relevant information can be found in
section D8 "The AArch64 Virtual Memory System Architecture", with key
information in D8.13 "Translation Lookaside Buffers" and D8.14 "TLB
maintenance".

For example, early in D8.13 we have the rule:

| R_SQBCS
|   
|   When address translation is enabled, a translation table entry for an
|   in-context translation regime that does not cause a Translation fault, an
|   Address size fault, or an Access flag fault is permitted to be cached in a
|   TLB or intermediate TLB caching structure as the result of an explicit or
|   speculative access.

Thanks,
Mark.
