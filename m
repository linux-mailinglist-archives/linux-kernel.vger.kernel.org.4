Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBF6ED19F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjDXPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjDXPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:43:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E9FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:43:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63d4595d60fso28859811b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682351032; x=1684943032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y94kv4Rk3iMTSBh2tM9IseZv7kKI9eQQ2uKEfYb7wc=;
        b=bfqMNspTUR07cVDdCj7SlELLZZ83YmBEmO2Uq6W0tFwNSQPkt5hAaPxANaOF1FdSIR
         i9a0ocFqi5MLcrMvtdmZjd2aSR79XGZois2J3Yryn1P/X2THIP/B8BWo1YGDpEC3OtYF
         W6dUXC9zefKCkGgu9MnPezH3ZYHhvWWNWW2XK3rU9cBJfKVLn8c8mJ05Nm5b8O3t/In6
         /GODt079WO7e7oK1tFA/xpBK0VpfXqcFy9eYELW68sxe6xhgehaSMSYrB0XUZ6a4lzWv
         OdHuxRH0a9J+UVSMjtMf4TQGa8OZJIYs2zVt9oaZB8UjrBKah12X0wPK/OZaVbDsHuE0
         9VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351032; x=1684943032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y94kv4Rk3iMTSBh2tM9IseZv7kKI9eQQ2uKEfYb7wc=;
        b=b9j/AXE8MgdtFgA7iz1j9XLcUZbUN2jz/AA2RWhd41N0lpohOeuFmY4wgZ92D9rB9Z
         98PfiSSTtznHy0W1S2eFKOIAos9Qyi08p6anP8CfhagklcjQR+BPHeB8MZlBpW66zuOc
         gsOEC6O7v6hA5Z+Jvw2DAV/JqzOCwilcoaWHLdXMrhJ4fYYsTr3EROVGtkpkKpxHhrP/
         xmCF3y6nHQVn7TcJomvJ8Jbu7e835biI+RJ9MDVKqqDf4jc1eXaRj2aLNX9SvO6L2NFW
         ASxiBLkluyFEGJnk/5BIBHweNN6WvLmsprWBnodIKf9IlsPSiiuVdygaJhAIbg+KcZpF
         AbXg==
X-Gm-Message-State: AAQBX9cQzeYF09d8kIB+EjIiElOqqKpJwTmXGpeM6CF+SXi+fTvHu8Zy
        sEb6qZryfO2D21l0kewq/RYmM91f218=
X-Google-Smtp-Source: AKy350YrdMCoecv6uUyzr/dRBtPNCJLufI9W1otCK+PuTbNoU4pTRwhSkGaH7sHfgLAjxeWl6mnnQA==
X-Received: by 2002:a05:6a21:329a:b0:f2:e20a:c8f4 with SMTP id yt26-20020a056a21329a00b000f2e20ac8f4mr8577557pzb.31.1682351031753;
        Mon, 24 Apr 2023 08:43:51 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:26c1:a43d:1ede:71a3])
        by smtp.gmail.com with ESMTPSA id j16-20020aa783d0000000b0063efe2f3ecdsm7541515pfn.204.2023.04.24.08.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:43:51 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: use cow inode data when updating atomic write
Date:   Mon, 24 Apr 2023 08:43:48 -0700
Message-ID: <20230424154348.22885-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Need to use cow inode data content instead of the one in the original
inode, when we try to write the already updated atomic write files.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8df225014304..7165b1202f53 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3491,7 +3491,7 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 			struct page *page, loff_t pos, unsigned int len,
-			block_t *blk_addr, bool *node_changed)
+			block_t *blk_addr, bool *node_changed, bool *use_cow)
 {
 	struct inode *inode = page->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
@@ -3505,10 +3505,12 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 
 	/* Look for the block in COW inode first */
 	err = __find_data_block(cow_inode, index, blk_addr);
-	if (err)
+	if (err) {
 		return err;
-	else if (*blk_addr != NULL_ADDR)
+	} else if (*blk_addr != NULL_ADDR) {
+		*use_cow = true;
 		return 0;
+	}
 
 	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
 		goto reserve_block;
@@ -3538,6 +3540,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct page *page = NULL;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
 	bool need_balance = false;
+	bool use_cow = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
@@ -3597,7 +3600,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	if (f2fs_is_atomic_file(inode))
 		err = prepare_atomic_write_begin(sbi, page, pos, len,
-					&blkaddr, &need_balance);
+					&blkaddr, &need_balance, &use_cow);
 	else
 		err = prepare_write_begin(sbi, page, pos, len,
 					&blkaddr, &need_balance);
@@ -3637,7 +3640,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			goto fail;
 		}
-		err = f2fs_submit_page_read(inode, page, blkaddr, 0, true);
+		err = f2fs_submit_page_read(use_cow ?
+				F2FS_I(inode)->cow_inode : inode, page,
+				blkaddr, 0, true);
 		if (err)
 			goto fail;
 
-- 
2.40.0.634.g4ca3ef3211-goog

