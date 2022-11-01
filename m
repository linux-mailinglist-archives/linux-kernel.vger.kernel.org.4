Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D16153ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKAVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKAVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:15:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A21DDF7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:15:11 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpybFoWfIh; Tue, 01 Nov 2022 22:15:10 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:10 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:13:54 +0100
Message-Id: <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/configfs.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f1d71ac0086..7c83dfd1bca6 100644
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
@@ -2186,7 +2187,7 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 	bool new;
 	int ret;
 
-	if (strtobool(buf, &new) < 0)
+	if (kstrtobool(buf, &new) < 0)
 		return -EINVAL;
 
 	if (new == ndev->hmb)
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9443ee1d4ae3..3eb8bdd4d464 100644
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
@@ -1272,7 +1273,7 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 	struct nvmet_subsys *subsys = to_subsys(item);
 	bool pi_enable;
 
-	if (strtobool(page, &pi_enable))
+	if (kstrtobool(page, &pi_enable))
 		return -EINVAL;
 
 	subsys->pi_support = pi_enable;
@@ -1392,7 +1393,7 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool enable;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		goto inval;
 
 	if (enable)
-- 
2.34.1

