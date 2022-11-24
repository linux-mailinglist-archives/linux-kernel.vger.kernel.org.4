Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2674A636F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKXAtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiKXAtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:49:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6C4F72D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so225563wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrZRxDUkNBpr7/CO3VUWuIRRJhqQxCbIa8B1ayhBv+4=;
        b=alnNX5/8pjWpNqitFxc8xrGTxdcS0z3LULJuF81hAIpPFFWTTo3LQ9bQALG3/37BLS
         QhbJWzQnPq+rBm8pE1V3rDXM0K0as0+3/GzJ1BFGrcg0mJvjaRUv9pqRng5j5oREb00x
         5OsaJvyHkqsUiXfbozEVFjM0/Ci4P7gOzaMSAAtM/GZLwE9kWNFWvg3OT4Ge38a5tYuZ
         A84lQPS7W7jnt3BQMmtofHlx8od+Mu+5FuaF7Sa0K0ry747MqpXVmfJb7yhTw9WxR52+
         aF4g+VsT7XdURvdFng3eMnRpH8sZtxLGc1B/25xlH9urLJDIG1+WUZ0Ti1+JhUcqyO20
         HYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrZRxDUkNBpr7/CO3VUWuIRRJhqQxCbIa8B1ayhBv+4=;
        b=V5lvsIrvucQOE7rz8ZkmmVW2PiwsuKR7ceXcalWrfgtF4l2mtdcKL3KqoptOY64rTI
         EF0t0X36NfnizssgRI36UbKQ4+45cLfOzVYdApUk4l0RdBtce/xx5vIgOQN14k9+2EtC
         IiC90q8LD16A6Z20MlM/qTotPjVDed7zjgTuE6o7FGMLaGDYwoFK5AlW1DhuqR2SKoBU
         bdqynuSEsZgRPnUC/n8UZyoI4XmJqYvWkZj2F6AzCOym4NuBU43zH9zy2CnmDSbXFbog
         Zh9GZk6iFZ8TjFAZB5s3Azrw9eyCMrCQpWzzusZLxzY/LNzLUL55qJNMAWeXoljog/Ld
         r9UA==
X-Gm-Message-State: ANoB5pkjPpjrUmbvV5r4X1RPWHX1VCoiMOo2h/HXBCwmqTwixZhXgp3h
        Mgl/pti8NjpIMvmlpOaMkvEpCg==
X-Google-Smtp-Source: AA0mqf6FIDKl6U6xGN7PD002PybHgTf1Ig9NQ4P4OYT2DJSYPVWiWf5kxCCUb3pADhOUezMf3B0tpA==
X-Received: by 2002:a5d:4ec7:0:b0:241:e27f:840e with SMTP id s7-20020a5d4ec7000000b00241e27f840emr6368859wrv.690.1669250903944;
        Wed, 23 Nov 2022 16:48:23 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:23 -0800 (PST)
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
Subject: [PATCH v3 16/18] arm64: dts: qcom: sdm660: Add compat qcom,sdm660-dsi-ctrl
Date:   Thu, 24 Nov 2022 00:47:59 +0000
Message-Id: <20221124004801.361232-17-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,sdm660-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for sdm660 against the yaml documentation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm660.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index 10bf1c45cf6ec..f8ec728e67f3d 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -154,7 +154,8 @@ mdp5_intf2_out: endpoint {
 
 &mdss {
 	dsi1: dsi@c996000 {
-		compatible = "qcom,mdss-dsi-ctrl";
+		compatible = "qcom,sdm660-dsi-ctrl",
+			     "qcom,mdss-dsi-ctrl";
 		reg = <0x0c996000 0x400>;
 		reg-names = "dsi_ctrl";
 
-- 
2.38.1

