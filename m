Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39D96369ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbiKWTfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiKWTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:35:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2732A5A6F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:35:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w79so466277pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw4WyKM9DBvayVTRE4i7RSk2LhfDltgpSKG4zBjifYs=;
        b=XMJtRrlnTXVBcoyHujvErjTAqzGHuybT6RNT1Er5bJrKwKEh7NeijldbMDp6KBUffc
         Yalc/mjwDbYliUWcYuf55hZ5wrFlwRG8T5Jc0zElKA4J7z7vqi4+xvh8U715+CFAPyQg
         mw5WnQqCDRbvon9S2fzGnlwwjKW8dEexrCPXxmFjCp8gTYf2C/m3/fdNqhAr6o+SdC29
         siyeqccDBIGwfDF0SvkCe56er4N1TFDT9PRG3gVCZfFedkVNsDRbfpu3HqqMLc0xYAGM
         PUGHkYIE4e40rOGmMh6Mp2MIcCIhhFfeoDm5YD4CiZTCje19T44CWAek/WF4pZyIkZ5H
         t7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zw4WyKM9DBvayVTRE4i7RSk2LhfDltgpSKG4zBjifYs=;
        b=hsmjRxJ3FoU4g8tWia/T3iQDruIvOrsXY/2ApRVKZVsHCSl3aU5uL62WzzLK3R07M8
         ckd+2XnuvsFbOKy04M3RJF7bFLRexUnMNxpET2K+c7G8glm/dI3wkuwNJYWd9XC3wUXW
         xEafjXrGq/1nHKYP60/rrUpi8cj5x0jyl05fOVrdkm4beenW++dZSusiYRX3uB+OrU4J
         Y+BEDzGnwrHtccIsTQlCCJm8ySSUppRO3NHCQJY+wQB3ZSV3jaoJ5jQljWLMAxth8m8M
         ztilvFoiEPTFNG+eJyVc3yCEm2zUU6xlQq7fYZuHXRQaAnNCZrtvqdMNyeYXZ/IDZjhk
         1zNw==
X-Gm-Message-State: ANoB5pl9lFaYPSPPs0m4hszDanfS48UY9lj/radsxHT3Hir51OLsNOZG
        qMTqsEt8WL4bakDp30IBDb9PqcJbHto=
X-Google-Smtp-Source: AA0mqf6Jsu2ej9z6FPyYdMuIguGaUqFE2fq/fuLv9fHofeGV1Ss1FIrCzEvgXGv8Ot5J8/c5NjpToQ==
X-Received: by 2002:a05:6a00:2403:b0:572:698b:5f69 with SMTP id z3-20020a056a00240300b00572698b5f69mr14698532pfh.54.1669232102646;
        Wed, 23 Nov 2022 11:35:02 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id g17-20020a63e611000000b00476c2180dbcsm6702628pgh.29.2022.11.23.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:35:02 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     zokeefe@google.com, mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable v4 PATCH] mm: replace VM_WARN_ON to pr_warn if the node is offline with __GFP_THISNODE
Date:   Wed, 23 Nov 2022 11:30:14 -0800
Message-Id: <20221123193014.153983-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108184357.55614-3-shy828301@gmail.com>
References: <20221108184357.55614-3-shy828301@gmail.com>
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
preferred node is bogus.  The previous patch fixed the khugepaged
code to avoid allocating page from non-existing node.  But it is still
racy against memory hotremove.  There is no synchronization with the
memory hotplug so it is possible that memory gets offline during a
longer taking scanning.

So this warning still seems not quite helpful because:
  * There is no guarantee the node is online for __GFP_THISNODE context
    for all the callsites.
  * Kernel just fails the allocation regardless the warning, and it looks
    all callsites handle the allocation failure gracefully.

Although while the warning has helped to identify a buggy code, it is not
safe in general and this warning could panic the system with panic-on-warn
configuration which tends to be used surprisingly often.  So replace
VM_WARN_ON to pr_warn().  And the warning will be triggered if
__GFP_NOWARN is set since the allocator would print out warning for such
case if __GFP_NOWARN is not set.

Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
Signed-off-by: Yang Shi <shy828301@gmail.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v4: * Renamed nid to this_node and gfp to warn_gfp to make the code
      more readable per Michal.
    * Collected ack from Michal.
v3: * Reverted the old commit from mm-unstable which remove the VM_WARN
      (patch 1/3).
    * Incorporated the suggestion from Michal to use pr_warn.
v2: * Added patch 1/2.
    * Reworded the commit log per Michal.

 include/linux/gfp.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ef4aea3b356e..7e144b81c6c4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -210,6 +210,20 @@ alloc_pages_bulk_array_node(gfp_t gfp, int nid, unsigned long nr_pages, struct p
 	return __alloc_pages_bulk(gfp, nid, NULL, nr_pages, NULL, page_array);
 }
 
+static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
+{
+	gfp_t warn_gfp = gfp_mask & (__GFP_THISNODE|__GFP_NOWARN);
+
+	if (warn_gfp != (__GFP_THISNODE|__GFP_NOWARN))
+		return;
+
+	if(node_online(this_node))
+		return;
+
+	pr_warn("%pGg allocation from offline node %d\n", &warn_gfp, this_node);
+	dump_stack();
+}
+
 /*
  * Allocate pages, preferring the node given as nid. The node must be valid and
  * online. For more general interface, see alloc_pages_node().
@@ -218,7 +232,7 @@ static inline struct page *
 __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
+	warn_if_node_offline(nid, gfp_mask);
 
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
@@ -227,7 +241,7 @@ static inline
 struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
+	warn_if_node_offline(nid, gfp);
 
 	return __folio_alloc(gfp, order, nid, NULL);
 }
-- 
2.38.1

