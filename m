Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09533662C7F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjAIRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjAIRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:19:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492C26D3;
        Mon,  9 Jan 2023 09:19:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F2E2B80E77;
        Mon,  9 Jan 2023 17:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167BBC433F0;
        Mon,  9 Jan 2023 17:19:02 +0000 (UTC)
Date:   Mon, 9 Jan 2023 17:19:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, will@kernel.org, anshuman.khandual@arm.com,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, punit.agrawal@bytedance.com,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        yangyicong@hisilicon.com, huzhanyuan@oppo.com, lipeifeng@oppo.com,
        zhangshiming@oppo.com, guojian@oppo.com, realmz6@gmail.com,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, wangkefeng.wang@huawei.com,
        xhao@linux.alibaba.com, prime.zeng@hisilicon.com,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v7 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
Message-ID: <Y7xMhPTAwcUT4O6b@arm.com>
References: <20221117082648.47526-1-yangyicong@huawei.com>
 <20221117082648.47526-3-yangyicong@huawei.com>
 <Y7cToj5mWd1ZbMyQ@arm.com>
 <CAGsJ_4yC0i6MYwvosRSrdQ1iT7n88ypmK3aOQJkuusqNKtddtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yC0i6MYwvosRSrdQ1iT7n88ypmK3aOQJkuusqNKtddtg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 06:48:41PM +0800, Barry Song wrote:
> On Fri, Jan 6, 2023 at 2:15 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Nov 17, 2022 at 04:26:48PM +0800, Yicong Yang wrote:
> > > It is tested on 4,8,128 CPU platforms and shows to be beneficial on
> > > large systems but may not have improvement on small systems like on
> > > a 4 CPU platform. So make ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH depends
> > > on CONFIG_EXPERT for this stage and make this disabled on systems
> > > with less than 8 CPUs. User can modify this threshold according to
> > > their own platforms by CONFIG_NR_CPUS_FOR_BATCHED_TLB.
> >
> > What's the overhead of such batching on systems with 4 or fewer CPUs? If
> > it isn't noticeable, I'd rather have it always on than some number
> > chosen on whichever SoC you tested.
> 
> On the one hand, tlb flush is cheap on a small system. so batching tlb flush
> helps very minorly.

Yes, it probably won't help on small systems but I don't like config
options choosing the threshold, which may be different from system to
system even if they have the same number of CPUs. A run-time tunable
would be a better option.

> On the other hand, since we have batched the tlb flush, new PTEs might be
> invisible to others before the final broadcast is done and Ack-ed.

The new PTEs could indeed be invisible at the TLB level but not at the
memory (page table) level since this is done under the PTL IIUC.

> thus, there
> is a risk someone else might do mprotect or similar things  on those deferred
> pages which will ask for read-modify-write on those deferred PTEs.

And this should be fine, we have things like the PTL in place for the
actual memory access to the page table.

> in this
> case, mm will do an explicit flush by flush_tlb_batched_pending which is
> not required if tlb flush is not deferred.

I don't fully understand why it's needed, or at least why it would be
needed on arm64. At the end of an mprotect(), we have the final PTEs in
place and we just need to issue a TLBI for that range.
change_pte_range() for example has a tlb_flush_pte_range() if the PTE
was present and that won't be done lazily. If there are other TLBIs
pending for the same range, they'll be done later though likely
unnecessarily but still cheaper than issuing a flush_tlb_mm().

> void flush_tlb_batched_pending(struct mm_struct *mm)
> {
>        int batch = atomic_read(&mm->tlb_flush_batched);
>        int pending = batch & TLB_FLUSH_BATCH_PENDING_MASK;
>        int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;
> 
>        if (pending != flushed) {
>                flush_tlb_mm(mm);
>         /*
>          * If the new TLB flushing is pending during flushing, leave
>          * mm->tlb_flush_batched as is, to avoid losing flushing.
>         */
>       atomic_cmpxchg(&mm->tlb_flush_batched, batch,
>            pending | (pending << TLB_FLUSH_BATCH_FLUSHED_SHIFT));
>      }
> }

I guess this works on x86 better as it avoids the IPIs if this flush
already happened. But on arm64 we already issued the TLBI, we just
didn't wait for it to complete via a DSB.

> I believe Anshuman has contributed many points on this in those previous
> discussions.

Yeah, I should re-read the old threads.

-- 
Catalin
