Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4526C964D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjCZPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjCZPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:54:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB84239
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so26403185eda.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb6wejOAWg8Tq0/xVUihnm3zM3Ykv1bV1Wxaitw6vys=;
        b=uFqZlpVVmx5h5YGt9V4RkhGjCgFfg/K53xRA90eWEwZ86FJdYz0lHlHfZ+UVmruME+
         H70w1sAhHv8hXJPLeWKNvEmI391bLRf4+S+l5RYE9j7G2Tz+1rKTAQGxWcul7qCTOd2T
         uJjnW6PX2ofmzgVmlmwGi+K4OWEELT4YTPaLmmOTM8tYs0GBVM5bgevUQpoYHZy3Xmyi
         omLEIAcwAEwvUBI5+iNUlJI4AJhlkilix63Pt1I9jOVinOJjx1pfJ2CrHW67ATorWT81
         Ag4uoRbQ7iiykNL5j1MkndTuoN7v/JGf7+N7YwaehYFtqFcD2B1/IfwGirP5MMpaxegB
         WDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb6wejOAWg8Tq0/xVUihnm3zM3Ykv1bV1Wxaitw6vys=;
        b=grCtEVDZoY4pYKNy3wYCrWIOD6lpBwvLqTVWX3i9bL+pfwzNPfR8vKkrZPmngIe4hA
         IsVO7cR/m0hMMAEo721UttknN2YNaoTDTn8lvyxZcIM3TCCezwVZY7uzl4nY05cwkFXG
         2gDsbD8tRlQhsCG+GjzzBId3ttIXDOdwe5OU/Pr1s//MODflanSPBlufGwT5biUoXMlo
         V+QmjX7j+oVW3KNFu5vhfnizBc7g/tO3ILi58r4lZAZrIl03JM0jEptG2f44cOQdBPil
         qBs7nMF3kJLdUviH8X9H4jdf71slYuTHxmhyH6vFOST9k3SPm548xaF85JA4xO30xd1V
         ndMw==
X-Gm-Message-State: AAQBX9f7OgtESPxM6jweBTd+zbxK+OhPEy+Y4MFwHKksVSoaKuFFwpch
        PcURsS9IFvh9MgCQGm9ykZbttQ==
X-Google-Smtp-Source: AKy350Zt2i4Or7nsFrCPdZGmCr9S/cL7QJFPKdglAMXRGLWGsseYfQ1oUV5m2neU6SIbvgRLUsj6Tg==
X-Received: by 2002:a17:906:3896:b0:933:3a22:8513 with SMTP id q22-20020a170906389600b009333a228513mr10968276ejd.53.1679846072731;
        Sun, 26 Mar 2023 08:54:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm13506742edj.18.2023.03.26.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:54:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/6] dt-bindings: display: panel-simple-dsi: document port
Date:   Sun, 26 Mar 2023 17:54:23 +0200
Message-Id: <20230326155425.91181-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
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

Panels are supposed to have one port (coming from panel-common.yaml
binding):

  msm8916-samsung-a3u-eur.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/panel/samsung,s6e88a0-ams452ef01.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
index 44ce98f68705..b749e9e906b7 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     const: samsung,s6e88a0-ams452ef01
   reg: true
+  port: true
   reset-gpios: true
   vdd3-supply:
     description: core voltage supply
@@ -25,6 +26,7 @@ properties:
 required:
   - compatible
   - reg
+  - port
   - vdd3-supply
   - vci-supply
   - reset-gpios
@@ -46,5 +48,11 @@ examples:
                     vdd3-supply = <&pm8916_l17>;
                     vci-supply = <&reg_vlcd_vci>;
                     reset-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+
+                    port {
+                            panel_in: endpoint {
+                                    remote-endpoint = <&dsi0_out>;
+                            };
+                    };
             };
     };
-- 
2.34.1

