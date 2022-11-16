Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782562BEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiKPMvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiKPMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:51:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625171AF0B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:51:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v7so11840045wmn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2H1d5sAZJ+t9NwoF1iOHgYCETQzv/jXX7CIaFm3b3E=;
        b=gGxjSUZpAml1aIyqHw3VVmLjwPSVVASQetUasiWHCeAesZswbx+yYG2gYgnO4+3WqF
         rODtwr/NO5kVFQQBcZfxlOe56Wi9hWxGXuAEe6RNhHS47BlNaDIvZj5KFlSF4VWWdD6k
         XsqcQyzTl3KryVtnlovRE5RlktX5W7UmqLt+Y/AGIijJ7j4PvNzA/nlEJsX8lmSw+v9Q
         2bZ1nc46gKq9Q639tmsMTWiEmfy3JiphjugAX6sLrqFc4JqOMD9NCT4xvWdolKMuk2T0
         eNupuvbpBoCqju2TFAynQQX5pk11MeDw0uW/2TYMIBb268xjoWaL/2MOgxUxzKaO4JET
         iL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2H1d5sAZJ+t9NwoF1iOHgYCETQzv/jXX7CIaFm3b3E=;
        b=Mttww/Uyq/c580kQeNGJQn4KOigXPypYEUSXOvSkI1DXOyEaMvX9AetLF6LQEgFDXs
         gr1INg6jEr53xecvVsYwUE+F5nROYVYw2POtomlRkshuoXu0SAtzTSfuoov16fnTVeKh
         6heKoeEI9yOba3Bk51R5PscvvcrCEVaVGSVT2i8lD+KelQNdGjFljAz4+ZnGqM1NE05R
         Jjmi2pTEGIm0gMddKLLmgkBrOMSd49X03LwFN6n3cbKLo+owP+KGnzDqQK0fxrfTa3B6
         xcnLj1ZnbqiAYvdcOJiEojGL0zPrp6GUypSv7+TbHIlG7jXtef1rlWYH5B2zdGCtPwy0
         9G4Q==
X-Gm-Message-State: ANoB5pkicLh7XR/Vd8WCzPAGg+y5rvaApejh5PLl1D/cZ0TNZVwORP4L
        iwcfES+oU/JLLU/9DEg9Bui8/qcex3Umtw==
X-Google-Smtp-Source: AA0mqf6ZCGHBWAq3ypZIp2xmZ7qCZ6qMlmTRzbjQrzJx1q0F7LLrgc+J+/K0e5AsgXDRTCr013tlSA==
X-Received: by 2002:a05:600c:17cf:b0:3cf:608b:1b6a with SMTP id y15-20020a05600c17cf00b003cf608b1b6amr2077711wmo.20.1668603095928;
        Wed, 16 Nov 2022 04:51:35 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d6450000000b0022cc0a2cbecsm15386776wrw.15.2022.11.16.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:51:35 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: Add UFS host controller and PHY node
Date:   Wed, 16 Nov 2022 14:51:12 +0200
Message-Id: <20221116125112.2788318-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116125112.2788318-1-abel.vesa@linaro.org>
References: <20221116125112.2788318-1-abel.vesa@linaro.org>
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

Enable UFS host controller and PHY node on SM8550 MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index d4c8d5b2497e..fef7793a7dec 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -417,3 +417,25 @@ data-pins {
 &uart7 {
 	status = "okay";
 };
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l17b_2p5>;
+	vcc-max-microamp = <1300000>;
+	vccq-supply = <&vreg_l1g_1p2>;
+	vccq-max-microamp = <1200000>;
+	vccq2-supply = <&vreg_l3g_1p2>;
+	vccq2-max-microamp = <100>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1d_0p88>;
+	vdda-phy-max-microamp = <188000>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+	vdda-pll-max-microamp = <18300>;
+};
-- 
2.34.1

