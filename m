Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECB715FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjE3McV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjE3Mbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A7C11C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso6782860e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449853; x=1688041853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuNT9Cruhplaf5M27x4h0WElwFVfgK7TB9z7U29d9j0=;
        b=ZSD/s6U/hvVdc5LUHI9NZ7bNxid4H+oOgpkQ+CQsqoYdvS5cHRSsdsqOGcZDPWZc2U
         5bDU86pAFGD28wDDe3ivik9ncECfrBVhGl0/jUBJLoI7FYIBKVZzBRjuH2QJVwGc0Aqe
         qU2a4SfRWbVO48pRWDqj6ZVnyXWefwOEksKRR+/1Iseh45s79x5k/gpqHdY2IESnJ7j7
         SGJN1vAWlLnBL+lYQ+q5FOfLm1ij1XV3BH4CZqGyxPOxo76UKbaUti1QUuVWXbDRgPUU
         uU8Dw8PLPgeIXGnmgzac2UZ7y4W1RVAj7g/62xpN2s5dp0NNzScwF656OAZ2OFv0auaG
         ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449853; x=1688041853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuNT9Cruhplaf5M27x4h0WElwFVfgK7TB9z7U29d9j0=;
        b=Q593zYH1bcso9BOQ00FdLm2CBKhBEWrktCXeLOoLC55UiR6eE+5B+CwPWR0YII96Qp
         zT+ELdvkICigthq8gxCaQo3aOYW5VHETLLEozARmO8OfPTmJU5QQFHhw32rx1dCLveOg
         GIPT/FTI/VGmgt512LzTMDq1L3swYIOz+J7DveHT37lrIen5w2CuIBxCDX9M1RtP5Ws9
         rXGVn8FH3lJ3FHi1s6QRg24Cl/Exs4DzgpKVsltJrSwF+aWgbF4Kj07iOwsMC7MR1kiL
         KHBvCoovSgd695KB5HAAYRdPcfvxqtN7/hZEOaHo4ace2V+kwXpzg5EtAWhJtKA1Po9z
         5MCg==
X-Gm-Message-State: AC+VfDwjmf46lyHUeqH4uZXmnDpXeLJNAykilMs//zVbzN3XdWX6N+Pq
        xQSltPSlvsWkPDJkqsfZGsFXdA==
X-Google-Smtp-Source: ACHHUZ43dfbnBCfl/ZdEAlewRPkC4kG5mka1e3GDE4iqfXWY4n4nzEGS+FyENrk0DVUwdUYfHDqfUw==
X-Received: by 2002:a05:651c:32c:b0:2af:2965:8f78 with SMTP id b12-20020a05651c032c00b002af29658f78mr3477894ljp.12.1685449853629;
        Tue, 30 May 2023 05:30:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:44 +0200
Subject: [PATCH v4 10/17] media: venus: hfi_venus: Sanitize
 venus_cpu_and_video_core_idle() per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-10-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=915;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rs7GlV5yuEvpX7uzQTE/PpuhYQ091SJv7fj57bpy7Ik=;
 b=5vCoXTz9cnFhoxI98HGqjp6z1qPYbBiZjNhWqTzvtukFvbllkKQ8MaUBoafM4wRPQKdBoCR+i
 W5DZnz3kWcoDVaQiJgHysPReShHQxloTA7GwTU7cHFnyBNtzaHTjLBa
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the general IS_V6 checks with more specific VPU version checks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 5e4b97b0a4ae..b5d7aab03bca 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1516,7 +1516,7 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	if (IS_V6(hdev->core))
+	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
 	else
 		cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);

-- 
2.40.1

