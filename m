Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F876F7E20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjEEHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjEEHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:47:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3121F150E8;
        Fri,  5 May 2023 00:47:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so14525795e9.0;
        Fri, 05 May 2023 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683272839; x=1685864839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNV1oA5bifbHrVzVGDwGABZ92MbgAi9sOiOOiEw4RrY=;
        b=lkg+LH04TwCQLhmLbRKDg/dBJWQ7XdfptJmigPx/HjYBXY0JRepARb5d/8OAgeih30
         3s4tXEUw9Eyzzf6rPHJisFmt66eFJtGTRs0+k7bGdujqpSbJM4E5IQ7BCKaxvynwbRGA
         mJV3MzMugU0NIXgPwW4Ydux0lvBTjIwHjJw13UBxeyldqBJyTDc8XMZydN5t31/e1Ql/
         Gz32EkDcx+AeFOVED0YbBJ8E0NpUnnrwX5MhiJJ1kkFyR7H4D8l+1EL8ZOeYFjy5m2zh
         rJr/4WDj4rDXo6MBKHzKd+T57LDftmdNnEZgDlp6IQW/vY/Ec/nq7wWhUtLHN9iY7Ppq
         7HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683272839; x=1685864839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNV1oA5bifbHrVzVGDwGABZ92MbgAi9sOiOOiEw4RrY=;
        b=fs0RjwE2Uro00xD/fuSxsHN3z7qiJOlMXC7xIZYEp/Vkq8k8lQHbegNYQg+lYPR3qC
         V7G0iUyNLmomqUaavWy8tBs0i6yqQOuX4BZqY6VYKzR2ejRcxOXaOUfTAhslUTSQlyFr
         J4cIcA8AlnofjiEXd1PtAPSaRG4AQNW2gZd8jZeyZGx1fpAR3fo66qvWBzmORTrKLLK7
         HR0LSuu+7MY66TzDm2LisSsxDZZW8eAp+pVEn3cFLppJOTX1+HJc3kFQufghYEj8OdPO
         XBoKIZlrgXQHNfvYIz2RqZ/YVMkd7SHKiMQ6LTpWAXdbWxCUnmHzSa2lnEpZGcd1O51n
         Hekg==
X-Gm-Message-State: AC+VfDx3N/faWZsTH24Z7sbz2skzYK87wjmgfaAQalf/Z5XbyOLSfqME
        KQCMTjjJUgDtw+hU2vcN4ks=
X-Google-Smtp-Source: ACHHUZ78e8aWw5mYmh7dTuHHV6lAjpYMYlKpnXW26CWTb45fLRd/NUafiy9B/9qFUCG0CUV5EcoWJw==
X-Received: by 2002:a1c:4b0a:0:b0:3ee:96f0:ea31 with SMTP id y10-20020a1c4b0a000000b003ee96f0ea31mr375663wma.18.1683272839493;
        Fri, 05 May 2023 00:47:19 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d5648000000b003062cdc6ac5sm1482198wrw.89.2023.05.05.00.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:47:19 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     robh+dt@kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: allwinner: d1: Add SPI0 controller node
Date:   Fri,  5 May 2023 10:46:51 +0300
Message-Id: <20230505074701.1030980-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards form the MangoPi family (MQ\MQ-Dual\MQ-R) may have
an optional SPI flash that connects to the SPI0 controller.
This controller is already supported by sun8i-h3-spi driver.
So let's add its DT node.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..d2de211d67d7 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -108,6 +108,12 @@ rmii_pe_pins: rmii-pe-pins {
 				function = "emac";
 			};
 
+			/omit-if-no-ref/
+			spi0_pins: spi0-pins {
+				pins = "PC2", "PC3", "PC4", "PC5";
+				function = "spi0";
+			};
+
 			/omit-if-no-ref/
 			uart1_pg6_pins: uart1-pg6-pins {
 				pins = "PG6", "PG7";
@@ -447,6 +453,20 @@ mmc2: mmc@4022000 {
 			#size-cells = <0>;
 		};
 
+		spi0: spi@4025000 {
+			compatible = "allwinner,sun8i-h3-spi";
+			reg = <0x04025000 0x300>;
+			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		usb_otg: usb@4100000 {
 			compatible = "allwinner,sun20i-d1-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.39.2

