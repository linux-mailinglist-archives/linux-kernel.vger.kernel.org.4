Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571D638A12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiKYMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKYMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:36:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1F4D5D6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n3so6581676wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNXziAWeRjbSnLjIyAqIFKmN58WZ2py3nHOgpD+6wt8=;
        b=B57NIcGeUTV3e/AvfwgYfQCL8WwpO+0pQRZgOSRxRcokrVVCq9p7vd21/LZ4oCKoxa
         piyNSZC/Qei2zeUYwePaBbQLy1WhJCniO7E5K9qluHA7+U4UzStsAfhwSLpZSBEML5ga
         uzPcG1blbJsv/hJhKdwALTZWNt+hJWC1F1QBSs88M1sIf6cUaBKhiNlEnD7h0OZSWoXA
         +ZJOHjaJ+3/HUboX/ewRLgHh5DIn8xh2nvca8rYJ9E87E+JvAZVIVzH8D3fk0tFgSMNc
         JXmF121AWAkkcBxsbhaaSCc2Bs67nK0Msful+mSOGjFjWSN3avpV/TI0X1/dxQXylAMH
         fCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNXziAWeRjbSnLjIyAqIFKmN58WZ2py3nHOgpD+6wt8=;
        b=adtVRD1cD+d7IaIXNh/oH/4S94/jUSOmhfRUvDCeV1GwgF8QJk9XGLqEbjf/hPSeoG
         L7Y5h/klGcU7ck0ssbpLHKfB5o2QvlhYgJ3oaaJDmUv4qk/xMsdC+M0W3LB7m9ZDqdaR
         +lodkXqdu/tW7dSKy2JATuSMmZnxezSB13kRfPTMMEgNtcCKiaP8eM0GcXO+LEymt+NX
         4X0Vjyyx0s7kvysF3Fm++NdkGgWA2zZkefljeilG/YLxrjszCoDD55sLkdHZQO5ENWEZ
         1D70C/d6noSLF7PV9Nb9Br+E+DJeTTnKP15mKCXfjT+E29C9zU9mHlRGFTeBNCeHAdip
         ntQQ==
X-Gm-Message-State: ANoB5pkKuaXh4whN683kY6s8fi1Sa/mCoKFvjbHeNXGb6YfuBZ+3qxEQ
        nCoFLgLIO4p/O5uymATayN37Mw==
X-Google-Smtp-Source: AA0mqf5fJKX3YejBQEmod2vLQ2Uujyxbwdzy+Q9rEcidm2wHUiU9vaCjMu45gX+3t2fw5sLRX+G17Q==
X-Received: by 2002:adf:e844:0:b0:241:bfc9:5975 with SMTP id d4-20020adfe844000000b00241bfc95975mr15595717wrn.605.1669379811597;
        Fri, 25 Nov 2022 04:36:51 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:51 -0800 (PST)
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
Subject: [PATCH v4 08/18] dt-bindings: msm: dsi-controller-main: Add vdd* descriptions back in
Date:   Fri, 25 Nov 2022 12:36:28 +0000
Message-Id: <20221125123638.823261-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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
index 0fbb0c04f4b06..bcbcbdca1a78a 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -133,6 +133,18 @@ properties:
       - port@0
       - port@1
 
+  vdd-supply:
+    description:
+      vdd regulator device node
+
+  vddio-supply:
+    description:
+      vdd-io regulator device node
+
+  vdda-supply:
+    description:
+      vdda regulator device node
+
 required:
   - compatible
   - reg
-- 
2.38.1

