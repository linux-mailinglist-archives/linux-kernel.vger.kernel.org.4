Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2A6DAB79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbjDGKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbjDGKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:23:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0F7ED3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:23:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-947abd74b10so205203566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1680863014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+qP6sIqw2JeqwkoX2od0pG8BYiMF1HbH0eIPQIxtYc=;
        b=MISQ9pXx9p/bX0BTFfQPN8k20XhK3myDqo6ukjMGi8UDpiJXcKBaVlqcDVypW97kiA
         7xeK2hntMRPZxOOrUNqI0hEAm5gQmU/EJ3DkmqB7llXWvVFJ4VsDk7ZAgxTtNdx/69TY
         wVNmQYQDzNE8xuzf86/SqRdMeOk1wMAHQ+H99ZpfTAMkAOO+MTCSAxwcOboAxEC6bqye
         ul9RiERuQsiH73XEPePNRy1uCvOKkR/XtNimCuo6xug2qeZUXBeQ2Kca3KV6gpwAH0pk
         qn0ywdgCJyVKN3qxIIjv8zW2VtB5bl+lbd9zUVnr255kxrzBuukhlQBwICvmQg3bJKGC
         wziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680863014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+qP6sIqw2JeqwkoX2od0pG8BYiMF1HbH0eIPQIxtYc=;
        b=oSO1RaA3pg7UEoFixbrCRqvpdfLoJ73qWLBTNRt/D4Ygj+A8KYeMvgO/8Ke61XFyQn
         SgoPvAdBc+zXuHlj+V/NhrAyzZL70a02Exl17HkPk7Ty8iIKzE0lzFW5lQZP4hVvN4Ia
         KE1qz8xi+l0QW/wn+j8uGwMZGbuv+8rdDTxf06SCyLi/GXGG+I3kZc7w86LGmEiuPM77
         vb8Bl5TIytJfxJpjXhwxxlIu9Xj9YVu0/WlhTx/wbMRg/eeWU2F+P2sZFKeOUL3puPdN
         0oTkoeNaBkXSoYGHGAvaa9QvqgTbfimLxD2gqO/dM4gH5mGyXxPW7QBUv90BROndQnt6
         +S/Q==
X-Gm-Message-State: AAQBX9fsvT3LhGFtYtcJFBuntlONIXV0m63WgmKOxU5Qv7HQBlYY3Oog
        jB6xv79ONVq9hL+K/iYlNdzrZw==
X-Google-Smtp-Source: AKy350Y2j/WGhiTljOkEjeQRadca20tSOMEG/fGCjdOQz5Y6lsaNwr2HPJoG6C0bVRAd7B4nm2UQMQ==
X-Received: by 2002:a05:6402:1043:b0:4fe:9689:96bb with SMTP id e3-20020a056402104300b004fe968996bbmr1797741edu.35.1680863013998;
        Fri, 07 Apr 2023 03:23:33 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906014700b00932fa67b48fsm1892612ejh.183.2023.04.07.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 03:23:33 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
Date:   Fri,  7 Apr 2023 12:23:23 +0200
Message-Id: <20230407102324.42604-2-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230407102324.42604-1-maarten.zanders@mind.be>
References: <20230407102324.42604-1-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding to configure the internal charge pump for lp55xx.

Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    v1: implement as bool to disable charge pump
    v2: rewrite to use string configuration, supporting all modes
    v3: simplification by replacing string option by u8 constant,
        removing previous Reviewed-by tags as it's a complete
        rewrite of the patch.
    v4: added notes
    v5: dual license, change property type to u32
    v6: change license type for leds-lp-55xx.h to preferred tag

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
index 000000000000..a4fb4567715d
--- /dev/null
+++ b/include/dt-bindings/leds/leds-lp55xx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
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

