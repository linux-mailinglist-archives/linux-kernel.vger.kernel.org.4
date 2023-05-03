Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5306F58A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjECNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjECNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A705592
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f315712406so23889055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119440; x=1685711440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NGIFkLLmK4Sr9kuOcuriuzObhMgDByOLRoFZOnzEg8=;
        b=WSIpp0AyUyNK8ejbmI+2AA2CkhtIQRzo7l1bt4nzDfp84pk0uBpzNmaZM/bHoydPnE
         JiNy2urDUO6Vj45zDRMZ5TzWPxOTn8iM4ySriyZIDj/V5rjhHTX+ryfsWePIU9DTPWMO
         n7dBIt2gl3WR/oXRGd7t/Y2rI6p3+W/D3Y2VSZHYCgvUvfrz27A5hxXMUUOQGIZV1LAW
         mxBbB72PcyiGAnvHnRo1USE4igrVcqZQySARze936WOuQbcnyRDray1o5J5G02dgbIYg
         9qRBAVhxRuyZDKgk2ATkg7SaeUK2FMmmiLDPxTZT+Adx+JXol46FCaWINZIBwbW2lhP0
         PIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119440; x=1685711440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NGIFkLLmK4Sr9kuOcuriuzObhMgDByOLRoFZOnzEg8=;
        b=Sp9xx6qgf2DDiV5GqWw3qFoJlsu95eijteiZO5pVg21QWuMnqzDUWP6RUfCZyQR+i3
         G6OPWQnx/+0icIDqi8BIMfGoyAhSM2tHGJMMFwAQY9q+ti5F2jS2n3JEp3pUPI5roAPc
         ImNYH8R/olKMJyjP/9eyca747HqV/sq8TVXZch4rpNbR13qVn7m2OQ7BTP1taRjx+hjS
         lqWu9TKJwM0IW2KKtJnKIw+VpdxqvL6ZsOVUWKux9tcWObkihPK4xh1iZYDQ8k46y6G+
         f2VWVZMK8gW+zmBcJZJ1QOepvNaUP6/LtlVin3UaD9wz3un2VDJsO8ZiwCllD3arkqPQ
         4K7w==
X-Gm-Message-State: AC+VfDzPJ7v3lDKWcyuDTvByi6JYw0w8ggEa340xoiOcpdCXjS34v1RU
        iBqzKSMC440LcEG7NFsQ9/pIDQ==
X-Google-Smtp-Source: ACHHUZ7MaD2EXQSyw90at3uuaScaXT0UHcM6Rth7weJFdKvGqxQTPpiwEAzlT35+ZqTu5SsRlQh8OQ==
X-Received: by 2002:adf:f5c9:0:b0:2f8:33bd:a170 with SMTP id k9-20020adff5c9000000b002f833bda170mr1615972wrp.32.1683119439757;
        Wed, 03 May 2023 06:10:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 03 May 2023 15:10:33 +0200
Subject: [PATCH 1/6] arm64: dts: qcom: sm8350: add ports subnodes in usb1
 qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-1-d1ee9397f2a6@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ht6a5DmmF0kzfbJ/xYkExLJE+gjvRhpNJMZTSQyBu3s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1LZr/WEoMmnAXZ2nsJdqWSKijmZ4ONtGaZKPYP
 vI1wON2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdSwAKCRB33NvayMhJ0Xp5D/
 0dbCCEjSD1BdP2zDtjdEUJjp8r7LYcR5nbJoVBq1awsPj50NqEboKoqF716e+5MifuMq+cTEVsgeQs
 PVV/xGHN37Tg/mZJPwJZvDtlX9u0lmCeP07x9fTXvEwTUYnddr4xi56O0BxjyUd6eORhnkMJFxvJew
 Fgm+oaHpKvsPO9lF5wfIdYcyPZ/wfxvn71rkctEgWusRgDEwr/H2sRsemePsscyo6DWE5dHUoAD1mg
 x15dk9iN8q7JTIGCOXobqqrEHUfEA/BzWS7F2ZGGsnEUhWO+yXhmImRHd3O13gMut9hDiLqaQCWLXg
 LUf7wS2Lu2KrDCuLAl9vU7Kgf1r5CIKFsYN8Jur/M0rvPzE4LxSETVvDIEIAsGvauYOEKMa0s6yEnX
 Dczb9kBAwH5y0QkLeFCdbA3CZEnFWgaJHAg97ouL4oZx5bva0YL3YF/tSiyX8X4o05EkXoK6FA5ZuB
 Fds3/+/5NJ9DOR+zqN9ozNJ4UXOBK2Q9d/dN/wl1+cwfH6QxJx/LSqSftkWc75JmwVf1D5xs4V4PdO
 riOlnbJoyMA3bAY0Zhul6Ur8Ig7btMmrRbSyrmIhBASt4ElE4Kr+EnPRGtAjm68ZUmHIsZM5VPT2UA
 WIJIcFMkGJjPBKXfZvs6E8r38psNp6TMFbFXuwpNiOmIGoVRCWYS7C2aRD8A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes in the SM8350 SoC DTSI
to avoid duplication in the devices DTs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ebcb481571c2..d048f4d35c89 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2149,6 +2149,32 @@ usb_1_qmpphy: phy@88e9000 {
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
+					usb_1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint@0 {
+						reg = <0>;
+					};
+
+					usb_1_qmpphy_dp_in: endpoint@1 {
+						reg = <1>;
+					};
+				};
+			};
 		};
 
 		usb_2_qmpphy: phy-wrapper@88eb000 {

-- 
2.34.1

