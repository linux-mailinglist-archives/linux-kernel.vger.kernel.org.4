Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E80675D57
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjATTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjATTCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:40 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81072BF8A5;
        Fri, 20 Jan 2023 11:02:33 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15ebfdf69adso7367248fac.0;
        Fri, 20 Jan 2023 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6gBQQgTi4K3Y99K1tsHxOMMy9BG9zhs5uBNfgpAj1A=;
        b=EgIBICgKIBipBfwSWWMa8ggl7BQSSomW1dcuUEpM8OqWVn78MmHecIUszpyI1Y9V8h
         cqRDoGlGHzxS3qgJsWwjNBSHAWGPEjwuDbiiSKCiWBLXbDcxGFhktrH6W/2y1kWUe8zu
         lYTr27JxgKASsC67XkOUa2uOxgb4Tuq5RpiGk5H71gOXb8clRQthKzpM1jAYSoL0BxNO
         63XW9c/LefvLWLgYF0A8UPD0U+H05/VwgEHUH4hX2KEhnlZ32fJDtnL+5kS4yUCgs2BG
         gf8GmMCIfpc0Fkv/v6OcPNex6ahR8c0m82IueUtNUkZZqGTgGcYVg2fRXD175xWaRZXJ
         cLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6gBQQgTi4K3Y99K1tsHxOMMy9BG9zhs5uBNfgpAj1A=;
        b=SRk7ftl9jI07Bu5ndPdJ7L+BqgCpxzjkcoKIrEyVc6OUuEmm7uaWBGjYWV807/BAPL
         ZAPDhxJA5K7XuWsUMWmmWSUYm3A3gGgFjPHvnIJ6tyGBuwIN1KJab0DsOchiKLfBYBvi
         bkIYYTLeZVAb9w5ltYXdbjxM1NjCWnQuSFSOvXqCiis8H9dxOWZN3kh47OxrT7mG02tH
         yEYRyoFpcgxKV6g662EDPseUGdHkJ+LtB0n+4q185VFpEqMfDLSjsYLXLfHhpFXaEwUC
         5qBFwSksW0dCghc9XyA6vp9CVB+On89CbGViWnMrT3Jg6NaEMN5ovRWHfLJphccqwPxD
         Hruw==
X-Gm-Message-State: AFqh2koTUv7rykgzSHV17gaf74AhXyDu/t6rGG/Zr6HsEvbb1l2cNs4a
        /n+arfmgxZATsv3H6LTlm0o=
X-Google-Smtp-Source: AMrXdXsfVnfCWclXty8MjyIts8pscLYhQIZ1F1otPOxetglspQ4E28CZd1ifr07mW2iZUK2DaQQSxg==
X-Received: by 2002:a05:6870:ed49:b0:144:57b1:c8cf with SMTP id ex9-20020a056870ed4900b0014457b1c8cfmr8460943oab.47.1674241353197;
        Fri, 20 Jan 2023 11:02:33 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:32 -0800 (PST)
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
Subject: [PATCH 5/6] dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
Date:   Fri, 20 Jan 2023 11:01:46 -0800
Message-Id: <20230120190147.718976-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120190147.718976-1-opendmb@gmail.com>
References: <20230120190147.718976-1-opendmb@gmail.com>
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
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml b/Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
index 9fe079917a98..a9199f299a68 100644
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
@@ -42,3 +49,12 @@ examples:
         interrupt-parent = <&aon_pm_l2_intc>;
         clocks = <&upg_fixed>;
     };
+
+  - |
+    rtc@f041a080 {
+        compatible = "brcm,brcmstb-waketimer";
+        reg = <0xf041a080 0x14>;
+        interrupts-extended = <&aon_pm_l2_intc 0x04>,
+                              <&upg_aux_aon_intr2_intc 0x08>;
+        clocks = <&upg_fixed>;
+    };
-- 
2.25.1

