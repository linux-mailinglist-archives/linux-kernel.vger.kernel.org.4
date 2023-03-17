Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF06C6BE52F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCQJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCQJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:12:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7712851
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:12:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v16so3794967wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsclgAbS3rbIW7FZHguIeDH6KZDloDI95tL7UtBDjJ0=;
        b=CQOtJq4h9MXDuBlkxkN/enldCB3Z/orNkBGeGxokzv8TQA76okAYfdFwt7rJsm9pWg
         sOizx7bgczOn7U4lX89/bzNmT1b7TLDRg1au+f337Pvn6ygsB3JsUIlwbW5TydwqgwYr
         8GRSh8Zmd/RMSuu+qbUxC8+DcGP1lBqeI9aZNbkRNOjt3m7gkdnfe156PgfcQAi4hbms
         ZpThOT8Virlrgd/5mafsE/+/BCC+HQnqoXVG0BDxWnI+TUaDk7u78q91i6ACtCcVX1GY
         +94VLF1G6IOxywCjHga5CKn5U/2e7kBWqOGIo6uBJ71nkJBhuK3wXVJ8cqbr7nYDoRfa
         1EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsclgAbS3rbIW7FZHguIeDH6KZDloDI95tL7UtBDjJ0=;
        b=1ilOXi1k+UNMUoiM8brv3j8xAWlTjoq1M7bMhHwZ8UQdt241pkJn8/7aHzELrzzk/Z
         dpr2nsWqFwC4ppPxDUy8loDV/VFM20rMWS/nC9DQFt764mqKUz7u+cdrZ6MwblAl4MbE
         AOGHUXOq3Bhr0hpOw9mesihmdeFR3S0U/HPxO1YzXV/Va1gWO6OBOxQQqeHHE/38QZ43
         AOA1jDXcjKNrwoSxU039ZdExHVkxxI/hvjsoMsTNbgLAyTjx/WpyfEGipbwJ1IxT66lE
         FvjqsCT/oxWH2RSBiqLlqz4F6kFcQVcW7hcUZa9YqSNjCVRaSo7g8td2Xw7dX0uvFiXF
         bFTQ==
X-Gm-Message-State: AO0yUKVWwtdJtTQmoxLfmwSUED71RySsJxToQxec2OSC82fzMnMjOXEX
        vyGXJSqInqm+9pnqEKhpQ7JISQ==
X-Google-Smtp-Source: AK7set+E6XtmuzwUH+FxEraKVHeTdYh+x338h0rG0Im9coRcfAySUa+y9M42vJngYgFX/v7c5cSujw==
X-Received: by 2002:adf:e707:0:b0:2ce:a162:784c with SMTP id c7-20020adfe707000000b002cea162784cmr6537417wrm.65.1679044372589;
        Fri, 17 Mar 2023 02:12:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002cea8f07813sm1467976wrs.81.2023.03.17.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:12:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 17 Mar 2023 10:12:49 +0100
Subject: [PATCH v5 3/5] arm64: dts: qcom: sm8350: add dp controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v5-3-a27f1b26ebe8@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v5-0-a27f1b26ebe8@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v5-0-a27f1b26ebe8@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Display Port controller subnode to the MDSS node.

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #SM8350-HDK
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 975ab4cbe57e..37ae4a948be1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2415,6 +2415,80 @@ dpu_intf2_out: endpoint {
 							remote-endpoint = <&mdss_dsi1_in>;
 						};
 					};
+
+					port@2 {
+						reg = <2>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp_in>;
+						};
+					};
+				};
+			};
+
+			mdss_dp: displayport-controller@ae90000 {
+				compatible = "qcom,sm8350-dp";
+				reg = <0 0xae90000 0 0x200>,
+				      <0 0xae90200 0 0x200>,
+				      <0 0xae90400 0 0x600>,
+				      <0 0xae91000 0 0x400>,
+				      <0 0xae91400 0 0x400>;
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+				clock-names = "core_iface",
+					      "core_aux",
+					      "ctrl_link",
+			                      "ctrl_link_iface",
+					      "stream_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
+			        phy-names = "dp";
+
+			        #sound-dai-cells = <0>;
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd SM8350_MMCX>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dp_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
 				};
 			};
 

-- 
2.34.1

