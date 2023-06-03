Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F5720FCA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjFCLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFCLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 07:00:10 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43DB31B5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 04:00:08 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:51732.1826327623
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 75CC61002EF;
        Sat,  3 Jun 2023 19:00:06 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 20b188bbcba64f2b8563c07bf6954a0d for l.stach@pengutronix.de;
        Sat, 03 Jun 2023 19:00:07 CST
X-Transaction-ID: 20b188bbcba64f2b8563c07bf6954a0d
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v7 3/7] drm/etnaviv: add dedicated functions to create and destroy platform devices
Date:   Sat,  3 Jun 2023 18:59:39 +0800
Message-Id: <20230603105943.3042766-4-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230603105943.3042766-1-15330273260@189.cn>
References: <20230603105943.3042766-1-15330273260@189.cn>
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

Also rename the virtual master platform device as etnaviv_platform_device,
for better reflection that it is a platform device, not a DRM device.

Another benefit is that we no longer need to call of_node_put() for three
different cases, Instead, we only need to call it once.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 56 +++++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 31a7f59ccb49..cec005035d0e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -656,12 +656,44 @@ static struct platform_driver etnaviv_platform_driver = {
 	},
 };
 
-static struct platform_device *etnaviv_drm;
+static struct platform_device *etnaviv_platform_device;
 
-static int __init etnaviv_init(void)
+static int etnaviv_create_platform_device(const char *name,
+					  struct platform_device **ppdev)
 {
 	struct platform_device *pdev;
 	int ret;
+
+	pdev = platform_device_alloc(name, PLATFORM_DEVID_NONE);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	*ppdev = pdev;
+
+	return 0;
+}
+
+static void etnaviv_destroy_platform_device(struct platform_device **ppdev)
+{
+	struct platform_device *pdev = *ppdev;
+
+	if (!pdev)
+		return;
+
+	platform_device_unregister(pdev);
+
+	*ppdev = NULL;
+}
+
+static int __init etnaviv_init(void)
+{
+	int ret;
 	struct device_node *np;
 
 	etnaviv_validate_init();
@@ -681,23 +713,13 @@ static int __init etnaviv_init(void)
 	for_each_compatible_node(np, NULL, "vivante,gc") {
 		if (!of_device_is_available(np))
 			continue;
+		of_node_put(np);
 
-		pdev = platform_device_alloc("etnaviv", PLATFORM_DEVID_NONE);
-		if (!pdev) {
-			ret = -ENOMEM;
-			of_node_put(np);
-			goto unregister_platform_driver;
-		}
-
-		ret = platform_device_add(pdev);
-		if (ret) {
-			platform_device_put(pdev);
-			of_node_put(np);
+		ret = etnaviv_create_platform_device("etnaviv",
+						     &etnaviv_platform_device);
+		if (ret)
 			goto unregister_platform_driver;
-		}
 
-		etnaviv_drm = pdev;
-		of_node_put(np);
 		break;
 	}
 
@@ -713,7 +735,7 @@ module_init(etnaviv_init);
 
 static void __exit etnaviv_exit(void)
 {
-	platform_device_unregister(etnaviv_drm);
+	etnaviv_destroy_platform_device(&etnaviv_platform_device);
 	platform_driver_unregister(&etnaviv_platform_driver);
 	platform_driver_unregister(&etnaviv_gpu_driver);
 }
-- 
2.25.1

