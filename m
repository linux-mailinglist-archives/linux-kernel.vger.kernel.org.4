Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB3618AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKCVhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiKCVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:36:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8936222283
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:36:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u6so3133303plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zbt6qB/1c/+1gLU+/4sNCX68bCG+yMYvDrFsBMAeuQ=;
        b=VKk+6TpjGdp93LuLE9ePqP553eYxDkMkD6mL4qi4cgGqPnoDWlWLHQKgdmvQUZFlWk
         K8w76FC/2Pkgd1TEAnIynxANEvR9oAn4/ovdI4PoNqALUtUiBJKAeahV6658YhiGyotB
         a1ubPt1i52WQeB/MHa3jH3xgvBCbEmjWDTOSy2kAcmmT3LztfJK+82elHSj20QaS1Tr+
         U4w5chhei1gsNQpH0IMNXUkhu3HAsxi7CAPa1tBsyk9rSseSpqrjD8ZzmIzaSIDu24Dn
         bp8SLKgOfC0N2ISE5Pzwxa1Cc3o68Vc5zJ5XUywENHsL6TtB2/0bVZHeZ3Lluisa5MKQ
         Wgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zbt6qB/1c/+1gLU+/4sNCX68bCG+yMYvDrFsBMAeuQ=;
        b=v6EG+FkDILPyIa8Ld1psRQuof5AcyUKjr0Afg7bEeruUdeDU0bXTXb14wrpMY8xLIt
         5WWk1KR4ogO23EScxLDhFtOV9Z8QPrwIYgqzlGUYfIPkrTuC7bR+OZOq9pSsglDlIWOg
         CMXKAuyur+nbd6hNk9hRmDFnz8agTZsgufECVxUtV8m1MtgHorzfyZRHP8k1pLlBejmY
         BmR1jFgb1WOLYOqoidSyR96NUjKSjD7Ul6NaIExfJn9sKZEZGI4W+DJLfOsHxeZYqfgB
         MBF8/mnwRyvV+IogPsuvo6gqaCgdSz3rKKiWsJhdfIg0yxuxRwv/kB4/mG7+st+/0dBj
         iiMg==
X-Gm-Message-State: ACrzQf30VFs0glGlPVsmCmGvYCb7m9asHpXIhSqnUQyDcHsezklkTyvO
        gBN4WxtdG9rDogWVhtpMgM0=
X-Google-Smtp-Source: AMsMyM6obNd7XwlBaMgkd7D5GeCTeE9NuIwQ9tms0i0f1S3WmYpmSZVpypgi51Bh1rFN5jWR+n5Kug==
X-Received: by 2002:a17:90a:f0d1:b0:213:473e:6ff0 with SMTP id fa17-20020a17090af0d100b00213473e6ff0mr32774003pjb.87.1667511406761;
        Thu, 03 Nov 2022 14:36:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id f132-20020a62388a000000b0056da8c41bbasm1195438pfa.161.2022.11.03.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:36:46 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     zokeefe@google.com, mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/2] mm: don't warn if the node is offlined
Date:   Thu,  3 Nov 2022 14:36:41 -0700
Message-Id: <20221103213641.7296-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221103213641.7296-1-shy828301@gmail.com>
References: <20221103213641.7296-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported the below splat:

WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node
include/linux/gfp.h:221 [inline]
WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221
hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221
alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
Modules linked in:
CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted
6.1.0-rc1-syzkaller-00454-ga70385240892 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 10/11/2022
RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc
ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9
96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
 hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
 madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
 madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
 do_madvise mm/madvise.c:1432 [inline]
 __do_sys_madvise mm/madvise.c:1432 [inline]
 __se_sys_madvise mm/madvise.c:1430 [inline]
 __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6b48a4eef9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
 </TASK>

It is because khugepaged allocates pages with __GFP_THISNODE, but the
preferred node is offlined.  The previous patch fixed the khugepaged
code to avoid allocating page from non-existing node.  But it is still
racy against memory hotremove.  There is no synchronization with the
memory hotplug so it is possible that memory gets offline during a
longer taking scanning.

So this warning still seems not quite helpful because:
  * There is no guarantee the node is online for __GFP_THISNODE context
    for all the callsites.
  * Kernel just fails the allocation regardless the warning, and it looks
    all callsites handle the allocation failure gracefully.

It is actually even harmful for those running in panic-on-warn mode.  So
removing the warning seems like a good move.

Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
Signed-off-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v2: * Added patch 1/2.
    * Reworded the commit log per Michal.

 include/linux/gfp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ef4aea3b356e..594d6dee5646 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -218,7 +218,6 @@ static inline struct page *
 __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
 
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
@@ -227,7 +226,6 @@ static inline
 struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
 
 	return __folio_alloc(gfp, order, nid, NULL);
 }
-- 
2.26.3

