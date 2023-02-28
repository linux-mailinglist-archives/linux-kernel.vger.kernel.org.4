Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0526A5BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjB1PYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjB1PYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680F23DBC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f41so13645403lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXugSA6r2tV+X0iFO+lGhptFx82s88fjNq0jEwrsdR0=;
        b=RPRIrotIE+koozd7vn/zocKpX5RSWm/6VDAD2UGrFh0IctGRRyHRnEGh+sSpoDTvRW
         ksd+hq83BAcnNyvyyxR8mcsHaW5kTw/hPn4rRjxpwpe74lDJvyKE5XReeUYZE3shedp/
         FuNQw5+aYrryJlzGHXh+uUgxQvl2+MQpfSdpBNzfZX0nL3d6mwJI+J/Bd+gZUSVEUP2U
         VvrFr+johfkEaj7kJ0rmBFYyB+dj2egWh1mSU3QbsPC1ZMeft4JFzA/GQePiQc0GzxFP
         0mi71GPNpc+ULpMi7owlLwbtBaG3rHwr9lYsUy/dRKxNpoDIVSg7E42CWllIVB4d2OA8
         9BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXugSA6r2tV+X0iFO+lGhptFx82s88fjNq0jEwrsdR0=;
        b=z6WO7U3UARtlSGFTLQ9XctJBGi8/jlmUAL8ZypKb66svJ9HsEJkh27pKzhSNEdBHFt
         AfgIYArY1ia1jbYhHzPXmYJoLM2Wo0tHVeEMeHWLq9CsGUmTLmU/8FTmIk5F/M5EajD5
         /h40hZu9tdl9RRDjR9Vjm4xPIwz9vbqfltNd7o7WQn21oagNWurhCiKlvhMLj0e6s07m
         eA+9UpWNdO/TlIlmDqn626lBxqtScozr1lGbziH9n8iHNVppxjxr6aIa7H4knihz8kwu
         1ATYFeX6wjlfx8Jr2sJWDPdj1b4cbMUd+P8bAO1rP00QG5fBMkIzl/iNrVgL2bd5IJlw
         lzTA==
X-Gm-Message-State: AO0yUKVZqCacZofUFKJ81/fnDUL1WMvTvFb/uODo3qp5aN7Wy/qW555y
        W817wfsRstOicsQHuZD5ElAgVg==
X-Google-Smtp-Source: AK7set/ETuGKMpQpJ4OQLtd/G98Lx8jAQPHrQ5KgigYJm1favsWQ3qmU/avdWBaWD5bBi2H3RAmQxg==
X-Received: by 2002:ac2:5df8:0:b0:4df:998d:79d7 with SMTP id z24-20020ac25df8000000b004df998d79d7mr771300lfq.8.1677597875450;
        Tue, 28 Feb 2023 07:24:35 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 16:24:25 +0100
Subject: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=1210;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=l21Hj3clKvJ5WDgOnhsicYzRTtdql9epuJV12nTy5r8=;
 b=WE/7f4vV02g5I5rmyHXeuw4wZOzwD2LPxcq1Q+IVLDzZ+6E2EdCHTjVF6JVDiYpFBH2ghcDOvGJx
 1Bj0zUymCybQ0fyG7CTW50knq8ZpeeEk14URBba4rDbYpJ6L6gOl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This call does not seem to have been cast on any kernel with support
for VPU-1.0 or newer (and by extension, HFI6 and newer). Restrict it
to V4 only, as it seems to have been enabled by mistake and causes a
hang & reboot to EDL on at least one occasion with SM6115 / AR50L

Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 2ad40b3945b0..4ccf31147c2a 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -952,7 +952,7 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	 * enable it explicitly in order to make suspend functional by checking
 	 * WFI (wait-for-interrupt) bit.
 	 */
-	if (IS_V4(hdev->core) || IS_V6(hdev->core))
+	if (IS_V4(hdev->core))
 		venus_sys_idle_indicator = true;
 
 	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);

-- 
2.39.2

