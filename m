Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7C749D88
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGFNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjGFNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4816D1FFA;
        Thu,  6 Jul 2023 06:24:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9741caaf9d4so80309866b.0;
        Thu, 06 Jul 2023 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649844; x=1691241844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKZMCCQ7wVVZeBi4fnxNrrCgfWKmBY0QQttlYN04RUs=;
        b=muMEGpAzBHoY1MUttdjulommg6urYMBgqAf79lMnKAkKiLzwVe8gSTZQ9T/xHy04ZV
         9hg+R5svbXxS3mCWeU+qFOrB+knC7NugjL8h5lNJv3ApRtujq9SNzam0CiOmapqlJj5H
         cPSDQOn1VanGnQEwDtu3z92yA30uD+fryYr7sMce4KVF2KK4te5NqVXCs5qoYitIJKXR
         lXCOAVmr/sMlosDCDntFJEDuJUJHRDDvs6qVEiRBBuiMfhJml818V4oJSbvQcuLznkz8
         m8qkeKKbBfFAj2/71tqIwx9ABUTOWLOX191nLz1wsyyRT3jQFsy0+s05QFFA5KoI6BCm
         HerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649844; x=1691241844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKZMCCQ7wVVZeBi4fnxNrrCgfWKmBY0QQttlYN04RUs=;
        b=emcbEmzGA4LGmi+S1u0GXOqjaW42ThHa05udoUT0n7PGEco/uu1B3u2oifcDKVUElR
         98l6H19QIV2qHI23YykiGOgHzJBpZn96QI2it8jfEB1zsvK7koURcvc6IVjASpBNeXih
         znussI0X3VZsO/CO4cpkqZCBw+fWo40XO1PMbeGqrfW8o/P2GyR+KX6f3PtELuVtT7Sf
         6kSjJcpl56AbClFiOmMzCG4eDDawTalxLRFJWN43HJiAjx/DtKl9mqAMYVsmHNFk/yFk
         KdsqpbpMTOYIDcO6dha8SY5QYVUEjmdiqK6s1lqOG51bZlrBuwE3lpbGUyVfqiSbO58V
         PXuw==
X-Gm-Message-State: ABy/qLYsfXiRGJszNVBhUeXXFBSBYMO5b5kUsH4lFBK8HxOZBVpweklr
        bxZsEvlwrAvKUCYmlSUuhgGzhwK3gLjXTfBZ
X-Google-Smtp-Source: APBJJlFckSqvoDXL/eQidtpW3U+6Djau0WKh/p6TYRKDgZMhLIer1UJ7Tx87tsWh35bpRmAih2z3ZA==
X-Received: by 2002:a17:906:7e11:b0:988:699d:64d0 with SMTP id e17-20020a1709067e1100b00988699d64d0mr1759883ejr.32.1688649844399;
        Thu, 06 Jul 2023 06:24:04 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:24:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 20/20] selinux: selinuxfs: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:35 +0200
Message-Id: <20230706132337.15924-20-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unsigned loop counters where the upper bound is of unsigned
type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 88d856f5c6bc..a2dc415779ae 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1074,7 +1074,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	u32 sid, *sids = NULL;
 	ssize_t length;
 	char *newcon;
-	int i, rc;
+	int rc;
 	u32 len, nsids;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
@@ -1107,7 +1107,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 
 	length = sprintf(buf, "%u", nsids) + 1;
 	ptr = buf + length;
-	for (i = 0; i < nsids; i++) {
+	for (u32 i = 0; i < nsids; i++) {
 		rc = security_sid_to_context(sids[i], &newcon, &len);
 		if (rc) {
 			length = rc;
@@ -1612,7 +1612,6 @@ static int sel_make_avc_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
 	static const struct tree_descr files[] = {
 		{ "cache_threshold",
 		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
@@ -1622,7 +1621,7 @@ static int sel_make_avc_files(struct dentry *dir)
 #endif
 	};
 
-	for (i = 0; i < ARRAY_SIZE(files); i++) {
+	for (u32 i = 0; i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 
@@ -1648,12 +1647,11 @@ static int sel_make_ss_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
 	static const struct tree_descr files[] = {
 		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 	};
 
-	for (i = 0; i < ARRAY_SIZE(files); i++) {
+	for (u32 i = 0; i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 
@@ -1699,9 +1697,7 @@ static const struct file_operations sel_initcon_ops = {
 
 static int sel_make_initcon_files(struct dentry *dir)
 {
-	int i;
-
-	for (i = 1; i <= SECINITSID_NUM; i++) {
+	for (u32 i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 		const char *s = security_get_initial_sid_context(i);
-- 
2.40.1

