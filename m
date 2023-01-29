Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4263D67FF78
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjA2OHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA2OHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:07:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250294482
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A178CB80C98
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E340C433EF;
        Sun, 29 Jan 2023 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675001267;
        bh=bivgQD4hccIujFULNfSi51tGjZlhLoS4MaUhofH0cSc=;
        h=From:To:Cc:Subject:Date:From;
        b=JqAp/Hc9UJhdXEb1d4OF6T7gLXjUOMIttzWm4qjncnt6y+JzSfVCQlRw8zBxhOIDh
         aFvOiUOp4J79fM36UPDgJe9yGWrciOioFsS1CkJ3Y8W2kj5LzXQ8ZZxsR1sxGr8/zw
         7020xN/e1BWTLpQjF6iWtgkKYqjaihUyBzDmbU8TWxDLTo9/wykwiOTYq9kYfE9m64
         K8ndYaMC3KLaf4z1mVTUHq7e0Ta3Pw5ST3JlRsfEbGqotqEhc+FFTHNNyrCH8P+NPW
         KEUs8cIxn4NQuGmb59oDphE2bXorgTMF7di9Ips+jrES/1PGtKPw/p+9g7wq4c51TO
         WD/O/1vgXducw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
Date:   Sun, 29 Jan 2023 16:30:45 +0800
Message-Id: <20230129083045.7754-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to use bitfield in struct f2fs_io_info to improve
memory usage.

struct f2fs_io_info {
...
	int need_lock:8;	/* indicate we need to lock cp_rwsem */
	int version:8;		/* version of the node */
	int submitted:1;	/* indicate IO submission */
	int in_list:1;		/* indicate fio is in io_list */
	int is_por:1;		/* indicate IO is from recovery or not */
	int retry:1;		/* need to reallocate block address */
	int encrypted:1;	/* indicate file is encrypted */
	int post_read:1;	/* require post read */
...
};

After this patch, size of struct f2fs_io_info reduces from 136 to 120.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fa41c0dad308..f2f201e2a6a6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1212,19 +1212,19 @@ struct f2fs_io_info {
 	struct page *encrypted_page;	/* encrypted page */
 	struct page *compressed_page;	/* compressed page */
 	struct list_head list;		/* serialize IOs */
-	bool submitted;		/* indicate IO submission */
-	int need_lock;		/* indicate we need to lock cp_rwsem */
-	bool in_list;		/* indicate fio is in io_list */
-	bool is_por;		/* indicate IO is from recovery or not */
-	bool retry;		/* need to reallocate block address */
 	int compr_blocks;	/* # of compressed block addresses */
-	bool encrypted;		/* indicate file is encrypted */
-	bool post_read;		/* require post read */
+	int need_lock:8;	/* indicate we need to lock cp_rwsem */
+	int version:8;		/* version of the node */
+	int submitted:1;	/* indicate IO submission */
+	int in_list:1;		/* indicate fio is in io_list */
+	int is_por:1;		/* indicate IO is from recovery or not */
+	int retry:1;		/* need to reallocate block address */
+	int encrypted:1;	/* indicate file is encrypted */
+	int post_read:1;	/* require post read */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
 	sector_t *last_block;		/* last block number in bio */
-	unsigned char version;		/* version of the node */
 };
 
 struct bio_entry {
-- 
2.36.1

