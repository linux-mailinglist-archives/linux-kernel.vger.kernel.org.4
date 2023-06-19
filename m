Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C389B734CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFSH7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFSH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55379E72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso38358381fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161521; x=1689753521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/+hrX0GgdYpPYOfBSffAgZkKDGGRgDNR2QD2HNyWl4=;
        b=aqPXyKAq/nPnJHGDf3vbLGeaDnIFa6SH/HG1MrCl3RbaH4T/+faQbFGbWtdkBXUCKy
         7gpz8nZbWTx9NHs0puTz5aczGY+Hd314DW1b58L6sCT1Q6/k0bW+pzn0/6WaIxYqchuI
         ou9/sWulOgXuZXOf0DuPG4MY6Pl/V4cnUnumlY35vM3c5MOmACKkZ1Ga8xdPE47SnTea
         /cRY/0jfcsrQaWsOWz3P4GO3JNRUgaUReIWl+Gjcd53ymUTxeTDiWCjefL0fSe+j4Ylr
         syCkLHqke2xiWWbx5gl3pYk/O7r5PLPz1t4x4JA+QOZxCppW2NcbzpHh+wUELoa07bgP
         gaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161521; x=1689753521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/+hrX0GgdYpPYOfBSffAgZkKDGGRgDNR2QD2HNyWl4=;
        b=dZGt1cvs5BJwXojXUZtcHO05w+UE9NoWKe4u5QCIx2rxAp0gGn0unxvU7d43ljNLJ2
         WMinsHfA8ldO+Cv99eCFhj826VPskrmMK2GNWcfBuHspAusGZfKTEoWRHAX9+q5NDLPc
         iKvP1J6oOXmk7CRiaEqsR+mn4NrPts7kvUfIpuuqxXGaz+VNTMjexicTEC78Dp8Jip31
         I/0fafnC+D/htaA83983gJgMVyKU17W6Ch+nBDwXJRS8XLPZoBRIX3K5UeGFr87fgwTH
         Zbe9qhou81W/ONa/A/xJnFZuRpEJF4cun+GJm0siw/j5UYcgiuYxT2TlD2i/Mmw7vCUf
         AZFg==
X-Gm-Message-State: AC+VfDylqAU11uGa5LIPbeJBOwL/uEnJIwINbIbydamZKCKwLnPolY40
        QQKr8UEUDxbEjw5k4M9baMMMSg==
X-Google-Smtp-Source: ACHHUZ66ABBk3DB6poGwvv1SMC5jAQGW9HTrtqkJvLSiN+HS2Plpm+IHRxHGUm9/arMwteeHmSNQiA==
X-Received: by 2002:a2e:9257:0:b0:2b4:6f70:c391 with SMTP id v23-20020a2e9257000000b002b46f70c391mr1756391ljg.37.1687161521660;
        Mon, 19 Jun 2023 00:58:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm7091491wml.19.2023.06.19.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:58:41 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 09:58:18 +0200
Subject: [PATCH v4 3/6] qcom: pmic_glink: enable altmode for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v4-3-eb2ae960b8dc@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAqrm2uSrSFCkmjz6JN99PWH5SaNfNy439TaRaUa
 JzDNg4eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAKqwAKCRB33NvayMhJ0a46EA
 CiSUeyhVz5qf+yULYYL09X5643R9KxoRaR73pwCLxNgBhncvoOd982mOBoquPA2ZawIfSQAl3cjSlN
 MhWflorAB9F5D0YrTjszSCHgOPL07dqeXJhCV6vHGO2qLnewYdrUpuSBw3AOfDkHG+vvPim54U+EQ4
 AsDij/AkzcfX9G/gibSnQA9WY7Gj0Q278TlT8s+uJh5J3VnB50pIFfbGOhIR9gsWGGQEPuzDjNIOgE
 gYsU3Fv6k9c5cPxU2ufnT/xVDgpxf0T5Sevp/hYosiVD55qfYH+rv2nkWpZvF8oNLgV46HY62s0yB8
 5cR+z6DjE/kmhAG9tNpBVwOvgzTUdEfCH/zToLh0JogwqSwcOsAu8nA5AM5yMUWkaOLaamTcMBLLmF
 oKWwYcxoGROOo4N6OYuqjJz8mfCoywlWxMUQ61IPL7v6nhqlsdkA5ZB+bVsTVAZa3NS8wW5FGXIdLW
 f3cuSL1wPdh76bMVCOu64TZnkQtOytb4yWQwbtRVPGg+fhD6vOT5HBYIW720Lq/c2b/03INEJxgbd2
 HmMEBNVOcM8wAERmalcpscOIvsGBKeAN3+BSL8XvwafHVMJYVFmQOfvAvO8KiTKz9bQ5SvWEpgPwtT
 kGtVxIBubN3Nj0kxJ9Kq5wsxEMiraQXminVk9TMuR/toXEG5g9R+69nTueQg==
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

