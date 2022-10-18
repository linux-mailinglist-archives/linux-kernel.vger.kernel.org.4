Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCF602009
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJRA6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJRA6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:58:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04B0193EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D21ACE180B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40829C433C1;
        Tue, 18 Oct 2022 00:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666054690;
        bh=EQfYE38gG+3EcKKsQRkrz/TOt3/lj4TBQRUYoSHM1ZA=;
        h=From:To:Cc:Subject:Date:From;
        b=U4vZwFiUKpge2D1EXLJqUATIuJMvFM/JYBRI43lZBV2OCmEfZo1ZFd9L5rR/pdwGK
         oIhgrg4ykO93RQQoM09JiC6oMCo3r/uQY5RvYamimihg88BCNKegNfGEQ4RN3OfljW
         DQgnf0/Qy0kJdgSaZcljHtM312itonP2yMosfsdRHZR1hput9pIUW3LwKQif99cz9u
         3R2UsdYg9Q1No7ymlZuSNYzBDFiCCE0fYHNTkB6trKZxUzFwiZYpzI09fyC2FJvHoP
         s4bKSEiL1WDk48Hkqa4TXjK9IGxHQctCuYSiSMfzuAxV5amG9cNafkF+Vc0H3Qy0BQ
         E6TsKKljkBYHQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: let's avoid to get cp_rwsem twice by f2fs_evict_inode by d_invalidate
Date:   Mon, 17 Oct 2022 17:58:06 -0700
Message-Id: <20221018005806.892778-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_unlink
 -> f2fs_lock_op
 -> d_invalidate
  -> shrink_dentry_list
   -> iput_final
    -> f2fs_evict_inode
     -> f2fs_lock_op

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a389772fd212..e104409c3a0e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -632,6 +632,8 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 	f2fs_delete_entry(de, page, dir, inode);
+	f2fs_unlock_op(sbi);
+
 #if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -642,8 +644,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
-	f2fs_unlock_op(sbi);
-
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
-- 
2.38.0.413.g74048e4d9e-goog

