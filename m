Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998CC732E58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbjFPKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbjFPKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2034C05;
        Fri, 16 Jun 2023 03:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D2556349F;
        Fri, 16 Jun 2023 10:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F93C433C0;
        Fri, 16 Jun 2023 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911234;
        bh=CLDU1kfkXj9OiR4dBqE5728MYJVyHOLU36MZSK/vsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXlJOAmIw4F8k6BM6XfQ9dKZJOG8AYMtwYufFpzV2YLDq7QxbEfzydo1SR9ffj8Oz
         KK9XtlUlbXuZv7JfxKvOzdqhLQTmPIeRFKSKOl9H/fIe7JB/S0MprsG3GaUMPRqZsp
         3mgygpyZdw2Qw+b3CLH2Jdvn8b2OW3QxGCAXQXAnpbR+DzoS+NCDMyHRGhuPr8XmYD
         og0ipnROU+fjUlqI78fmB2OJSWZtxPCTUzxOefc5A+MZO+BgczWkQBLEuqzY0MktL6
         BULg5RDnAG2iX4Cbcx9wwUAhYAYJ/9fPWrvgmW3f1ckY3QoC169WiW1PYSeoNnB7I/
         /LCSHHZvme8iA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 23/26] Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
Date:   Fri, 16 Jun 2023 06:26:20 -0400
Message-Id: <20230616102625.673454-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 1b29243933098cdbc31b579b5616e183b4275e2f ]

This reverts commit a44be64bbecb15a452496f60db6eacfee2b59c79.

Link: https://lore.kernel.org/r/653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5db1060b8684f..760249d9152d1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6341,7 +6341,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6528,7 +6527,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6575,9 +6574,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings
-- 
2.39.2

