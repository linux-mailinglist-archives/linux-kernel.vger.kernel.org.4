Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C259668B9CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjBFKRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjBFKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:17:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB612F30
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:17:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10389603wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+RQoVZfem6e9FhQzMWvwQuGFKN/4iRjnbC4Ju9Z81w=;
        b=jO63HprQpX1TzqC/M6khRjkw2lOa3GbfVoYsnQuE/rdgmq5b9dMi2eRBDrzUctTgGt
         OyqxR4P/t5DUOa0sGuG56ECWEd1VBrxLCcnBnV/IxbBkeRRdhgWCsZHzZLeLdQet8aI2
         OyiUme9Gj9YkgVqaPlu7dJs/CUwwwqXS08PDY17eh0Y427VjtlasiofnNaYyS7hJpXfd
         JoAEyBONbuEofQRSLIughYINxqm63ro5XEcIbuvhhY22kC9n4M/6lHw07E2NkQfEugcw
         ocH5FquEoggq/cflC9F+0by4tJzyP9N4FVza/uBtlZVxSaiIB0t2flD82GVrcQupmcHn
         p3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+RQoVZfem6e9FhQzMWvwQuGFKN/4iRjnbC4Ju9Z81w=;
        b=PjQNdeKaio2KQuoCJXyqu2Mqte5QOw+bf2tXZ7SYV08XxkdA2X2tQuHOTUqdAmatxT
         rNYjpaeDsWMQm/vYdVAs6finjC3lykDhaZW8fD6VpicYrME6dkrmqzkUgvfieN0coEy3
         zabQl0Xs0CLdaiL2PlJKbpdvHvZB9zjK7UqK/8rwmV+JS94/Ox0IMen/bemdoDJGTF1A
         yAtkFfoGBXwtxE1apXkf20Yw0NT+CASjt1tThAqA8lZ2dz0MfTFbDtRnRAx+twoll753
         2IfBXs4qb5NtKo16JFpiSr7M5iolFSlZidtH1ad1WG3LTY5LngltIXKpOXKExa4b82nU
         uxdw==
X-Gm-Message-State: AO0yUKXB8nA/HJkx5rok5DRRxW0ujt2p/FKZYaah6tTleFgjTDF8ERWN
        hCcBDH+6hr5A3kitVyzdkCQw0A==
X-Google-Smtp-Source: AK7set+d7A4lbY4mReLik2PTZlJBXWH37IuILHSbkhWuDxZdPsVKe0tSvhWKxEmZviqQbAWkn6AYNA==
X-Received: by 2002:a05:600c:4f53:b0:3dd:97d6:8f2a with SMTP id m19-20020a05600c4f5300b003dd97d68f2amr18366441wmq.33.1675678630959;
        Mon, 06 Feb 2023 02:17:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b003db0bb81b6asm11314201wmo.1.2023.02.06.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:17:10 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Feb 2023 11:17:07 +0100
Subject: [PATCH 4/5] arm64: dst: qcom: sm8450: switch to usb3/dp combo phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v1-4-f1345872ed19@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
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
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP PHY is a USB3/DP combo phy, switch to the newly
documented bindings and register the clocks to the GCC
and DISPCC controllers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 38 +++++++++++++-----------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d66dcd8fe61f..757b7c56d5f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -748,7 +748,7 @@ gcc: clock-controller@100000 {
 				 <&ufs_mem_phy_lanes 0>,
 				 <&ufs_mem_phy_lanes 1>,
 				 <&ufs_mem_phy_lanes 2>,
-				 <0>;
+				 <&usb_1_qmpphy 0>;
 			clock-names = "bi_tcxo",
 				      "sleep_clk",
 				      "pcie_0_pipe_clk",
@@ -2038,37 +2038,27 @@ usb_1_hsphy: phy@88e3000 {
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 		};
 
-		usb_1_qmpphy: phy-wrapper@88e9000 {
-			compatible = "qcom,sm8450-qmp-usb3-phy";
-			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x20>;
-			status = "disabled";
+		usb_1_qmpphy: phy@88e8000 {
+			compatible = "qcom,sm8450-qmp-usb3-dp-phy";
+			reg = <0 0x088e8000 0 0x4000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "ref_clk_src", "com_aux";
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
 
 			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: phy@88e9200 {
-				reg = <0 0x088e9200 0 0x200>,
-				      <0 0x088e9400 0 0x200>,
-				      <0 0x088e9c00 0 0x400>,
-				      <0 0x088e9600 0 0x200>,
-				      <0 0x088e9800 0 0x200>,
-				      <0 0x088e9a00 0 0x100>;
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			status = "disabled";
 		};
 
 		remoteproc_slpi: remoteproc@2400000 {
@@ -2976,8 +2966,8 @@ dispcc: clock-controller@af00000 {
 				 <&mdss_dsi0_phy 1>,
 				 <&mdss_dsi1_phy 0>,
 				 <&mdss_dsi1_phy 1>,
-				 <0>, /* dp0 */
-				 <0>,
+				 <&usb_1_qmpphy 0>,
+				 <&usb_1_qmpphy 1>,
 				 <0>, /* dp1 */
 				 <0>,
 				 <0>, /* dp2 */
@@ -4157,7 +4147,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x0 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phys = <&usb_1_hsphy>, <&usb_1_qmpphy 0>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};

-- 
2.34.1

