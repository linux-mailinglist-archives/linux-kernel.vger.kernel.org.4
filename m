Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D676193A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiKDJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKDJfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:35:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B429C83
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:35:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D98E218B2;
        Fri,  4 Nov 2022 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667554521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ydW/Ip1283kWWE39XBxi12qzqyAARAOIO5+UUf/EbQ=;
        b=Kz6kA/X+vxvzArLlD5xVTjEDgZ5xNUlssDDeNTVM6+UOkqphOHp8UnNWgSLDXS4XfmydOy
        qCoNI9tjLjPvmS8kVAvq6+CWxxS4g4BhLMSy0HSGDbdFibMDi1WkI3JoMrJfAjmb9J9BXz
        v97VWtqjZkRzssYkLEkmQBWQwBlk0B4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DF6F1346F;
        Fri,  4 Nov 2022 09:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fgv8BNncZGMEBwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Nov 2022 09:35:21 +0000
Date:   Fri, 4 Nov 2022 10:35:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] mm: don't warn if the node is offlined
Message-ID: <Y2Tc2JNeFWXmZbQ1@dhcp22.suse.cz>
References: <20221103213641.7296-1-shy828301@gmail.com>
 <20221103213641.7296-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103213641.7296-2-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-11-22 14:36:41, Yang Shi wrote:
> Syzbot reported the below splat:
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
> preferred node is offlined.  The previous patch fixed the khugepaged

I would go and call it out s@offlined@bogus@

> code to avoid allocating page from non-existing node.  But it is still
> racy against memory hotremove.  There is no synchronization with the
> memory hotplug so it is possible that memory gets offline during a
> longer taking scanning.
> 
> So this warning still seems not quite helpful because:
>   * There is no guarantee the node is online for __GFP_THISNODE context
>     for all the callsites.
>   * Kernel just fails the allocation regardless the warning, and it looks
>     all callsites handle the allocation failure gracefully.
> 
> It is actually even harmful for those running in panic-on-warn mode.  So
> removing the warning seems like a good move.

And I would rephrased this as well to:

So while the warning has helped to identify a buggy code it is not safe
in general and this warning could panic the system with panic-on-warn 
configuration which tends to be used surprisingly often.

> Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Btw. while you are at it. Considering the warning has helped to identify
a buggy code, do you think it would make sense to chage it to
---
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ef4aea3b356e..308daafc4871 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -227,7 +227,10 @@ static inline
 struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
+	if((gfp & __GFP_THISNODE) && !node_online(nid)) {
+		pr_warn("%pGg allocation from offline node %d\n", &gfp, nid);
+		dump_stack();
+	}
 
 	return __folio_alloc(gfp, order, nid, NULL);
 }
-- 
Michal Hocko
SUSE Labs
