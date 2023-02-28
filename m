Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715B46A5BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjB1PZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjB1PYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613B30EA7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f18so13728462lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2YOQCGUDR6LVZWl352w6X7jU8EvLQncBoIP/WOJkXQ=;
        b=DjaJv76Zk4rCmcRuGunlj0ep9NWS6zyfIYu7YtftiZRp9XSogaZWIrjwLSBkqKBrSY
         UwHRP4KC1Wuf8utc5VwOjbDOJXafiQoTunnMuCtvTfp1vuGGM6zIabUcVhJs+u+Vhh8e
         PxnsfrecdvR79S7DuFsFmBs6KTLFMBCTlh7bdm1FndrJVrOeloyLJmcl+Y8Njpx+ODJ+
         fLerzZeHBUFc+TSzuFQCj2QYEha4IX772QEUCsUIAA4pJ8DgxdkJM+Ba+lKyHEViKsdy
         X/cRjUTCqTEh38M0HFqE/d0BMmKTSum3srfh5G9FnuwDxm7Yr2Kr6ODogfYyW4+epu65
         72LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2YOQCGUDR6LVZWl352w6X7jU8EvLQncBoIP/WOJkXQ=;
        b=OA+cMRHBfqJW9TAQY896P42qR4CcDhU+R3laJegxklm1UqO006FHeOZwsbPbhKTOh0
         cd8HtqhGmCfbBKg1jHFEgDPWsLTjDv1oFkV7mD2oT3H7I9zgT2dHHT4uBDC33nrBWtZR
         Yqaq9Lz4j3aJmvO3p/Og/EstB+Aaav4CVnPnSlywiln00TH32M5ijMZIgsNTK/O0/+Ju
         qOILxF/1t4cKGWuDkWrH7UsZv6BIy0JOXnv3kKaxa/zN0Qx3v4XaAKrd8Xawe4j/kEZB
         XOhcNk6VkY4aRDxDFuGETIBpcrFGe4ElYu9BdwRhNlzs9OG2lQ+tVrNz1MDXoBNKzuKg
         6mVw==
X-Gm-Message-State: AO0yUKVQ93YZSfVqYnYnXFgEvcVIlY3gINTozue0eQgZ/cqktNcX4fra
        YNVjVWLzQGTOdDI4hYZCR6SRwA==
X-Google-Smtp-Source: AK7set/a1fp1jeDKrc0EDY1QxtskC/0PyKb2F5C8WAhtnjPc02nxuFJ7jF7xX9Obt2MUyfSZhNGAmg==
X-Received: by 2002:ac2:4c89:0:b0:4dc:84b3:bc5f with SMTP id d9-20020ac24c89000000b004dc84b3bc5fmr853961lfl.30.1677597890509;
        Tue, 28 Feb 2023 07:24:50 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:34 +0100
Subject: [PATCH 10/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_and_video_core_idle()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-10-58c2c88384e9@linaro.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=1023;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xcjWJ5FvVHrRZk+7AUmASQ5Umxw+WM1469ajK0AMX5Q=;
 b=NT8sLJ0hPyGLMNFmZj3Ojb+rbgBq3CUiqsTP0/kwI+y700b2+PK9Qo/SpgBYegJnTPFoDLaRNmKt
 DlKPUMFSCO6P/lFTSi9XBfd45L5VyOjnFiJkaKQKjLJc+m2GV0vn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index ecfbac36de20..584c84125887 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1543,7 +1543,7 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	if (IS_V6(hdev->core))
+	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
 		cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
 	else
 		cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);

-- 
2.39.2

