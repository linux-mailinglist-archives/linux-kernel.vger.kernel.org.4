Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FBF70FBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjEXQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEXQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:23:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3831AC;
        Wed, 24 May 2023 09:23:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96fffe11714so191986366b.0;
        Wed, 24 May 2023 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684945414; x=1687537414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=UItT9vYrEv/kfnpRB7ymoq0pbO0X+WFATR5duxybpApV0VslX3wEkhOt49PvRhdhyH
         u2wxN4RUq3UCMP+DOzHnZKVbrzBvh5CxrBoaAGHuE2X1s5Zjk/bXJXHQL1b+oEmzwbjf
         IbqXXFCzyy9KqgOeiDV2WwpPmZImQmC69uZoIZJWAzdyxvC+d6bQsMYVVbgMIOUp+Q9C
         tFtcaIJM7ucEQHYRswFkiIlHepIYbL49QO+qVBRXOU3mjkJzdaZ+R8xA35cwTCC58T8G
         llrimVok27IyOFYUYic1L0tnKYI1lTbNHi0K4FHrB8mh1jGoA8z5Vk3x90WV4gGNzDZo
         Jr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684945414; x=1687537414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=gO9/VbgN5SVnXWS/dFqCFusIQUWRhCWW/ZzpuWZN9IWYBvU/LCUoWGY3klbKmaiC89
         HVYF4ygQ1r35NUPNG8oqe/22HhNtFXtoPkqNyduzp0YxJtLXqIBQ4NaODG2vsagnafZZ
         hSSAckvWK8TgkraSV5iWoljIkLxqXWZvLnXdSsFfwe+0UsW16Q5ZGE9MqeXt9p9ZYb53
         E4yHaxpHxQO8fJNbaUNrnLs7tFhImkdBxOnVl6eC6kY856rnt/wB22v1WRQ5qzXq1tPT
         WnYQDK+SqulmC9eG8FtBRYkHVrDGncunmfEYrR7eQOk/i6RrvQQFabd3qR5blULAen2M
         FFFQ==
X-Gm-Message-State: AC+VfDxkxpQa/buPmoWOmGmoLviQqCybQNlAklhJrFuQjncah7FVXxRj
        AG0JR3DpOTjnPl4eVs3E0NU=
X-Google-Smtp-Source: ACHHUZ7MDPXXXXYo4DbsGUwSu0EzM1l4sfqZg9xWYeIw0Hj8LtCnDU0xtGqR9WUvxkNsDNqEQGjYxg==
X-Received: by 2002:a17:907:9494:b0:96a:30b5:cfb0 with SMTP id dm20-20020a170907949400b0096a30b5cfb0mr16826339ejc.22.1684945414459;
        Wed, 24 May 2023 09:23:34 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id p19-20020a170906229300b0096f5b48fe43sm5913793eja.47.2023.05.24.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:23:34 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 3/4] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Date:   Wed, 24 May 2023 18:23:28 +0200
Message-Id: <20230524162329.819770-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524162329.819770-1-robimarko@gmail.com>
References: <20230524162329.819770-1-robimarko@gmail.com>
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

