Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07EF712E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbjEZUs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjEZUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:48:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D2187;
        Fri, 26 May 2023 13:48:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso1011718a12.2;
        Fri, 26 May 2023 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685134089; x=1687726089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=mfzOVkfqB/p9o5a19CJ3Q8uzxdeWxlyk+I7RGvjW+fvlf/XKW4d65EwM22puPWmmyI
         IbN6lpXgm69WIY64/MYpJbOFTYSkGsQea+kqrixVrz0H/kPHzaASX/syIyrMY3DmVa0K
         G5VkuJPxCUILjR0VRNoscE47XIKSvnN3Musnrk1YTm8XPIb87iJVJS3sjIrnvtyRBuZn
         xxOdzNtUFjGORl/VEkk3QiuPa5xpmqJbX+ajyIFTm3Y2whC2D1agwgy0vWivEv+MwHdK
         EIA7dpQw/9umQfR3GSl3hqdtWaT7yugCszRapzqfJ7xtxkVjBEYDJflNTggX/zyQR4XB
         /qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134089; x=1687726089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=VsLfljJWSRTlOnZAW/668hd/os8q26+GtymSOudf8puDclXAS6VAbb4ZYP/JRsJBSB
         SJnkfEiDWweja1FTlfAeB55r8dB2v1yZ09CEhY9SWmEkjItY1IuR5WK0DRcD7l6bzhKJ
         ThYE+367FSF3owuMCWTObNyHQs3ouX5AH0ByI24evHIsplV1L/tJZv69z7eN8xxuFiuL
         BYPYoyYhXzl5ptIGO4diXnaVNBzMCI1key559VzlpZCuaur6nfoda2IOioGFk+irRAra
         waEc3jMpt1XyPMAwDxXtFX7sjdeXeDzfob5cHfxj3/y6EF+VgkjVODCBavFZd3gnMk1j
         gHnQ==
X-Gm-Message-State: AC+VfDyUqfs1YVTBlbYUq5eAqzpztfcEP1MCdgJ6vdMpyn/yiFGHrYlk
        cLDVnjTpkZiYSZ1iC0/tv1E=
X-Google-Smtp-Source: ACHHUZ6rwAbVvuSastJygwvVxbdtVLRvvy6CRx4rQ80ylwCVSk497cf8NbyG/QsqD+c+26HD5mM5OQ==
X-Received: by 2002:a17:907:3e0d:b0:96a:1f7c:3207 with SMTP id hp13-20020a1709073e0d00b0096a1f7c3207mr4480714ejc.19.1685134088729;
        Fri, 26 May 2023 13:48:08 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906160d00b0095342bfb701sm2604413ejd.16.2023.05.26.13.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:48:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 4/5] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Date:   Fri, 26 May 2023 22:48:01 +0200
Message-Id: <20230526204802.3081168-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526204802.3081168-1-robimarko@gmail.com>
References: <20230526204802.3081168-1-robimarko@gmail.com>
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

