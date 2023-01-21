Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1567A67660A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAULaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAUL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:29:54 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455673D91E;
        Sat, 21 Jan 2023 03:29:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mg12so19934375ejc.5;
        Sat, 21 Jan 2023 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APNLiKmbt8JWMBZWCLrn0Q41j8dsCsL0653AwgPsFDA=;
        b=g1UzDz1rMz/aM52AgBjc3ucmXLS+TBgaPsQES6XJz7DWT4VKzPfjlknwi4AXGEwbhQ
         tFX0r02QSxf6CnmsdRQCnAH+Y8xP7FB+b0x7Hj4KXHJWjmgKw/iZCYIcltpw5UhC6CLV
         TKqS+7TEWZX9x653IPLzRAbNMeW9CLGbl89PfEbHS4w5xiYIWnMHMzDknz3YAupITNZw
         3zlIFYRfyGVlexcI8grFSdVKHv/hK481UzVIbV25x7Zm06f8aNq+0kNbc3EruZLc5QkC
         +YHXcWsLPBeHNl11RjQ89dIsEe3OSJMo8PyjDRvz6aK2B8fv6ON6XG61vUC1Zk/RzoF7
         pvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APNLiKmbt8JWMBZWCLrn0Q41j8dsCsL0653AwgPsFDA=;
        b=Y6Y89EvCu4Vo9VZo8Jg6/WZjfGYCSShhAGBLSBLDJ2sTdmsBKs/Zjszl3fCClu6NJC
         pB0aKTNICkAu8kwbNHFp0QF+9z19eTLr/eyGNaSz5vLie/2ebi7khzWMXDWVT+waObEq
         L6MELexn75LmLs3+WlbVkCYXq8e5GhiEcmYFF/ArXv3nDnWhR1uWw06IvO/qdhIyrZPz
         CdqUDbNidMYohZwYTkzG7GfJLoXI8pF+X8BeIcwXx2rIEd25af0LAwheoMjRTkhgN+w6
         mdUi8YsKpjOZcajNdsuNJ/g1Ua4AHQTdkQlBlmz6jgUmkOpDhGF3GjUWtqbbwn0Q2N76
         LcTw==
X-Gm-Message-State: AFqh2kp9fbzIOk7Q5CDQ3S8WoDPFwSFhqZLuaioSHPZ2oCM15hFmd7WC
        jDBcvzz+dMudD3XMHDxWrs0=
X-Google-Smtp-Source: AMrXdXvvXTupPobSVzZSXlsGrSw071RkVOjTM5EO22JRbV8ArGldH8Ps6I9uHpDJa3iZACtgQr6GYg==
X-Received: by 2002:a17:906:78a:b0:86e:7683:4213 with SMTP id l10-20020a170906078a00b0086e76834213mr19743279ejc.42.1674300591806;
        Sat, 21 Jan 2023 03:29:51 -0800 (PST)
Received: from fedora.. ([188.252.220.152])
        by smtp.googlemail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm5152151eda.17.2023.01.21.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:29:51 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/4] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Date:   Sat, 21 Jan 2023 12:29:46 +0100
Message-Id: <20230121112947.53433-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121112947.53433-1-robimarko@gmail.com>
References: <20230121112947.53433-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM SoC ID-s are now stored in DT bindings so lets use those instead of
defining them in the driver again.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index c0a7841a56c1..da55d2e1925a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -30,12 +30,7 @@
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/socinfo.h>
 
-enum _msm_id {
-	MSM8996V3 = 0xF6ul,
-	APQ8096V3 = 0x123ul,
-	MSM8996SG = 0x131ul,
-	APQ8096SG = 0x138ul,
-};
+#include <dt-bindings/arm/qcom,ids.h>
 
 enum _msm8996_version {
 	MSM8996_V3,
@@ -150,12 +145,12 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 		return NUM_OF_MSM8996_VERSIONS;
 
 	switch (info->id) {
-	case MSM8996V3:
-	case APQ8096V3:
+	case QCOM_ID_MSM8996:
+	case QCOM_ID_APQ8096:
 		version = MSM8996_V3;
 		break;
-	case MSM8996SG:
-	case APQ8096SG:
+	case QCOM_ID_MSM8996SG:
+	case QCOM_ID_APQ8096SG:
 		version = MSM8996_SG;
 		break;
 	default:
-- 
2.39.1

