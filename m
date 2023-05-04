Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA73D6F66A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjEDICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEDIBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DF422B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso169784e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187303; x=1685779303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLzwYe07Ua0iWuXYI18glxIVscBHmMu8Vsc9c8pgxmk=;
        b=a6jNEwlsHRKGsAhlDZXWwcU+vptB3800vh4s8+quTBtjpEizpiW6LijeyHj+bV7d25
         2NUgE9AQUHf0rQ1Mn/oCX3APH7N4kKb1kW49gWBZDbb0pTIswXtl28DctQEiFgcTxAfT
         YQ5oN8SRWB8eRvT7QZQwKDYkOAk7l+CSqIPZATGxnfvbQVUrJOuokCrabmNHP1hPpjH/
         5G/AoqylBXbWyK0PT4v5iiYk78GA7to3cIdyUXb/Zyy8vq/iBVPQRDyVygZl6CYYm+TF
         VvKRwz5BvhVazI7aUNws2d9IsutyYyZ+iwnM+MUhrAdch6d6gezmeOPL6owlqzV63udD
         fomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187303; x=1685779303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLzwYe07Ua0iWuXYI18glxIVscBHmMu8Vsc9c8pgxmk=;
        b=U3zS7EfVm0b7BTnb/0IFdZNWbMha+fn9OOTCmsQgr0OyXy/spbw01TaLMaHZ3m8KMJ
         SjjddX1a7EZuGj8mylAbSWFOadoe8gvJrdAeFXq2UqQvucCCAnpNbZgDW2KQvrygHT8q
         TATcn+vRR1H9BLvkSBgWdnc8pAc0OsB+Och+moV0EjY/PHga3YhcoKEEAs2E30XhnJkH
         XvMVzk50y7t8zrnzfbmFsE+6IMOrMX41aOZM8ZBAm9ShoVekXNdnh30Di7pc26n+nkGt
         m4HegRp/YiEWO1WDhHoSicvNRtYZd2jaPaoYk8H43LVn16BNFoB5TI5SwNMkZTIbMzJt
         9Hwg==
X-Gm-Message-State: AC+VfDy/T5xr1AvtViI+7fp5Te6QFADuoktlqtDtKiLpR/1wzXLAYtER
        UqTOvZLOlJ1faAGQg8XQlZRIFg==
X-Google-Smtp-Source: ACHHUZ5gDgLDur7lUA0lukwvOxsFloKP3wPin8QpkMJCrjsxxefpJLvkwxERawO9zDOiItDFibz0lg==
X-Received: by 2002:a05:6512:11c7:b0:4d8:5238:ae97 with SMTP id h7-20020a05651211c700b004d85238ae97mr1344193lfr.36.1683187303588;
        Thu, 04 May 2023 01:01:43 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 04 May 2023 10:01:07 +0200
Subject: [PATCH v2 11/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_and_video_core_idle()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v2-11-d95d14949c79@linaro.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
In-Reply-To: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=1023;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1ifUdAT3ZHQBYgMADooIxCbatMIomtIxcid/wNFwLLU=;
 b=GbYkuKWaOiyIrl6/vhQgecr6tiCf5clf43NBvZwwmmoRPkt9ZJo3TBMGYRtoc+9FePflPoK4O
 gE5O2mywGyWDN5NflxKQVTVTSqskT0iw0eoy5PUHGSM+Jlk5WXOWAU/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_V6() should have instead checked for specific VPU versions. Fix it.

Fixes: e396e75fc254 ("media: venus: hfi: Read WRAPPER_TZ_CPU_STATUS_V6 on 6xx")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 6d5906fab800..82aa7deeafa1 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1537,7 +1537,7 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	if (IS_V6(hdev->core))
+	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
 	else
 		cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);

-- 
2.40.1

