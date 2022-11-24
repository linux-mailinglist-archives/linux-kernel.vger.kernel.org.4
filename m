Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E56380A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKXV2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:28:19 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08AF22B30
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:28:17 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id yJlWods52CoWhyJlWo2n87; Thu, 24 Nov 2022 22:28:15 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Nov 2022 22:28:15 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: Use kstrtobool() instead of strtobool()
Date:   Thu, 24 Nov 2022 22:28:12 +0100
Message-Id: <5edef1b51c865faf61752c991eaf292c8a68cc01.1669324969.git.christophe.jaillet@wanadoo.fr>
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
This patch was initially part of a serie ([1]) that axed all usages of
strtobool().

It is synched with latest -next and resent as an individual patch as
requested in [2].

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/20221102064747.GA8903@lst.de/
---
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/configfs.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0163bfa925aa..be70229c0b94 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -2185,7 +2186,7 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 	bool new;
 	int ret;
 
-	if (strtobool(buf, &new) < 0)
+	if (kstrtobool(buf, &new) < 0)
 		return -EINVAL;
 
 	if (new == ndev->hmb)
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6a2816f3b4e8..f14a5db3f02c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/kstrtox.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -267,7 +268,7 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool val;
 
-	if (strtobool(page, &val))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -532,7 +533,7 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	bool enable;
 	int ret = 0;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		return -EINVAL;
 
 	if (enable)
@@ -556,7 +557,7 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	bool val;
 
-	if (strtobool(page, &val))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
 	mutex_lock(&ns->subsys->lock);
@@ -579,7 +580,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	bool val;
 
-	if (strtobool(page, &val))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
 	if (!val)
@@ -728,7 +729,7 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
 	bool enable;
 	int ret = 0;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		return -EINVAL;
 
 	if (enable)
@@ -995,7 +996,7 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 	bool allow_any_host;
 	int ret = 0;
 
-	if (strtobool(page, &allow_any_host))
+	if (kstrtobool(page, &allow_any_host))
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
@@ -1275,7 +1276,7 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 	struct nvmet_subsys *subsys = to_subsys(item);
 	bool pi_enable;
 
-	if (strtobool(page, &pi_enable))
+	if (kstrtobool(page, &pi_enable))
 		return -EINVAL;
 
 	subsys->pi_support = pi_enable;
@@ -1395,7 +1396,7 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool enable;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		goto inval;
 
 	if (enable)
-- 
2.34.1

