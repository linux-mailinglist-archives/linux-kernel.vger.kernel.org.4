Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906D6715FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjE3McI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjE3Mbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1FBE42
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af30a12e84so46128741fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449850; x=1688041850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txi3v40xeq1skICXUdS8mQdkH8Gx8cp0BEFL2/OQ3wI=;
        b=a4GmkCT4FYKvoO1zaqw+4yWcxhEgBiClLH8HcvBwpREQ5avFR9IIYRArPe7tZhG5gE
         Ub25UHyTPR9LXH4cEDutwUYkwZBVSdy0f/e8w9uArEE2fVfYWOeLlQRD+JI1wSh3PXYt
         F9VYjSjKypFzWMNwbIZn7zZhkDSFCJfTGyRpd1Jd0KzF1QHYXBShmW4myLELyn9zVi2e
         b5bktQubb4FMN8SJ+oKpJ0trNhjxlpFf26CMBUg9vHf3owTyd9bd02+8OiX1InGkwS2Z
         uxE8UZEO5cRrIn5IeP3sdinQi4q4QzWDvhn6pOrCO72CFNsQcd7gp27nvF9wU2sIOtq+
         6a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449850; x=1688041850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txi3v40xeq1skICXUdS8mQdkH8Gx8cp0BEFL2/OQ3wI=;
        b=GEnLTFShfUt4Vgz4Iu7gN2qxAvkJkyYoAvDdASCxR8WY0vkNvp83RhRz8T8Pa/d+Dl
         kJ4ClF4b1LxsCqDUNOhpcYahr+49dmAS1Y9BC6TlUyUba80N+Wwhz+Bg1WdlhhzG+2ST
         DucehszmzDzqrXgmYXu7y+RAPOy5w51eus9iW5Jrti5KMNvMMp51XnXOVHGsb+82s8te
         WjVosf+hZ95eqJ62dHJb61p5nnR/vgjtwkhCpHIhaePVPS1GZfBbJo/SiJgYKfTLFph/
         lmWd8hIvJTa2gGpETaDLYhJmHZH7D9yLNlmuLgDIKsTvp3l/6r3SBvordk/K6q0owAru
         w19Q==
X-Gm-Message-State: AC+VfDwAHCY3gjmdysfF+gCk/9YmvSqp/l8Tcgos2UrrvZDugVf3OF2o
        lWTHxFTCOGuc4xDg+vtfPds+tg==
X-Google-Smtp-Source: ACHHUZ4ZaNTNJE75kVSt7ogTnm6YJPqnBOB9g0/YkhP8sbksz9DKJrt9ebpFWC5DuQP2BAncZjmJgQ==
X-Received: by 2002:a2e:9884:0:b0:2ad:81ca:a52f with SMTP id b4-20020a2e9884000000b002ad81caa52fmr727410ljj.47.1685449850275;
        Tue, 30 May 2023 05:30:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:42 +0200
Subject: [PATCH v4 08/17] media: venus: hfi_venus: Sanitize
 venus_halt_axi() per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-8-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=1056;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CwRrKkc56gP78vWbwj31mgvh7BvEJbPxU0vhFKBwos8=;
 b=1VSC8LRy2Yd6gP8VcoQDaPeCC2ljSd5bhpTsKRED/3emZGSDqHWLGNiYO0Q17KO7iqKjeNsj/
 7CTpQpJKX3mDK80Z4kDPVuxdJt0M9+EP412kVhMcl+BwaI4W89RjpMe
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

Only IRIS2(_1) should enter the until-now-IS_V6() path and IRIS2_1
can be used instead of openly checking the number of VPP pipes.

Use VPU version comparison in both of these cases instead.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 9e36ef9076a0..60252d05781e 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -548,10 +548,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
 	u32 mask_val;
 	int ret;
 
-	if (IS_V6(hdev->core)) {
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
 		writel(0x3, cpu_cs_base + CPU_CS_X2RPMH_V6);
 
-		if (hdev->core->res->num_vpp_pipes == 1)
+		if (IS_IRIS2_1(hdev->core))
 			goto skip_aon_mvp_noc;
 
 		writel(0x1, aon_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);

-- 
2.40.1

