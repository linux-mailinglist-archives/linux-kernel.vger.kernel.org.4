Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0917118BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjEYVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbjEYVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:02:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DC4E44;
        Thu, 25 May 2023 14:02:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so364114a12.1;
        Thu, 25 May 2023 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048541; x=1687640541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=L5qtNbh7SdIzNNd/mBEdxZ2FXrZxraKRbC9vv+2cZMYlTmN7Fw6x3ZZh8YM1dv7Ph7
         p7U9cm8tug0+kmBTUGpROeRlg9SQ+zQrkOA7Q+nCnYFjvjAzinqVRdt0nuQ3zWkY7yXi
         pS6MyLZAPaE6r0wjH7214ik//1ggheBqo477uQ7HCrMQJKPrPQ0gLP5a3M1YEILYYfOq
         UeXBCiebcgRS5HxKLa/4Ey7PIZRHuOOO/ysrqZ3KY6Z0ZuxkHB9WoXRkVLLPN59pWqGM
         wWPda2nzJiJMMzmzPCapojuwVHmgxg3Y0R14PE7Jp0+Kn2aGdoBX1LE2RuqvxHVyhlCY
         3uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048541; x=1687640541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=MjCBH4TgaXK36YE+LzyQdtd5CxlfH7bek91Q1Qeyw0fKZBe61C/eUZlkcLsDOyMms6
         WaOqlR2Qhg+QIiILJ4eXAtWaVD3WLne9sOTaxIdr8rcznHitFnTlsGPKrvS3B6HtPEPt
         V+nohXMMEETPKTGtZZvNZNKfrJ8tg9eEWIBGFAcv9FfoK6sTQ6m0oZkXfTiXiwc8STbc
         H+i0fP4KjFj9+pQnqIr57hLkT2Q6XCer4wFta9qVrsA1ajcDCcVGDKjVzx6kC+e1DWv3
         4EqJFBUL8Qn8X0FQI7Oe35g/MwE6wVM6BbY0WUTPnq8Vqu4mJxHv44qC9l33V67IH0dz
         DBGA==
X-Gm-Message-State: AC+VfDyRzIwrPkk8V3xqB/ahvbRHfjdVHKR2OCs5rtOLX9+g2T+mjy6h
        cmRUtiWpWUqtpcHTcbIozuI=
X-Google-Smtp-Source: ACHHUZ7cokGVc2W2zOPV2XYF80y64Q7vf/pSMINHzih9EoZmNvIAe4flYuau5K4CTTJCEgtdbO9XBg==
X-Received: by 2002:aa7:d687:0:b0:50d:a804:423 with SMTP id d7-20020aa7d687000000b0050da8040423mr4007864edr.10.1685048540688;
        Thu, 25 May 2023 14:02:20 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id c25-20020aa7df19000000b0050e04125a46sm913010edy.10.2023.05.25.14.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:02:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 4/5] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Date:   Thu, 25 May 2023 23:02:13 +0200
Message-Id: <20230525210214.78235-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525210214.78235-1-robimarko@gmail.com>
References: <20230525210214.78235-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM SoC ID-s are now stored in DT bindings so lets use those instead of
defining them in the driver again.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a577586b23be..60e99be2d3db 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -31,12 +31,7 @@
 
 #define MSM_ID_SMEM	137
 
-enum _msm_id {
-	MSM8996V3 = 0xF6ul,
-	APQ8096V3 = 0x123ul,
-	MSM8996SG = 0x131ul,
-	APQ8096SG = 0x138ul,
-};
+#include <dt-bindings/arm/qcom,ids.h>
 
 enum _msm8996_version {
 	MSM8996_V3,
@@ -154,12 +149,12 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 	msm_id++;
 
 	switch ((enum _msm_id)*msm_id) {
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
2.40.1

