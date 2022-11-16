Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CD62BEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiKPNE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiKPNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:04:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8221D275D4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:04:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1415241wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K59h3chldv659kO/hvYsDP3wmikzxtwg4m9ZJi+0ejg=;
        b=X+USBc8Eamwf136iZ6dntFbPgOVBA28cWlFQwARCClPCDige3uxV7yb+YNH8z263S3
         qFVDcUJqomCh3EvAuQI/+0kA8WpliCJwRT16nbQGJIM7CGHCB/PfcQYpW9XSLy1M/87d
         qLLDcnIfgmp1IdHwGBabgc0kkxpLeFZaXCdpciXTmeV1CNdOxcdx0Im/bez+9WemQrtY
         IJQIqJ0ZabN/fW/6h3eprecl+/PqKR8ze0I1YfrbZfwC7GI+5uWcgeTVVc6KfRPOfD/u
         hTPrhFTnQkzzk0RB2lpvzcChgMLDDBI9nuxa0/NOWYsurTzzwOUE10JsgVsEvGOvn7fC
         8ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K59h3chldv659kO/hvYsDP3wmikzxtwg4m9ZJi+0ejg=;
        b=3QUZKsFhaoA3ZwASgYo4pUYK83XiMXS4yR2sbnyuD3K+9S5h3wGKV+KVxLWfqI+HGb
         TuSVM3qy36eAT+DWg3KxJqaz5ybxPmpxbbwg9lyA2szAC14y5vgf0cLL82JwV9MdlsXM
         MGxX0nIeC8NelijTZ4VkJd154sm1HavhjtgIlkW/d98cmjfp6/W9WAUM5tETHVMUgbxj
         tacDiYz/8QChkAcUhIfQaCUknU3CEF23f0pwIWEU2qvvwnivCIIIpxEWJS7xCXQOfHD0
         yvxyefi4TTe53TKZRQk6c0DnONs30WgzCdNskbw6HcNNj//uxEmZrdfLz+KsBJQoUBNl
         Or7A==
X-Gm-Message-State: ANoB5pkKh/rIZVqoLf6V4kYChWdwD8dSEReUqKAbAFAUcpcy7fjIZ2+u
        RXIOYXTru4dgPbZ9BdMQ2uLKFQ==
X-Google-Smtp-Source: AA0mqf5DdkDaKD5m+4RXL6MWKggy8EKpMZg+LPka1RA+qvXDg7g5P8C9iT8WD8CgxflX5sAW7zD9YA==
X-Received: by 2002:a05:600c:5014:b0:3cf:72d9:10b0 with SMTP id n20-20020a05600c501400b003cf72d910b0mr2115770wmr.26.1668603880109;
        Wed, 16 Nov 2022 05:04:40 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id co19-20020a0560000a1300b0022e66749437sm15130613wrb.93.2022.11.16.05.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:04:39 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
Date:   Wed, 16 Nov 2022 15:04:30 +0200
Message-Id: <20221116130430.2812173-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116130430.2812173-1-abel.vesa@linaro.org>
References: <20221116130430.2812173-1-abel.vesa@linaro.org>
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

Enable PCIe controllers and PHYs nodes on SM8550 MTP board.

Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index d4c8d5b2497e..93a676754666 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -414,6 +414,31 @@ data-pins {
 	};
 };
 
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
 &uart7 {
 	status = "okay";
 };
-- 
2.34.1

