Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7965209B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiLTMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiLTMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9984BE36
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bx10so11646116wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EavGT4Puc+h0aZwFuDS/6S+WtpAyzJabS4DGaf73BZA=;
        b=vgdU3XWqu/RW55vCO1V8u3uh4aqfe3fEWyt0nWEWzNKlcuRmo3+H1wIoA0a/5atI0X
         Ejs6K/19fjsIzBWlQe8/MxNQTEBfydeKnapHyWTB6MXU4Omt4Zz60GMGt7ppDSR1rovj
         ntTMkDsJA6wiZnSqMJTSgF1vtrHD7zHtJFic5vw4FRkjY9VdCg9KvBYZBAVOV2+eQVT7
         RdhDsHwZitdjwPySCQ8qAct7j8hUhzBZVvNbVTQlRP+oB0HCMvDtUv6NWtcGyfUmeaym
         Ch7od+XnAy5J4nM83XUuRIhSjXj6wPXtWRE+poaHo9x3/SXO9aPod2AVuT6d7XekaARL
         1srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EavGT4Puc+h0aZwFuDS/6S+WtpAyzJabS4DGaf73BZA=;
        b=RwuE8Izbb6NsgAavprbizW7/Z1GTxaFGFvaLnzH2oGXN2RNKV6meRoBIjD32H1QOpD
         AF3Jzr9HpxHg83i0eHmGzhazPwIoZq45JNfhmneZ0R0H/l49E73NyxP3dcB6UtWpmXSa
         hMWOlgz2BxjYxrCQg5yCz9Tguxhe8qFxxihwBT6jpG4A33XIkfYDXDCs80tCUgluERta
         XA1HtYZ/9bzF+kQQ0eeXAaB/xN1SpZKXFWhT1lh4pZ7hvVLkl4oOhD08a1/bVRdolQDG
         c22xTCsOmAZx3wLaxTum3CcbL18IIVmqRdkqjfagfor4BT8P2fIXsmimWbir7C71lPMH
         a5wQ==
X-Gm-Message-State: AFqh2kouNM+FHtZQnw+RKon10iggHtH5p4Lm2iGoV0AW7Cqd4szkgjNO
        HbJ5wJ+VyfiNs7S7sHCi+B9+CA==
X-Google-Smtp-Source: AMrXdXsDDzoMbqCmHInHOLoltwk/aIaW47vjVs1GGTqe7ReSVl+1Q8AG6gLhjJymA7qTamaL/6j8gg==
X-Received: by 2002:adf:cc83:0:b0:242:8d5:c6ee with SMTP id p3-20020adfcc83000000b0024208d5c6eemr1458540wrj.15.1671539806390;
        Tue, 20 Dec 2022 04:36:46 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:46 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v5 08/21] dt-bindings: msm: dsi-controller-main: Add vdd* descriptions back in
Date:   Tue, 20 Dec 2022 12:36:21 +0000
Message-Id: <20221220123634.382970-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
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

When converting from .txt to .yaml we didn't include descriptions for the
existing regulator supplies.

- vdd
- vdda
- vddio

Add those descriptions into the yaml now as they were prior to the
conversion. In the .txt description we marked these regulators as required,
however, that requirement appears to have been in error.

Taking the example of sc7180-trogdor-wormdingler.dtsi. The avdd and avee
come from GPIO controlled external regulators, not the SoC and in this case
there's no need for vddio to power an I/O bus. Similarly the regulators for
the LCD are controlled by the panel driver not by the dsi-ctrl driver.

It would be possible to connect a different type of panel to the DSI bus
here in which case we may or may not want to make use of vdd, vdda or
vddio.

This is also the case for older chipsets like apq8064, msm8916 etc the vdd*
regulators in the dsi-ctrl block are helpers not dependencies.

Add the description of vdd, vdda and vddio back in for the existing
upstream dts where vdd, vdda or vddio are already declared but, don't
declare those regulators required - they are not SoC requirements.

Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 4116b3010219a..785cc51838f07 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -143,6 +143,18 @@ properties:
       - port@0
       - port@1
 
+  vdd-supply:
+    description:
+      VDD regulator
+
+  vddio-supply:
+    description:
+      VDD-IO regulator
+
+  vdda-supply:
+    description:
+      VDDA regulator
+
 required:
   - compatible
   - reg
-- 
2.38.1

