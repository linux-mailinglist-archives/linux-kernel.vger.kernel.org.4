Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75970649B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiLLJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiLLJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:33:24 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA2F60F4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:33:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b9so11875168ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN1LN8Q13bIGioRmVa1bu9PkrPkTjKd3uyYwlIhvFvM=;
        b=sqRK+DUkBbboDM1xjUfhDcSMwMKw02FtrsEce4gvw5gmTle3/0c9mxjQHV7PqlKoLl
         0v+vN217H4gyG8YsjgJ2cKFTqhAEfm3VWyT8+PfMioubEPTLg5sMT/AwwGLWKhwfshaW
         MCupofIq/FZlQy71E5aiWAYHNH2MEQomPzYAy2ej+Yh2yIp8yKxhYP+g2xuYGoTom0jn
         qgD7KNRquiT9Kepl6r/zsZTLSaMdU6E2orkB1fBOqhwL301cUQAcFUv/Q2KhWQd7tgCi
         DWBdnuCZAtekT30+1fbqKD4UtQs932L6pCcKWYjruqVryy/+M/TjEPTYJ9RfhnytCOmc
         rZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xN1LN8Q13bIGioRmVa1bu9PkrPkTjKd3uyYwlIhvFvM=;
        b=lQYx7TqlNb4nL3Ak0hGcc5t4BT2q5cmZn/kylq7NOlyPr6hQnha3TEF2GWtxi08Zhi
         cEB9JGYIuRqXbnIvpjTqYvWdynG326DZUKZ/WDNEv3lj1uEhO7GKsR0m1EhJOIKfc2iU
         45Th3gUluo5QcwDfWOEXqzrW1fvayTiA5mBYH4jwwC8kIm0Mzbse8E0rOPa+gNJ9gfKj
         Ye1onmQD900ir72jp99NCHhmQHn8JYyTCZYHyYpUVKFeZRrrLOO0n5s6V2HwFzFYyFyv
         aRuys/wpzLCZpZDztcDXsnP4oHLkIILr+xAVuFQvzev76dcRu8GynzqLyWjtD5YURuff
         DE1g==
X-Gm-Message-State: ANoB5plRfXXKBhCSLygYj9mhKPypBoQznQWyqKz/U0gH0jAtHum/CrUq
        opSUjtOi32A7E90zM/XEO6aNbg==
X-Google-Smtp-Source: AA0mqf49ZV1sY4WXZX15jqMsuI6ytLu7nqTx7I4CfWaxDkFNza9Q3mIexZm4mXJmXQyUbItioe+ZbQ==
X-Received: by 2002:a2e:be28:0:b0:26f:db35:2e96 with SMTP id z40-20020a2ebe28000000b0026fdb352e96mr7090008ljq.8.1670837601793;
        Mon, 12 Dec 2022 01:33:21 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id y2-20020a05651c106200b002770fb5722fsm1155081ljm.123.2022.12.12.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 01:33:21 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm8150: Add DISPCC node
Date:   Mon, 12 Dec 2022 10:33:13 +0100
Message-Id: <20221212093315.11390-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212093315.11390-1-konrad.dybcio@linaro.org>
References: <20221212093315.11390-1-konrad.dybcio@linaro.org>
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

Years after the SoC support has been added, it's high time for it to
get dispcc going. Add the node to ensure that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a0c57fb798d3..ff04397777f4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3579,6 +3579,32 @@ camnoc_virt: interconnect@ac00000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,sm8150-dispcc";
+			reg = <0 0x0af00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			clock-names = "bi_tcxo",
+				      "dsi0_phy_pll_out_byteclk",
+				      "dsi0_phy_pll_out_dsiclk",
+				      "dsi1_phy_pll_out_byteclk",
+				      "dsi1_phy_pll_out_dsiclk",
+				      "dp_phy_pll_link_clk",
+				      "dp_phy_pll_vco_div_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+
+			power-domains = <&rpmhpd SM8150_MMCX>;
+			/* TODO: Maybe rpmhpd_opp_min_svs could work as well? */
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8150-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x400>;
-- 
2.38.1

