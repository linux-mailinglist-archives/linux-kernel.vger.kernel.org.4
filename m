Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5266AA30
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjANIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjANIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:50:44 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5131959E6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:50:42 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GcFKpBC5RvDxRGcFKplSye; Sat, 14 Jan 2023 09:50:39 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 09:50:39 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        nvdimm@lists.linux.dev
Subject: [PATCH v2] nvdimm: Use kstrtobool() instead of strtobool()
Date:   Sat, 14 Jan 2023 09:50:21 +0100
Message-Id: <7565f107952e31fad2bc825b8c533df70c498537.1673686195.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch was already sent as a part of a serie ([1]) that axed all usages
of strtobool().
Most of the patches have been merged in -next.

I synch'ed with latest -next and re-send the remaining ones as individual
patches.

Changes in v2:
  - synch with latest -next.

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 drivers/nvdimm/namespace_devs.c | 3 ++-
 drivers/nvdimm/pmem.c           | 3 ++-
 drivers/nvdimm/region_devs.c    | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index c60ec0b373c5..07177eadc56e 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2,6 +2,7 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/sort.h>
@@ -1338,7 +1339,7 @@ static ssize_t force_raw_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	bool force_raw;
-	int rc = strtobool(buf, &force_raw);
+	int rc = kstrtobool(buf, &force_raw);
 
 	if (rc)
 		return rc;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 80ded5a2838a..f2a336c6d8c6 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -17,6 +17,7 @@
 #include <linux/moduleparam.h>
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
+#include <linux/kstrtox.h>
 #include <linux/vmalloc.h>
 #include <linux/blk-mq.h>
 #include <linux/pfn_t.h>
@@ -408,7 +409,7 @@ static ssize_t write_cache_store(struct device *dev,
 	bool write_cache;
 	int rc;
 
-	rc = strtobool(buf, &write_cache);
+	rc = kstrtobool(buf, &write_cache);
 	if (rc)
 		return rc;
 	dax_write_cache(pmem->dax_dev, write_cache);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 83dbf398ea84..f5872de7ea5a 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -5,6 +5,7 @@
 #include <linux/scatterlist.h>
 #include <linux/memregion.h>
 #include <linux/highmem.h>
+#include <linux/kstrtox.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/hash.h>
@@ -275,7 +276,7 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
 		const char *buf, size_t len)
 {
 	bool flush;
-	int rc = strtobool(buf, &flush);
+	int rc = kstrtobool(buf, &flush);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (rc)
@@ -530,7 +531,7 @@ static ssize_t read_only_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	bool ro;
-	int rc = strtobool(buf, &ro);
+	int rc = kstrtobool(buf, &ro);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (rc)
-- 
2.34.1

