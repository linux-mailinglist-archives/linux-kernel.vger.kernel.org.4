Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818346C97CA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCZUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:42:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA3A5FD4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t10so27827668edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG9ztwx7gkHgYSG+hPtINy83lSHlJ3gPmXdpgMiGDik=;
        b=LqM6CQ9N2gfNQiu+AELRYpJP1+VlJ8mX378s9ioDTPMA0rQgjhLt5a462ImkPp9RWs
         6EhDymwdIbm64k5VQcx5QONB2V5bqW0Td4vm5NXRQfY0GLIlHLvRkYiDst+fn9Lm/7kA
         z0ml+gzuO9NI71ChVKArUO4EITIfnhATGiycVMz3vn8hx27zUZGrG9EsqWePBepXS4d6
         KFpY+RF1nHWQ8nhbN1FftacCFX0SfZXw62aWNojpgFHiby4rAvdo48Yoxk9fuQ9KOEs1
         mzk8lWheF3ujT3gwGaCrcEr+yi29Z/XHt4uDt4ndXpEz8lz9XhzUrBwrf8P8n5z+pwG8
         sF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG9ztwx7gkHgYSG+hPtINy83lSHlJ3gPmXdpgMiGDik=;
        b=G6Qw0k2cyalYSJYP/LdGHVjEa+q1ri0HWOEP5DKVgPsxUPR1d7GXImCPdJUZu3n7kw
         km3wodCmj0q5C6XIbGFbr46y7ndy7Uy9Ilkf0GdzZKNjSrbkRyVD0X/Cc7BF0ObL9qny
         5fx/ArB3wgF3sV9eUkIKBVmfD/+NAJ74n/2C0HF7L0A0E4tmsqYjNIeEpJVNEAjbUImG
         552jCMzATzTIKjYN93bCANoaXUIUZRwzD94MiQ/0HVop06Y/liL95Q6ujyY8SsnZpPTz
         o0MJlqeGHvP7C019uguJl6W15TeGFWHqzPiijnW2XSdVU3VG+DtXqkRVT0eiCMFCxEo7
         g9gQ==
X-Gm-Message-State: AAQBX9dtsd/ExCNe/hf7Y4w5EoFelgpqk/cxDcaixJHPrKZjtXL4d/ty
        Gnj0PFF3cBWrTn2Vwe+FJ9GpAw==
X-Google-Smtp-Source: AKy350YGoyy5ydS3ykgysksCRYUBpA6u9Rbf+AmZYMzg/ie6Vr9vCvGLmxU9sQ33365hiV5iuz0tOQ==
X-Received: by 2002:a17:906:1645:b0:88d:f759:15ae with SMTP id n5-20020a170906164500b0088df75915aemr10723378ejd.42.1679863347920;
        Sun, 26 Mar 2023 13:42:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b009255b14e91dsm13286144ejc.46.2023.03.26.13.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:42:27 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: display: xinpeng,xpp055c272: document port
Date:   Sun, 26 Mar 2023 22:42:21 +0200
Message-Id: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
binding):

  px30-evb.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/xinpeng,xpp055c272.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
index d5c46a3cc2b0..c407deb6afb1 100644
--- a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
+++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
@@ -17,6 +17,7 @@ properties:
     const: xinpeng,xpp055c272
   reg: true
   backlight: true
+  port: true
   reset-gpios: true
   iovcc-supply:
     description: regulator that supplies the iovcc voltage
@@ -27,6 +28,7 @@ required:
   - compatible
   - reg
   - backlight
+  - port
   - iovcc-supply
   - vci-supply
 
@@ -44,6 +46,12 @@ examples:
             backlight = <&backlight>;
             iovcc-supply = <&vcc_1v8>;
             vci-supply = <&vcc3v3_lcd>;
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

