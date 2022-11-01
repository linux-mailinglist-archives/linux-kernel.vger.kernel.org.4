Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3976153E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKAVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKAVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:15:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6E1EC77
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:09 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpyb8oWfHr; Tue, 01 Nov 2022 22:15:03 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:03 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        nvdimm@lists.linux.dev
Subject: [PATCH 05/30] nvdimm: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:13:53 +0100
Message-Id: <5990e1eadd81a25026e6f04fdda96bd43ff23a07.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].

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
index 3c63dc2cdc81..46475d146f64 100644
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
index e0875d369762..76e1ae6f830a 100644
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
@@ -229,7 +230,7 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
 		const char *buf, size_t len)
 {
 	bool flush;
-	int rc = strtobool(buf, &flush);
+	int rc = kstrtobool(buf, &flush);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (rc)
@@ -484,7 +485,7 @@ static ssize_t read_only_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	bool ro;
-	int rc = strtobool(buf, &ro);
+	int rc = kstrtobool(buf, &ro);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (rc)
-- 
2.34.1

