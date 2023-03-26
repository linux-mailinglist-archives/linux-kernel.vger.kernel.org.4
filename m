Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844526C97CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCZUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCZUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:42:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6C5FD9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i5so28137854eda.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+pxacFz13bsHOBsFxJX8/Qwx9xhoEQC7gMc+L9m6/I=;
        b=eZSrbaXgBHICG39/4wcDpoDcr8baPcRVwzg5FoG+euX0Gohz1uroRPCyF8/2ao8u5E
         2hwjEXdBT9Ebmyl6W7N6jB+fFj8WsSiZPnLeQFJEMyZRy52jDVqPUzyTxK/cQ8KTbomm
         a92cn1mobn0es1Mxm8SRs6qY8YaACJMjj94l2FV6XPEiJFNIxT7tdyonv56ZzO8Z04R1
         AmfemiMPsKDFENPAP3kR2+TKQuQASXciZg0sQJd/dZ+bGJkDWNKN0cuVUFQ+4v5csQp4
         nHJYDQmajljkyKJGdXL+qwsVJ8yFk7KubHYAVFG0rarRZmeW9IPe8boplrJKyWM2PknQ
         0IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+pxacFz13bsHOBsFxJX8/Qwx9xhoEQC7gMc+L9m6/I=;
        b=jtLm9y2EjwYybLfjir+j8FQaPAvWHp2YrogiKkE4rzOyNUUVzGYnixB4It5ckV7WaQ
         2B5W9bjZygIxER+gIg1JLIpr8to2JvkfBsOTp1sEiBxcTaqoCbPOPqRGNiO9u2Qilbef
         /dAJHMU6DuriTJ0Ps+KU/0vtewTOS7c3a9gh5AW4lMHA3DNhebJMOm6elY5LHzikRPqg
         hA14CvQed9QpSFoaFP1GaiYC3+IdQpZfvQ8WBtVr8+L27o0fVC4bi64zs6vjDRNJdGY2
         b22Mz5JbH1giUDS6sA1LXkpua9NWyLkE6+HuiKxTnkum0fqLv0y51KKd+Z4F84yqhtp1
         yaTQ==
X-Gm-Message-State: AAQBX9dbHf5JBFtkUEFnFxdUQIVxMIdomnMsO76q8HRCVGOf+ku8bQYG
        +Eaf28jZNKLT5h3qz5WtUZsp2Q==
X-Google-Smtp-Source: AKy350aV5GBIBhEVsNXkK5hJNQO8z9gH+wV2mBzEG1ThZvIdFFLVt/W2ufYh5KdKOFklvwSoLmEA5Q==
X-Received: by 2002:a17:907:8a08:b0:944:44d:c736 with SMTP id sc8-20020a1709078a0800b00944044dc736mr3868077ejc.64.1679863349831;
        Sun, 26 Mar 2023 13:42:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b009255b14e91dsm13286144ejc.46.2023.03.26.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:42:29 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: display: elida,kd35t133: document port and rotation
Date:   Sun, 26 Mar 2023 22:42:23 +0200
Message-Id: <20230326204224.80181-3-krzysztof.kozlowski@linaro.org>
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

  rk3326-odroid-go2.dtb: panel@0: 'port', 'rotation' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/elida,kd35t133.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml b/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
index 7adb83e2e8d9..265ab6d30572 100644
--- a/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
+++ b/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
@@ -17,7 +17,9 @@ properties:
     const: elida,kd35t133
   reg: true
   backlight: true
+  port: true
   reset-gpios: true
+  rotation: true
   iovcc-supply:
     description: regulator that supplies the iovcc voltage
   vdd-supply:
@@ -27,6 +29,7 @@ required:
   - compatible
   - reg
   - backlight
+  - port
   - iovcc-supply
   - vdd-supply
 
@@ -43,6 +46,12 @@ examples:
             backlight = <&backlight>;
             iovcc-supply = <&vcc_1v8>;
             vdd-supply = <&vcc3v3_lcd>;
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

