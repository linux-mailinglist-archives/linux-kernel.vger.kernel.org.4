Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0235F715F98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjE3Mbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjE3MbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716BB18B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:30:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso4813191e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449840; x=1688041840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1axqNPjGLjogy6xSCaHfcBTXr5wHaN2QoDEVW2I44o=;
        b=nzb6gIvlQ4aKJ8Q3cB0kI7/hz8JZao8iRtKTTama0cj97b32ntEv9i+7wgaSKmTz1v
         gDYNNUz6HLfBSylcqBvsWwc3XRGt5k08YT/FNjJkQW8q6xUzZpdXsyTUH/i4RYvPukDE
         TDZ7/GekaQm7VIeuoF0aiJ29BDXgdCJKFyae1A2lvlj25WEWXU4P4PytjJIayM3MqFNZ
         ttZ66kkvI6u7kYOlm/jWn96IwBCJTueLsI1FnuPGf5ERxMjTiwgU6UFi8chZ1KLdvisa
         6aZN1S/X+PRT02U2cA1yHFYbbTPp45v7xY2WY2nmNPy6KzAFegv5P/jiUlbSsAkgq9FD
         4Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449840; x=1688041840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1axqNPjGLjogy6xSCaHfcBTXr5wHaN2QoDEVW2I44o=;
        b=TLAA2b22dL0AAzaDW904GYYOLF2zkOunPu8piJ1OK0cz39vZSCk1KgeIYATqQKSauM
         R4gaRJuZ8DjveXxsBzIk3vVROGipASOB/ia9Yyym4Iahs4Hde64rN3+KUippnqXDkikd
         Ht54hSY41nhfseLKvUX3CnOJBpTnVTRLIfgh7FUVgzHyijT1vksVyS0ruhhboEIxpw8A
         vE+X+9Ns9jLFj/3TpF3jVh4B6oxD7bM3tR795KtFSAWwWGj0RHZbF+VDI8j3QZk3Pg3Q
         6BcRDNcSeQqUQvdeMovRxjnlcmleDFJQ9CLUk2FWsOSVYBmnAG76IyAktXSec7D+p8Td
         XmIg==
X-Gm-Message-State: AC+VfDzDyvZsvtq0GiNW8T6FkKpJltvDxMachcQJu9iaabIki+vH3WTQ
        Ln+sB5u9X9LpmUeF7oWnDMvDeA==
X-Google-Smtp-Source: ACHHUZ5vtGFblc7ILzF1jK+As2eSp0Dzr3xY7FvxZ6IFxNnLtJ4Rhd8eZ8lqoxA+YrXxLIyFjtFPxA==
X-Received: by 2002:a2e:8ed4:0:b0:299:a7be:5775 with SMTP id e20-20020a2e8ed4000000b00299a7be5775mr668729ljl.35.1685449840144;
        Tue, 30 May 2023 05:30:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:35 +0200
Subject: [PATCH v4 01/17] media: venus: hfi_venus: Only consider
 sys_idle_indicator on V1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-1-feebb2f6e9b8@linaro.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
In-Reply-To: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=2458;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hvIZqkG858oUVv/9/D5T6FwxTNGe5nTsI4JSBUSHEXc=;
 b=gfFwBEKZNcaX0ECRSIpun8YMTAzBblotZ3BrrfkwhTF+DA138t16RryJYsEWkJB9+E/daHJMt
 SKZSXL/fEwJB4y/FR3FJyyUPy1hwBfaX8GqJaK35num6vah4gXomdFX
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

As per information from Qualcomm [1], this property is not really
supported beyond msm8916 (HFI V1) and some newer HFI versions really
dislike receiving it, going as far as crashing the device.

Only consider toggling it (via the module option) on HFIV1.
While at it, get rid of the global static variable (which defaulted
to zero) which was never explicitly assigned to for V1.

Note: [1] is a reply to the actual message in question, as lore did not
properly receive some of the emails..

[1] https://lore.kernel.org/lkml/955cd520-3881-0c22-d818-13fe9a47e124@linaro.org/
Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f0b46389e8d5..918a283bd890 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -131,7 +131,6 @@ struct venus_hfi_device {
 
 static bool venus_pkt_debug;
 int venus_fw_debug = HFI_DEBUG_MSG_ERROR | HFI_DEBUG_MSG_FATAL;
-static bool venus_sys_idle_indicator;
 static bool venus_fw_low_power_mode = true;
 static int venus_hw_rsp_timeout = 1000;
 static bool venus_fw_coverage;
@@ -927,17 +926,12 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
-	/*
-	 * Idle indicator is disabled by default on some 4xx firmware versions,
-	 * enable it explicitly in order to make suspend functional by checking
-	 * WFI (wait-for-interrupt) bit.
-	 */
-	if (IS_V4(hdev->core) || IS_V6(hdev->core))
-		venus_sys_idle_indicator = true;
-
-	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
-	if (ret)
-		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
+	/* HFI_PROPERTY_SYS_IDLE_INDICATOR is not supported beyond 8916 (HFI V1) */
+	if (IS_V1(hdev->core)) {
+		ret = venus_sys_set_idle_message(hdev, false);
+		if (ret)
+			dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
+	}
 
 	ret = venus_sys_set_power_control(hdev, venus_fw_low_power_mode);
 	if (ret)

-- 
2.40.1

