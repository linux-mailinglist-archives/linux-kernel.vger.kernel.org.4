Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1622E6D263C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjCaQui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjCaQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F032CA29;
        Fri, 31 Mar 2023 09:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE826229F;
        Fri, 31 Mar 2023 16:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54092C433D2;
        Fri, 31 Mar 2023 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680281248;
        bh=/lkIh5Nz3go+vQYNCoQXglwXXZHR6bz3tdiI3tn+/LE=;
        h=From:To:Cc:Subject:Date:From;
        b=uAUI4tf4c0+iTL6VZpA452QzH6rdPXK2D1+tb4vwwT/OCVlIWYk71lbZJF6RRrGWV
         LYsPAv/3q2kfIQIF6xRFhs1/+9r4W6MSzzvfcu/DOw5ddPOo2e27YJz00wzn+PgD+B
         3eLOeqaGIYYJq3/QuqmuAkaNlfXlOBfepGFnP+DQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org
Subject: [PATCH] pktcdvd: simplify the class_pktcdvd logic
Date:   Fri, 31 Mar 2023 18:47:24 +0200
Message-Id: <20230331164724.319703-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3396; i=gregkh@linuxfoundation.org; h=from:subject; bh=/lkIh5Nz3go+vQYNCoQXglwXXZHR6bz3tdiI3tn+/LE=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnqfLM2ZljVbzQ8OFcgf5P80eJV6glVGl5Fx83nrXt4Y uePc78YO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAidv8ZFszbIx716uosyzke z/UrVUNeKbab6zAsuFQbVZT3TohFYmNs7IYzjZb5JzcUAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to dynamically create and destroy the class_pktcdvd
structure, just make it static and remove the memory allocation logic
which simplifies and cleans up the logic a lot.

Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, I would like to take this through my driver-core tree as it is
needed for other struct class cleanup work I have done and am continuing
to do there.

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

