Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9734631337
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiKTJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 04:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKTJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 04:34:47 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9F1CFFE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:34:45 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wgiooJbLW0H6IwgioonYC1; Sun, 20 Nov 2022 10:34:44 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Nov 2022 10:34:44 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tim Harvey <tharvey@gateworks.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (gsc-hwmon) Switch to flexible array to simplify code
Date:   Sun, 20 Nov 2022 10:34:41 +0100
Message-Id: <61a23e1d642397cfcecc4ac3bb0ab485d257987d.1668936855.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
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

Using flexible array is more straight forward. It
  - saves 1 pointer in the 'gsc_hwmon_platform_data' structure
  - saves an indirection when using this array
  - saves some LoC and avoids some always spurious pointer arithmetic

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/hwmon/gsc-hwmon.c               | 6 ++----
 include/linux/platform_data/gsc_hwmon.h | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index b60ec95b5edb..73e5d92b200b 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -257,13 +257,10 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
 	if (nchannels == 0)
 		return ERR_PTR(-ENODEV);
 
-	pdata = devm_kzalloc(dev,
-			     sizeof(*pdata) + nchannels * sizeof(*ch),
+	pdata = devm_kzalloc(dev, struct_size(pdata, channels, nchannels),
 			     GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	ch = (struct gsc_hwmon_channel *)(pdata + 1);
-	pdata->channels = ch;
 	pdata->nchannels = nchannels;
 
 	/* fan controller base address */
@@ -277,6 +274,7 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
 
 	of_node_put(fan);
 
+	ch = pdata->channels;
 	/* allocate structures for channels and count instances of each type */
 	device_for_each_child_node(dev, child) {
 		if (fwnode_property_read_string(child, "label", &ch->name)) {
diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
index 281f499eda97..f2781aa7eff8 100644
--- a/include/linux/platform_data/gsc_hwmon.h
+++ b/include/linux/platform_data/gsc_hwmon.h
@@ -29,18 +29,17 @@ struct gsc_hwmon_channel {
 
 /**
  * struct gsc_hwmon_platform_data - platform data for gsc_hwmon driver
- * @channels:	pointer to array of gsc_hwmon_channel structures
- *		describing channels
  * @nchannels:	number of elements in @channels array
  * @vreference: voltage reference (mV)
  * @resolution: ADC bit resolution
  * @fan_base: register base for FAN controller
+ * @channels:	array of gsc_hwmon_channel structures describing channels
  */
 struct gsc_hwmon_platform_data {
-	const struct gsc_hwmon_channel *channels;
 	int nchannels;
 	unsigned int resolution;
 	unsigned int vreference;
 	unsigned int fan_base;
+	struct gsc_hwmon_channel channels[];
 };
 #endif
-- 
2.34.1

