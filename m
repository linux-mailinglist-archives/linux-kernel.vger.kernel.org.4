Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A1734D24
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFSIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFSIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49065FA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9002a1a9bso29266795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162040; x=1689754040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/+hrX0GgdYpPYOfBSffAgZkKDGGRgDNR2QD2HNyWl4=;
        b=nCjeSP/703vwmDe80yw1glK0f+b80yiMw/BTYdLJpu+I/GWcg6J4s/DI2EjDpwGapH
         loEaN3f7INJyrBLR8GduTPDOmUbMIFMKdY2zqD+gymnvA/ed7sPg81i59xJE02aHMj6x
         Sa4nADwTk+YQf4OHit43GI+CH7OIJm66tZeKSDv7G+9cn1RNjRme9N6Sc5kMAV3Hqmur
         9VElvgizgQlUoB+78pjYamDj4cMPVmM4nXEpvnbRlxWjBpRDhzwKEbmxk2oRe+XIaZWN
         N1Lck2IeiXBVgdkeQlq3Pi3cCqQM9Re09KzY39SMVGgYD+/hF2Lf/ZvR1ai9OqLRGWA8
         D5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162040; x=1689754040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/+hrX0GgdYpPYOfBSffAgZkKDGGRgDNR2QD2HNyWl4=;
        b=G9lNIQAGy9vFQJF+GqExtypqevL7nwqan5t7ES/jzXgfoxFRf4l5Qio/0cRZPJWew0
         Qnl2FtVPTOUQXvBOSDBgRSKYWjN8jBFvW4O+7kquavtMVhTc7PEfq3i0z/pWZ/Z7ZClP
         bknikMA79lEvl1JmmMi+NBO4lwBAND0p/ELS5fpYETSPCbJ2AaWMFqWdiVjc1tSRRzFl
         MUxjhKx8aKUU4wL5p4/PSjpdBnn3BZ1D1lzMI1+tdgax2e9eZTEigzPTHTSicATUTjML
         31F8aT7bCyN2pjiE3Q0mQVSxyb9sjAJ6jDE+Bt3xfVC8zcP4TSERIM0EA0CBzvp9gIE1
         xAbg==
X-Gm-Message-State: AC+VfDyRxmo3xTsYGJIco2CKzQpK1p8zGNszhQgBF4qn7LuDIvrsBIIj
        5DXRtjqJZTvbqdPQocURsb4VnQ==
X-Google-Smtp-Source: ACHHUZ6MGMSk7kSXhM2qfjrVYAtS19FO8ezadaLX5DgcnjzxuLyT0H6kT7n7NKTLZf6N6PC6eE/KYg==
X-Received: by 2002:a05:600c:21c4:b0:3f9:b12b:1596 with SMTP id x4-20020a05600c21c400b003f9b12b1596mr1412256wmj.19.1687162040760;
        Mon, 19 Jun 2023 01:07:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:20 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:07:15 +0200
Subject: [PATCH v5 3/6] qcom: pmic_glink: enable altmode for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-3-9221cd300903@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kJ8k1s4YhbZeghfNqa2GuV3vcB5ikSdP7IhrDDYjGGI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAyzydKg6gsMsLtHSbgGjR+C7u4iF05goQRd/Jzx
 QhtdG3qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMswAKCRB33NvayMhJ0d3dEA
 ChOwiXYTap6dr8Ut5wRdHm79uAP4pqQBSHeL9pLB+bn6ar8+uKklL7FkDYH72bHxniJflLSvgGHky2
 rMBpIIrSo+kunMXtrcwObgsO+sxsW2ATkh2780MCHlTSJ8cEduD0Nr/24rUBzq5IyPi4mRGaMpz+t0
 TSZ8lMy5nLwwsVOfEvgEyaiw+UwwjZx0zs+B+GDw77qMbG4+bSmQKnRhpqD+obGul/S39qHW7kJQr1
 dw3nTcAUSKhty2Y8iszohIkq0M2nP7bGJrnWpAKcXjkd+0EVaM+Wn21KTVGTb6GjrYyr4djLM7wpQJ
 xjbsxacq6JEajfN44h1IyzBe4tIsvlV83sD+CI5Hcw4NtFov3wdKFcr6rjw9dP4D2gXb0y89BoNLGT
 sZ+dmEhBq9jSNc6U14d0wr5cOKRMMiSi3V+fwM0sp8CJj9q250otz8F5bPDNcTiIWKhnm3Lr7GYNU+
 GHp8KcXWhGIAPcx6vw2r3D9E9JPae1HKmya3w62rV6f7q2Cuvmmbl3dwn1zZb6kSVjwn+WGE+IKIC0
 cUtbs68bMyMF9xn0WaSPrmv3PMcQPIc086sZKfa5vkW+m3/kOth8esjfN5leHgIknfe2DDx0BgOHpy
 tk5uRemk5JKadGnmw40Le7bYg6X2OKFPAdhOQ5B0DxyT6DM8VlILS0uOH/Ew==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Altmode is also supported for SM8550, allow it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index c87056769ebd..8af06bdc6f5a 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
 							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
 							   BIT(PMIC_GLINK_CLIENT_UCSI);
 
-/* Do not handle altmode for now on those platforms */
-static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
-							   BIT(PMIC_GLINK_CLIENT_UCSI);
-
 static const struct of_device_id pmic_glink_of_match[] = {
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8550_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,pmic-glink" },
 	{}
 };

-- 
2.34.1

