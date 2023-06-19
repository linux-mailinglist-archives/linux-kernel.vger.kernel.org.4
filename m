Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD92734D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjFSIIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFSIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EA1BE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f906d8fca3so15998205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162041; x=1689754041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXgCX8dNw6x02jPRHVLJkaCju40zMsClluJj0tjYPUQ=;
        b=HZCmwtu9BdWLU1dMdp3EoA80X8qLInuwgGr71Y5XfG0UsZxBWTOnF/owLWpSEKmILO
         VTRrmcQqyH5z1oyLzNk1IuTJcWBFW2cZWQ/5MRc9ggG+A3OEb2nfAz5OmZxnF5h+WsCP
         TetumsdWHHL1rIgvC/CicMPCH6PRezdSK+nIjbCAJLKVmEjX9mg+tU9cTxObHvhzdTwD
         Lhw5ZuAxefgNAghnyj5XIwuV0bK+rxFjK2PtevT5JWI1eqniF/L/JX1F7tjSmqQxXlJB
         rMKozxN0juPSzU3fsVOquDOtZHs8UKebKhllIl586LfdH3KFkJQ/KIkWsl+qWfKRG/EZ
         Hx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162041; x=1689754041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXgCX8dNw6x02jPRHVLJkaCju40zMsClluJj0tjYPUQ=;
        b=jlk8j6kQOSkN8LmhUtlb29rfIQKGr2NEeoYiUejyg18rSsmpgiYW79FeOmdwrUF4Td
         vQhMrCmO7t9AXJc4St9oag4nX+USTBSmZMDY0JIPj1NkkwgOURzzsEty0GqJh7yb9mif
         Oas2r9KP5f+F14o3xBPnwrShGa8KFG7yRNOMWJXIXuIVqOsL643r26dzLbiFKN4qn02Y
         x3AeR/PPFvZKoEIUhoMfh2kpUc1ZNLWzzi2fYwZD6hx1O+7/J/K+etG8o+urw0GvT3Ed
         3uQFVDKw2y5gAbLzjBtuUayzOmqapt1ejYwUh2Ypgo5MFGIV9BV87WUIi/Rn5kF44j9A
         6pEA==
X-Gm-Message-State: AC+VfDyPe7PGsWbzF2Oz+2YOq7aFXC8wvASYTqP9Xq/6FsYs4cg4mTjc
        boNhya+WY9BEESx1JJkUR6v43A==
X-Google-Smtp-Source: ACHHUZ6LrQbSzM6YbvNuMCLpmIzyNThns9KH+we9XG9ltfZeVvmZc7zAAsLLsrAnhxeSCHuyDneByw==
X-Received: by 2002:a7b:cbd0:0:b0:3f8:a56:e9f2 with SMTP id n16-20020a7bcbd0000000b003f80a56e9f2mr6311748wmi.1.1687162041606;
        Mon, 19 Jun 2023 01:07:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:07:16 +0200
Subject: [PATCH v5 4/6] arm64: dts: qcom: sm8550: add ports subnodes in
 usb/dp qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-4-9221cd300903@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YCpe2uXLy9w3nWR5fQNPmqhcnIYVQV3CZ+KVZfbwGls=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAyz456k5QKZ8K7+THfqNMbg4gFA+ybmcn/po3/N
 N4SZbnOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMswAKCRB33NvayMhJ0VzMD/
 0cZ0+3U+k63SGi0VxqXX2Pnma+6XRUgPT8jgIOkqTAf48ooaouwOF67rO6eQAjgD0pkEJg0kUqV90e
 7hmIHQyeVbA1SbRgSTzJOvbc0u6VuqqEX+XdgVsBH9izezH/QDvzwix9q5lwHuYSYT/q4RJFoPxqbo
 R0FiNaRiRTc8fQ8gfWG9LX+w9RXRZbhL2iJNJwGmFV/ompbaXRizAMo7X9sIUtZdlxfDEnJzFmBM9e
 0WupI/wxCx0AkxQmeDRKb3SFcwSCN29HhcFW3rA/coaCebS4vLn6OnGrY7HhaBxdO2apZ/a5Ex6JuJ
 EBPugF8gExruUKvrc0e5++b+LjTyvY81HXqYZfwBnd4je+zONKNNcE44PqZiIVAj1AKX8kOgHCYvIp
 Mq6YrEf/CsDVqjUMN9YSGqcVJvnKJikMd1+ZTa+e1uAuAjHybx3S9fEpX4EH/O0droGsUaMl38qSJR
 9mPdHyFuXxJDbpeBHTXbsm6w7SeLpsj8DeLeEJAnvirZ/Hnu8vVbpyRjswOWXdSf4c7XIlZLhheh0s
 kmIbm/hdbVWSJPh0jeBJdU8SCCSh6LMw4+fg3q84Mk5EFJGOELPTIJFhbgvPQxT4ovL2Ws5nl10nR/
 rSwbWPafaEoUtfYSdZc+USYJX25nSeJF7eOE7RcPai9OE81gSbdnPE4ctLhA==
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 41d60af93692..54636f475306 100644
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

