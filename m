Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041D654ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiLWCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiLWCKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:10:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941720F4E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i7so3380982wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxzU/4Isx5Bw7i+FyAwZduonpplLHnY+yx6NVoxUWos=;
        b=ZzZyLbcSq/M0cWx42qPkbcS/ao1WzWXn/J1DdHQgME8hoeLXngmdQq/1z9O5FHYe7k
         rQSl2dkRf8ZF4dmPrIJGkmJU9x/kTxa0hymsbNIy+4z2QqeXTtoQh8nUpu38C7YgwXBo
         uyk8rvqJbT7YnAoVRBDQihYG3wd/lCRsy8zv9TErd6MuV7xyj2Oescfyy02hiPobGU1A
         wgfI57NBT9/C1ZTMpHNVQ5uRii6RWTQcDJggXHxsAcfBqrgcrPGDfUh9N+TbTVBO3dVv
         RYOxOnM4AqZG7UyUlOJkmJPXj0NQIfOA8h8c6Uo1d5VojHgejtwayWregAnRI+dgYWHp
         GEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxzU/4Isx5Bw7i+FyAwZduonpplLHnY+yx6NVoxUWos=;
        b=3Dl+3lY+krV956nSF+rQn24pcBaxhAtLjmnxIkNavLMgKAoucHibE0UijybVD1E0Kl
         K0mcYT4/4A1c3J3BYrGt+91qQG7dl6Pir9SEqgBssiV5j9wXk9rLwnSPwHSJm6/omdgb
         9PcLeby4xRLMXtHMURN2WZUhq5LQUm5P8JGHpbHvYBOc1NMUW+2Gjr1FtD8UyZhKgWip
         mBpYvfziXZzOHINrhB67jZR6AJuNAOnkaGLUWGyV4XymIWEAm5L6s12WGY/3490TOPRy
         Dvj7xFXO7U4nysIdKzZ4wJeyeiGjC9uSADONNOyZRUY1kw401oKzaWH5U8X+rQjE3jqU
         ULTw==
X-Gm-Message-State: AFqh2kpGlk38iH43pul/OpYIWhAq6QrnnRjdd+KqEvRASFxXpTB7lriE
        pAfGMebhY8XdUEnnJbtFxBdIkg==
X-Google-Smtp-Source: AMrXdXsVIHJHohtOxRkzSsfV8ryOczF4edTTSfyWsjbBy+eH9RYuWuy4UYavNQ90Y93ylGDk2YmOCA==
X-Received: by 2002:a5d:670b:0:b0:242:509a:ad4e with SMTP id o11-20020a5d670b000000b00242509aad4emr4273598wru.27.1671761435282;
        Thu, 22 Dec 2022 18:10:35 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:34 -0800 (PST)
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
        bryan.odonoghue@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 06/18] dt-bindings: msm: dsi-controller-main: Add vdd* descriptions back in
Date:   Fri, 23 Dec 2022 02:10:13 +0000
Message-Id: <20221223021025.1646636-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 4b79b31123515..3144699e20a08 100644
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

