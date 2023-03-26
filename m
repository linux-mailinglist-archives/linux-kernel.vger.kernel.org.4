Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727426C97D0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCZUmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCZUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:42:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF55FD4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er18so16708918edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew1SyOgc+Q7GMXF7T6us3Qow14K/abD5i3gh3lFcCZY=;
        b=eXnSIZRA/7ZdDiZvFi+IsTCSk8BkvQg/VUKSIjFwB4QqOUvjzxtxA9lz+E7pSv/mj8
         jrf1Mu8CCKgfI49hv5O2h1vnZ0MhIjDzxf6t6FeQEZFvdndIPH5MYqBy3AYwDpLtbzvP
         9Sspdyc2fg09jMucuaLd+o3u2I1NIRi2avI/4VLnh6Fck7V0TlzMrBGkJhCc+gRb0lK0
         Dzr2iiteUUbIVrN7EyfnhYp+MoQgaidey7ta6UwB36TR9VCUrN/QASOh5x/LYPVJiyLV
         65Kmn+NwJN4aO4hhG8IuGMU3xNrOMUJghDnNp7BBy8IKp4BZShiZQZKDXirJtec9tLk7
         DPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew1SyOgc+Q7GMXF7T6us3Qow14K/abD5i3gh3lFcCZY=;
        b=J7SswqsyVs5GWNwDj8MX90Udbk7NbYQ8BCcgKWCncpFBmmJIzNOyQOwLcfJCaB/6uw
         JJtBykUiZ3yQQ66pZm1Y2WWwPzRRP5F0dxwGeJSPvEvExvKMKAsrUaCARbQ8Fdfa1N+P
         29xXImaV+klN+GmtI7dLv6xMCtNUR9J9w1wG6lgiZK+rcHSqhyazYb72f4zqZ7fq05Uz
         Gquafe6eWOdi8gKrmfvPnVGxeg7Zj0vsUJhIWCLHmLcWphQxNydd5b9TuP4oxWSjMVhl
         8DkFJxmALBTrty65SOfAkMUJ+ASQlRIO6FLvPUfPN+xLMh7wExYval+bJm50ZAvjHi7O
         s1iQ==
X-Gm-Message-State: AAQBX9c3u+syrg9Haw81oitovGJhs6vXYhc+3vj9ExPJRYdC5YppaXrk
        2MhbEZmjImJ878iW4sgfuwnzaw==
X-Google-Smtp-Source: AKy350b8Qq2nfe1wFdmZ/iGhbbovdEBefSjUAKlu3sDWABfuoBZNwk2iQv9QSajhWclgO8UNpcL1yg==
X-Received: by 2002:a17:906:facb:b0:93b:752:d2a9 with SMTP id lu11-20020a170906facb00b0093b0752d2a9mr10277563ejb.31.1679863350701;
        Sun, 26 Mar 2023 13:42:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b009255b14e91dsm13286144ejc.46.2023.03.26.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:42:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] dt-bindings: display: sitronix,st7701: document port and rotation
Date:   Sun, 26 Mar 2023 22:42:24 +0200
Message-Id: <20230326204224.80181-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
References: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panels are supposed to have one port (defined in panel-common.yaml
binding) and can have also rotation:

  rk3326-odroid-go3.dtb: panel@0: 'port', 'rotation' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/sitronix,st7701.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index 83d30eadf7d9..4dc0cd4a6a77 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -42,7 +42,9 @@ properties:
   IOVCC-supply:
     description: I/O system regulator
 
+  port: true
   reset-gpios: true
+  rotation: true
 
   backlight: true
 
@@ -51,6 +53,7 @@ required:
   - reg
   - VCC-supply
   - IOVCC-supply
+  - port
   - reset-gpios
 
 additionalProperties: false
@@ -70,5 +73,11 @@ examples:
             IOVCC-supply = <&reg_dldo2>;
             reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
             backlight = <&backlight>;
+
+            port {
+                mipi_in_panel: endpoint {
+                    remote-endpoint = <&mipi_out_panel>;
+                };
+            };
         };
     };
-- 
2.34.1

