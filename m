Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAB636F43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKXAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKXAs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:48:29 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F80ED705
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so202666wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNXziAWeRjbSnLjIyAqIFKmN58WZ2py3nHOgpD+6wt8=;
        b=Hy1so5B7geaFM1IXMTGxX5JXmXgo0d3B5upAtbSpgsjAk/2UjOT2gHJfrdSN+wxXUO
         WI0Z62orpd561R41SBM7w5ewoEbZ5UZM38jFDQm6BpTYKAWj48vcII08LYCKJRg+QE0y
         OpfO9p7ux6kX1Giwy2ZyLBzLY7W//KO7J3AX76NHEF+6JT1Dk6aS2ttLIy6W3vDb+vI9
         uesiEcfN/aYlrqS9Lns7wHuS/cKaL645Ggi8qrMw2nmxRcDcgHvx2H9UEZo3L7kVkDuf
         UM486geAyMtnb/qL69zg1D7v7FaUojuUisRNMC6WUbGO+V2n/V4Szf+7xCvpXiPEBwds
         44Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNXziAWeRjbSnLjIyAqIFKmN58WZ2py3nHOgpD+6wt8=;
        b=LOV5Hv1nziqYctMzarc5uT59GAymfhmiExFObEjrtm+ll6RApz2cZpACxionJd9iVQ
         Fms5BQy+T7thZ1TRbJAAclekH1ilQNq9ZnLvChRI3Okh0d3OpOVRF4464BmRF7dbasXp
         QelS0XSvJo7e1fK1gJ8n2jXecU/K894+DGZ0q7i/WPlxQbvPFvldFiQzLYBkoNTew7PO
         oTi9jmV+ThXqvMcuEad1/lMzUSRszZm5lWTulgtrNJbn0/cebgtb9BS3unUCv0bcC96P
         i8jOFxuiaHjFDMPfXJTkFJN9RLOpFThqm1vuTUqc3VjwY4FvTSawyCku98yrPrN8OsiQ
         P2AA==
X-Gm-Message-State: ANoB5plQGLqHtOXHLbhOtlS6+L4h2Ixf3WBow+yCb8p4Tig3eoy1mUc2
        DylQiruO8GVOuM5OMdWjqRcbKw==
X-Google-Smtp-Source: AA0mqf6YVz4IMn/YpDjmhDVs8Qlx7LojdAd8PiodySUyMSBe/MESilqDOspPk80Bu7xUlbNS6eEkTQ==
X-Received: by 2002:a05:600c:1d9c:b0:3c6:bf1e:ebb9 with SMTP id p28-20020a05600c1d9c00b003c6bf1eebb9mr24942343wms.173.1669250894492;
        Wed, 23 Nov 2022 16:48:14 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:14 -0800 (PST)
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
Subject: [PATCH v3 08/18] dt-bindings: msm: dsi-controller-main: Add vdd* descriptions back in
Date:   Thu, 24 Nov 2022 00:47:51 +0000
Message-Id: <20221124004801.361232-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
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

