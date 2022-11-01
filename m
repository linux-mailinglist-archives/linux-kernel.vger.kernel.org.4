Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11D6153DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKAVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKAVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:14:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E51DDFF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:14:57 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyanoKD2rsfCIpyb1oWfHL; Tue, 01 Nov 2022 22:14:56 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:14:56 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH 04/30] scsi: target: Use kstrtobool() instead of strtobool()
Date:   Tue,  1 Nov 2022 22:13:52 +0100
Message-Id: <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
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
 drivers/target/target_core_configfs.c        | 29 ++++++++++----------
 drivers/target/target_core_fabric_configfs.c |  3 +-
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 533524299ed6..b8a5c8d6cfde 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -12,6 +12,7 @@
  *
  ****************************************************************************/
 
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <generated/utsrelease.h>
@@ -578,7 +579,7 @@ static ssize_t _name##_store(struct config_item *item, const char *page,	\
 	bool flag;							\
 	int ret;							\
 									\
-	ret = strtobool(page, &flag);					\
+	ret = kstrtobool(page, &flag);					\
 	if (ret < 0)							\
 		return ret;						\
 	da->_name = flag;						\
@@ -638,7 +639,7 @@ static ssize_t emulate_model_alias_store(struct config_item *item,
 		return -EINVAL;
 	}
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -660,7 +661,7 @@ static ssize_t emulate_write_cache_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -712,7 +713,7 @@ static ssize_t emulate_tas_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -737,7 +738,7 @@ static ssize_t emulate_tpu_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -767,7 +768,7 @@ static ssize_t emulate_tpws_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -866,7 +867,7 @@ static ssize_t pi_prot_format_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -903,7 +904,7 @@ static ssize_t pi_prot_verify_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -932,7 +933,7 @@ static ssize_t force_pr_aptpl_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 	if (da->da_dev->export_count) {
@@ -954,7 +955,7 @@ static ssize_t emulate_rest_reord_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -977,7 +978,7 @@ static ssize_t unmap_zeroes_data_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -1126,7 +1127,7 @@ static ssize_t alua_support_store(struct config_item *item,
 	bool flag, oldflag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -1165,7 +1166,7 @@ static ssize_t pgr_support_store(struct config_item *item,
 	bool flag, oldflag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -1194,7 +1195,7 @@ static ssize_t emulate_rsoc_store(struct config_item *item,
 	bool flag;
 	int ret;
 
-	ret = strtobool(page, &flag);
+	ret = kstrtobool(page, &flag);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index 95a88f6224cd..67b18a67317a 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -11,6 +11,7 @@
 *
  ****************************************************************************/
 
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/utsname.h>
@@ -829,7 +830,7 @@ static ssize_t target_fabric_tpg_base_enable_store(struct config_item *item,
 	int ret;
 	bool op;
 
-	ret = strtobool(page, &op);
+	ret = kstrtobool(page, &op);
 	if (ret)
 		return ret;
 
-- 
2.34.1

