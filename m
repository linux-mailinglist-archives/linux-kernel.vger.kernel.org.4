Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2255736850
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFTJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFTJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:48:04 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D87F3F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wU8Ie
        13gmhuczqUhzOFuP6vAwh58ReysXrVNUirzfUE=; b=GC2ldmreyh2Saxl/FHTUO
        VrQpzdOc2TsGLUTx/Nhhlugkz/WvUJaZrMGBAC/AxDlVQQ1hTV+CBh8XbGVubpZY
        DsBj1eUl/eV/MY/U+bmhSKlW0MMNTfyLknSX9vM54ISSM1Vu/hoa2b6Cx0tuLrrV
        obbESOjNDz0UuZjtZNSBmw=
Received: from openarena.loongson.cn (unknown [114.242.206.180])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wAXg3CldZFkB8yiAQ--.11241S3;
        Tue, 20 Jun 2023 17:47:18 +0800 (CST)
From:   Sui Jingfeng <18949883232@163.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v10 01/11] drm/etnaviv: Add a dedicated function to register an irq handler
Date:   Tue, 20 Jun 2023 17:47:06 +0800
Message-Id: <20230620094716.2231414-2-18949883232@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620094716.2231414-1-18949883232@163.com>
References: <20230620094716.2231414-1-18949883232@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXg3CldZFkB8yiAQ--.11241S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1UXr15Kr4rtw13uw43trb_yoW8uw4Dpa
        n7JFyYkr18Ca42g34fAF98XFyYkr1xuayIywnrt3sIk398Jrs8tryFyF1jqFyfAr95Ga13
        tr1jqFWUu3W5ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLiSdUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprymkizyyjjits6il2tof0z/1tbiEwmU0WE17eMXkQACsB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Because getting IRQ from a device is platform-dependent, PCI devices have
different methods for getting an IRQ. This patch is a preparation to extend
this driver for supporting the PCI devices.

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index de8c9894967c..a03e81337d8f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1817,6 +1817,27 @@ static const struct of_device_id etnaviv_gpu_match[] = {
 };
 MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
 
+static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
+{
+	struct device *dev = gpu->dev;
+	int err;
+
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_irq(dev, irq, irq_handler, 0, dev_name(dev), gpu);
+	if (err) {
+		dev_err(dev, "failed to request irq %u: %d\n", irq, err);
+		return err;
+	}
+
+	gpu->irq = irq;
+
+	dev_info(dev, "irq(%d) handler registered\n", irq);
+
+	return 0;
+}
+
 static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1837,16 +1858,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 		return PTR_ERR(gpu->mmio);
 
 	/* Get Interrupt: */
-	gpu->irq = platform_get_irq(pdev, 0);
-	if (gpu->irq < 0)
-		return gpu->irq;
-
-	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
-			       dev_name(gpu->dev), gpu);
-	if (err) {
-		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
+	err = etnaviv_gpu_register_irq(gpu, platform_get_irq(pdev, 0));
+	if (err)
 		return err;
-	}
 
 	/* Get Clocks: */
 	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
-- 
2.25.1

