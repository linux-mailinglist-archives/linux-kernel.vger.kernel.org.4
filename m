Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D46732E59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbjFPKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344946AbjFPKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB1C4C21;
        Fri, 16 Jun 2023 03:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B2F635F7;
        Fri, 16 Jun 2023 10:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F5C433CB;
        Fri, 16 Jun 2023 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911235;
        bh=Pcc99vaLZuLfMMsY+NpaeI4I2awRxyVLyJNsDBdDRbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTB/hWwU0k2Ve3Rt1+aB+/iH2eS4FRrPQi+3i6ppkAa/aboagYIsoXusRnQaLD3i3
         Ll2nD3JUQhyFCOQXhqJWMBviYSijgkkTZLgQqVL3TRuB5ud8yKlLGdoIxwN11tXlhk
         PpQc0L7/2FuPb8WK6P6QwMXnD4PqxXR/LQXwucsI8zHfuQz5D01CRvWbbcgPSQi8SK
         faMBQF40QR78pEiq5ZCXCiwVjGgwnY3lyypV8UhUqxH+IRx+z1eg8DuJH9ol0D8iPa
         usXpD2w/QIxD99iOkJW3Q1vzfXyXpBiLQi9qIVYiivigt+ptOqXfWAiKXoAPkhvb86
         WTInkhMww0GXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/26] ext4: only check dquot_initialize_needed() when debugging
Date:   Fri, 16 Jun 2023 06:26:21 -0400
Message-Id: <20230616102625.673454-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit dea9d8f7643fab07bf89a1155f1f94f37d096a5e ]

ext4_xattr_block_set() relies on its caller to call dquot_initialize()
on the inode.  To assure that this has happened there are WARN_ON
checks.  Unfortunately, this is subject to false positives if there is
an antagonist thread which is flipping the file system at high rates
between r/o and rw.  So only do the check if EXT4_XATTR_DEBUG is
enabled.

Link: https://lore.kernel.org/r/20230608044056.GA1418535@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index fddde5045d0c8..51d642a95bd29 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2006,8 +2006,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2070,8 +2071,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
-- 
2.39.2

