Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36F15F6A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJFPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJFPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC85B1E0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E04619E9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF558C433C1;
        Thu,  6 Oct 2022 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665068979;
        bh=wXqoiRqvOOsXHSVgafb2mnLDBiY/qtfZwDyNj7iYQcY=;
        h=From:To:Cc:Subject:Date:From;
        b=Ky+/zJFHFPIJO5ycxxNUg/8qpGmI1yL0vxQHqYUnzfN/CCj0tohff9XmWgwpvge/p
         qttC97fafocV1WDCCoUhwDsrEkCZ+uIRTln5s0gtz7UwqAKlvltVixIPdonPzqg319
         durwBHcpH/K2LWupSuTrmLVrbSzlNnEY1qBygKQSZH4eARfsRgHXc0p3IFuTB3+Apg
         GA5r3NFg3qQXL303ikBYrZslXvd1ihjJwDvuvv8wXQ2VoxQW+HKtnq7mhJSvNMDAjm
         fN2+1AiMl+yt8gv4JNlzP9SbJWwCy25OXb0DnzejOWeqcYj91siLrEePuU/l0woL0c
         scQn6QFLHVoAA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support fault injection for f2fs_is_valid_blkaddr()
Date:   Thu,  6 Oct 2022 23:09:28 +0800
Message-Id: <20221006150928.56627-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports to inject fault into f2fs_is_valid_blkaddr() to
simulate accessing inconsistent data/meta block addressses from caller.

Usage:
a) echo 262144 > /sys/fs/f2fs/<dev>/inject_type or
b) mount -o fault_type=262144 <dev> <mountpoint>

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 1 +
 fs/f2fs/checkpoint.c               | 5 +++++
 fs/f2fs/f2fs.h                     | 1 +
 fs/f2fs/super.c                    | 1 +
 4 files changed, 8 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 6f19e7f9e908..3bca70fff5ea 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -199,6 +199,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_SLAB_ALLOC	  0x000008000
 			 FAULT_DQUOT_INIT	  0x000010000
 			 FAULT_LOCK_OP		  0x000020000
+			 FAULT_BLKADDR		  0x000040000
 			 ===================	  ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 109e96c15b84..2a5d9256a6f4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -168,6 +168,11 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
+	if (time_to_inject(sbi, FAULT_BLKADDR)) {
+		f2fs_show_injection_info(sbi, FAULT_BLKADDR);
+		return false;
+	}
+
 	switch (type) {
 	case META_NAT:
 		break;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3a63125ffdfd..fa9ac681f71c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -60,6 +60,7 @@ enum {
 	FAULT_SLAB_ALLOC,
 	FAULT_DQUOT_INIT,
 	FAULT_LOCK_OP,
+	FAULT_BLKADDR,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 787010893a12..fad333881ea2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -61,6 +61,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_SLAB_ALLOC]	= "slab alloc",
 	[FAULT_DQUOT_INIT]	= "dquot initialize",
 	[FAULT_LOCK_OP]		= "lock_op",
+	[FAULT_BLKADDR]		= "invalid blkaddr",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-- 
2.36.1

