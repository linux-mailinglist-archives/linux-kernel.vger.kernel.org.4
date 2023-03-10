Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62066B470D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjCJOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjCJOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:30 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4712117B;
        Fri, 10 Mar 2023 06:47:13 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-176b48a9a05so6135328fac.0;
        Fri, 10 Mar 2023 06:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OloxL41416j0dtlZQrOwSKVoKWWxTAqOsy1vcR6cR6w=;
        b=zoF4kDNEDYdtD8udASlTO6I6boLG0OOTU9ptoMm4On6U17+Pt0UEHI1vmECPBqJ/Fq
         /2ZJZm4ZMLs/OBx64SjcW31GaW92sojCaBq7w/vILUuuHqWxPxgJewAK7SY0tl8CdVbf
         TrGdP6fwKpJHqAaVeSlSQmSOSx5HQdjZiOAfGc9+q4ouzUbfLFolociaXCwWKSaHkiRG
         eOIIcemkQ7oAiKDCuZeSLXfAUWFmYGpMREjq5wqT+peCtIqn8lFxGALej+X2JnIcJ5YF
         f6ykthSpC0Om7AgDei1U8+6pku3Fqs8mXpl01uwfjoi4znECDnC4APvZJvNpnVgdh4Ft
         L24g==
X-Gm-Message-State: AO0yUKXo4jhMXUKZygTmBAA6JL/5FXpxaBNUNRTAEjMbz3lej+xz+FX1
        irIVymhA+Je4qjNB9ywZ5Q5znpMSiw==
X-Google-Smtp-Source: AK7set8cE4u5Ar/WSEdd16NF/1QGLSArsjjzwCLB+imXcXgcq/h7vUoNgg1qv4X2jNW3kiukcdtxwQ==
X-Received: by 2002:a05:6870:560a:b0:16e:7440:db73 with SMTP id m10-20020a056870560a00b0016e7440db73mr17913111oao.26.1678459630847;
        Fri, 10 Mar 2023 06:47:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s26-20020a05683004da00b00694303567b0sm129607otd.29.2023.03.10.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:10 -0800 (PST)
Received: (nullmailer pid 1541461 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ata: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:00 -0600
Message-Id: <20230310144700.1541414-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ata/ahci_mtk.c         | 2 +-
 drivers/ata/libahci_platform.c | 2 +-
 drivers/ata/sata_dwc_460ex.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index c056378e3e72..5714efe3f8e7 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -106,7 +106,7 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
 	struct device_node *np = dev->of_node;
 
 	/* enable SATA function if needed */
-	if (of_find_property(np, "mediatek,phy-mode", NULL)) {
+	if (of_property_present(np, "mediatek,phy-mode")) {
 		plat->mode = syscon_regmap_lookup_by_phandle(
 					np, "mediatek,phy-mode");
 		if (IS_ERR(plat->mode)) {
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index b9e336bacf17..f00da19670b0 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -363,7 +363,7 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
 	switch (rc) {
 	case -ENOSYS:
 		/* No PHY support. Check if PHY is required. */
-		if (of_find_property(node, "phys", NULL)) {
+		if (of_property_present(node, "phys")) {
 			dev_err(dev,
 				"couldn't get PHY in node %pOFn: ENOSYS\n",
 				node);
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 21d77633a98f..3a30e6eff8a8 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -810,7 +810,7 @@ static int sata_dwc_dma_get_channel(struct sata_dwc_device_port *hsdevp)
 	struct device *dev = hsdev->dev;
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!of_find_property(dev->of_node, "dmas", NULL))
+	if (!of_property_present(dev->of_node, "dmas"))
 		return sata_dwc_dma_get_channel_old(hsdevp);
 #endif
 
@@ -1180,7 +1180,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
-	if (!of_find_property(np, "dmas", NULL)) {
+	if (!of_property_present(np, "dmas")) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
 		if (err)
 			return err;
-- 
2.39.2

