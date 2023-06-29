Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9086D742B34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF2R1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjF2R1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A903AAE;
        Thu, 29 Jun 2023 10:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D65D0615C4;
        Thu, 29 Jun 2023 17:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA6FC433C0;
        Thu, 29 Jun 2023 17:26:58 +0000 (UTC)
Date:   Thu, 29 Jun 2023 18:26:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        mark.rutland@arm.com, ryan.roberts@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, linux-doc@vger.kernel.org,
        corbet@lwn.net, peterz@infradead.org, arnd@arndb.de,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>, wangkefeng.wang@huawei.com,
        xhao@linux.alibaba.com, prime.zeng@hisilicon.com,
        Jonathan.Cameron@huawei.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RESEND PATCH v9 2/2] arm64: support batched/deferred tlb
 shootdown during page reclamation/migration
Message-ID: <ZJ2+37Q7v4odMmEd@arm.com>
References: <20230518065934.12877-1-yangyicong@huawei.com>
 <20230518065934.12877-3-yangyicong@huawei.com>
 <ZJ2x6DlmyA3kVh1n@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ2x6DlmyA3kVh1n@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:31:36PM +0100, Catalin Marinas wrote:
> On Thu, May 18, 2023 at 02:59:34PM +0800, Yicong Yang wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> > 
> > on x86, batched and deferred tlb shootdown has lead to 90%
> > performance increase on tlb shootdown. on arm64, HW can do
> > tlb shootdown without software IPI. But sync tlbi is still
> > quite expensive.
> [...]
> >  .../features/vm/TLB/arch-support.txt          |  2 +-
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/arm64/include/asm/tlbbatch.h             | 12 ++++
> >  arch/arm64/include/asm/tlbflush.h             | 33 ++++++++-
> >  arch/arm64/mm/flush.c                         | 69 +++++++++++++++++++
> >  arch/x86/include/asm/tlbflush.h               |  5 +-
> >  include/linux/mm_types_task.h                 |  4 +-
> >  mm/rmap.c                                     | 12 ++--
> 
> First of all, this patch needs to be split in some preparatory patches
> introducing/renaming functions with no functional change for x86. Once
> done, you can add the arm64-only changes.
> 
> Now, on the implementation, I had some comments on v7 but we didn't get
> to a conclusion and the thread eventually died:
> 
> https://lore.kernel.org/linux-mm/Y7cToj5mWd1ZbMyQ@arm.com/
> 
> I know I said a command line argument is better than Kconfig or some
> random number of CPUs heuristics but it would be even better if we don't
> bother with any, just make this always on. Barry had some comments
> around mprotect() being racy and that's why we have
> flush_tlb_batched_pending() but I don't think it's needed (or, for
> arm64, it can be a DSB since this patch issues the TLBIs but without the
> DVM Sync). So we need to clarify this (see Barry's last email on the
> above thread) and before attempting new versions of this patchset. With
> flush_tlb_batched_pending() removed (or DSB), I have a suspicion such
> implementation would be faster on any SoC irrespective of the number of
> CPUs.

I think I got the need for flush_tlb_batched_pending(). If
try_to_unmap() marks the pte !present and we have a pending TLBI,
change_pte_range() will skip the TLB maintenance altogether since it did
not change the pte. So we could be left with stale TLB entries after
mprotect() before TTU does the batch flushing.

We can have an arch-specific flush_tlb_batched_pending() that can be a
DSB only on arm64 and a full mm flush on x86.

-- 
Catalin
