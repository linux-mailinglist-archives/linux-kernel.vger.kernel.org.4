Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C18738EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFUShM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjFUShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:37:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E4C6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:37:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6689430d803so1835292b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687372629; x=1689964629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HttJ+IZPAFgAC2KFju7xOOGbFCf82oXdQ0iEodC89/8=;
        b=nO50UhyVVA8Y94ODBGdhTOLw2aFgzMeIqVRRWVk7tgqaqKiMGEytcSwZ+y4vzjPB1u
         F/JgOQJHv6TbyKU8bvIxFCjvs+Iho9/b/0PnAm/XkSPl7NA4mASHCPGg97pUBmSKZ+K1
         VFDWNssgbn0YsTuILvQ2iBY/cfknOADdQOZr1MWChptp0H6PGhP0rS1e9LrEhD9x98BP
         gyOXoV38+jDpPmDz5VNQLW3jOW24wsUzpOdYaSTCNftO9q5ySsNDceIoxGE5lWSa9Xne
         eixcKbbhqJBuL2+2m6jZJZynRcsuUMdUBXfW47cLhoXswmHXdmH5duy3VtvwrAF+qCNy
         GcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372629; x=1689964629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HttJ+IZPAFgAC2KFju7xOOGbFCf82oXdQ0iEodC89/8=;
        b=bqLChdPgpZPwSxsQyK88WqQrBlj/FhoeFByQw0eOUW4zIrJreahBXLADyDnw21M9jK
         xF06z04zY+X61qpsGuyF1zlvz1RXdksB5lTyj9PnkKRsb6siHzXplopcEJKgXq2ERqiJ
         CNfY4dlpTppJ6fUt0whRd+hJKCl4KxC909FEKbpEgn8JKgl6WlMC5AK4hgy0GCpZsYYT
         CEoVzbCVXsznTHUaNbiAnnPaWxbOH04Qt0w0P6gbXx3c7NkGxQ5GNwy96WQlWI1ymNox
         H2vKBIU+kgF1wsr7EW6CNKHiKGu4FZ2bUsYkDONYUTAoXVx5dKLm/jHtOw6II7hfNo2o
         jtuw==
X-Gm-Message-State: AC+VfDwrtL0Wf4zIVY4pO6XX/M5jmfZHtTei4Ceopr8s68qqOpd80LzY
        bR6Tvf4/rL/FExuVAF1v8jM=
X-Google-Smtp-Source: ACHHUZ7BMK4uKx4E4hlm1l99TriZp6rOiSWu6de4B1O/UAlnENoG+aYVvtHECZDw12qdEkLBJ0/fiA==
X-Received: by 2002:a05:6a00:1a0f:b0:668:8705:57dd with SMTP id g15-20020a056a001a0f00b00668870557ddmr6703897pfv.28.1687372629026;
        Wed, 21 Jun 2023 11:37:09 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id y17-20020a63e251000000b0050a0227a4bcsm3446104pgj.57.2023.06.21.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:37:08 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:07:03 +0530
From:   Yogesh <yogi.kernel@gmail.com>
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH] fs: jfs: Fix UBSAN: array-index-out-of-bounds in
 dbAllocDmapLev
Message-ID: <ZJNDT7ro6OA4hYM9@zephyrusG14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:1965:6
index -84 is out of range for type 's8[341]' (aka 'signed char[341]')
CPU: 1 PID: 4995 Comm: syz-executor146 Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 dbAllocDmapLev+0x3e5/0x430 fs/jfs/jfs_dmap.c:1965
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1809
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1350
 dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:874
 dtSplitUp fs/jfs/jfs_dtree.c:974 [inline]
 dtInsert+0xda7/0x6b00 fs/jfs/jfs_dtree.c:863
 jfs_create+0x7b6/0xbb0 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1f4e33f7e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc21129578 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1f4e33f7e9
RDX: 000000000000275a RSI: 0000000020000040 RDI: 00000000ffffff9c
RBP: 00007f1f4e2ff080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1f4e2ff110
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The bug occurs when the dbAllocDmapLev()function attempts to access
dp->tree.stree[leafidx + LEAFIND] while the leafidx value is negative.

To rectify this, the patch introduces a safeguard within the
dbAllocDmapLev() function. A check has been added to verify if leafidx is
negative. If it is, the function immediately returns an I/O error, preventing
any further execution that could potentially cause harm.

Tested via syzbot.

Reported-by: syzbot+853a6f4dfa3cf37d3aea@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
Signed-off-by: Yogesh <yogi.kernel@gmail.com>
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..839f1b67485f 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1953,6 +1953,8 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
 		return -ENOSPC;
 
+	if (leafidx < 0)
+		return -EIO;
 	/* determine the block number within the file system corresponding
 	 * to the leaf at which free space was found.
 	 */
-- 
2.34.1

