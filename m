Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441CC67F04A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjA0VR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA0VR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:17:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B961D918
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:17:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so4308149wmo.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2CqnTIkfAqED0CQ9aF9DG/sLx9ru/fz+pepxlbDILA=;
        b=NAX3/vBvZG6/s8AhSoJJmBMZWopusb2B7NRWdsTPrKQ+zYNDn+iIqAtAjx/ZNF2UI/
         z3gLvKp2c/AkrCr5LrzvdCUQqU8hbaW1501X9Y5CRgLlGbk0n/dnrxae/9qnBXbztRtO
         MDRSHFhM8UmFzozoJ9YVeODEQKnJaRB9tonDpCWa5OhWZNR+6TCfQwTs5EvPhiw3QUTW
         qPVZkPSlOl+0SHZCry8Dn8kiqHb6jkZ/TbgCWlRuLeHxgVISHhq2Bhv90LCpYx1vQ2aU
         lVM3dNPaKFw4pe8RpZaHUJ+4Rb0KfRlEdNqA89r8pEMAmM41fbS2bbduXT8EGKkWKbuA
         znlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2CqnTIkfAqED0CQ9aF9DG/sLx9ru/fz+pepxlbDILA=;
        b=aHdmbX4f90dCNaCTSTOTnJKGfUkWcRewp6vrOdnz/ggbjWm4q1fSQhS1a3ij4eozjc
         PixG4MkS4qrelQEBbCc8Sns4Q0t8TmJYVYrBgsxwVbWsRt0/xtN/D7TN42O7THJmrpX4
         jIH5BixfWs0sRpfXzfPFBJDIAYoclIMH/IghIxJUi5auD9bBDTKbQ19tYG1iSYKZw1Mr
         hZVsrjI+Y0vZsIjeA0WCiWolSdDccmV2yAAnUbLGafK5/4S8gSr62GSRg9V75PfxMM58
         pAmiRoibc1O2TwgMCeWXQPUc7xMA3QsHDQDbx+WfxibZQdrJrOceJdf+XCB6BELQ+xkt
         yZDA==
X-Gm-Message-State: AFqh2kqoW75I7AMDBuGCiMvz+v1mQ76QK+pm//34ZDh/wB44KXc7PahQ
        fh1FvXRRNUreo51uBHk1wENJIw==
X-Google-Smtp-Source: AMrXdXuAvXQR2Q0dQ5687sSwAmQYI3bktYVsYW/LUdQo+8U8qvC1x44cvRqs3S+hq8k5B0Me4mmBVQ==
X-Received: by 2002:a1c:7712:0:b0:3da:1e35:dfec with SMTP id t18-20020a1c7712000000b003da1e35dfecmr41853351wmi.4.1674854273942;
        Fri, 27 Jan 2023 13:17:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003dafb0c8dfbsm6080811wmg.14.2023.01.27.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:17:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: usb: samsung,exynos-dwc3: allow unit address in DTS
Date:   Fri, 27 Jan 2023 22:17:48 +0100
Message-Id: <20230127211748.260718-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung Exynos SoC USB 3.0 DWC3 Controller is a simple wrapper of
actual DWC3 Controller device node.  It handles necessary Samsung
Exynos-specific resources (regulators, clocks), but does not have its
own MMIO address space.

However neither simple-bus bindings nor dtc W=1 accept device nodes in
soc@ node which do not have unit address.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Use ranges with values and drop reg from usb-wrapper node.
2. Keep "usb" as wrapper's node name.

DTS fixes are here:
https://lore.kernel.org/linux-samsung-soc/20230127211527.260060-1-krzysztof.kozlowski@linaro.org/T/#t
---
 .../devicetree/bindings/usb/samsung,exynos-dwc3.yaml      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 6b9a3bcb3926..42ceaf13cd5d 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -108,19 +108,19 @@ examples:
     #include <dt-bindings/clock/exynos5420.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    usb {
+    usb@12000000 {
         compatible = "samsung,exynos5250-dwusb3";
         #address-cells = <1>;
         #size-cells = <1>;
-        ranges;
+        ranges = <0x0 0x12000000 0x10000>;
         clocks = <&clock CLK_USBD300>;
         clock-names = "usbdrd30";
         vdd33-supply = <&ldo9_reg>;
         vdd10-supply = <&ldo11_reg>;
 
-        usb@12000000 {
+        usb@0 {
             compatible = "snps,dwc3";
-            reg = <0x12000000 0x10000>;
+            reg = <0x0 0x10000>;
             interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
             phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
             phy-names = "usb2-phy", "usb3-phy";
-- 
2.34.1

