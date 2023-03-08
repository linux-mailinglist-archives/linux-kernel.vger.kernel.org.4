Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC976B0DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjCHQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjCHP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:59:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA69B1ED0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:59:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso1471106wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678291150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3gnd/d/MLXJUAK0HLanbIn82QxPIkJ3zZK4UMU0euI=;
        b=rl8Drhy1ZHKjf0fTHD6/H53KQSiQI5SLJ7WfDX+eVtbeHnMlZ9yaESFaS0f1MQYon0
         oWcgidFWp0iYsFqXb9LaIvrzJVY557trMGZasbEDTaS7V08K+RociKRgNs1D2yTdwnhy
         Ve1Q7thOnHad90nPMxRFpuTfrdoi5j+1pW0itPn/xnen7r98T8TofWMt/9lqPvWcam9M
         D7di7CYxIZRHjoWmfX2R+wy3MCdp6mhZI6k+n53bIZUMrCur1cbM7pgC9soEeK4b24Ln
         ONNd9aICsTEvhbUi1y5HQ0lqg51hpSOAANrvT0hK8SrklnrqXig7GW5R1y+2HI8LPk9w
         LkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3gnd/d/MLXJUAK0HLanbIn82QxPIkJ3zZK4UMU0euI=;
        b=ZKMkWi5yza3osGv72tU4haHlcA7uG9VhONDmjpjuy+yMOIf/SwMm2KeR7ZKM9jp5CM
         Pkc1Grc1BSIezw1PIFSsst89Rh2BvjNDoeq5GA28a8ToEe5MfZF8/91jKvsdin2WyDLT
         jMdtlUWLQXpBeHe2WRip9tzCHVGFVVPq2AFOuKcZIXYyqdQOF75/5+wf/83VEMH+I904
         J2ADEzNyOH6mmuo+9SkhcKLpcNGH4Zk1J8fvP/A2+iQ/4x+fGlGD3MQEjgjfuopUPyVH
         PAIHUMD3r87I1mcbEOMJBoXAa1vCUXGFkvarO5ylXS58foOHzA7SorRxuflw85rdhr9w
         hn8w==
X-Gm-Message-State: AO0yUKV7i0Uv/tx8SbBCE3qa0ylO8LABIVfIpJkSinJsIs4ZgGR10+hJ
        w2dHvLpksZj2k4MHYZB5eVb6Jg==
X-Google-Smtp-Source: AK7set90j7W0DmZbPdYoUas5/sJDtvyaCTDeMr9rAzDAu0F/Vq88d/1lOJkxSxkDGM0IOQv3za/mdQ==
X-Received: by 2002:a05:600c:3111:b0:3eb:399d:ab24 with SMTP id g17-20020a05600c311100b003eb399dab24mr15404956wmo.28.1678291150619;
        Wed, 08 Mar 2023 07:59:10 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2548430wmf.2.2023.03.08.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:59:09 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH v2 2/7] dt-bindings: ufs: qcom: Add ICE phandle and drop core clock
Date:   Wed,  8 Mar 2023 17:58:33 +0200
Message-Id: <20230308155838.1094920-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308155838.1094920-1-abel.vesa@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICE will have its own devicetree node, so drop the ICE core clock
and add the qcom,ice property instead.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch was not part of the v1.

 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..a0c93c2d7a42 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -70,6 +70,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
   reg:
     minItems: 1
     maxItems: 2
@@ -140,8 +144,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 9
-          maxItems: 9
+          minItems: 8
+          maxItems: 8
         clock-names:
           items:
             - const: core_clk
@@ -152,7 +156,6 @@ allOf:
             - const: tx_lane0_sync_clk
             - const: rx_lane0_sync_clk
             - const: rx_lane1_sync_clk
-            - const: ice_core_clk
         reg:
           minItems: 2
           maxItems: 2
@@ -166,8 +169,8 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 11
-          maxItems: 11
+          minItems: 10
+          maxItems: 10
         clock-names:
           items:
             - const: core_clk_src
@@ -177,7 +180,6 @@ allOf:
             - const: iface_clk
             - const: core_clk_unipro_src
             - const: core_clk_unipro
-            - const: core_clk_ice
             - const: ref_clk
             - const: tx_lane0_sync_clk
             - const: rx_lane0_sync_clk
-- 
2.34.1

