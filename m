Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA2616828
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiKBQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiKBQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:13:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E492D76B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:11:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C52C222D61;
        Wed,  2 Nov 2022 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667405513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/a40auuQ0L/AJHav0351LK7cNnLgaQeg9TE6eFJvOk=;
        b=d8bCk+71C3xkLcEx92hV4+fPX8PwQwV4ZNBEE/KopsBFkoqxVj0Cl68+2Xh8Mqnjg1NUdi
        KUupgZ8txk+a/5GyzatujSbtyyJ1dDabwNQKiXWpfs+JeqYmFr4iWz540QK3qQqMJeeWbE
        tRG6Y7bHU14OBS6iCjEUWhLCGTCEMVA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A70F6139D3;
        Wed,  2 Nov 2022 16:11:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3mGrJ8mWYmNTGgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 16:11:53 +0000
Date:   Wed, 2 Nov 2022 17:11:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zach O'Keefe <zokeefe@google.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2KWyAx50rUPGGXz@dhcp22.suse.cz>
References: <20221031183122.470962-1-shy828301@gmail.com>
 <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
 <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <Y2IY4odZJHCwC16t@dhcp22.suse.cz>
 <CAHbLzkq0C_EDpivHK5OdCfZPVt814P5r92pnPoNfW=CiXyCeww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq0C_EDpivHK5OdCfZPVt814P5r92pnPoNfW=CiXyCeww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 08:58:09, Yang Shi wrote:
> On Wed, Nov 2, 2022 at 12:14 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 01-11-22 10:12:49, Yang Shi wrote:
> > > On Tue, Nov 1, 2022 at 12:54 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 31-10-22 17:05:06, Zach O'Keefe wrote:
> > > > > On Mon, Oct 31, 2022 at 3:08 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Mon 31-10-22 11:31:22, Yang Shi wrote:
> > > > > > > Syzbot reported the below splat:
> > > > > > >
> > > > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > > > > Modules linked in:
> > > > > > > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > > > > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > > > > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > > > > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > > > > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > > > > > > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > > > > > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > > > > > > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > > > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > > > > > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > > > > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > Call Trace:
> > > > > > >  <TASK>
> > > > > > >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> > > > > >
> > > > > > This is quite weird, isn't it? alloc_charge_hpage is selecting the most
> > > > > > busy node (as per collapse_control). How come this can be an offline
> > > > > > node? Is a parallel memory hotplug happening?
> > > > >
> > > > > TBH -- I did not look closely at the syzbot reproducer (let alone
> > > > > attempt to run it) and assumed this was the case. Taking a quick look,
> > > > > at least memory hot remove is enabled:
> > > > >
> > > > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > > > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > > > > CONFIG_MEMORY_HOTPLUG=y
> > > > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > > > > CONFIG_MEMORY_HOTREMOVE=y
> > > > >
> > > > > But looking at the C reproducer, I don't immediately see anywhere
> > > > > where we offline nodes. I'll try to run this tomorrow to make sure I'm
> > > > > not missing something real here.
> > > >
> > > > Looking slightly closer at hpage_collapse_scan_file I think that it is
> > > > possible that xas_for_each simply doesn't find any entries in the page
> > > > cache and with khugepaged_max_ptes_none == HPAGE_PMD_NR we can fall back
> > > > to collapse_file even without any real entries.
> > >
> > > The khugepaged_max_ptes_none can't be HPAGE_PMD_NR, it must be <=
> > > (HPAGE_PMD_NR - 1), but MADV_COLLAPSE does ignore it.
> >
> > OK, I see.
> >
> > > But a closer look at the code about how to pick up the preferred node,
> > > there seems to be a corner case for MADV_COLLAPSE.
> > >
> > > The code tried to do some balance if several nodes have the same hit
> > > record. Basically it does conceptually:
> > >     * If the target_node <= last_target_node, then iterate from
> > > last_target_node + 1 to MAX_NUMNODES (1024 on default config)
> > >     * If the max_value == node_load[nid], then target_node = nid
> >
> > Correct
> >
> > > So assuming the system has 2 nodes, the target_node is 0 and the
> > > last_target_node is 1, if MADV_COLLAPSE path is hit, then it may
> > > return 2 for target_node, but it is actually not existing (offline),
> > > so the warn is triggered.
> >
> > How can node_load[2] > 0 (IIUC max_value > 0 here) if the node is
> > offline (other than a race with hotplug)?
> 
> The max_value may be 0 if there is no entry in page cache for that range IIUC.

Ohh, I am blind. I believe you have already mentioned that but I must
have overlooked it. I have only now noticed cc->is_khugepaged part of the
check. Supposedly, the primary idea here being that madvise calls should
de-facto create a brand new THP in that case. A creative way to call
collapsing but I can see some point in that.

See my other reply on how to deal with that in a more reasonable (IMHO)
way.

-- 
Michal Hocko
SUSE Labs
