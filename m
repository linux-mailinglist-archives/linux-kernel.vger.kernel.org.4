Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3F613FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJaVQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJaVQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:16:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F2114D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:16:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp15so21112295lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lwiXVdVzRoAw8WA6tfB2QdoVnZldACbyQziD2vvO+50=;
        b=qb+GQpc2eYEZhgZE+jSRTCbEk4uwVcutwJlaLUc6InUMzb9Yxg+/cb1ht0vRNWJXAc
         cUf8j3bsvuWyr6zeWPPQdY4r5fsNRXU+XjOg9Fil9+QdV+Shu5D7m1b4KHrYUXJQaGo6
         QOplEulQKcKKA+MYfYB3Etjlf5znB78K4Ly8ZUZYtOsSEgwhzNBDo11fDgMvhcIe4nfo
         HMtey6DjNI6+lDmaZA++bJIzqU6GKvjxvoN1gxzUkozx97e2zOiaN2OGPKZxpMmbs9J8
         ABKy96BlGYojzd/zcL+ZqL43igyMdT1aR6nB3bJrz7gGWECIDHamNCP1alb2rhDbdEaV
         fXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwiXVdVzRoAw8WA6tfB2QdoVnZldACbyQziD2vvO+50=;
        b=qNnl09xnGVO2202Wya9tg4vanu0PQDW0NE3YPsrJPf+5qlZ+VdiXEhlUmxI6sVCANx
         xvYkWtvmoBuogbI0SiqFHoYO3HYNzUtNKTafxeRWhTKuGT33Lq1qBwZxyV2TOttKqKSI
         NkC/Q8OQVr280LU2iwh+njf+bOzXrfcKDmibdkHND3c82Ji7ehB9txBl8SdVLHf/0lbo
         Cp/LK2h+hQl2SjLFF5bKOWS3nEKtkBw/lo/1VZeksnRMA87mddQyr5pRc5dM8yIHAbfM
         AgoAeGM3GR1FhEoNQM53VxGwUubFE3bwp7eLlZDFjGa7afukFZp95mtU6NeGTJXzxgB9
         /KkQ==
X-Gm-Message-State: ACrzQf1SsU8UeuOcrIZWbfkVfONVLOEzm0fqqakxjvJFxYg8DAi/A/g4
        zCRgsIW1/oEmtqZJrIojaupX6lREj1ZIOw1fiWN2jQ/MmY2CIQ==
X-Google-Smtp-Source: AMsMyM7lLWPAKizpwKEGS39c93s7G6i0ifJ3lFjcgf724M2s6gTsXdxxZUDEOQCxEd3UBKn3CNS95N+xASSudn0FydE=
X-Received: by 2002:a05:6512:224e:b0:4a2:5060:55ef with SMTP id
 i14-20020a056512224e00b004a2506055efmr6049228lfu.412.1667251011572; Mon, 31
 Oct 2022 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com>
In-Reply-To: <20221031183122.470962-1-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 31 Oct 2022 14:16:14 -0700
Message-ID: <CAAa6QmSxChkCyF5fKSgxEQfOGzFV4A0zqsHUv3f-b9RNUUzgKw@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Yang Shi <shy828301@gmail.com>
Cc:     mhocko@suse.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:31 AM Yang Shi <shy828301@gmail.com> wrote:
>
> Syzbot reported the below splat:
>
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Modules linked in:
> CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
>  hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
>  madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
>  madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
>  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
>  do_madvise mm/madvise.c:1432 [inline]
>  __do_sys_madvise mm/madvise.c:1432 [inline]
>  __se_sys_madvise mm/madvise.c:1430 [inline]
>  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6b48a4eef9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
> RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
> RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
> R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
>  </TASK>
>
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node
> include/linux/gfp.h:221 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221
> hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221
> alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Modules linked in:
> CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted
> 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 10/11/2022
> RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc
> ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9
> 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
>  hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
>  madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
>  madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
>  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
>  do_madvise mm/madvise.c:1432 [inline]
>  __do_sys_madvise mm/madvise.c:1432 [inline]
>  __se_sys_madvise mm/madvise.c:1430 [inline]
>  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6b48a4eef9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
> RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
> RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
> R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
>  </TASK>
>
> It is because khugepaged allocates pages with __GFP_THISNODE, but the
> preferred node is offlined.  The warning was even stronger before commit
> 8addc2d00fe17 ("mm: do not warn on offline nodes unless the specific node
> is explicitly requested").  The commit softened the warning for
> __GFP_THISNODE.
>
> But this warning seems not quite useful because:
>   * There is no guarantee the node is online for __GFP_THISNODE context
>     for all the callsites.
>   * Kernel just fails the allocation regardless the warning, and it looks
>     all callsites handle the allocation failure gracefully.
>
> So, removing the warning seems like the good move.
>
> Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Michal Hocko <mhocko@suse.com>

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

> ---
>  include/linux/gfp.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ef4aea3b356e..594d6dee5646 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -218,7 +218,6 @@ static inline struct page *
>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>  {
>         VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -       VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
>
>         return __alloc_pages(gfp_mask, order, nid, NULL);
>  }
> @@ -227,7 +226,6 @@ static inline
>  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
>  {
>         VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -       VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
>
>         return __folio_alloc(gfp, order, nid, NULL);
>  }
> --
> 2.26.3
>
