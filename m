Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB069575E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjBNDT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBNDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:19:26 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2F4694;
        Mon, 13 Feb 2023 19:19:26 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676344764;
        bh=/j6gYMkWQlw3NcQ1X0C8XkJ0pAG5hrhzDMoF3CPWPq4=;
        h=From:Date:Subject:To:Cc:From;
        b=Uy6Aov4R9l4UUO0iiwFR9AHOn+xr2EJEWsvfuEBWWYOspGztYXlLgMXOt+5NOjUb6
         B3vJyLq2QuFBqSPJcEtiHght6itypsj8p1Rt1JvdDn5V6xAMKxuE5fc13tJ9lvp3zl
         X96UJMFExdwj392iJW1hIYyFUwyyNuRs8ciwqJmM=
Date:   Tue, 14 Feb 2023 03:19:22 +0000
Subject: [PATCH] md: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230214-kobj_type-md-v1-1-d6853f707f11@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALn96mMC/x2NWwqDMBAAryL73QVNLAGvIlKSuNb1ESWxRRHv7
 uLnDAxzQqLIlKDKToj058RLECheGfjehi8ht8KgcqVzVZQ4Lm74bMdKOLdotTfG6LcpfQeSOJs
 IXbTB9xKF3zSJXCN1vD+PurmuGwztvLFzAAAA
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676344762; l=1569;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/j6gYMkWQlw3NcQ1X0C8XkJ0pAG5hrhzDMoF3CPWPq4=;
 b=bsFcY3wtN3ALz/fXXkg2f+AZItfYpqAJ3W8jA8TNC9MDF/AEAN0Xnb41ix9R9DZ6GfTA26Uqe
 Eq1kH03/ec0DTJlhXmcbaD6Yg23DDDSEgNuGo2RD1n/poVDpR5D4SmP
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
 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 02b0240e7c71..091c1d6f0b87 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -78,7 +78,7 @@
 static LIST_HEAD(pers_list);
 static DEFINE_SPINLOCK(pers_lock);
 
-static struct kobj_type md_ktype;
+static const struct kobj_type md_ktype;
 
 struct md_cluster_operations *md_cluster_ops;
 EXPORT_SYMBOL(md_cluster_ops);
@@ -3600,7 +3600,7 @@ static const struct sysfs_ops rdev_sysfs_ops = {
 	.show		= rdev_attr_show,
 	.store		= rdev_attr_store,
 };
-static struct kobj_type rdev_ktype = {
+static const struct kobj_type rdev_ktype = {
 	.release	= rdev_free,
 	.sysfs_ops	= &rdev_sysfs_ops,
 	.default_groups	= rdev_default_groups,
@@ -5558,7 +5558,7 @@ static const struct sysfs_ops md_sysfs_ops = {
 	.show	= md_attr_show,
 	.store	= md_attr_store,
 };
-static struct kobj_type md_ktype = {
+static const struct kobj_type md_ktype = {
 	.release	= md_kobj_release,
 	.sysfs_ops	= &md_sysfs_ops,
 	.default_groups	= md_attr_groups,

---
base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
change-id: 20230214-kobj_type-md-a3c7773574cf

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

