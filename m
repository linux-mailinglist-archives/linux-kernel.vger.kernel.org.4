Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8568E6E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBHEBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBHEBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:01:34 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE727D47;
        Tue,  7 Feb 2023 20:01:33 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675828891;
        bh=z6gdQRd22b6rFVmZcQycIuiVt7AJMHofVc+WstYPDkY=;
        h=From:Date:Subject:To:Cc:From;
        b=SMVGqKkWvYKLqdYThJODx9Ce/DLrtV6ktdvSre1o7xD9bhKGqyWKFPTkAiN/afXd0
         tbzWMrhC7kGMsX/klu+Qx9DVg+TPnHNxnM7S7lPvIoazKiAkuuOLI7Z17vJASoWihB
         TFA/eJgCAkfQMB2iG6um5M5TQAuH+LKMcjLfwAxY=
Date:   Wed, 08 Feb 2023 04:01:22 +0000
Subject: [PATCH] block: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230208-kobj_type-block-v1-1-0b3eafd7d983@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJEe42MC/x2N2wqDMBAFf0X22UBcEUp/pYjksqlbQyKJLYr47
 y59nDkM54RKhanCszmh0I8r5yTQtQ242aQ3KfbCgBp7jfqhlmw/03aspGzMblEBnR96GwjRg1T
 WVJmKSW6WLn1jFLkWCrz/b17jdd3ntZ9wdgAAAA==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675828885; l=4439;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z6gdQRd22b6rFVmZcQycIuiVt7AJMHofVc+WstYPDkY=;
 b=OVn8wDUodWZsOG2PyBY402xLem4m3t9KJb6qTlDz0+R5mYqphg8I64SVMuj9ctspuU5cGhm44
 DJOqv01D7rmDtbNFTLJ/4wWHAqrtoZEDs+dZkmMRgFeVmx350hiDpZJ
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
 block/blk-crypto-sysfs.c | 2 +-
 block/blk-ia-ranges.c    | 4 ++--
 block/blk-integrity.c    | 2 +-
 block/blk-mq-sysfs.c     | 6 +++---
 block/blk-sysfs.c        | 2 +-
 block/elevator.c         | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index 55268edc0625..a304434489ba 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -116,7 +116,7 @@ static void blk_crypto_release(struct kobject *kobj)
 	kfree(container_of(kobj, struct blk_crypto_kobj, kobj));
 }
 
-static struct kobj_type blk_crypto_ktype = {
+static const struct kobj_type blk_crypto_ktype = {
 	.default_groups = blk_crypto_attr_groups,
 	.sysfs_ops	= &blk_crypto_attr_ops,
 	.release	= blk_crypto_release,
diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 2141931ddd37..c9eb4241e048 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -75,7 +75,7 @@ static void blk_ia_range_sysfs_nop_release(struct kobject *kobj)
 {
 }
 
-static struct kobj_type blk_ia_range_ktype = {
+static const struct kobj_type blk_ia_range_ktype = {
 	.sysfs_ops	= &blk_ia_range_sysfs_ops,
 	.default_groups	= blk_ia_range_groups,
 	.release	= blk_ia_range_sysfs_nop_release,
@@ -94,7 +94,7 @@ static void blk_ia_ranges_sysfs_release(struct kobject *kobj)
 	kfree(iars);
 }
 
-static struct kobj_type blk_ia_ranges_ktype = {
+static const struct kobj_type blk_ia_ranges_ktype = {
 	.release	= blk_ia_ranges_sysfs_release,
 };
 
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69eed260a823..8f01d786f5cb 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -356,7 +356,7 @@ static const struct sysfs_ops integrity_ops = {
 	.store	= &integrity_attr_store,
 };
 
-static struct kobj_type integrity_ktype = {
+static const struct kobj_type integrity_ktype = {
 	.default_groups = integrity_groups,
 	.sysfs_ops	= &integrity_ops,
 };
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 4515288fbe35..a8f4accb6646 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -153,15 +153,15 @@ static const struct sysfs_ops blk_mq_hw_sysfs_ops = {
 	.store	= blk_mq_hw_sysfs_store,
 };
 
-static struct kobj_type blk_mq_ktype = {
+static const struct kobj_type blk_mq_ktype = {
 	.release	= blk_mq_sysfs_release,
 };
 
-static struct kobj_type blk_mq_ctx_ktype = {
+static const struct kobj_type blk_mq_ctx_ktype = {
 	.release	= blk_mq_ctx_sysfs_release,
 };
 
-static struct kobj_type blk_mq_hw_ktype = {
+static const struct kobj_type blk_mq_hw_ktype = {
 	.sysfs_ops	= &blk_mq_hw_sysfs_ops,
 	.default_groups = default_hw_ctx_groups,
 	.release	= blk_mq_hw_sysfs_release,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93d9e9c9a6ea..0f5798883776 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -755,7 +755,7 @@ static void blk_queue_release(struct kobject *kobj)
 	/* nothing to do here, all data is associated with the parent gendisk */
 }
 
-static struct kobj_type blk_queue_ktype = {
+static const struct kobj_type blk_queue_ktype = {
 	.default_groups = blk_queue_attr_groups,
 	.sysfs_ops	= &queue_sysfs_ops,
 	.release	= blk_queue_release,
diff --git a/block/elevator.c b/block/elevator.c
index adee58e48e2d..24909069f872 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -126,7 +126,7 @@ static struct elevator_type *elevator_find_get(struct request_queue *q,
 	return e;
 }
 
-static struct kobj_type elv_ktype;
+static const struct kobj_type elv_ktype;
 
 struct elevator_queue *elevator_alloc(struct request_queue *q,
 				  struct elevator_type *e)
@@ -455,7 +455,7 @@ static const struct sysfs_ops elv_sysfs_ops = {
 	.store	= elv_attr_store,
 };
 
-static struct kobj_type elv_ktype = {
+static const struct kobj_type elv_ktype = {
 	.sysfs_ops	= &elv_sysfs_ops,
 	.release	= elevator_release,
 };

---
base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
change-id: 20230208-kobj_type-block-f2cd53bfe22d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

