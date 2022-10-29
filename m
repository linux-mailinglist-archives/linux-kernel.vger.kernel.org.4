Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4482612115
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJ2Hox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ2Hot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:44:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35AC63D7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:44:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b2so11704975lfp.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODsvEZSt8L9OgvY/uXP8nyDMl5NJNUX3zne8NzsJ3Zw=;
        b=MjBdbM+ALBCYc7vNc6UWs4mrtrCfhKXdJBhZxvKGEJQimcFUwmHBOMWpUFyuYF2wuK
         ptu+uk+UcfRpG0L9zV2Y1K1h04FPxLVNU2xptGl0Oq1tlECEk0N2uOWDSHV1DoR/1mnD
         hphYc6kNZnWa2S7fPo3d6gTPfxW/9o50sV+9r+ZrKbi3xAYBkIpUyvrxlDoiWxb1TVWQ
         tnLH6zuJtMnxElc+Ydm0+cQtvT+xGT3my/JgtO9+Al4FslQbvH82BLGI0CYVQ4DZ6t8x
         bp1kbcG2iHk+2aTUCCmOvexMov+ritTOrp1SfzJVU5V2McyIIl/yQie5WVj15hmoUP+7
         EX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODsvEZSt8L9OgvY/uXP8nyDMl5NJNUX3zne8NzsJ3Zw=;
        b=H4+SfeDNb89FHceXGM05T2E0BQeANPZTlajUcu3FKeU+lHr2X1yPuJN22WjXY6S8Qb
         1J+xV82MFKCrtxi4pIG9+e0o7GEnNI7MLufVcRhapq0kLWfRb4S+js7W8wS2dw43BWlg
         jl5Z6oAe2XjIpTcBRF6q6wJRP7C6KkSQFX9kNl6JF2v90ZyWZIyJlHnHBVeSeo4ZrU7x
         lmFSddB8SkWRwsqfk6RR0IUqsFw9xFzMq1UC+urwreYmL3fZudmxpqrO7sMXAsAaBbe9
         gaUvvAZw9NGAjUdDw+wYzBLeEelHUC2g2L2FAAXcDw2uHMXJQvHj6P8Lo842vel5Ynpy
         8HBA==
X-Gm-Message-State: ACrzQf0Bzf+z0UpjeQB3s/8G+Gy+FcXUtx+x4A0eE9BDq77jF/I/W0zF
        ihviJJpAePa6AkCTWwu61pw=
X-Google-Smtp-Source: AMsMyM5kVZWX+n6uvYMbPYCdqP59Z1ohYI0hGLBsRjnxCUDIE/5Lm7JE1GN4L9+CMJtlkWH2fbnc9A==
X-Received: by 2002:a05:6512:230d:b0:4a2:fd3:9208 with SMTP id o13-20020a056512230d00b004a20fd39208mr1263691lfu.557.1667029478162;
        Sat, 29 Oct 2022 00:44:38 -0700 (PDT)
Received: from localhost.localdomain (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id 202-20020a2e09d3000000b0026acfbbcb7esm121716ljj.12.2022.10.29.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:44:37 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     nm@ti.com, ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        grygorii.strashko@ti.com, khilman@baylibre.com,
        nfrayer@baylibre.com
Subject: [PATCH v2] soc: ti: k3-ringacc: Allow the driver to be built as module
Date:   Sat, 29 Oct 2022 10:53:56 +0300
Message-Id: <20221029075356.7296-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring accelerator driver can be built as module since all depending
functions are exported.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
Hi,

Changes since v1:
- Fix MODULE_LICENSE line to GPL
- Use goto label in k3_ringacc_request_ring() for try_module_get error
- keep suppress_bind_attrs = true

Nicolas, I have not added your reviewed and tested by tag due to these changes.
I would appreciate if you would spare some time to re-check the patch.

Regards,
Peter

 drivers/soc/ti/Kconfig      |  2 +-
 drivers/soc/ti/k3-ringacc.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 7e2fb1c16af1..e009d9589af4 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -63,7 +63,7 @@ config TI_SCI_PM_DOMAINS
 	  rootfs may be available.
 
 config TI_K3_RINGACC
-	bool "K3 Ring accelerator Sub System"
+	tristate "K3 Ring accelerator Sub System"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_SCI_INTA_IRQCHIP
 	help
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index f7bf18b8229a..e01e4d815230 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -7,7 +7,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -336,6 +336,9 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 
 	mutex_lock(&ringacc->req_lock);
 
+	if (!try_module_get(ringacc->dev->driver->owner))
+		goto err_module_get;
+
 	if (id == K3_RINGACC_RING_ID_ANY) {
 		/* Request for any general purpose ring */
 		struct ti_sci_resource_desc *gp_rings =
@@ -380,6 +383,9 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 	return &ringacc->rings[id];
 
 error:
+	module_put(ringacc->dev->driver->owner);
+
+err_module_get:
 	mutex_unlock(&ringacc->req_lock);
 	return NULL;
 }
@@ -616,6 +622,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
 no_init:
 	clear_bit(ring->ring_id, ringacc->rings_inuse);
 
+	module_put(ringacc->dev->driver->owner);
+
 out:
 	mutex_unlock(&ringacc->req_lock);
 	return 0;
@@ -1450,6 +1458,7 @@ static const struct of_device_id k3_ringacc_of_match[] = {
 	{ .compatible = "ti,am654-navss-ringacc", .data = &k3_ringacc_data, },
 	{},
 };
+MODULE_DEVICE_TABLE(of, k3_ringacc_of_match);
 
 struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 					    struct k3_ringacc_init_data *data)
@@ -1544,12 +1553,27 @@ static int k3_ringacc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int k3_ringacc_remove(struct platform_device *pdev)
+{
+	struct k3_ringacc *ringacc = dev_get_drvdata(&pdev->dev);
+
+	mutex_lock(&k3_ringacc_list_lock);
+	list_del(&ringacc->list);
+	mutex_unlock(&k3_ringacc_list_lock);
+	return 0;
+}
+
 static struct platform_driver k3_ringacc_driver = {
 	.probe		= k3_ringacc_probe,
+	.remove		= k3_ringacc_remove,
 	.driver		= {
 		.name	= "k3-ringacc",
 		.of_match_table = k3_ringacc_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(k3_ringacc_driver);
+module_platform_driver(k3_ringacc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
+MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
-- 
2.38.1

