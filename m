Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8506661CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjAIDpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAIDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:45:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A82F020
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:45:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A165060EAD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBC1C433F2;
        Mon,  9 Jan 2023 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673235914;
        bh=z+rEkFMv+wRfNSPG7VtFK07vpI0/Mb7wF/w9G4C5Uac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtGz6EvXa+PBbLwGnayMZXLkItsmkkRMAzq4RG4PAi2baRQI+1yaWsh/aM3xDxP2v
         3Vjdh6bHI6i/e4n+cSTmMDxh1IPlD7HACU6HAUuQgLw6uXVeZk1UTEHfGHCg4xyF+V
         suZvvZrCquqM7Fe88ORTzPJQEgckViUKuctoe0+hrsgRFsS1ME4falCNouyTrbyXvj
         kXliOVbAeEV9pt7voeRaoA4ACYnq8fpfm05Ao6f/Vc9vmBTJlZI6AczeccBXXOIjrz
         H6bFMyumDZIkYiUL5B9lQFVw7LjzK2c+syKYUp8wN5e2CnZn8nnQFRR95pU2mWGLdc
         uPACqtsXlbEnA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/5] f2fs: clear atomic_write_task in f2fs_abort_atomic_write()
Date:   Mon,  9 Jan 2023 11:44:50 +0800
Message-Id: <20230109034453.490176-2-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
References: <20230109034453.490176-1-chao@kernel.org>
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

Otherwise, last .atomic_write_task will be remained in structure
f2fs_inode_info, resulting in aborting atomic_write accidentally
in race case. Meanwhile, clear original_i_size as well.

Fixes: 7a10f0177e11 ("f2fs: don't give partially written atomic data from process crash")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c6f6d0618164..5f7e42b355eb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -201,9 +201,12 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 	stat_dec_atomic_inode(inode);
 
+	F2FS_I(inode)->atomic_write_task = NULL;
+
 	if (clean) {
 		truncate_inode_pages_final(inode->i_mapping);
 		f2fs_i_size_write(inode, fi->original_i_size);
+		fi->original_i_size = 0;
 	}
 }
 
-- 
2.25.1

