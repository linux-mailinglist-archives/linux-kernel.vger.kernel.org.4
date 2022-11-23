Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8912636210
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiKWOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiKWOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:41:36 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541FD58039
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:41:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:881b:815b:474d:c3fd])
        by laurent.telenet-ops.be with bizsmtp
        id nqhS2800e49U0Rd01qhSaN; Wed, 23 Nov 2022 15:41:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwI-001Rqi-06; Wed, 23 Nov 2022 15:41:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxqwH-0012HT-3W; Wed, 23 Nov 2022 15:41:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/6] memory: renesas-rpc-if: Always use dev in rpcif_probe()
Date:   Wed, 23 Nov 2022 15:41:19 +0100
Message-Id: <298009c43ad119703f564c0f1864743914b4beeb.1669213027.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669213027.git.geert+renesas@glider.be>
References: <cover.1669213027.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rpcif_probe() already has a "dev" variable pointing to the right device
structure, so there is no need to take a detour through the platform
device.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Combination of the old "memory: renesas-rpc-if: Always use dev in
    rpcif_sw_init()" and "memory: renesas-rpc-if: Add dev helper to
    rpcif_probe()" after rebasing on top of the two fixes.
---
 drivers/memory/renesas-rpc-if.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 42c5f9f10135b86a..83171242f9514c22 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -688,9 +688,9 @@ static int rpcif_probe(struct platform_device *pdev)
 	const char *name;
 	int ret;
 
-	flash = of_get_next_child(pdev->dev.of_node, NULL);
+	flash = of_get_next_child(dev->of_node, NULL);
 	if (!flash) {
-		dev_warn(&pdev->dev, "no flash node found\n");
+		dev_warn(dev, "no flash node found\n");
 		return -ENODEV;
 	}
 
@@ -700,12 +700,12 @@ static int rpcif_probe(struct platform_device *pdev)
 		name = "rpc-if-hyperflash";
 	} else	{
 		of_node_put(flash);
-		dev_warn(&pdev->dev, "unknown flash type\n");
+		dev_warn(dev, "unknown flash type\n");
 		return -ENODEV;
 	}
 	of_node_put(flash);
 
-	rpc = devm_kzalloc(&pdev->dev, sizeof(*rpc), GFP_KERNEL);
+	rpc = devm_kzalloc(dev, sizeof(*rpc), GFP_KERNEL);
 	if (!rpc)
 		return -ENOMEM;
 
@@ -734,9 +734,9 @@ static int rpcif_probe(struct platform_device *pdev)
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
-	vdev->dev.parent = &pdev->dev;
+	vdev->dev.parent = dev;
 
-	rpc->dev = &pdev->dev;
+	rpc->dev = dev;
 	rpc->vdev = vdev;
 	platform_set_drvdata(pdev, rpc);
 
-- 
2.25.1

