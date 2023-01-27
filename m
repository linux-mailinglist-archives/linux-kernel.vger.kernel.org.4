Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A967E164
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjA0KSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjA0KSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:18:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F27E6FC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m7so4502198wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfpEfnGIjQr7bQPFSfFC9pAQfYSwfGfE35jAIEeJPDo=;
        b=lzO9Pc3lTB8/x7kTGKNNxuzwH1gdIzbxw4gskc/roD6dqJbtKjNs1ntcn3bR0cApR3
         0DlShIufHBHidmFQ3eGgP+ty0lF7O9QE+zwzreCebrCr8yib+UR3r7A60F7irRBuViZC
         joUvKy0j7tjrsLKCT8G8xYgpHhym9HmVXbFG/dPmhbLPQKLm+zLCgLx5m+RzahSg5N5M
         QIt8QdVxs/SxWk5ELVq5vTrHfMI3u9BnGeA1pgH5TGlI5BEKg//ZrsKhml9PgfkXf60n
         UKlMj4aFm3wYxsu/jWFHWJ5Bfcb36orW/oYlimoonRugLCIt7m6qBBqNizwP2Cy5V45T
         /tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfpEfnGIjQr7bQPFSfFC9pAQfYSwfGfE35jAIEeJPDo=;
        b=ZBcYiLrvLKbAReRVfM3ghNab5BOipZqHIIUr2AVxRL4PgkeOyfumyoGkMWbJkGNZg2
         3MBubFPCTxhDShhWDJY2xyw3YTapfrQSk7/4uUVbIYKuJ3kaUUwkTgaQe/B0xOYC3vr2
         s68Qy6A5jyXSYjGHcjFIoKGcFAgqyHmWNc81o0L54Es8xd2uAZQWkSe4qw4XsdcGoyKD
         qma7C0CLXHbmXOodIzbcIFADS9+LuQJmHX+rvB3v16cArcCvrDPU/4GqMFXKixsWzTtg
         lQupFw1yd7w22Df+iyg0u+l/bgjPU2jFaOsadQCL1HEn5i7pa9dsPBqF/2wDvZNn6wF+
         hV8w==
X-Gm-Message-State: AFqh2kpz6kipOLUqjP+R2M/Op1N1sjyhGWD4y1FPj+VIhl9zPfw3yXVG
        bnfORmvDIZe3fCCXDinuvGMZgg==
X-Google-Smtp-Source: AMrXdXskJLfclmoNt1rqBKCfNDujf3mErEVf5ONxUJA/bWtUE9dzdIgVazg8M7W+AxsyBqqMbKVttA==
X-Received: by 2002:adf:d1c7:0:b0:2be:544c:fe2c with SMTP id b7-20020adfd1c7000000b002be544cfe2cmr29452359wrd.25.1674814714070;
        Fri, 27 Jan 2023 02:18:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm3646706wro.8.2023.01.27.02.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ixp4xx: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:31 +0100
Message-Id: <20230127101832.93789-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts        | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts      | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts    | 2 +-
 arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts     | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts      | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts  | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts  | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts    | 4 ++--
 arch/arm/boot/dts/intel-ixp42x-ixdp425.dts           | 4 ++--
 arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts          | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts     | 4 ++--
 arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts    | 6 +++---
 arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts   | 4 ++--
 arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts  | 2 +-
 arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts  | 6 +++---
 arch/arm/boot/dts/intel-ixp43x-kixrp435.dts          | 4 ++--
 arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi | 2 +-
 17 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts b/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
index bd4230d7dac9..765ab36e6f0c 100644
--- a/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-adi-coyote.dts
@@ -56,7 +56,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from Coyote PCI boardfile.
@@ -80,7 +80,7 @@ pci@c0000000 {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -102,7 +102,7 @@ phy5: ethernet-phy@5 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts b/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
index 92b987bc3f99..6f5b4e4eb1cc 100644
--- a/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-arcom-vulcan.dts
@@ -112,7 +112,7 @@ watchdog@5,0 {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from Vulcan PCI boardfile.
@@ -137,7 +137,7 @@ pci@c0000000 {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -159,7 +159,7 @@ phy1: ethernet-phy@1 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts b/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
index 5ab09fb10dae..b9d46eb06507 100644
--- a/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-dlink-dsm-g600.dts
@@ -122,7 +122,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from DSM-G600 PCI boardfile (dsmg600-pci.c)
diff --git a/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts b/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
index b740403b05a9..5a5e16cc7335 100644
--- a/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-freecom-fsg-3.dts
@@ -159,7 +159,7 @@ led@0,5 {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Written based on the FSG-3 PCI boardfile.
@@ -187,7 +187,7 @@ pci@c0000000 {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -209,7 +209,7 @@ phy5: ethernet-phy@5 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts b/arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts
index b7cbc90e1c18..4d70f6afd13a 100644
--- a/arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-gateway-7001.dts
@@ -53,7 +53,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from Gateway 7001 PCI boardfile (gateway7001-pci.c)
@@ -74,7 +74,7 @@ pci@c0000000 {
 		};
 
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -91,7 +91,7 @@ phy1: ethernet-phy@1 {
 		};
 
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts b/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
index a5943f51e8c2..97e3f25bb210 100644
--- a/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-gateworks-gw2348.dts
@@ -108,7 +108,7 @@ ide@1,0 {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from Avila PCI boardfile.
@@ -142,7 +142,7 @@ pci@c0000000 {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -164,7 +164,7 @@ phy1: ethernet-phy@1 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts b/arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts
index f80388b17a9e..9ec0169bacf8 100644
--- a/arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-goramo-multilink.dts
@@ -82,7 +82,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * The device has 4 slots (IDSEL) with one dedicated IRQ per slot.
@@ -148,7 +148,7 @@ hss@1 {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 32>;
 			phy-mode = "rgmii";
@@ -170,7 +170,7 @@ phy1: ethernet-phy@1 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 33>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts b/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
index cbc87b344f6a..8da6823e1dbe 100644
--- a/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-iomega-nas100d.dts
@@ -109,7 +109,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from NAS 100D PCI boardfile (nas100d-pci.c)
@@ -129,7 +129,7 @@ pci@c0000000 {
 		};
 
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-ixdp425.dts b/arch/arm/boot/dts/intel-ixp42x-ixdp425.dts
index beaadda4685f..194945748dc3 100644
--- a/arch/arm/boot/dts/intel-ixp42x-ixdp425.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-ixdp425.dts
@@ -40,7 +40,7 @@ partitions {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -62,7 +62,7 @@ phy1: ethernet-phy@1 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts b/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
index f17cab12a64b..7011fea6205b 100644
--- a/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-ixdpg425.dts
@@ -61,7 +61,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from IXDPG425 PCI boardfile.
@@ -95,7 +95,7 @@ pci@c0000000 {
 
 		/* EthB */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -117,7 +117,7 @@ phy5: ethernet-phy@5 {
 
 		/* EthC */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts b/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
index 0edc5928e00b..da1e93212b86 100644
--- a/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
@@ -116,7 +116,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from NSLU2 PCI boardfile, INT A, B, C swizzled D constant
@@ -143,7 +143,7 @@ pci@c0000000 {
 		};
 
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts b/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
index 5e7e31b74b04..4aba9e0214a0 100644
--- a/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-linksys-wrv54g.dts
@@ -117,7 +117,7 @@ partition@240000 {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * We have up to 2 slots (IDSEL) with 2 swizzled IRQs.
@@ -141,7 +141,7 @@ pci@c0000000 {
 		 * Do we need a new binding and property for this?
 		 */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
@@ -165,7 +165,7 @@ phy5: ethernet-phy@5 {
 
 		/* EthC - connected to KS8995 switch port 5 */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts b/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts
index df2ca6d95ee5..19d56e9aec9d 100644
--- a/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-netgear-wg302v1.dts
@@ -54,7 +54,7 @@ partitions {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from WG302 v2 PCI boardfile (wg302v2-pci.c)
@@ -77,7 +77,7 @@ pci@c0000000 {
 		};
 
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts b/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
index b444003c10e1..c550c421b659 100644
--- a/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
+++ b/arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
@@ -79,7 +79,7 @@ partition@fff000 {
 
 		/* LAN port */
 		ethernet@c8009000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 3>;
 			queue-txready = <&qmgr 20>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts b/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
index cf4010d60187..1db849515f9e 100644
--- a/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
+++ b/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
@@ -121,7 +121,7 @@ ide@3,0 {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * In the boardfile for the Cambria from OpenWRT the interrupts
@@ -167,7 +167,7 @@ pci@c0000000 {
 		};
 
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
@@ -188,7 +188,7 @@ phy2: ethernet-phy@2 {
 		};
 
 		ethernet@c800c000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 2>;
 			queue-txready = <&qmgr 19>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp43x-kixrp435.dts b/arch/arm/boot/dts/intel-ixp43x-kixrp435.dts
index 3d7cfa1a5ed4..4703a8b24765 100644
--- a/arch/arm/boot/dts/intel-ixp43x-kixrp435.dts
+++ b/arch/arm/boot/dts/intel-ixp43x-kixrp435.dts
@@ -36,7 +36,7 @@ partitions {
 
 		/* CHECKME: ethernet set-up taken from Gateworks Cambria */
 		ethernet@c800a000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 4>;
 			queue-txready = <&qmgr 21>;
 			phy-mode = "rgmii";
@@ -57,7 +57,7 @@ phy2: ethernet-phy@2 {
 		};
 
 		ethernet@c800c000 {
-			status = "ok";
+			status = "okay";
 			queue-rx = <&qmgr 2>;
 			queue-txready = <&qmgr 19>;
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi b/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
index 146352ba848b..31c0a69771c4 100644
--- a/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
+++ b/arch/arm/boot/dts/intel-ixp4xx-reference-design.dtsi
@@ -99,7 +99,7 @@ fs@800000 {
 		};
 
 		pci@c0000000 {
-			status = "ok";
+			status = "okay";
 
 			/*
 			 * Taken from IXDP425 PCI boardfile.
-- 
2.34.1

