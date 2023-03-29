Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2379E6CD1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjC2GBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC2GBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:01:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C3358B;
        Tue, 28 Mar 2023 23:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B40B8200F;
        Wed, 29 Mar 2023 06:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B197C433D2;
        Wed, 29 Mar 2023 06:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680069685;
        bh=VmpSqDmABCdiRrhZPUIC9g9iH1F5K/OB3bj4hj2T7/o=;
        h=From:To:Cc:Subject:Date:From;
        b=N74FlaxeHd/XcyD7wDsFfAHp0QgMR2u7iZIxzF23eyiHhxGjhPQWvYV1DaLXxy7h4
         7AVj7yPVkaGJJBmCEdl9Y56TUUSnvEnU0EbpO5uiBkElFdwNxfdMRXCrisPUX57uZQ
         Ef8m9Yol6pZMQI2tW2kE2gTREaSGYa5NeFO+J0mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] pktcdvd: simplify the class_pktcdvd logic
Date:   Wed, 29 Mar 2023 08:01:21 +0200
Message-Id: <20230329060121.2688338-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3437; i=gregkh@linuxfoundation.org; h=from:subject; bh=VmpSqDmABCdiRrhZPUIC9g9iH1F5K/OB3bj4hj2T7/o=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnKV/RezPS67rU91M9H6m9HdO636N1HBSzZtt3fYXo29 exzq+ezO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAid6UY5uf4uO7a4XXz8Lv8 CvmU9GbJ+f9l8hnmyi1a8rn2kv+8l3IVDsqTZkQ/2bXMDwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to dynamically create and destory the class_pktcdvd
structure, just make it static and remove the memory allocation logic
which simplifies and cleans up the logic a lot.

Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note: I would like to take this through the driver-core tree as I have
later struct class cleanups that depend on this change being made to the
tree if that's ok with the maintainer of this file.

 drivers/block/pktcdvd.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ba9bbdef9ef5..79af8a59142e 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -100,7 +100,8 @@ static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t psd_pool;
 static struct bio_set pkt_bio_set;
 
-static struct class	*class_pktcdvd = NULL;    /* /sys/class/pktcdvd */
+/* /sys/class/pktcdvd */
+static struct class	class_pktcdvd;
 static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
@@ -315,8 +316,8 @@ static const struct attribute_group *pkt_groups[] = {
 
 static void pkt_sysfs_dev_new(struct pktcdvd_device *pd)
 {
-	if (class_pktcdvd) {
-		pd->dev = device_create_with_groups(class_pktcdvd, NULL,
+	if (class_is_registered(&class_pktcdvd)) {
+		pd->dev = device_create_with_groups(&class_pktcdvd, NULL,
 						    MKDEV(0, 0), pd, pkt_groups,
 						    "%s", pd->name);
 		if (IS_ERR(pd->dev))
@@ -326,7 +327,7 @@ static void pkt_sysfs_dev_new(struct pktcdvd_device *pd)
 
 static void pkt_sysfs_dev_remove(struct pktcdvd_device *pd)
 {
-	if (class_pktcdvd)
+	if (class_is_registered(&class_pktcdvd))
 		device_unregister(pd->dev);
 }
 
@@ -338,11 +339,6 @@ static void pkt_sysfs_dev_remove(struct pktcdvd_device *pd)
                      device_map     show mappings
  *******************************************************************/
 
-static void class_pktcdvd_release(struct class *cls)
-{
-	kfree(cls);
-}
-
 static ssize_t device_map_show(const struct class *c, const struct class_attribute *attr,
 			       char *data)
 {
@@ -405,35 +401,23 @@ static struct attribute *class_pktcdvd_attrs[] = {
 };
 ATTRIBUTE_GROUPS(class_pktcdvd);
 
+static struct class class_pktcdvd = {
+	.name		= DRIVER_NAME,
+	.class_groups	= class_pktcdvd_groups,
+};
+
 static int pkt_sysfs_init(void)
 {
-	int ret = 0;
-
 	/*
 	 * create control files in sysfs
 	 * /sys/class/pktcdvd/...
 	 */
-	class_pktcdvd = kzalloc(sizeof(*class_pktcdvd), GFP_KERNEL);
-	if (!class_pktcdvd)
-		return -ENOMEM;
-	class_pktcdvd->name = DRIVER_NAME;
-	class_pktcdvd->class_release = class_pktcdvd_release;
-	class_pktcdvd->class_groups = class_pktcdvd_groups;
-	ret = class_register(class_pktcdvd);
-	if (ret) {
-		kfree(class_pktcdvd);
-		class_pktcdvd = NULL;
-		pr_err("failed to create class pktcdvd\n");
-		return ret;
-	}
-	return 0;
+	return class_register(&class_pktcdvd);
 }
 
 static void pkt_sysfs_cleanup(void)
 {
-	if (class_pktcdvd)
-		class_destroy(class_pktcdvd);
-	class_pktcdvd = NULL;
+	class_unregister(&class_pktcdvd);
 }
 
 /********************************************************************
-- 
2.40.0

