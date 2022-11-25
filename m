Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBD638A28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiKYMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKYMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:37:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9F4C254
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z4so6589967wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrZRxDUkNBpr7/CO3VUWuIRRJhqQxCbIa8B1ayhBv+4=;
        b=HewUI0q3JiGBKkRoIELpg8nbjCjuH8cpAkd53x1g6nujXHUTGpJlWiJsaGeMS0QI+o
         WN1tIeREr9cv1rsh2JOJAMu1fd3B5eI0P6OIFHLSxUXf1+HOUSszUn8urAD8AoSbzeWf
         pStkO5vDtE6A+IDMosKbktRuds3zBw1w9tgahaXy0Ghs9BxdkOttNyj+S6Kp6sTwXsyD
         ZkRJw8r4cS2Ne93lfFvbpue5MPWBQdQfsikW5SoMLU0BJwpJ1hqMEKskR7DqdEojolQs
         dQvF/fYZBLbm9ZD1MRI1kfvEbUFgZHfCXikICSfbd2IrAZdylqymO6YeDMZ54zsxpjQA
         RoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrZRxDUkNBpr7/CO3VUWuIRRJhqQxCbIa8B1ayhBv+4=;
        b=WhdmiR2pFvMxRB6iz1T5KNR2dASfxl7xNh9657TrdQtgh36IaeF8wJvXBjrH9p24/3
         ICdmBwYsZoPxD9VIRBPTkxWoyHwZFZWdpYF0oHwm69t1GYx9WIRW9WiLi2zWIGd5Shfg
         3inAJEdOKie/4yFdU2LE4DZ6vbPjuCtDorJbY3Q85BT8+KNFW8xw969lkhfjmepweoWA
         AeqNlKvD+PYwFiW4Pwh4WEa4HRzn6AgIqv7mg1Bi3Ht5y0pf+kntxC1bFdETGoFnv5Rx
         vOp/ZD1IcF9iGGyufc2ccfn+72+a/wOKZS0+Ctz6V1hOkzeP2HmObwVkbnQKx7RDEpIG
         6ePg==
X-Gm-Message-State: ANoB5pmUcKrBuF0FMoJqcjGzNeUCGNn4xT4/nOd3IlgFU1ENaG4g1iFJ
        np+YSVSLJzrLhvWVE7nb3PrNnQ==
X-Google-Smtp-Source: AA0mqf6uYcqHm6pJSFDYrGlH5uVpN8pnpSEtO4Xpcd119fJlRZqAf2omUuW/V37TYfnf9GTgSRw5sg==
X-Received: by 2002:a05:6000:114b:b0:241:d199:1a04 with SMTP id d11-20020a056000114b00b00241d1991a04mr15971719wrx.227.1669379821520;
        Fri, 25 Nov 2022 04:37:01 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:37:01 -0800 (PST)
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
Subject: [PATCH v4 16/18] arm64: dts: qcom: sdm660: Add compat qcom,sdm660-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:36 +0000
Message-Id: <20221125123638.823261-17-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

