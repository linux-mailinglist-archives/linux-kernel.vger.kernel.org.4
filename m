Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E648725C39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbjFGK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbjFGK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:56:16 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1581D192
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:15 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:55208.1520123491
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id BBE501002CE;
        Wed,  7 Jun 2023 18:56:13 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id 2d6665bc324c466abda1ee67f04d8d7e for l.stach@pengutronix.de;
        Wed, 07 Jun 2023 18:56:14 CST
X-Transaction-ID: 2d6665bc324c466abda1ee67f04d8d7e
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 8/8] drm/etnaviv: add a dedicated function to create the virtual master
Date:   Wed,  7 Jun 2023 18:55:51 +0800
Message-Id: <20230607105551.568639-9-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607105551.568639-1-15330273260@189.cn>
References: <20230607105551.568639-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

After introducing the etnaviv_of_first_available_node() helper, the
creation of the virtual master platform device can also be simplified.
So, switch to etnaviv_create_virtual_master() function.

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 43 ++++++++++++++++-----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index d7e7498826f5..6f2260a76433 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -769,10 +769,32 @@ static void etnaviv_destroy_platform_device(struct platform_device **ppdev)
 	*ppdev = NULL;
 }
 
+static int etnaviv_create_virtual_master(void)
+{
+	struct platform_device **master = &etnaviv_platform_device;
+	struct device_node *np;
+
+	/*
+	 * If the DT contains at least one available GPU device, instantiate
+	 * the DRM platform device.
+	 */
+	np = etnaviv_of_first_available_node();
+	if (np) {
+		int ret;
+
+		of_node_put(np);
+
+		ret = etnaviv_create_platform_device("etnaviv", master);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int __init etnaviv_init(void)
 {
 	int ret;
-	struct device_node *np;
 
 	etnaviv_validate_init();
 
@@ -790,22 +812,9 @@ static int __init etnaviv_init(void)
 		goto unregister_platform_driver;
 #endif
 
-	/*
-	 * If the DT contains at least one available GPU device, instantiate
-	 * the DRM platform device.
-	 */
-	for_each_compatible_node(np, NULL, "vivante,gc") {
-		if (!of_device_is_available(np))
-			continue;
-		of_node_put(np);
-
-		ret = etnaviv_create_platform_device("etnaviv",
-						     &etnaviv_platform_device);
-		if (ret)
-			goto unregister_platform_driver;
-
-		break;
-	}
+	ret = etnaviv_create_virtual_master();
+	if (ret)
+		goto unregister_platform_driver;
 
 	return ret;
 
-- 
2.25.1

