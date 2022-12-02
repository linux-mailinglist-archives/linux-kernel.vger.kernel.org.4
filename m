Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8464057C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiLBLF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiLBLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:05:53 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246DBC5B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:05:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a19so5071931ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/MYWAzLrsiFv/kife7wjMs75KZhRzq7Qa+Mjizpr/0=;
        b=e9dLVlFZ6g3NZLVtx3jd9ZJMo1yjijb3LlpqvrlAT2O0mCpFQf5KcAa/CNU3C7yPuE
         nzgXnIf1oQ1ixZK+4E7SXCLouNNVSEMwAv+oTrnBTzd4TEihWsw65p40nT6EtcRYoleK
         //eARJM6h8w3XG1IYGMKUn5pYiXp5MfMEvp6wwTIcJfuz/HGmEs8AnA9DcPxAMMYlV04
         MYzvGiS2iy1jKuPv5q8/F2f3aRQgaFxS7vEFHmqsekUN6PWiY9GWl3fkkGT18f/L35mH
         HpEB8BT0EinF5/PejBu68SQlXcD2U9e8kCgxPoG0W2Y8N0jgBjrKliamf9stojUh1gkP
         CZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/MYWAzLrsiFv/kife7wjMs75KZhRzq7Qa+Mjizpr/0=;
        b=BAhg80wXM3KL0eUC/pOKH9XqPPBfUw065TaP9IkRqBSbuuVoaNGcMjVFoinzvPmpjj
         jq6b/4B/pnlP8VI8ix0oNYgjlOBeZqRw8dV4GvhIFUOWt+pTnUp+TovDIhHdZQg0AVkF
         i70WxGHLms4xjSmCIhoOr8b0dnT765V4mT/zhMYpY9u2g6V8Twp7CW+yOEhgjiGnV5Ki
         Ikn29d95ZGHCSE0GjkVXeaTlZPa5EqiOv1wPJefVNaCZZBN9aftbPLNLuHc+KFz3WpwY
         KKAJTk+JM9LXhVh18QwEqfdmJuFYWM+6hK2vmJ51iXpwf+JjHeT9FJwxlMrx9zKLRPfv
         Drbg==
X-Gm-Message-State: ANoB5pkj+OjbJpExX13xaMJYaADryuCaxLjX/P68H68XPachxpXVT84O
        Vvu5uRo2bIIYrc6eFycsZfiQ1w==
X-Google-Smtp-Source: AA0mqf5p2GN6tdQOaDO61vyYhvtBhYwCW2hqoggoR/3/VzjKQ488fykU9lScF73tXkfx+auCKMQGNA==
X-Received: by 2002:a2e:7e0a:0:b0:277:6f0:5239 with SMTP id z10-20020a2e7e0a000000b0027706f05239mr17465456ljc.186.1669979149097;
        Fri, 02 Dec 2022 03:05:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z5-20020a2eb525000000b0027973ba8718sm588267ljm.37.2022.12.02.03.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:05:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: vendor-prefixes: sort entries alphabetically
Date:   Fri,  2 Dec 2022 12:05:36 +0100
Message-Id: <20221202110536.22230-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort entries alphabetically.  This was a semi manual job with help of:

  cat Documentation/devicetree/bindings/vendor-prefixes.yaml | grep '":' > old
  cat old | sort > new
  diff -ubB old new

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch rebased on next-20221201 therefore might not apply cleanly to
Rob's tree. Probably should be taken after the 6.2-rc1.
---
 .../devicetree/bindings/vendor-prefixes.yaml  | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 10c178d97b02..7a27a8c5df49 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -198,10 +198,10 @@ patternProperties:
     description: Bosch Sensortec GmbH
   "^boundary,.*":
     description: Boundary Devices Inc.
-  "^broadmobi,.*":
-    description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^brcm,.*":
     description: Broadcom Corporation
+  "^broadmobi,.*":
+    description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^bsh,.*":
     description: BSH Hausgeraete GmbH
   "^bticino,.*":
@@ -547,6 +547,8 @@ patternProperties:
     description: Hitex Development Tools
   "^holt,.*":
     description: Holt Integrated Circuits, Inc.
+  "^holtek,.*":
+    description: Holtek Semiconductor, Inc.
   "^honestar,.*":
     description: Honestar Technologies Co., Ltd.
   "^honeywell,.*":
@@ -559,8 +561,6 @@ patternProperties:
     description: Hewlett Packard Enterprise
   "^hsg,.*":
     description: HannStar Display Co.
-  "^holtek,.*":
-    description: Holtek Semiconductor, Inc.
   "^huawei,.*":
     description: Huawei Technologies Co., Ltd.
   "^hugsun,.*":
@@ -605,12 +605,10 @@ patternProperties:
     description: Infineon Technologies
   "^inforce,.*":
     description: Inforce Computing
-  "^ingrasys,.*":
-    description: Ingrasys Technology Inc.
-  "^ivo,.*":
-    description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^ingenic,.*":
     description: Ingenic Semiconductor
+  "^ingrasys,.*":
+    description: Ingrasys Technology Inc.
   "^injoinic,.*":
     description: Injoinic Technology Corp.
   "^innocomm,.*":
@@ -647,6 +645,8 @@ patternProperties:
     description: ITEAD Intelligent Systems Co.Ltd
   "^itian,.*":
     description: ITian Corporation
+  "^ivo,.*":
+    description: InfoVision Optoelectronics Kunshan Co. Ltd.
   "^iwave,.*":
     description: iWave Systems Technologies Pvt. Ltd.
   "^jadard,.*":
@@ -895,14 +895,14 @@ patternProperties:
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
     description: Guangdong Neweast Optoelectronics CO., LTD
+  "^newhaven,.*":
+    description: Newhaven Display International
   "^newvision,.*":
     description: New Vision Display (Shenzhen) Co., Ltd.
   "^nexbox,.*":
     description: Nexbox
   "^nextthing,.*":
     description: Next Thing Co.
-  "^newhaven,.*":
-    description: Newhaven Display International
   "^ni,.*":
     description: National Instruments
   "^nintendo,.*":
@@ -1051,10 +1051,10 @@ patternProperties:
     description: QEMU, a generic and open source machine emulator and virtualizer
   "^qi,.*":
     description: Qi Hardware
-  "^qihua,.*":
-    description: Chengdu Kaixuan Information Technology Co., Ltd.
   "^qiaodian,.*":
     description: QiaoDian XianShi Corporation
+  "^qihua,.*":
+    description: Chengdu Kaixuan Information Technology Co., Ltd.
   "^qishenglong,.*":
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
@@ -1081,22 +1081,22 @@ patternProperties:
     description: reMarkable AS
   "^renesas,.*":
     description: Renesas Electronics Corporation
-  "^rex,.*":
-    description: iMX6 Rex Project
   "^rervision,.*":
     description: Shenzhen Rervision Technology Co., Ltd.
   "^revotics,.*":
     description: Revolution Robotics, Inc. (Revotics)
+  "^rex,.*":
+    description: iMX6 Rex Project
   "^richtek,.*":
     description: Richtek Technology Corporation
   "^ricoh,.*":
     description: Ricoh Co. Ltd.
   "^rikomagic,.*":
     description: Rikomagic Tech Corp. Ltd
-  "^riscv,.*":
-    description: RISC-V Foundation
   "^riot,.*":
     description: Embest RIoT
+  "^riscv,.*":
+    description: RISC-V Foundation
   "^rockchip,.*":
     description: Fuzhou Rockchip Electronics Co., Ltd
   "^rocktech,.*":
@@ -1159,6 +1159,8 @@ patternProperties:
     description: Si-En Technology Ltd.
   "^si-linux,.*":
     description: Silicon Linux Corporation
+  "^siemens,.*":
+    description: Siemens AG
   "^sifive,.*":
     description: SiFive, Inc.
   "^sigma,.*":
@@ -1181,8 +1183,8 @@ patternProperties:
     description: Siliconfile Technologies lnc.
   "^siliconmitus,.*":
     description: Silicon Mitus, Inc.
-  "^siemens,.*":
-    description: Siemens AG
+  "^silvaco,.*":
+    description: Silvaco, Inc.
   "^simtek,.*":
     description: Cypress Semiconductor Corporation (Simtek Corporation)
   "^sinlinx,.*":
@@ -1268,8 +1270,6 @@ patternProperties:
     description: Sun Microsystems, Inc
   "^supermicro,.*":
     description: Super Micro Computer, Inc.
-  "^silvaco,.*":
-    description: Silvaco, Inc.
   "^swir,.*":
     description: Sierra Wireless
   "^syna,.*":
@@ -1291,16 +1291,18 @@ patternProperties:
     description: Shenzhen City Tang Cheng Technology Co., Ltd.
   "^tdo,.*":
     description: Shangai Top Display Optoelectronics Co., Ltd
+  "^team-source-display,.*":
+    description: Shenzhen Team Source Display Technology Co., Ltd. (TSD)
   "^technexion,.*":
     description: TechNexion
   "^technologic,.*":
     description: Technologic Systems
+  "^techstar,.*":
+    description: Shenzhen Techstar Electronics Co., Ltd.
   "^teltonika,.*":
     description: Teltonika Networks
   "^tempo,.*":
     description: Tempo Semiconductor
-  "^techstar,.*":
-    description: Shenzhen Techstar Electronics Co., Ltd.
   "^terasic,.*":
     description: Terasic Inc.
   "^tesla,.*":
@@ -1354,10 +1356,6 @@ patternProperties:
     description: Tronsmart
   "^truly,.*":
     description: Truly Semiconductors Limited
-  "^visionox,.*":
-    description: Visionox
-  "^team-source-display,.*":
-    description: Shenzhen Team Source Display Technology Co., Ltd. (TSD)
   "^tsd,.*":
     description: Theobroma Systems Design und Consulting GmbH
   "^tyan,.*":
@@ -1366,10 +1364,10 @@ patternProperties:
     description: u-blox
   "^u-boot,.*":
     description: U-Boot bootloader
-  "^ucrobotics,.*":
-    description: uCRobotics
   "^ubnt,.*":
     description: Ubiquiti Networks
+  "^ucrobotics,.*":
+    description: uCRobotics
   "^udoo,.*":
     description: Udoo
   "^ugoos,.*":
@@ -1408,6 +1406,8 @@ patternProperties:
     description: Used for virtual device without specific vendor.
   "^vishay,.*":
     description: Vishay Intertechnology, Inc
+  "^visionox,.*":
+    description: Visionox
   "^vitesse,.*":
     description: Vitesse Semiconductor Corporation
   "^vivante,.*":
@@ -1422,6 +1422,8 @@ patternProperties:
     description: Vision Optical Technology Co., Ltd.
   "^vxt,.*":
     description: VXT Ltd
+  "^wanchanglong,.*":
+    description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":
     description: Wandbord (Technexion)
   "^waveshare,.*":
@@ -1462,8 +1464,6 @@ patternProperties:
     description: Wondermedia Technologies, Inc.
   "^wobo,.*":
     description: Wobo
-  "^wanchanglong,.*":
-    description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^x-powers,.*":
     description: X-Powers
   "^xen,.*":
@@ -1506,10 +1506,10 @@ patternProperties:
     description: Shenzhen Yashi Changhua Intelligent Technology Co., Ltd.
   "^ysoft,.*":
     description: Y Soft Corporation a.s.
-  "^zealz,.*":
-    description: Zealz
   "^zarlink,.*":
     description: Zarlink Semiconductor
+  "^zealz,.*":
+    description: Zealz
   "^zeitec,.*":
     description: ZEITEC Semiconductor Co., LTD.
   "^zidoo,.*":
-- 
2.34.1

