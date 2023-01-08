Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EE661497
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 11:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjAHKs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 05:48:55 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DC10B78;
        Sun,  8 Jan 2023 02:48:54 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id z190so2650323vka.4;
        Sun, 08 Jan 2023 02:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+ulyHY5t1vIQHRPkJRkZkMsVhYDzl0Wi1NRRdUXX9E=;
        b=khZsRl3/h6xFPtV+trGF8SoZlhUH7CXOkbNSVy0ph0vcxdY2POtEBg03zxNX8NOjKd
         tk0nBaNgQ7Qkcbndq/9sUu9/ASJ7jbK4uYDbK/bTz5OlmFXDU8glJgzuEEv6Z/s6NMfA
         mp4rpznbR52Td9JIJd+jemR2waWnWqaR5O+5xO3DbdqK/ncWuaOvXDjz4YwzrATW6+AT
         M8+n4X/t1ZgquFU/5c+wBFLYST09b1qKcf+ZPYUk9m3W2UOYcUJY3wtRak73CebxOF2s
         Srav0OegoVZNvk1eaPYqXHoJyRanQU2FIyrTJWyfZ4nP8ieu3yAmmAtAsqqtCCVbv2RA
         wVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+ulyHY5t1vIQHRPkJRkZkMsVhYDzl0Wi1NRRdUXX9E=;
        b=VJ+P9EjuVG/nOslkNTEPSl+LMHTxyVm/iF6uLpmHYxFbGuJKTjwC7TBLzBFYjBEQ6h
         7ZtEfKTKrVMm4YNm8RJAURgXRoWW4rTpb8z9f/eIt92bBxeFdm5Tbtk2NOYP0gKLrpRD
         7e53frsKVfzQxkgxbVhY0VTWWCwdAsT113nAsx1GmKt7CUXtJUxkW60GnD8JDKKGdVxj
         t+cel5EjhrNgJlfNk3lQVtAknhismRosmGMEeS1fxAU0j2BJwhyHq1HFLtRlANS8lagv
         14KaKAKdPndeR7q66UpPzXatELMAb+W1FWKJw4vz67tc5ofNHB3Nt814fQ8qm3REXm7U
         pIcg==
X-Gm-Message-State: AFqh2kqBqIKO8O9EWqR27mP2nS3s62cxaKToJdmqjcRmwN87yxl5HUnP
        e4qoUgxexJOraT4VZFRLpsY2c1+JQrGDKvf9SH0=
X-Google-Smtp-Source: AMrXdXsC9zjoSX3JUJXUNKpbqfCGbJ5sLgu3n0p9Rc2JNm9GFnGoyDe1ACeN5YOtUEET51RrQuI/o6A4avtvFhehWBM=
X-Received: by 2002:a1f:2e4e:0:b0:3d5:5ea6:ccb9 with SMTP id
 u75-20020a1f2e4e000000b003d55ea6ccb9mr6218898vku.7.1673174933379; Sun, 08 Jan
 2023 02:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20221117082648.47526-1-yangyicong@huawei.com> <20221117082648.47526-3-yangyicong@huawei.com>
 <Y7cToj5mWd1ZbMyQ@arm.com>
In-Reply-To: <Y7cToj5mWd1ZbMyQ@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 8 Jan 2023 18:48:41 +0800
Message-ID: <CAGsJ_4yC0i6MYwvosRSrdQ1iT7n88ypmK3aOQJkuusqNKtddtg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 2:15 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 17, 2022 at 04:26:48PM +0800, Yicong Yang wrote:
> > It is tested on 4,8,128 CPU platforms and shows to be beneficial on
> > large systems but may not have improvement on small systems like on
> > a 4 CPU platform. So make ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH depends
> > on CONFIG_EXPERT for this stage and make this disabled on systems
> > with less than 8 CPUs. User can modify this threshold according to
> > their own platforms by CONFIG_NR_CPUS_FOR_BATCHED_TLB.
>
> What's the overhead of such batching on systems with 4 or fewer CPUs? If
> it isn't noticeable, I'd rather have it always on than some number
> chosen on whichever SoC you tested.

On the one hand, tlb flush is cheap on a small system. so batching tlb flush
helps very minorly.

On the other hand, since we have batched the tlb flush, new PTEs might be
invisible to others before the final broadcast is done and Ack-ed. thus, there
is a risk someone else might do mprotect or similar things  on those deferred
pages which will ask for read-modify-write on those deferred PTEs. in this
case, mm will do an explicit flush by flush_tlb_batched_pending which is
not required if tlb flush is not deferred. the code is in:

static unsigned long change_pte_range(struct mmu_gather *tlb,
struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
unsigned long end, pgprot_t newprot, unsigned long cp_flags)
{
        ...

      pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);

      flush_tlb_batched_pending(vma->vm_mm);
      arch_enter_lazy_mmu_mode();
      do {
                oldpte = *pte;
                if (pte_present(oldpte)) {
                           pte_t ptent;
                ...
}

since we don't have the mechanism to record which pages should be
flushed in flush_tlb_batched_pending(), flush_tlb_batched_pending()
is flushing the whole process,

void flush_tlb_batched_pending(struct mm_struct *mm)
{
       int batch = atomic_read(&mm->tlb_flush_batched);
       int pending = batch & TLB_FLUSH_BATCH_PENDING_MASK;
       int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;

       if (pending != flushed) {
               flush_tlb_mm(mm);
        /*
         * If the new TLB flushing is pending during flushing, leave
         * mm->tlb_flush_batched as is, to avoid losing flushing.
        */
      atomic_cmpxchg(&mm->tlb_flush_batched, batch,
           pending | (pending << TLB_FLUSH_BATCH_FLUSHED_SHIFT));
     }
}

I guess mprotect things won't be that often for a running process especially
when the system has begun to reclaim its memory. it might be more often
only during the initialization of a process. And x86 has enabled this feature
for a long time, probably this concurrency doesn't matter too much.

but it is still case by case. That is why we have decided to be more
conservative
on globally enabling this feature and why it also depends on CONFIG_EXPERT.

I believe Anshuman has contributed many points on this in those previous
discussions.

Thanks
Barry
