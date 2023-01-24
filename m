Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD867A3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjAXUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjAXUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:14:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D732A15E;
        Tue, 24 Jan 2023 12:14:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2402796pju.0;
        Tue, 24 Jan 2023 12:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll14lOuViaenf8FjC8Zh9d13ikWCf4/ACX98HmRIznQ=;
        b=ZAopVKkN0s7Png4zG+tuGkTd3xixUMd69So0uL2bMx5KZYtc59pIqZ4f2v8pmvU3AB
         Kv95PTiLofjK8wrWBwJZDyZmKerFogMJQE3VWtLiLWEbnfCFI9IBKwP2Fnkao1M50VV6
         jPwciYogW4lFiUwTsf7OxNMVtNrC1BOvo7FD2DvB62ARFsUh32Tw3rImxM28KOBudBZx
         o3DrAhuk052jHvkh1NKylSFBAdr/sH8ccp1r0dbjQOm+qfst19wDunhyd4k4SlIK/bLa
         lEHCOhLIuivm1krpd8+vkGHCDUaqD+GfMOc/C8jxl1H08Mio2yA+Tl3Jjyf37nv50I1Y
         o9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll14lOuViaenf8FjC8Zh9d13ikWCf4/ACX98HmRIznQ=;
        b=o/+ZTXdM5UNdPmo+6Rcvy8Q0ryT7CTmaQa7eb1ZHjQUkuCere5xp/yUklm3a01ZhjG
         PTt5ElEgCTmHeUZgVeYhrQ45a0MZzRGNLJvUTTiveT1yua15FW1d5IYs3qB1pTsfiQ9j
         IF59bEyKxW/DJ8Cq6lH9iNO6Ogve75IE8k/cU2rcy9kem+aZlcvlvxSl1NvVYnVnK76Q
         gukGbvuJ6JBStzfeSR7vkpQVRWAJtLyjFXf6vuzH/4gnXIzDKHj5g45HSukfRzdGGpRu
         1v7kYmqSMZIqX0srE4Xr7S8SFC1XPSdlDBrM2n0s5atyHZFXwy9GVwGDCAezz5kI6es0
         QxMg==
X-Gm-Message-State: AFqh2kq/I7v8weZos6PF3rjeZFDl1HQO9y6DcTYdGi76hMVZ9nkvKtex
        PcdovrnGXcVJH/pXem4XuMQ=
X-Google-Smtp-Source: AMrXdXtSLjjpmIZl5tzMLd8wwiQWRF3O8uIuMF/HEzETMHjTsG/sYrTi7X2oO1JsB5GcOA6m9vZ7Vg==
X-Received: by 2002:a17:902:ca13:b0:195:f265:66dc with SMTP id w19-20020a170902ca1300b00195f26566dcmr12490201pld.68.1674591291804;
        Tue, 24 Jan 2023 12:14:51 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b00174f61a7d09sm2057824pll.247.2023.01.24.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:14:51 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
Date:   Tue, 24 Jan 2023 12:14:29 -0800
Message-Id: <20230124201430.2502371-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124201430.2502371-1-opendmb@gmail.com>
References: <20230124201430.2502371-1-opendmb@gmail.com>
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

A second interrupt can optionally be specified for this device
to be used for generating RTC alarm interrupts.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
index 9fe079917a98..c6c57636c729 100644
--- a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
+++ b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
@@ -11,7 +11,8 @@ maintainers:
 
 description:
   The Broadcom STB wake-up timer provides a 27Mhz resolution timer, with the
-  ability to wake up the system from low-power suspend/standby modes.
+  ability to wake up the system from low-power suspend/standby modes and
+  optionally generate RTC alarm interrupts.
 
 allOf:
   - $ref: "rtc.yaml#"
@@ -24,8 +25,14 @@ properties:
     maxItems: 1
 
   interrupts:
-    description: the TIMER interrupt
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: the TIMER interrupt
+      - description: the ALARM interrupt
+    description:
+      The TIMER interrupt wakes the system from low-power suspend/standby modes.
+      An ALARM interrupt may be specified to interrupt the CPU when an RTC alarm
+      is enabled.
 
   clocks:
     description: clock reference in the 27MHz domain
@@ -35,10 +42,10 @@ additionalProperties: false
 
 examples:
   - |
-    rtc@f0411580 {
+    rtc@f041a080 {
         compatible = "brcm,brcmstb-waketimer";
-        reg = <0xf0411580 0x14>;
-        interrupts = <0x3>;
-        interrupt-parent = <&aon_pm_l2_intc>;
+        reg = <0xf041a080 0x14>;
+        interrupts-extended = <&aon_pm_l2_intc 0x04>,
+                              <&upg_aux_aon_intr2_intc 0x08>;
         clocks = <&upg_fixed>;
     };
-- 
2.25.1

