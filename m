Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C997323BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbjFOXhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbjFOXhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:37:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C02953
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:37:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f845060481so1687525e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686872219; x=1689464219;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdJJ9+n9IRKzLwmspC95Y35DrYAR/DTBRoHRTZGhZyY=;
        b=avRMt4C2kPx7TE6eiY9u6yHoPok027p/AeOSqKP9Ru5H8PN5X1VGm2KxUvg0xp6ExH
         e1qPBkUf0psLZ+h/j4H2ZaZyxXuH+pBToTv64SrzTtZGNxOGXhAEULXcXCcGhgdpCqSV
         k1l41Fttq1Pi6Ffr766pG1DtIpX8tFw6C8wD2aiyaO7SSe3BiTovwL8gI0Vti10EOzgE
         PZkD2MpAcCqcYvI1F08z+k3PgAMWLDb+rR+01XKUZ4THqX+eAhbxzEPUAvnYu9xfc3SL
         j2nGictXtZwIj+9wnb+e+CErYrwq7StVzUTWTdVlZYgRL5ol1Vvx5KZ3IyAXZm9WP/n4
         5tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872219; x=1689464219;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdJJ9+n9IRKzLwmspC95Y35DrYAR/DTBRoHRTZGhZyY=;
        b=JVUkLwhfg99dGSSDfssgkXP5jqvMvN1uv/fcq4Mf55Sx+4Mu6/9idekiylfWNL6mlP
         8djfCz2UJYcv8nNP/ssrzlgwAZiWitfN+VLCHYcn7AsXGzhyTE0K0Lm4TcKXrYSdXpYw
         P/t3X7Q4EKzHR/7R9hstnmQPI0orrVUxNKEb9NaULJc7UfRtZEyubE+mx9S8+9vLx9DH
         XSa1B2nH8q20qTeNRQOFa9zFft31kHCqJVnuQGoD0V1BhyezEK6/WiXaUw0vHFa9dYso
         w+3uySa2d4AeswPbMRKPKBiKy9iF4fzgEf4DYKbyEHmR6b8CX4On+T/AFm5ehRgPZYf2
         iIuQ==
X-Gm-Message-State: AC+VfDw6J/HETV8sUSdzlurz6Aj9Ko4Pfj1GmSA2tV/wdMD+uNIknibV
        MOTP9eZvb4zHc9WyGlj+J3rQ7K+//m9BaLiqNYU=
X-Google-Smtp-Source: ACHHUZ7DYmN/QRx0U9s1ok/upaVNmStFp3pK98PKKkmgqb1rLau3RN/FYfCMY//aCov1R//URRFlXQ==
X-Received: by 2002:a05:6512:606:b0:4f4:c972:981f with SMTP id b6-20020a056512060600b004f4c972981fmr105872lfe.54.1686872219539;
        Thu, 15 Jun 2023 16:36:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id n25-20020ac24919000000b004f61ae50a7dsm2761423lfi.142.2023.06.15.16.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:36:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:36:58 +0200
Subject: [PATCH] media: venus: core: Set up secure memory ranges for SC7180
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-topic-sc7180_venus_lawp-v1-1-15a8f44d474e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJmgi2QC/x2N0QqDMAwAf0XyvELrsLr9yhgSY5yBUksznSD+u
 2WPd3DcAcpZWOFZHZB5E5UlFnC3CmjG+GEjY2GobX233nnzXZKQUWpdZ/uN46p9wF8yD99wM42
 uoxah1AMqmyFjpLn0cQ2hyJR5kv2/e73P8wJmoSC5fgAAAA==
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686872218; l=1142;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SnxJxghJqJ9uhVZbjXUcGSZM2YFGDcZxmB3hYFB3gWM=;
 b=Cnh6syjdwDe950DfMtQqhOHmyL3ekvZwsm5d4D8wPap9mVlerIdV7VwLXR1w8qfSpUyt2i+mI
 Mz5NghdVn0yBnML617bZrIskyRxnu7EO87p8CDPCe1PX/pnbSZsY3xf
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all SC7180 devices ship with ChromeOS firmware. WoA devices use
Android-like TZ, which uses PAS for image authentication. That requires
the predefined virtual address ranges to be passed via scm calls.
Define them to enable Venus on non-CrOS SC7180 devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 2ae867cb4c48..bee1b4c98060 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -760,6 +760,10 @@ static const struct venus_resources sc7180_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
+	.cp_start = 0,
+	.cp_size = 0x70800000,
+	.cp_nonpixel_start = 0x1000000,
+	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/venus-5.4/venus.mdt",
 };
 

---
base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
change-id: 20230616-topic-sc7180_venus_lawp-965e5fd18c7a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

