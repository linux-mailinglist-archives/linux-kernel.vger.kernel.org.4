Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD16719F31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjFAOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFAOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFDE42
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30ae141785bso887138f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628432; x=1688220432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnxtQ4HTUnx3uNE22CEc4Kze7zRk+aIPTi5NqE0B9iQ=;
        b=QFUE2P2uPwuUgeO9EPIYuRP4n+DgTvh2Re4LHmFCaeZXxEXzSeiLDeMMJ6zMZSInbH
         oo3jHjdDozTkLhc/lzZkW9AUlHakq7/mPpsMm3svTJ305xnW1t3dCJVUaHDBVRjvqjgw
         RWUdunxfSgEiZ23pYoVX3wb7gDHgO1WgqXa+mUNDLC9vf2pXiExBppnFOdRNDqJo58G7
         HUO7g8t5Z+zi1tmrjh5LUx6GjSJMv7VO2zOsJ0jti+gKkqarSdHfXcEvl50DkTThTeyX
         VninEasywFBslNABPQyVOgpno38oYsYkTcUqvbSExHETZidqF3n08gkzMFgrXt8+qGrd
         OUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628432; x=1688220432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnxtQ4HTUnx3uNE22CEc4Kze7zRk+aIPTi5NqE0B9iQ=;
        b=WNU/Ck40yuR6uCell4CzFPoQCYJCqQbUyqVqe4rdR/sWxBwI6lwttDE0oVlIPICE9O
         gvp6Frrpbi3tR1AaEakTP1YVAlCG93Dxt4xddWN2w9rgfz/maPaK21uTj62cP1NZoYFV
         T4Ae2JVYzdzs8+DusRnAAIOL63N+1QPFEHy9excqAPzWzEcAeIUj/iIx8es57T1qimdx
         ejErDUUwPQpN1ePT3/zLJMx3123LYdfYUIuDMEU0B7qzbDHKsq3dxVI6GOlQAXjE3JO8
         w91zOKXwf/LWhl147E5sUcCoWyqX0X5mEOYcrWKr6BX5FyhCUnJ4nrSdvO2KN5bxtBzt
         kxog==
X-Gm-Message-State: AC+VfDyhQdrxhWF8C7RP93eYeLSCWTTNiUyF+b7gOgH4tqqkYnQ2l+G6
        WedlVref6MHGlKGGfGFT7aQ9UA==
X-Google-Smtp-Source: ACHHUZ4N1LtbVcSSlgrwWiiN8ib1kk8aku1l17gEfJPD2KLnBUHb/IIze6yUyRA0cPHVitObpGphhw==
X-Received: by 2002:a5d:4812:0:b0:309:4165:f733 with SMTP id l18-20020a5d4812000000b003094165f733mr2026267wrq.17.1685628431970;
        Thu, 01 Jun 2023 07:07:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 16:07:05 +0200
Subject: [PATCH RFC 5/7] arm64: dts: qcom: sm8550: add ports subnodes in
 usb/dp qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-5-d4d97b4d8bab@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=g7Vc0o9RsiUJlV/GgGAIcm7zZrgyQ+1KWc0K9qA4qyc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYJ3rhVAR6IdtJRTpnTUXJdYCy836TCXZnwDloY
 +fao992JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimCQAKCRB33NvayMhJ0emOEA
 Cb+ttzWk6oQjYgpfBF1+TtSnm+vrky8Jw8k0g/Ds9Ref7+ddLyu2L+Hw8EqnZOv5Fig3CzqkW30nGZ
 aIRo+g8UelTO1+T8mZmqtylF1dIcdTFRL3Yzzbk/GVOkneUNQ3pF/QaZphJafP38t4735PGvJIluRq
 gPnfQvzeGK+YVwRZ9CWUjYwJgozzXdzzt4kRn7eOHm3MhgiDTe4X1gOVr7WXMUIsm73p/yizdvUaev
 FA0AlhZXr2goebj3gpPhRnJzQbUlC2LxB1EDuK1svLHa3I5ERDwW4sRQ6eq0X9ZOJTjUdPXCbEAuq+
 Igi6tdw0mswRLgFKhTvfm/vI6/6z0TE1JArFb/kezkapMnmKv66iLkWtszH2wysWjckKUrUJFiNUBG
 mFTG6rD/73CQvDUWqnPVvB71t+Q1FqV6IylMuipDHDVZGTaXrpMnYQUlBPE4nPL5xhLS68rNJPhI8/
 ei7Tv/oOGRSIIsYO46vt9ziu0OxSG3qXIsPdTGsqrKJLNiSMeFIdK4/gDCZUR5tv8+OTRE05YFyfep
 5Q/0j1DiKPBeWiOqxmoUV0S0HKjQ4gGpNwVxt+7h67bX7vk5HgoS4y8RHX8wtsNmqzr+T78HbcNNbY
 9QTk0fUI+QwzEvEbF1iu3OXD6N0IaH+cLRseNX9bCHSneq0HSGxmzxqS1kgg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes in the SM8550 SoC DTSI
to avoid duplication in the devices DTs.

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

