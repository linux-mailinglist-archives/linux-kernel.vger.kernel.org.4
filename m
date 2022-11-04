Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC261A254
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKDUj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:39:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0348B43AEE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:39:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 136so1469022pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ubWD15QGui1Wa+OmgQENt0j4CGmR5kcmrnu3O/AWxw=;
        b=AiDqJTksWmCSXHand7iTz5gSWzBE1+hCoz5DNMmzA8wGWGfjmolIkgIVYujOe9Ml3F
         PNal9SlNrs7hgDpPfGJ167ISE6OUxt+hibP07hB1Ve5km50trdSL2XTP+oKcsXgMrE9E
         OJrONY7YjCaWQMu6ILyk0XUrHUca5anmd5CD0HWtEIXYNJLq4hre9XyL+oVtxu0+/Nrg
         K/Gco9Hw2k6plt8y89eNFE2mbPZ6oHCKyCHo/q1DdAz8bPlEleZUojem4WIPDsVuHt7h
         J8/zVvP5RtudgYRve4s7MV8Ny+mDe2mbkoIg96suTnm2DuV9w++H1XpPOCuW7A9Lggne
         2l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ubWD15QGui1Wa+OmgQENt0j4CGmR5kcmrnu3O/AWxw=;
        b=g6ZOOSQe9RTKWS9Rkstfrz67vjrUgP5GInVnW+FdxbfpYQwTeRg7xhd+BUd/I27xBr
         yfyXfyU/RmR1Z8jj8oxQNV2th64GRVs1t/vchi5H0VZuUcHTtPX3XYLlsXNft0YATncV
         ABELL0nr3aGeHgetNSzHfFGQyGvhuuBQbd/WTv6ipxYL3nFlnCiZBeaoddIJZVBZxSNm
         Z+A/svqfAQ8g6HbDq2PQbabaY7Hy9ZwKRHiQ/wVXnkFn+TIVqu2MkHbIucnMFaSFNFfU
         hO8mvxwrzlW2slU8a9NqJERR2qq4AtdreNMRIiwpeY51Ab07Hy5fG92tZH43OR8m99U7
         s4OQ==
X-Gm-Message-State: ANoB5pkJEJAMyYOo8cvmGaemqh0BNeQ5/w9fbHHQ6MIhdBgmIoRhFLNn
        myaufgGT69O/HrZPN9n4KK6IdJny0a2PGPZT2wY=
X-Google-Smtp-Source: AA0mqf4skAdg/Kcp2MVFYEm2ehLCaCvdaynsAXCJFgPGWri0XYV15De2oFFdcjd6N1btPwZCdmPV+Do2vG9b1at7+wc=
X-Received: by 2002:a05:6a00:24c5:b0:56e:b06c:f97a with SMTP id
 d5-20020a056a0024c500b0056eb06cf97amr1585410pfv.57.1667594362412; Fri, 04 Nov
 2022 13:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221103213641.7296-1-shy828301@gmail.com> <Y2RViRKdDQw2cONa@google.com>
In-Reply-To: <Y2RViRKdDQw2cONa@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Nov 2022 13:39:09 -0700
Message-ID: <CAHbLzkrd5S-6Pm2w93ZX2dSsgb6f5rbJY_ObN1BhMg+pZQiesQ@mail.gmail.com>
Subject: Re: [v2 PATCH 1/2] mm: khugepaged: allow page allocation fallback to
 eligible nodes
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     mhocko@suse.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 4:58 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Nov 03 14:36, Yang Shi wrote:
> > Syzbot reported the below splat:
> >
> > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > Modules linked in:
> > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> >  hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
> >  madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
> >  madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
> >  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
> >  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
> >  do_madvise mm/madvise.c:1432 [inline]
> >  __do_sys_madvise mm/madvise.c:1432 [inline]
> >  __se_sys_madvise mm/madvise.c:1430 [inline]
> >  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f6b48a4eef9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
> > RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
> > RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
> > R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
> >  </TASK>
> >
> > The khugepaged code would pick up the node with the most hit as the preferred
> > node, and also tries to do some balance if several nodes have the same
> > hit record.  Basically it does conceptually:
> >     * If the target_node <= last_target_node, then iterate from
> > last_target_node + 1 to MAX_NUMNODES (1024 on default config)
> >     * If the max_value == node_load[nid], then target_node = nid
> >
> > But there is a corner case, paritucularly for MADV_COLLAPSE, that the
> > non-existing node may be returned as preferred node.
> >
> > Assuming the system has 2 nodes, the target_node is 0 and the
> > last_target_node is 1, if MADV_COLLAPSE path is hit, the max_value may
> > be 0, then it may return 2 for target_node, but it is actually not
> > existing (offline), so the warn is triggered.
> >
> > The node balance was introduced by commit 9f1b868a13ac ("mm: thp:
> > khugepaged: add policy for finding target node") to satisfy
> > "numactl --interleave=all".  But interleaving is a mere hint rather than
> > something that has hard requirements.
> >
> > So use nodemask to record the nodes which have the same hit record, the
> > hugepage allocation could fallback to those nodes.  And remove
> > __GFP_THISNODE since it does disallow fallback.  And if nodemask is
> > empty (no node is set), it means there is one single node has the most
> > hist record, the nodemask approach actually behaves like __GFP_THISNODE.
> >
> > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Reviewed-by: Zach O'Keefe <zokeefe@googel.com>

Thanks.

>
> > ---
> >  mm/khugepaged.c | 32 ++++++++++++++------------------
> >  1 file changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ea0d186bc9d4..572ce7dbf4b0 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -97,8 +97,8 @@ struct collapse_control {
> >       /* Num pages scanned per node */
> >       u32 node_load[MAX_NUMNODES];
> >
> > -     /* Last target selected in hpage_collapse_find_target_node() */
> > -     int last_target_node;
> > +     /* nodemask for allocation fallback */
> > +     nodemask_t alloc_nmask;
> >  };
> >
> >  /**
> > @@ -734,7 +734,6 @@ static void khugepaged_alloc_sleep(void)
> >
> >  struct collapse_control khugepaged_collapse_control = {
> >       .is_khugepaged = true,
> > -     .last_target_node = NUMA_NO_NODE,
> >  };
> >
> >  static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
> > @@ -783,16 +782,11 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
> >                       target_node = nid;
> >               }
> >
> > -     /* do some balance if several nodes have the same hit record */
> > -     if (target_node <= cc->last_target_node)
> > -             for (nid = cc->last_target_node + 1; nid < MAX_NUMNODES;
> > -                  nid++)
> > -                     if (max_value == cc->node_load[nid]) {
> > -                             target_node = nid;
> > -                             break;
> > -                     }
> > +     for_each_online_node(nid) {
> > +             if (max_value == cc->node_load[nid])
> > +                     node_set(nid, cc->alloc_nmask);
> > +     }
> >
> > -     cc->last_target_node = target_node;
> >       return target_node;
> >  }
> >  #else
> > @@ -802,9 +796,10 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
> >  }
> >  #endif
> >
> > -static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node)
> > +static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node,
> > +                                   nodemask_t *nmask)
> >  {
> > -     *hpage = __alloc_pages_node(node, gfp, HPAGE_PMD_ORDER);
> > +     *hpage = __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
> >       if (unlikely(!*hpage)) {
> >               count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
> >               return false;
> > @@ -955,12 +950,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
> >  static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
> >                             struct collapse_control *cc)
> >  {
> > -     /* Only allocate from the target node */
> >       gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
> > -                  GFP_TRANSHUGE) | __GFP_THISNODE;
> > +                  GFP_TRANSHUGE);
> >       int node = hpage_collapse_find_target_node(cc);
> >
> > -     if (!hpage_collapse_alloc_page(hpage, gfp, node))
> > +     if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
> >               return SCAN_ALLOC_HUGE_PAGE_FAIL;
> >       if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
> >               return SCAN_CGROUP_CHARGE_FAIL;
> > @@ -1144,6 +1138,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> >               goto out;
> >
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> > +     nodes_clear(cc->alloc_nmask);
> >       pte = pte_offset_map_lock(mm, pmd, address, &ptl);
> >       for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
> >            _pte++, _address += PAGE_SIZE) {
> > @@ -2078,6 +2073,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> >       present = 0;
> >       swap = 0;
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> > +     nodes_clear(cc->alloc_nmask);
> >       rcu_read_lock();
> >       xas_for_each(&xas, page, start + HPAGE_PMD_NR - 1) {
> >               if (xas_retry(&xas, page))
> > @@ -2581,7 +2577,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> >       if (!cc)
> >               return -ENOMEM;
> >       cc->is_khugepaged = false;
> > -     cc->last_target_node = NUMA_NO_NODE;
> >
> >       mmgrab(mm);
> >       lru_add_drain_all();
> > @@ -2607,6 +2602,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> >               }
> >               mmap_assert_locked(mm);
> >               memset(cc->node_load, 0, sizeof(cc->node_load));
> > +             nodes_clear(cc->alloc_nmask);
> >               if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
> >                       struct file *file = get_file(vma->vm_file);
> >                       pgoff_t pgoff = linear_page_index(vma, addr);
> > --
> > 2.26.3
> >
>
> Thanks for the patch, Yang! Looks good. khugepaged selftest is good too.

Thanks for running the test. I ran it too.
