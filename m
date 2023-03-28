Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F76CBBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjC1KDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjC1KDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:03:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0730618A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:03:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so15047244lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sl9kxXSw+Tz25eb85qCM7uxtmc76BHK03FRsB6nWKSE=;
        b=xqSEU/kqI0Diy4z4+MqEBldFOfHYnHjrn/VIcy+3OrcOcxOGBciCx4ARC7cjTGQupw
         hCWssqow5Tqz4t+ZlqXr1WHFFsx42NQoLKeOSwFlffd4Y9zrGCa4lYIWGuf68UZu61/c
         UgwEz0OZUDmXLkzceyoEi15VfMQCMsnihjZStKFER+zz3H6vGYYSPX0EFXCrVFmoEBpH
         YV75NCnqFqv5T+Dc54OkEgfToptxK9OB8Ea0r8JsGhDQkA/ztZmWY99+MQo1uPbwgB7p
         zqLcJnzzcxhN03+TSNChqJQSvw2PA4SWJiwEwLST55kJZj+bXdEvyQyzNrWr7KsQFDPC
         HUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl9kxXSw+Tz25eb85qCM7uxtmc76BHK03FRsB6nWKSE=;
        b=j7Y/kv5f/lP+Fqx4z76Kd6Mn6PWX4mxd6ij9z7WqwufXZ4lUykX88YafTj2ISFiRQS
         1js/OSpoAid7eJVZVZCz3eIQdDrlfXgPZGVuGZGk1+qYkZGu8Hc6ohnlQy/nCcDtJvbN
         UY9mhyqoyhzLnSXyAevpZTVomfACQTZ/E6VlwcZpPydxekb3WD8YJ4jk/DxbVFvAi/L/
         LqFMe2Uc2Z8s9W6UoPt5hKgeTcRLbM8MTPuU+OWdoJ1i8s3JtGtplpbAgGbF+lzQhKUX
         VSCy3rP4PWNKYyrGesfBkd2dbo10iMn4kR+Dp6Ii/yOP1byFXwYlJ8E5V6eoBEUuynx3
         8IPA==
X-Gm-Message-State: AAQBX9fVawVFZImXA0gDjISfyVEe0nG2prMJaMHnWKJ9axBDulYZCVbu
        Bbbg/Z/Ft7hSE7YSU8J5WwKJF2IAssQ4xb2BULs=
X-Google-Smtp-Source: AKy350YMwE0ddyX51M/0yjHpBUptGp7dETGcgGbw3f2Xvu7upg2kzTEHZQUXY87LiX8lgJx8wcJJHQ==
X-Received: by 2002:ac2:4f8d:0:b0:4e0:979d:56e8 with SMTP id z13-20020ac24f8d000000b004e0979d56e8mr4712169lfs.22.1679997783162;
        Tue, 28 Mar 2023 03:03:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f10-20020ac24e4a000000b004db3e330dcesm5008471lfr.178.2023.03.28.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:03:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Mar 2023 12:02:53 +0200
Subject: [PATCH 2/2] irqchip: irq-qcom-mpm: Support passing a slice of SRAM
 as reg space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v1-2-1b788a5f5a33@linaro.org>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679997779; l=3266;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=j53C+GXyNrDcAD6z2W1lAVzYENLhZdbwFZ4vxEDuGZ0=;
 b=7kBk95MhrZI4VdrM3PLJSqOqrg5k4VerCssvwUKsN3a3wwSN2HQpGfazNjS67qCZqX6v05Gnbbt5
 0oAHWK3MBdG7T7VAurc9V+VPfvEqc7s/93tfWzENjWAcIpfw9SWj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPM hardware is accessible to us from the ARM CPUs through a shared
memory region (RPM MSG RAM) that's also concurrently accessed by other
kinds of cores on the system (like modem, ADSP etc.). Modeling this
relation in a (somewhat) sane manner in the device tree basically
requires us to either present the MPM as a child of said memory region
(which makes little sense, as a mapped memory carveout is not a bus),
define nodes which bleed their register spaces into one another, or
passing their slice of the MSG RAM through some kind of a property.

Go with the third option and add a way to map a region passed through
the "qcom,rpm-msg-ram" property as our register space.

The current way of using 'reg' is preserved for ABI reasons.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/irqchip/irq-qcom-mpm.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index d30614661eea..6fe59f4deef4 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,6 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	struct device *dev = &pdev->dev;
 	struct irq_domain *parent_domain;
 	struct generic_pm_domain *genpd;
+	struct device_node *msgram_np;
 	struct qcom_mpm_priv *priv;
 	unsigned int pin_cnt;
+	struct resource res;
 	int i, irq;
 	int ret;
 
@@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 
 	raw_spin_lock_init(&priv->lock);
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	/* If we have a handle to an RPM message ram partition, use it. */
+	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
+	if (msgram_np) {
+		ret = of_address_to_resource(msgram_np, 0, &res);
+		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
+		priv->base = ioremap(res.start, resource_size(&res));
+		of_node_put(msgram_np);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	} else {
+		/* Otherwise, fall back to simple MMIO. */
+		priv->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	}
 
 	for (i = 0; i < priv->reg_stride; i++) {
 		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);
@@ -387,8 +402,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto unmap_base;
+	}
 
 	genpd = &priv->genpd;
 	genpd->flags = GENPD_FLAG_IRQ_SAFE;
@@ -451,6 +468,9 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	mbox_free_channel(priv->mbox_chan);
 remove_genpd:
 	pm_genpd_remove(genpd);
+unmap_base:
+	if (res.start)
+		iounmap(priv->base);
 	return ret;
 }
 

-- 
2.40.0

