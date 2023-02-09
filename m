Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED968FDDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjBIDVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjBIDU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:20:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55640658D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:20:16 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675912814;
        bh=0ax1L+4wlH+3bsB/7eEn2YOweom015kqtn2sv4C2TLM=;
        h=From:Date:Subject:To:Cc:From;
        b=FmqVtcQMfIPfadTCbIb6fQaMYIPvH7vQ8bGmgzgE48D5pOefvT8fWpZQQmsMrDrF9
         fOJ4kowhcbW5ytiOuOmPFxEMntnr7Tb/W7qvlGpeerY56geyqtXb5gahcF30WoQowB
         mIzTTORMQQYsv37hlUAcFY3Ur8Pj4Qi76JlfPcPk=
Date:   Thu, 09 Feb 2023 03:20:10 +0000
Subject: [PATCH] f2fs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGlm5GMC/x2NQQrCQAwAv1JyNrDGXtqviMhmzdrUsi0bFaX07
 6YeZ2CYFUyqikHfrFDlraZzcTgeGkhDLHdBvTkDBToFCh0+Zh6vz+8imCkbctx9armjAB5xNEG
 usaTBs/KaJpdLlayf/+V82bYf4kgpr3UAAAA=
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675912812; l=2105;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0ax1L+4wlH+3bsB/7eEn2YOweom015kqtn2sv4C2TLM=;
 b=kIRzSTrKvek4pySmNk1lSuXeegxwku6qFmFpJjx7qPcDmSyr1HrZc7v/iT/FDL9a3zQH3ynhi
 z00ICnBe17YAoHuKe6JJhWcCvt440/jSRgeJiJJdyR/TAYIYMrybH8a
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/f2fs/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 83a366f3ee80..43f1ff1b92ba 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1129,13 +1129,13 @@ static const struct sysfs_ops f2fs_attr_ops = {
 	.store	= f2fs_attr_store,
 };
 
-static struct kobj_type f2fs_sb_ktype = {
+static const struct kobj_type f2fs_sb_ktype = {
 	.default_groups = f2fs_groups,
 	.sysfs_ops	= &f2fs_attr_ops,
 	.release	= f2fs_sb_release,
 };
 
-static struct kobj_type f2fs_ktype = {
+static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
 };
 
@@ -1143,7 +1143,7 @@ static struct kset f2fs_kset = {
 	.kobj	= {.ktype = &f2fs_ktype},
 };
 
-static struct kobj_type f2fs_feat_ktype = {
+static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_attr_ops,
 };
@@ -1184,7 +1184,7 @@ static const struct sysfs_ops f2fs_stat_attr_ops = {
 	.store	= f2fs_stat_attr_store,
 };
 
-static struct kobj_type f2fs_stat_ktype = {
+static const struct kobj_type f2fs_stat_ktype = {
 	.default_groups = f2fs_stat_groups,
 	.sysfs_ops	= &f2fs_stat_attr_ops,
 	.release	= f2fs_stat_kobj_release,
@@ -1211,7 +1211,7 @@ static const struct sysfs_ops f2fs_feature_list_attr_ops = {
 	.show	= f2fs_sb_feat_attr_show,
 };
 
-static struct kobj_type f2fs_feature_list_ktype = {
+static const struct kobj_type f2fs_feature_list_ktype = {
 	.default_groups = f2fs_sb_feat_groups,
 	.sysfs_ops	= &f2fs_feature_list_attr_ops,
 	.release	= f2fs_feature_list_kobj_release,

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230209-kobj_type-f2fs-ba2302c4b920

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

