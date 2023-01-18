Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1EB672C41
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjARXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjARXFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:05:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F444BF2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:05:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso952308wmn.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rTc5+Ho/KRpl/LXYC6JGe1LGWYfXgWMZkP2VaRi1e0=;
        b=zksurqVjkE0vZAqc4OP0Im2X+KScoypyBqXfDmsAuBwP3n1G0jEC30w6bD2bWd76X+
         DoddnDsPWaDOyc5SPLyj7dKoHUJ+4RainC8GtbdG0/Ca5Cb0NNye41v0D7MA80ZQTXZC
         zc/j0s9B8mwN2mo1CTp5u5qtdRxdy6lFXH/fyrZnt67d8JZUtz4oyDbtrPNK1+5D8bvk
         9Bm/MqSH25IQTZ/0oGaxyI1DP0DivlDZ2gHzPsX8zQYnOd+sk07UzW9w4WyWid/iY+cS
         bmv+b6reWdWHiNolAHJHwLLEcFzzfSiUaVdnglQuD3XX76J+TKKEs9steONOMjKQMaDa
         2ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rTc5+Ho/KRpl/LXYC6JGe1LGWYfXgWMZkP2VaRi1e0=;
        b=NHbSRNLd7iGz2dOHmJNz3iew2sySskYDLVfTUrGezBxFVGs0tInttkkfk/5Tjq+Fe/
         eidB7yToXpNxTwiIFzLF5MrZYWWfzOWGqsUdXGkXsEP0a11RkHaQtVrbIh3aHRsqraxZ
         b0+ihyqeOX3jqPWoF46Vb8r6AWdBQzWlAO8d3bWLUrZQrUoYjbpwWODiJpFjvKyQNOJc
         Q5hcBrbpXLYHJqvqT6Nq5zDcrox7o5sV0ZOkRXj8SFiOZpOCr1qVHP/4/LlpChvT6bqj
         egP6nbHyZni2AqRZjDUaBwMgIOMLEQYlCMt4rlMfGdd6MehHKMvN8B9J1ZQP//jWD8Du
         PWNQ==
X-Gm-Message-State: AFqh2kpYZNOZYyC7j/+In6yeph+ScTE/fTAoQ8wcALnTBvBlITDT4tWO
        TA0TInaq6drGr7U/o8Yl5+mmgA==
X-Google-Smtp-Source: AMrXdXu9U0AJnkorpywyvARAGHxdbyx/QOe78+UUUd6oZmp77WCdrXuAVhIXQ4z2a2ApsckavMHb0g==
X-Received: by 2002:a05:600c:511f:b0:3da:f97b:2ab0 with SMTP id o31-20020a05600c511f00b003daf97b2ab0mr8552392wms.14.1674083133314;
        Wed, 18 Jan 2023 15:05:33 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003c6f8d30e40sm3523314wms.31.2023.01.18.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:05:32 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
Date:   Thu, 19 Jan 2023 01:05:26 +0200
Message-Id: <20230118230526.1499328-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118230526.1499328-1-abel.vesa@linaro.org>
References: <20230118230526.1499328-1-abel.vesa@linaro.org>
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

Enable PCIe controllers and PHYs nodes on SM8550 MTP board.

Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 81fcbdc6bdc4..b69ded9c4b57 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -359,6 +359,35 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&pcie_1_phy_aux_clk {
+	clock-frequency = <1000>;
+};
+
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1e_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+	status = "okay";
+};
+
+&pcie1 {
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l3c_0p91>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+	vdda-qref-supply = <&vreg_l1e_0p88>;
+	status = "okay";
+};
+
 &pm8550_gpios {
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio12";
-- 
2.34.1

