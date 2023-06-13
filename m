Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9A72DBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbjFMH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240682AbjFMH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F21989
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6225464e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642972; x=1689234972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM0R8urzzNx7/U/EWs+VO9ol8E23jRS6ix/l2ppndlw=;
        b=SlH89Ms3G7hSLHFkwGdt77qYrSjogDjbe+IJFRrp8nT1MvEMDwjT1d1J4o/f2UstUN
         L91NL/6QHJ9H384gpw/IIlCkbHsVRxj8wLPyI0mz2LKc/FBAJg6ETngTrVxMMB1AKwo8
         vi4923KNemBwHH0+BuRF/RJU4Y0iFf3rKb//qow7TvdCNcm6yay32et/JD4BTAPbCLBH
         6meptI/XFYFFCvLs/VpU7ndxn47QEOwVJLijUK0/SlrB5/LJgB8j+ZreJm0cHamL0Vg9
         ob5lyJ0zxQJvrh5C0h5drXXaDG6uRwmm+m0NSe3nfvfeeSQch5iumzc4Xho0OiMcZIoS
         KMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642972; x=1689234972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM0R8urzzNx7/U/EWs+VO9ol8E23jRS6ix/l2ppndlw=;
        b=PAy8+xVPRBVFPaBp5P5FC7DEcZPR0pEi4B+Os2L4RVxlyFL8zYa+NN9wWzAn5Si+rY
         bGDrQMQ3CUgz8sCmbWb+e+6hfof3jyzUL19EOIphG9IGCfHTfIzTLdt22AJmx9AXoDdf
         ObcZHVymTzKCK9/x8M3uJ1sWJGseQ4KyW3nvTmPGwGm1ubYj82eYfYq/G7TijOBslX3s
         QHUviVqwUOIT+ryo0I+50vT/4CWdtCNbG+43LFlNRYjtq4592reZzMQuvmkntYJBgtms
         xpz47VdOIuTGwHTSbGGwvEjEMd9SBb5GHCfF4NIa7QVtqkn3P7Ghz09CnEEAyFdunEhG
         buLQ==
X-Gm-Message-State: AC+VfDwtvX5oRBihOF3eAhu3kdkCySOVXhozoAlyMq1CxexKJ348uM/b
        FXXEjb1rDMvfJZfEVXvS/1sGvw==
X-Google-Smtp-Source: ACHHUZ6T9ubeCNB6BGzQcRCOIoZ6uuJfQJsYip/IXp+C95yMz7G0m18/422gRgNfEgBYrm4CJ1G1kw==
X-Received: by 2002:a19:2d42:0:b0:4ef:6ed9:7af2 with SMTP id t2-20020a192d42000000b004ef6ed97af2mr4837396lft.8.1686642972540;
        Tue, 13 Jun 2023 00:56:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 09:55:59 +0200
Subject: [PATCH v3 6/8] arm64: dts: qcom: sm8550: add ports subnodes in
 usb/dp qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-6-22c9973012b6@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BkC0Jwx2QyfHEOewEqYxvy0hZhtFX6P/om7OzNUurFk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCETuMqKB2RUb0Y2pltGdjxWNg2jyB5BQM0+3rAu
 mM8HeP2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghEwAKCRB33NvayMhJ0WL/D/
 9LGZXM6cR5I5ToU3SULnlqhxkd+7nEXrcLdyXy9HGFsM8mIf2hYVOZflVgzHaRu9EyCRl/r7AO9GgT
 C7TwX6D9uw4UjJDOsafgNuze3+GRVy//AikkXlKC5+JdQWBglBWScUtNH5SuHv0q2TZHJB2Bl4aLf9
 jbI1CmsQIHO6C7nTjnq/f0smEqulNJKGh0TLov7zwmFO+QSFy1mfJlMjyOsnGBCWN5psoaHWVc0+eA
 UVSMexN1NVvtAcnueTWHrAO3wZAg9lIr1I3tAnuyyEsBzZzpXq9aPzExSIOEnhhIq7Rfn7BPLLWFXO
 PXG1IbaodZMO8pKdMY60Yczz+0589l3au3PRdSJiorBcSa2QG+aTHPeCm8EPalDgDTzRTHaYFqtk8c
 EaM32b9bTb9w4SqKrgY8sQpL0exUtGp280M+Vfv4eS/v8hEIH3PTp7ez68euu6+rU25TSoO72Tnk5U
 j4aczumJNHPzUBbMwVFAUngrBjFeiwrZamEtzllhoPer8xlU+utwa1IVrHQBO94okPBxAAwicgR3IJ
 his2vYpmo39nGvBCnjMA+tuaxXn4YWuGy2FseWGO0rb/aeNmnl2SGIvSqeyyubsQixXyn9gS2euGl2
 RyJxAQTTVsmYxAWmLDwzeJgTphYOq0bg9n2ADTuMp5fgtWAe6bJizqmBSLpg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes in the SM8550 SoC DTSI
to avoid duplication in the devices DTs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index b41b3981b3ce..ca2280041f83 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2838,6 +2838,32 @@ usb_dp_qmpphy: phy@88e8000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_dp_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_dp_qmpphy_usb_ss_in: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_dp_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_1: usb@a6f8800 {

-- 
2.34.1

