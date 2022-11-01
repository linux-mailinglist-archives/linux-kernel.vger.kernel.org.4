Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8E614216
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKAAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKAAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:05:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A615801
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:05:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l8so7818897ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txnZSp/Uxinz0uPSRhzfeynMSK2VfD19NZd64peYgz0=;
        b=tI7lDymutDjdtRCI5Rn9I/xFciMbyhtaLAFtkTb3VycWNMjxpOumJWdgtXuSj/pR7E
         /Nuo5dHW2C3ADQ0ZPjtGXnWLeFut5M91na+RD08T+euxdTiB/ssg9ORpdbix7eRXbDZ+
         Bh26lOBnaODYwXY2hPyClFps95GocCM1urBaEBusq3F2XP3Y+/O4YoM+bBFjL//4ZJVv
         UYevgeHG/D2QC+04e+vHLiEWo6jdZa8FL2ZXulPjtdoLhKx+yKPlb1M06mh5z3w6Ein2
         j36g/wzsvZqI3a5Ic0wX5aA5dVsJxBCiXV6z2CYlTOawhos3InQ0GrHPRWw6L8HtCKYT
         br+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txnZSp/Uxinz0uPSRhzfeynMSK2VfD19NZd64peYgz0=;
        b=zkPnKpdsVIDuqOAN+lq5yNnNWSOSySTx/h8kFiFh+wMnllCef/ZGOxn2U+ucU9FjkO
         jbsFilAPeXvwEPtH+5iKMs8FPLKSToAsN9azY7tzgwBFVz1Cg6fRPVqbvmmCZqsFKC+P
         aaYwPel9nghQzSeKm71yp95jvhuuX1u1XScMAF8jDo+oWSxIw2MjJRemOb6PP8fg2p6k
         I8wDRwl3Ma7jFLguMJkIHqz8hZfF4qA4hcfAwylCywB4Aukmd8lUWx7qToGL52gyWgwD
         5TvU3siGraUju6xevBtjk17Zd18bPPPRGsgDUtkatYzY/Vsi0XZ/PUr2B41puUTPd+O5
         q1Sg==
X-Gm-Message-State: ACrzQf3WWPgw/HlRHViQCOWuUWWJYalJc6jEpaSDuW6W/LvNQGhAmNWz
        mmn6socXCuNdHYsjEz2mwuuKgpyprLiKhnR/ia5BxQ==
X-Google-Smtp-Source: AMsMyM6B8h37i9zOCQcpvyiVXU6FtpmReXFQC3bzx+UzgCwxtwe0VqgkMDRUm0dDBOYuCiBtfoNwjxZVLAv6x00Ah78=
X-Received: by 2002:a2e:99d0:0:b0:277:7c4:6c49 with SMTP id
 l16-20020a2e99d0000000b0027707c46c49mr168145ljj.276.1667261142954; Mon, 31
 Oct 2022 17:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
In-Reply-To: <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 31 Oct 2022 17:05:06 -0700
Message-ID: <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Mon, Oct 31, 2022 at 3:08 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 31-10-22 11:31:22, Yang Shi wrote:
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
>
> This is quite weird, isn't it? alloc_charge_hpage is selecting the most
> busy node (as per collapse_control). How come this can be an offline
> node? Is a parallel memory hotplug happening?

TBH -- I did not look closely at the syzbot reproducer (let alone
attempt to run it) and assumed this was the case. Taking a quick look,
at least memory hot remove is enabled:

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y

But looking at the C reproducer, I don't immediately see anywhere
where we offline nodes. I'll try to run this tomorrow to make sure I'm
not missing something real here.

Thanks,
Zach


> [...]
>
> > It is because khugepaged allocates pages with __GFP_THISNODE, but the
> > preferred node is offlined.  The warning was even stronger before commit
> > 8addc2d00fe17 ("mm: do not warn on offline nodes unless the specific node
> > is explicitly requested").  The commit softened the warning for
> > __GFP_THISNODE.
> >
> > But this warning seems not quite useful because:
> >   * There is no guarantee the node is online for __GFP_THISNODE context
> >     for all the callsites.
>
> The original idea IIRC was to catch a buggy code which mishandled node
> assignment. But this looks like a perfectly valid code. There is no
> synchronization with the memory hotplug so it is possible that memory
> gets offline during a longer taking scanning.
>
> I do agree that the warning is not really helpful in this case. It is
> actually even harmful for those running in panic-on-warn mode.
>
> >   * Kernel just fails the allocation regardless the warning, and it looks
> >     all callsites handle the allocation failure gracefully.
> >
> > So, removing the warning seems like the good move.
> >
> > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > Cc: Zach O'Keefe <zokeefe@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
>
> Unless I am wrong in my above statement I would appreciate extending the
> changelog to describe the actual code is correct so the warning is
> harmful.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  include/linux/gfp.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index ef4aea3b356e..594d6dee5646 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -218,7 +218,6 @@ static inline struct page *
> >  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
> >  {
> >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > -     VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
> >
> >       return __alloc_pages(gfp_mask, order, nid, NULL);
> >  }
> > @@ -227,7 +226,6 @@ static inline
> >  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
> >  {
> >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > -     VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
> >
> >       return __folio_alloc(gfp, order, nid, NULL);
> >  }
> > --
> > 2.26.3
>
> --
> Michal Hocko
> SUSE Labs
