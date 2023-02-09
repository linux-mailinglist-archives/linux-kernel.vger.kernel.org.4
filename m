Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AA68FDD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjBIDRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBIDQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:16:58 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697AB30FA;
        Wed,  8 Feb 2023 19:16:51 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675912608;
        bh=EOSpu9ACEWSLjzcgspy1Q7fHgmu8nL5pVF1WC0t9ApM=;
        h=From:Date:Subject:To:Cc:From;
        b=XulfDUaYGO1YH/QW0L/fgM3IeTbryEjLV1El1GQ6HX3kFmwS0x+KFoI36WlT9ZE//
         EYXGGXzaObEAEy1gLEiAdO8SN3fk/Ubzol2coysRgQMiayHCI1MHu90USuo0jN/Jo9
         O/ou/OLvK5vZoSje31gRF/Vv9jwJxsTLPukMumII=
Date:   Thu, 09 Feb 2023 03:16:43 +0000
Subject: [PATCH] xfs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230209-kobj_type-xfs-v1-1-9d3bd77715f3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJpl5GMC/x2N0QqDMAwAf0XyvECt4NRfkSFtjTNTqjSbKOK/G
 /Z4B8edIJSYBJrshEQbCy9RIX9kEEYX34TcK4M1tjDW1Dgt/tN9j5VwHwRDXj6NrWpPVQnaeCe
 EPrkYRq3ib55VrokG3v+T9nVdN7XE78l0AAAA
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675912606; l=3892;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EOSpu9ACEWSLjzcgspy1Q7fHgmu8nL5pVF1WC0t9ApM=;
 b=Nu+mT3ub4RRZpfrMde3mYv2OIXDG7VUqPN/5dvg/rzW/rLx73m4lg0yipfcWNwfH7vb5QhIJn
 i2D/+dq16gqBV1+1uYcscdVqaKL5HrntPFx70/gXznayrRy9rB9OcRJ
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
 fs/xfs/xfs_error.c |  2 +-
 fs/xfs/xfs_sysfs.c | 12 ++++++------
 fs/xfs/xfs_sysfs.h | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index ae082808cfed..b2cbbba3e15a 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -228,7 +228,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 };
 ATTRIBUTE_GROUPS(xfs_errortag);
 
-static struct kobj_type xfs_errortag_ktype = {
+static const struct kobj_type xfs_errortag_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_errortag_sysfs_ops,
 	.default_groups = xfs_errortag_groups,
diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index f7faf6e70d7f..a3c6b1548723 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -69,7 +69,7 @@ static struct attribute *xfs_mp_attrs[] = {
 };
 ATTRIBUTE_GROUPS(xfs_mp);
 
-struct kobj_type xfs_mp_ktype = {
+const struct kobj_type xfs_mp_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
 	.default_groups = xfs_mp_groups,
@@ -266,7 +266,7 @@ static struct attribute *xfs_dbg_attrs[] = {
 };
 ATTRIBUTE_GROUPS(xfs_dbg);
 
-struct kobj_type xfs_dbg_ktype = {
+const struct kobj_type xfs_dbg_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
 	.default_groups = xfs_dbg_groups,
@@ -324,7 +324,7 @@ static struct attribute *xfs_stats_attrs[] = {
 };
 ATTRIBUTE_GROUPS(xfs_stats);
 
-struct kobj_type xfs_stats_ktype = {
+const struct kobj_type xfs_stats_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
 	.default_groups = xfs_stats_groups,
@@ -410,7 +410,7 @@ static struct attribute *xfs_log_attrs[] = {
 };
 ATTRIBUTE_GROUPS(xfs_log);
 
-struct kobj_type xfs_log_ktype = {
+const struct kobj_type xfs_log_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
 	.default_groups = xfs_log_groups,
@@ -564,13 +564,13 @@ static struct attribute *xfs_error_attrs[] = {
 };
 ATTRIBUTE_GROUPS(xfs_error);
 
-static struct kobj_type xfs_error_cfg_ktype = {
+static const struct kobj_type xfs_error_cfg_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
 	.default_groups = xfs_error_groups,
 };
 
-static struct kobj_type xfs_error_ktype = {
+static const struct kobj_type xfs_error_ktype = {
 	.release = xfs_sysfs_release,
 	.sysfs_ops = &xfs_sysfs_ops,
 };
diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 513095e353a5..148893ebfdef 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -7,10 +7,10 @@
 #ifndef __XFS_SYSFS_H__
 #define __XFS_SYSFS_H__
 
-extern struct kobj_type xfs_mp_ktype;	/* xfs_mount */
-extern struct kobj_type xfs_dbg_ktype;	/* debug */
-extern struct kobj_type xfs_log_ktype;	/* xlog */
-extern struct kobj_type xfs_stats_ktype;	/* stats */
+extern const struct kobj_type xfs_mp_ktype;	/* xfs_mount */
+extern const struct kobj_type xfs_dbg_ktype;	/* debug */
+extern const struct kobj_type xfs_log_ktype;	/* xlog */
+extern const struct kobj_type xfs_stats_ktype;	/* stats */
 
 static inline struct xfs_kobj *
 to_kobj(struct kobject *kobject)
@@ -28,7 +28,7 @@ xfs_sysfs_release(struct kobject *kobject)
 static inline int
 xfs_sysfs_init(
 	struct xfs_kobj		*kobj,
-	struct kobj_type	*ktype,
+	const struct kobj_type	*ktype,
 	struct xfs_kobj		*parent_kobj,
 	const char		*name)
 {

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230209-kobj_type-xfs-c1670289be86

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

