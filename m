Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BD66C3C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAPPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjAPPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:23:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776991D912
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:21:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q10so8485382wrs.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Svkhj0q099C0FoiRDtRciP7InWwLuxVC/46qIXiovr8=;
        b=XiGm3zMYMyDlv0c1X9o6TrBRuEi/kQNHOp2u5zNrD/sHrcPgWC/YQ/eJBFnht6Mb0G
         7JyVb+VWubkM5kfO/7JWgXzV2g2htARtzz231Cmbk4MTMuaJiVD5thwlWO/UIfvu3ndH
         uuYJrVBv4HFOTASO57osvW7iv9jTr4wMmlUqwG+mHAPAEeWDK/dSC2mMwXfQ/GexI2p0
         Kb9K1wtezdR3/8pNSs+1gk8qczjQMUIOUVUn6LGSzrEb1T+G2+ojZLQUUCE7i/g7WRFp
         rkiq9hVAv22X1l3gQ785eU+a2D/UNP/0WsnYcbDpN9nCB5Pv8RF4Knl00AV3QT1y4v8U
         GFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Svkhj0q099C0FoiRDtRciP7InWwLuxVC/46qIXiovr8=;
        b=rr4FR4c5o72wuR3X9y/CI959vrUqXoBSFMP1Y2CqDUq/VlhGE0k+s9llOIVQDP/C8h
         DbkfCMktReRnNGftbt3MVsJPDB+lDP39oXgnyujfsetLF4ULUIhmR+XWurfotAU2Rrih
         Kg+yxZ37ivqYq/XSIfqFQb5VlJIjWUq8vNPk21mSdFXcY2Pk1C7TLlasIrGZ3BZ3C2jv
         X0+7xj6cBEqXcZtyAri/eb1Gzadg6z5xXCyP13d9FgwXomLmG8oNI+1aekoUOWFsDLvF
         7c7X72HBX4+tJqEpTO7mSzPUMEkHBqCW5gyYKnZk87bjTFvcfIfIFcYeSqWjJtySeveT
         dmbA==
X-Gm-Message-State: AFqh2kqJnW1WhWx9YaCbx5XTlpUk2GyuV6bVTfseWnWjWMu5XNcBHjbo
        /7V6pu/QxEmPRU26ChAIVOp6pg==
X-Google-Smtp-Source: AMrXdXvYYOSm7wWeXzSebG8PvNN7IVXYycMtduzO2ztLQ2GdkIaw7bdJ3YsodsbHgkLl8/KqxPfYug==
X-Received: by 2002:a05:6000:884:b0:2a3:ac90:dda3 with SMTP id ca4-20020a056000088400b002a3ac90dda3mr34494653wrb.35.1673882495009;
        Mon, 16 Jan 2023 07:21:35 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u18-20020adff892000000b002bded7da2b8sm6874686wrp.102.2023.01.16.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 07:21:34 -0800 (PST)
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
Subject: [PATCH v7 3/4] dt-bindings: msm: dsi-controller-main: Add vdd* descriptions back in
Date:   Mon, 16 Jan 2023 15:21:27 +0000
Message-Id: <20230116152128.909646-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230116152128.909646-1-bryan.odonoghue@linaro.org>
References: <20230116152128.909646-1-bryan.odonoghue@linaro.org>
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
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 47faf08a37443..7b849c8f119a7 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -147,6 +147,18 @@ properties:
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

