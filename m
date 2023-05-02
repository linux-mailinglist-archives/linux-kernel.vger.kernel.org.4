Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997836F4336
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjEBMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjEBMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:00:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE82123
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:00:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f109b1808so731702666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683028846; x=1685620846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3Lfco4BnCXSWDeSvGyocalO93LWCUXAn4Hyq4qa2GU=;
        b=k0Qq8qmjrUvfH6d/fC9U0sPZuAEoXcPQ4JTMgHYGwISYhsa+oGHET4gBj5mRXV5BY6
         J9oPKo6p6LNHUzk6fNIf1/8kxsUPtVW9Q/ap8x6H4UR0256dSsZKyyxiMM6bu9JmZAgD
         C3ul8k+qwtitqBiLFWI8XgCyZuh7Ma+NNHjVrxGHXaDpxWvzHFcwmACfQns75pQTOJmh
         /amtYuMgcdsWfxX0xl9doBLJhh7lzyKykOA3ZcSwH2mEBLq2MgB1AgriHZ0275vZbhcJ
         b++yGidZypMKNhCy9xAA4L4h4ef9MN65JVflD0AjbCpmbmYev0QUORf1kf3lOqVWZbPs
         YZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683028846; x=1685620846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3Lfco4BnCXSWDeSvGyocalO93LWCUXAn4Hyq4qa2GU=;
        b=JOvc4xGGbHk7YVlT1KuQSUaZXTMLxDWLOKuIY9hWwBcSekai9iiKeaA7Db+dDxvXBC
         O5yLvJLzxcyL2uRdPLScaMLMNUDQ1/NhlrJSBlemFabAiw3IUSx/xeJwsgJ0FS119AWl
         CHBOm4ODd4KQ4LV+smXc6Uxo36L+Joh+tetLpEZF6RH5MpsN+tgA5Y/D3QJ18z8t7gGY
         w5q7Tc1Ea7NP5EjZXS2qt7OEassBgNPpw+NCmhM2FV+eEoKATym1tOU2Ob1pwK3lCpWU
         1Vl6WlPr+f1BwOhRLHLGAiQLbwqZcUWuwOm4zRG5lL0L2F6dncebhlunKqe7N9Gmu+54
         OGMQ==
X-Gm-Message-State: AC+VfDxgTz3KGrRtaMWJPfSE4Zxy6Yi2KDSUifcybjNkwpf+8dOLmsuI
        P4vu++5jWbM+SUhE1okMCvtmjg==
X-Google-Smtp-Source: ACHHUZ4A7IqeyLXRL8smscOzdIf9v+IQzynF+xG31Ayj1umN6zEC38/CTVoxXfWwQg6EJ/5ynn1J+A==
X-Received: by 2002:a17:907:6d19:b0:94f:720b:1b14 with SMTP id sa25-20020a1709076d1900b0094f720b1b14mr16467542ejc.29.1683028846077;
        Tue, 02 May 2023 05:00:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b0094ee3e4c934sm16063403ejf.221.2023.05.02.05.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:00:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: display: novatek,nt35950: define ports
Date:   Tue,  2 May 2023 14:00:35 +0200
Message-Id: <20230502120036.47165-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel-common schema does not define what "ports" property is, so
bring the definition to enforce the type.  Panels can be single- or
dual-link, thus require only one port@0.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rework to add ports to device schema, not to panel-common.
https://lore.kernel.org/all/20230420160905.GA2952736-robh@kernel.org/
---
 .../bindings/display/panel/novatek,nt35950.yaml           | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
index 377a05d48a02..c93cc1018b41 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
@@ -47,8 +47,13 @@ properties:
   vddio-supply:
     description: regulator that supplies the I/O voltage
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    required:
+      - port@0
+
   backlight: true
-  ports: true
   reg: true
 
 required:
@@ -59,6 +64,7 @@ required:
   - avee-supply
   - dvdd-supply
   - vddio-supply
+  - ports
 
 additionalProperties: false
 
-- 
2.34.1

