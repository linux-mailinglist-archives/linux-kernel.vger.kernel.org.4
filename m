Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117CE6942BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjBMKU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBMKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:20:54 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6531027E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:20:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id sa10so30499950ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hcdi8yudCq01YRZ7n/hBjJ5nuYzLbluvZbFoBNJpLKc=;
        b=IMHpDCxhKL9WyyEsWWaDeFfXqqj+Jq/HX73Urr5gos5F+ufXCev3/IU6mtUmj401yE
         AZ2MdkBSz+2IroMqQ/kRteMJz+NxEywGH3pgSXdWocfiZbeq5SJCxY1lhZLBGEMT6HfJ
         gco0fl7eVDwOzyzXK/B8dcZWcMEgboPsltKHASG0Pc8XyZFwb+r4A6zzDVte+42Op/Vj
         k9Cm16iAbWkjpqnmcCQTG88tkRjLTln63ecq2U3o7L1QWpb/9TK9dA0trbHmbIXJaLzY
         0zCGVLhHqVLMOV9S8IzZtxU6FbxV6K16dlZh7QOmUD2whUAsiXjCNq5iblqYPGJC1PJk
         SobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hcdi8yudCq01YRZ7n/hBjJ5nuYzLbluvZbFoBNJpLKc=;
        b=NYDCRmN/W2Wl8QYKjpqeTXocm82+VSy4JiQI017mMfinHekVFdHMZxNltGWk0h1gdx
         e09jA/AO92PHoc4gCxBYddGn89LKRp7qRsoPoEceYy7LgxksLg20+HZJ475BrDPbmGDl
         sJYX+LTOSIx6ToHkntzHtT6VQqe2IY5vznx2HCqt7vyotk+TeVj9MO+BDY1WySRtt0pV
         RC9RbJRP4w1a2EPB+driZX+Mb8YrWcrYeE5T4IA5hilZnzDcaPuCQpE7lTrPHdki09pd
         s+kJBxnsUjXWEFJtWlleHpJTnCmzWS4yL5rfxHAiOvvp2KH62dQx1L4ar8yBgcx2qFxr
         lATQ==
X-Gm-Message-State: AO0yUKUoI6C9wK6iDOmX5L+fhgEX0nv82B2PWQYFhzltifhaLMlTedF4
        pt1fFvkbWcss+HwjqVIsHfoTGg==
X-Google-Smtp-Source: AK7set+hrztEjBcXIEHC44xkN9i2Kk8qkVj30qAy1pJKLtuuGXyyeQaBLTh8jtw7DPSatvdxYVqb7w==
X-Received: by 2002:a17:906:d051:b0:86f:3dfa:4016 with SMTP id bo17-20020a170906d05100b0086f3dfa4016mr22553813ejb.7.1676283633613;
        Mon, 13 Feb 2023 02:20:33 -0800 (PST)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b00878003adeeesm6564552ejz.23.2023.02.13.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 02:20:33 -0800 (PST)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Date:   Mon, 13 Feb 2023 11:20:26 +0100
Message-Id: <20230213102027.29961-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230213102027.29961-1-maarten.zanders@mind.be>
References: <20230213102027.29961-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to configure the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---

Notes:
    v1: implement as bool to disable charge pump
    v2: rewrite to use string configuration, supporting all modes
    v3: simplification by replacing string option by u8 constant,
        removing previous Reviewed-by tags as it's a complete
        rewrite of the patch.
    v4: added notes
    v5: dual license, change property type to u32

 .../devicetree/bindings/leds/leds-lp55xx.yaml          |  8 ++++++++
 include/dt-bindings/leds/leds-lp55xx.h                 | 10 ++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index ae607911f1db..ede9cb9ca175 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -66,6 +66,12 @@ properties:
   '#size-cells':
     const: 0
 
+  ti,charge-pump-mode:
+    description:
+      Set the operating mode of the internal charge pump as defined in
+      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 patternProperties:
   '^multi-led@[0-8]$':
     type: object
@@ -152,6 +158,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/leds/leds-lp55xx.h>
 
     i2c {
         #address-cells = <1>;
@@ -164,6 +171,7 @@ examples:
             reg = <0x32>;
             clock-mode = /bits/ 8 <2>;
             pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
+            ti,charge-pump-mode = <LP55XX_CP_BYPASS>;
 
             led@0 {
                 reg = <0>;
diff --git a/include/dt-bindings/leds/leds-lp55xx.h b/include/dt-bindings/leds/leds-lp55xx.h
new file mode 100644
index 000000000000..e2256312714b
--- /dev/null
+++ b/include/dt-bindings/leds/leds-lp55xx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+#ifndef _DT_BINDINGS_LEDS_LP55XX_H
+#define _DT_BINDINGS_LEDS_LP55XX_H
+
+#define LP55XX_CP_OFF		0
+#define LP55XX_CP_BYPASS	1
+#define LP55XX_CP_BOOST		2
+#define LP55XX_CP_AUTO		3
+
+#endif /* _DT_BINDINGS_LEDS_LP55XX_H */
-- 
2.37.3

