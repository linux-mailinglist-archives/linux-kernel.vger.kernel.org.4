Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B820D60717C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJUHxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJUHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:53:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644BA248CA9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:53:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g7so3731683lfv.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQpiZwUW3au5g/HB9/ft8xnzROXqpcSmgkp+tMrAa3Q=;
        b=lM4zWjvRuuIWFsM95yo/7cse+KjXX4KNSFhmPQqiEAkMJ3IJ4tvcThD/ZfIPOgbDZT
         VJ5rzIkz+xuGTA6D+9LohoW2iLb5Vbwe8HSSt23l1LVmIEuIrBkGEJxb6+hrqXSnP4wd
         TP+kTRL13hbQA2kS8aW6bUZALlKcm662ljBfT85sBFcB965dsaQ0IIvrMmIdAM8dyJK/
         35uTeuXqSlH4um+LgNd1gu4ibp2aAN5C9pOfva01fanM/66rlWeuIj5W/SeT/N3OSu+n
         dTwMvTcYnK87Z6DbYuuBsGoyWL5Sdj5f+0uzIKehlPQFf290pkmNKe4iOXq9zVBQWIJX
         834w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQpiZwUW3au5g/HB9/ft8xnzROXqpcSmgkp+tMrAa3Q=;
        b=ZjvOCcKF/9IOV1jfKr49aS0QY2EYE9BYs91lzku2MYfy+tcQnZ2+zJeoPd33ED2F1i
         fwLMNgPB4eoF+zRki0t9NTfan270UnqjCYMJyKdQcjqR7RUOawXLZXGVL2/ljaLbdqiw
         JtYzvdMDsBnb11AIaNTSKjpsFgRbgsRB1vqwarZssq8+FS9a2O9FuBAAAhUsyiuKVcKu
         zpTGYgMh08HDkf4NGozv51Mvf5odpvAYAx0OEpN1nXzwR+59mVXjIeOLDmbXCpCZAtjG
         tcM/rabVMz0H765CiCOGHUBYxKLRTx1fSIWiEv/V4+3eKDToG+Nil6oc4H4UtlSMrgAW
         J8pA==
X-Gm-Message-State: ACrzQf1y8CwhG5ZCC40/fFwV3OnlwOoWwJ1lH26II2LW2jdPVYfKR5fm
        CltEgtNd/ZV+yxFNrhG+GG8led7rT/j62A==
X-Google-Smtp-Source: AMsMyM7FtXwqw6pVEdWV0VTfM5Mr5nGog/UFnzTGvSxNTmwWvO0noxER/k7Bw/IUc+/cAZchFJwWGg==
X-Received: by 2002:ac2:5189:0:b0:4a2:3bc6:27f2 with SMTP id u9-20020ac25189000000b004a23bc627f2mr6933668lfi.73.1666338800570;
        Fri, 21 Oct 2022 00:53:20 -0700 (PDT)
Received: from localhost.localdomain (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id g15-20020a2e9ccf000000b0026e8dd02eacsm3265632ljj.16.2022.10.21.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 00:53:19 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     nm@ti.com, ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        grygorii.strashko@ti.com, khilman@baylibre.com,
        nfrayer@baylibre.com
Subject: [PATCH] soc: ti: k3-ringacc: Allow the driver to be built as module
Date:   Fri, 21 Oct 2022 11:02:31 +0300
Message-Id: <20221021080231.1076-1-peter.ujfalusi@gmail.com>
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
 drivers/soc/ti/Kconfig      |  2 +-
 drivers/soc/ti/k3-ringacc.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

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
index f7bf18b8229a..e011412f2975 100644
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
@@ -336,6 +336,11 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 
 	mutex_lock(&ringacc->req_lock);
 
+	if (!try_module_get(ringacc->dev->driver->owner)) {
+		mutex_unlock(&ringacc->req_lock);
+		return NULL;
+	}
+
 	if (id == K3_RINGACC_RING_ID_ANY) {
 		/* Request for any general purpose ring */
 		struct ti_sci_resource_desc *gp_rings =
@@ -380,6 +385,7 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 	return &ringacc->rings[id];
 
 error:
+	module_put(ringacc->dev->driver->owner);
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
@@ -1544,12 +1553,26 @@ static int k3_ringacc_probe(struct platform_device *pdev)
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
-		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(k3_ringacc_driver);
+module_platform_driver(k3_ringacc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
+MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
-- 
2.38.1

