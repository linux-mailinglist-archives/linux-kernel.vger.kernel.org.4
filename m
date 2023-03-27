Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555846CAEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjC0Ti4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjC0Tir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:38:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE1330C4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so40650674edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679945923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m856MF7/K8cmlkjTZnYkKWIuqNSc8qvv8L1aH+g2FYU=;
        b=jSMHL1o+sEz/8UCrR0JpZuVM3abUO5F4TCgm6EHB5G/f0ljDCjLdYO5aAJei1xbjuq
         FrzaT0G0no5peyc9FQdI8M3U7UoVwPVkewYcIQd+99KXMnUxEvzoTmUJ/m0BXW647X1P
         DUH817nCOHi46L6xIRqqfCprAEUE3gQmkvJa/4SU8lU3PFgH0p/7rpLR4rEuWlP7tJbd
         LxAGaSy0ZhyMZZQHr2Y2l69XbwCCa3Hz959XUALSFFdP9xvHdmRbzbwk1kvYDgSZM/pV
         ebVwa8hCjvbHj6cYC8yq4Oflmdj7TIUeQ1xiKwFd3fm8vglMelxSJXS8aCkHP35vdrFe
         xxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m856MF7/K8cmlkjTZnYkKWIuqNSc8qvv8L1aH+g2FYU=;
        b=va+K9ND7IKf3djBtMjwrybU4XbPk6IwhfC0E6gSINArRk8jfwOEfgo0ECfBu/TtuU8
         TxB5XcXoqJkHJN1ZYLS0sHGjJBtTAoM4b3/cX26XZfzqvvzIUCEPlK+MeW94cQX2px2J
         /j7082dm0LOpWGLu/t7vxSAL8FAZc/vlnsG4w0AlAGANIUg63joaKqAMbc2S6XfZV4UY
         TijR5UsiFbAm7sr/14LgCnJj390QXGbFVTJx9Kw4TtKVBe0ee4MfPZt+OekccQ5rUjC7
         i3uPFPlG+8TAYhWbOHQ2bQKu+4JqLbLeKo8arRV6GIHhyrbILJOjAUqPq9UFEnQyjL3/
         vw4g==
X-Gm-Message-State: AAQBX9fp+5PmEnz24j0hmXRl/diiVayVa2zmTmV29et5tyd1u3Mh9ZWq
        1Ew5l32G/Bh+BHH6Aorf4cT+iQ==
X-Google-Smtp-Source: AKy350b6KvNLgtmif+8h85vL/f3a96hcMSDEr+sVEL3+PRHWCK8YWN7hy1+VbEGbFsbiRQHO0QVBWA==
X-Received: by 2002:a17:907:174f:b0:7e0:eed0:8beb with SMTP id lf15-20020a170907174f00b007e0eed08bebmr13297221ejc.41.1679945923236;
        Mon, 27 Mar 2023 12:38:43 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm11701254ejc.100.2023.03.27.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:38:42 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 4/4] clk: qcom: Add sync state callback to all providers
Date:   Mon, 27 Mar 2023 22:38:29 +0300
Message-Id: <20230327193829.3756640-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327193829.3756640-1-abel.vesa@linaro.org>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have support for sync state delayed disabling of unused
power domains and a provided generic qcom_cc sync state callback,
add it to all the providers for all platforms that actually registers
GDSCs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/apss-ipq6018.c        | 1 +
 drivers/clk/qcom/camcc-sc7180.c        | 1 +
 drivers/clk/qcom/camcc-sc7280.c        | 1 +
 drivers/clk/qcom/camcc-sdm845.c        | 1 +
 drivers/clk/qcom/camcc-sm6350.c        | 1 +
 drivers/clk/qcom/camcc-sm8250.c        | 1 +
 drivers/clk/qcom/camcc-sm8450.c        | 1 +
 drivers/clk/qcom/dispcc-qcm2290.c      | 1 +
 drivers/clk/qcom/dispcc-sc7180.c       | 1 +
 drivers/clk/qcom/dispcc-sc7280.c       | 1 +
 drivers/clk/qcom/dispcc-sc8280xp.c     | 1 +
 drivers/clk/qcom/dispcc-sdm845.c       | 1 +
 drivers/clk/qcom/dispcc-sm6115.c       | 1 +
 drivers/clk/qcom/dispcc-sm6125.c       | 1 +
 drivers/clk/qcom/dispcc-sm6350.c       | 1 +
 drivers/clk/qcom/dispcc-sm6375.c       | 1 +
 drivers/clk/qcom/dispcc-sm8250.c       | 1 +
 drivers/clk/qcom/dispcc-sm8450.c       | 1 +
 drivers/clk/qcom/dispcc-sm8550.c       | 1 +
 drivers/clk/qcom/gcc-apq8084.c         | 1 +
 drivers/clk/qcom/gcc-ipq806x.c         | 1 +
 drivers/clk/qcom/gcc-ipq8074.c         | 1 +
 drivers/clk/qcom/gcc-mdm9615.c         | 1 +
 drivers/clk/qcom/gcc-msm8660.c         | 1 +
 drivers/clk/qcom/gcc-msm8909.c         | 1 +
 drivers/clk/qcom/gcc-msm8916.c         | 1 +
 drivers/clk/qcom/gcc-msm8939.c         | 1 +
 drivers/clk/qcom/gcc-msm8953.c         | 1 +
 drivers/clk/qcom/gcc-msm8960.c         | 1 +
 drivers/clk/qcom/gcc-msm8974.c         | 1 +
 drivers/clk/qcom/gcc-msm8976.c         | 1 +
 drivers/clk/qcom/gcc-msm8994.c         | 1 +
 drivers/clk/qcom/gcc-msm8996.c         | 1 +
 drivers/clk/qcom/gcc-msm8998.c         | 1 +
 drivers/clk/qcom/gcc-qcm2290.c         | 1 +
 drivers/clk/qcom/gcc-qcs404.c          | 1 +
 drivers/clk/qcom/gcc-qdu1000.c         | 1 +
 drivers/clk/qcom/gcc-sa8775p.c         | 1 +
 drivers/clk/qcom/gcc-sc7180.c          | 1 +
 drivers/clk/qcom/gcc-sc7280.c          | 1 +
 drivers/clk/qcom/gcc-sc8180x.c         | 1 +
 drivers/clk/qcom/gcc-sc8280xp.c        | 1 +
 drivers/clk/qcom/gcc-sdm660.c          | 1 +
 drivers/clk/qcom/gcc-sdm845.c          | 1 +
 drivers/clk/qcom/gcc-sdx55.c           | 1 +
 drivers/clk/qcom/gcc-sdx65.c           | 1 +
 drivers/clk/qcom/gcc-sm6115.c          | 1 +
 drivers/clk/qcom/gcc-sm6125.c          | 1 +
 drivers/clk/qcom/gcc-sm6350.c          | 1 +
 drivers/clk/qcom/gcc-sm6375.c          | 1 +
 drivers/clk/qcom/gcc-sm7150.c          | 1 +
 drivers/clk/qcom/gcc-sm8150.c          | 1 +
 drivers/clk/qcom/gcc-sm8250.c          | 1 +
 drivers/clk/qcom/gcc-sm8350.c          | 1 +
 drivers/clk/qcom/gcc-sm8450.c          | 1 +
 drivers/clk/qcom/gcc-sm8550.c          | 1 +
 drivers/clk/qcom/gpucc-msm8998.c       | 1 +
 drivers/clk/qcom/gpucc-sc7180.c        | 1 +
 drivers/clk/qcom/gpucc-sc7280.c        | 1 +
 drivers/clk/qcom/gpucc-sc8280xp.c      | 1 +
 drivers/clk/qcom/gpucc-sdm660.c        | 1 +
 drivers/clk/qcom/gpucc-sdm845.c        | 1 +
 drivers/clk/qcom/gpucc-sm6115.c        | 1 +
 drivers/clk/qcom/gpucc-sm6125.c        | 1 +
 drivers/clk/qcom/gpucc-sm6350.c        | 1 +
 drivers/clk/qcom/gpucc-sm6375.c        | 1 +
 drivers/clk/qcom/gpucc-sm8150.c        | 1 +
 drivers/clk/qcom/gpucc-sm8250.c        | 1 +
 drivers/clk/qcom/gpucc-sm8350.c        | 1 +
 drivers/clk/qcom/lcc-ipq806x.c         | 1 +
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 1 +
 drivers/clk/qcom/lpasscc-sc7280.c      | 1 +
 drivers/clk/qcom/lpasscorecc-sc7180.c  | 2 ++
 drivers/clk/qcom/lpasscorecc-sc7280.c  | 2 ++
 drivers/clk/qcom/mmcc-apq8084.c        | 1 +
 drivers/clk/qcom/mmcc-msm8974.c        | 1 +
 drivers/clk/qcom/mmcc-msm8994.c        | 1 +
 drivers/clk/qcom/mmcc-msm8996.c        | 1 +
 drivers/clk/qcom/mmcc-msm8998.c        | 1 +
 drivers/clk/qcom/mmcc-sdm660.c         | 1 +
 drivers/clk/qcom/videocc-sc7180.c      | 1 +
 drivers/clk/qcom/videocc-sc7280.c      | 1 +
 drivers/clk/qcom/videocc-sdm845.c      | 1 +
 drivers/clk/qcom/videocc-sm8150.c      | 1 +
 drivers/clk/qcom/videocc-sm8250.c      | 1 +
 85 files changed, 87 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index f2f502e2d5a4..bf450c82bcb3 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -96,6 +96,7 @@ static struct platform_driver apss_ipq6018_driver = {
 	.probe = apss_ipq6018_probe,
 	.driver = {
 		.name   = "qcom,apss-ipq6018-clk",
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index e2b4804695f3..fe3e4590aaa3 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1695,6 +1695,7 @@ static struct platform_driver cam_cc_sc7180_driver = {
 		.name = "cam_cc-sc7180",
 		.of_match_table = cam_cc_sc7180_match_table,
 		.pm = &cam_cc_pm_ops,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/camcc-sc7280.c b/drivers/clk/qcom/camcc-sc7280.c
index 4396fddba7a6..798adaf5ad39 100644
--- a/drivers/clk/qcom/camcc-sc7280.c
+++ b/drivers/clk/qcom/camcc-sc7280.c
@@ -2465,6 +2465,7 @@ static struct platform_driver cam_cc_sc7280_driver = {
 	.driver = {
 		.name = "cam_cc-sc7280",
 		.of_match_table = cam_cc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm845.c
index 27d44188a7ab..98cae0e24afc 100644
--- a/drivers/clk/qcom/camcc-sdm845.c
+++ b/drivers/clk/qcom/camcc-sdm845.c
@@ -1743,6 +1743,7 @@ static struct platform_driver cam_cc_sdm845_driver = {
 	.driver	= {
 		.name = "sdm845-camcc",
 		.of_match_table = cam_cc_sdm845_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index acba9f99d960..2536a1f94335 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -1887,6 +1887,7 @@ static struct platform_driver camcc_sm6350_driver = {
 	.driver = {
 		.name = "sm6350-camcc",
 		.of_match_table = camcc_sm6350_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/camcc-sm8250.c b/drivers/clk/qcom/camcc-sm8250.c
index 9b32c56a5bc5..6bc32e5441c0 100644
--- a/drivers/clk/qcom/camcc-sm8250.c
+++ b/drivers/clk/qcom/camcc-sm8250.c
@@ -2441,6 +2441,7 @@ static struct platform_driver cam_cc_sm8250_driver = {
 	.driver = {
 		.name = "cam_cc-sm8250",
 		.of_match_table = cam_cc_sm8250_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
index 51338a2884d2..b2c6109c7eba 100644
--- a/drivers/clk/qcom/camcc-sm8450.c
+++ b/drivers/clk/qcom/camcc-sm8450.c
@@ -2847,6 +2847,7 @@ static struct platform_driver cam_cc_sm8450_driver = {
 	.driver = {
 		.name = "camcc-sm8450",
 		.of_match_table = cam_cc_sm8450_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 2ebd9a02b895..bb35f79ce245 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -530,6 +530,7 @@ static struct platform_driver disp_cc_qcm2290_driver = {
 	.driver = {
 		.name = "dispcc-qcm2290",
 		.of_match_table = disp_cc_qcm2290_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 9536bfc72a43..118379921410 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -721,6 +721,7 @@ static struct platform_driver disp_cc_sc7180_driver = {
 	.driver = {
 		.name = "sc7180-dispcc",
 		.of_match_table = disp_cc_sc7180_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index ad596d567f6a..374fcaf52514 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -892,6 +892,7 @@ static struct platform_driver disp_cc_sc7280_driver = {
 	.driver = {
 		.name = "disp_cc-sc7280",
 		.of_match_table = disp_cc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 167470beb369..a64c396b9cc4 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3199,6 +3199,7 @@ static struct platform_driver disp_cc_sc8280xp_driver = {
 	.driver = {
 		.name = "disp_cc-sc8280xp",
 		.of_match_table = disp_cc_sc8280xp_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc379..9415a832d137 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -869,6 +869,7 @@ static struct platform_driver disp_cc_sdm845_driver = {
 	.driver		= {
 		.name	= "disp_cc-sdm845",
 		.of_match_table = disp_cc_sdm845_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
index 1937edf23f21..28699f7f4692 100644
--- a/drivers/clk/qcom/dispcc-sm6115.c
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -600,6 +600,7 @@ static struct platform_driver disp_cc_sm6115_driver = {
 	.driver = {
 		.name = "dispcc-sm6115",
 		.of_match_table = disp_cc_sm6115_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm6125.c b/drivers/clk/qcom/dispcc-sm6125.c
index 87b27053ddb6..f607d1f60c05 100644
--- a/drivers/clk/qcom/dispcc-sm6125.c
+++ b/drivers/clk/qcom/dispcc-sm6125.c
@@ -690,6 +690,7 @@ static struct platform_driver disp_cc_sm6125_driver = {
 	.driver = {
 		.name = "disp_cc-sm6125",
 		.of_match_table = disp_cc_sm6125_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index ea6f54ed846e..2a791b614dbb 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -778,6 +778,7 @@ static struct platform_driver disp_cc_sm6350_driver = {
 	.driver = {
 		.name = "disp_cc-sm6350",
 		.of_match_table = disp_cc_sm6350_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm6375.c b/drivers/clk/qcom/dispcc-sm6375.c
index caa1b90a5ff2..963b1c0f9c2b 100644
--- a/drivers/clk/qcom/dispcc-sm6375.c
+++ b/drivers/clk/qcom/dispcc-sm6375.c
@@ -591,6 +591,7 @@ static struct platform_driver disp_cc_sm6375_driver = {
 	.driver = {
 		.name = "disp_cc-sm6375",
 		.of_match_table = disp_cc_sm6375_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..6556404141af 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1380,6 +1380,7 @@ static struct platform_driver disp_cc_sm8250_driver = {
 	.driver = {
 		.name = "disp_cc-sm8250",
 		.of_match_table = disp_cc_sm8250_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index adbfd30bfc96..0ea719940a8e 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1803,6 +1803,7 @@ static struct platform_driver disp_cc_sm8450_driver = {
 	.driver = {
 		.name = "disp_cc-sm8450",
 		.of_match_table = disp_cc_sm8450_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1e5a11081860..60251884f655 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1788,6 +1788,7 @@ static struct platform_driver disp_cc_sm8550_driver = {
 	.driver = {
 		.name = "disp_cc-sm8550",
 		.of_match_table = disp_cc_sm8550_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index 7085d2ccae49..e89c2fd5ed2b 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -3642,6 +3642,7 @@ static struct platform_driver gcc_apq8084_driver = {
 	.driver		= {
 		.name	= "gcc-apq8084",
 		.of_match_table = gcc_apq8084_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 6447f3e81b55..53c14e476521 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3428,6 +3428,7 @@ static struct platform_driver gcc_ipq806x_driver = {
 	.driver		= {
 		.name	= "gcc-ipq806x",
 		.of_match_table = gcc_ipq806x_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 6541d98c0348..f2b08ab865cb 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4741,6 +4741,7 @@ static struct platform_driver gcc_ipq8074_driver = {
 	.driver = {
 		.name   = "qcom,gcc-ipq8074",
 		.of_match_table = gcc_ipq8074_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index 8bed02a748ab..5cdaac200378 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -1720,6 +1720,7 @@ static struct platform_driver gcc_mdm9615_driver = {
 	.driver		= {
 		.name	= "gcc-mdm9615",
 		.of_match_table = gcc_mdm9615_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
index a9eb6a9ac445..e5ff66cee197 100644
--- a/drivers/clk/qcom/gcc-msm8660.c
+++ b/drivers/clk/qcom/gcc-msm8660.c
@@ -2775,6 +2775,7 @@ static struct platform_driver gcc_msm8660_driver = {
 	.driver		= {
 		.name	= "gcc-msm8660",
 		.of_match_table = gcc_msm8660_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8909.c b/drivers/clk/qcom/gcc-msm8909.c
index 2a00b11ce2cd..bde4992e0a7d 100644
--- a/drivers/clk/qcom/gcc-msm8909.c
+++ b/drivers/clk/qcom/gcc-msm8909.c
@@ -2711,6 +2711,7 @@ static struct platform_driver gcc_msm8909_driver = {
 	.driver		= {
 		.name	= "gcc-msm8909",
 		.of_match_table = gcc_msm8909_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index 0c8fe19387a7..0fa2232f6f6b 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -3448,6 +3448,7 @@ static struct platform_driver gcc_msm8916_driver = {
 	.driver		= {
 		.name	= "gcc-msm8916",
 		.of_match_table = gcc_msm8916_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index 7f8969a77974..ce1ea997b5ff 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -4013,6 +4013,7 @@ static struct platform_driver gcc_msm8939_driver = {
 	.driver		= {
 		.name	= "gcc-msm8939",
 		.of_match_table = gcc_msm8939_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 8aafa6591e84..313e279af413 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -4230,6 +4230,7 @@ static struct platform_driver gcc_msm8953_driver = {
 	.driver = {
 		.name = "gcc-msm8953",
 		.of_match_table = gcc_msm8953_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index dbc7093ab9cc..07dc9ab735bd 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3768,6 +3768,7 @@ static struct platform_driver gcc_msm8960_driver = {
 	.driver		= {
 		.name	= "gcc-msm8960",
 		.of_match_table = gcc_msm8960_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index 0231c1efd286..93e81deafdee 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -2904,6 +2904,7 @@ static struct platform_driver gcc_msm8974_driver = {
 	.driver		= {
 		.name	= "gcc-msm8974",
 		.of_match_table = gcc_msm8974_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8976.c b/drivers/clk/qcom/gcc-msm8976.c
index 8beb923c0e19..665f5165b066 100644
--- a/drivers/clk/qcom/gcc-msm8976.c
+++ b/drivers/clk/qcom/gcc-msm8976.c
@@ -4137,6 +4137,7 @@ static struct platform_driver gcc_msm8976_driver = {
 	.driver = {
 		.name = "qcom,gcc-msm8976",
 		.of_match_table = gcc_msm8976_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 0f52c48e89d8..09cda139a416 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -2712,6 +2712,7 @@ static struct platform_driver gcc_msm8994_driver = {
 	.driver		= {
 		.name	= "gcc-msm8994",
 		.of_match_table = gcc_msm8994_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 5e44d1bcca9e..7386026b08c1 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -3856,6 +3856,7 @@ static struct platform_driver gcc_msm8996_driver = {
 	.driver		= {
 		.name	= "gcc-msm8996",
 		.of_match_table = gcc_msm8996_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index be024f8093c5..bf9ecda86946 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -3249,6 +3249,7 @@ static struct platform_driver gcc_msm8998_driver = {
 	.driver		= {
 		.name	= "gcc-msm8998",
 		.of_match_table = gcc_msm8998_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 096deff2ba25..5dcd4db13b69 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -3002,6 +3002,7 @@ static struct platform_driver gcc_qcm2290_driver = {
 	.driver = {
 		.name = "gcc-qcm2290",
 		.of_match_table = gcc_qcm2290_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index a39c4990b29d..640ee59ca1b5 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2832,6 +2832,7 @@ static struct platform_driver gcc_qcs404_driver = {
 	.driver = {
 		.name = "gcc-qcs404",
 		.of_match_table = gcc_qcs404_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index 5051769ad90c..bea26044df30 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -2634,6 +2634,7 @@ static struct platform_driver gcc_qdu1000_driver = {
 	.driver = {
 		.name = "gcc-qdu1000",
 		.of_match_table = gcc_qdu1000_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index bb94ff367abd..ff101e1f0163 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4766,6 +4766,7 @@ static struct platform_driver gcc_sa8775p_driver = {
 	.driver = {
 		.name = "sa8775p-gcc",
 		.of_match_table = gcc_sa8775p_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index cef3c77564cf..7f36d7017e14 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2469,6 +2469,7 @@ static struct platform_driver gcc_sc7180_driver = {
 	.driver = {
 		.name = "gcc-sc7180",
 		.of_match_table = gcc_sc7180_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 1dc804154031..c6e10e174811 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3480,6 +3480,7 @@ static struct platform_driver gcc_sc7280_driver = {
 	.driver = {
 		.name = "gcc-sc7280",
 		.of_match_table = gcc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index c41b9f010585..61bcc73e2703 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4610,6 +4610,7 @@ static struct platform_driver gcc_sc8180x_driver = {
 	.driver		= {
 		.name	= "gcc-sc8180x",
 		.of_match_table = gcc_sc8180x_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index b3198784e1c3..64d828ba07da 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7441,6 +7441,7 @@ static struct platform_driver gcc_sc8280xp_driver = {
 	.driver = {
 		.name = "gcc-sc8280xp",
 		.of_match_table = gcc_sc8280xp_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index db918c92a522..a2839e893cb1 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -2485,6 +2485,7 @@ static struct platform_driver gcc_sdm660_driver = {
 	.driver		= {
 		.name	= "gcc-sdm660",
 		.of_match_table = gcc_sdm660_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 6af08e0ca847..2142e0c21d03 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -4020,6 +4020,7 @@ static struct platform_driver gcc_sdm845_driver = {
 	.driver		= {
 		.name	= "gcc-sdm845",
 		.of_match_table = gcc_sdm845_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sdx55.c b/drivers/clk/qcom/gcc-sdx55.c
index d5e17122698c..4aa29c08459c 100644
--- a/drivers/clk/qcom/gcc-sdx55.c
+++ b/drivers/clk/qcom/gcc-sdx55.c
@@ -1628,6 +1628,7 @@ static struct platform_driver gcc_sdx55_driver = {
 	.driver = {
 		.name = "gcc-sdx55",
 		.of_match_table = gcc_sdx55_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
index b0c17043551d..50530f61225a 100644
--- a/drivers/clk/qcom/gcc-sdx65.c
+++ b/drivers/clk/qcom/gcc-sdx65.c
@@ -1591,6 +1591,7 @@ static struct platform_driver gcc_sdx65_driver = {
 	.driver = {
 		.name = "gcc-sdx65",
 		.of_match_table = gcc_sdx65_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 5b8222fea2f7..f6b9d560ec40 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -3512,6 +3512,7 @@ static struct platform_driver gcc_sm6115_driver = {
 	.driver = {
 		.name = "gcc-sm6115",
 		.of_match_table = gcc_sm6115_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
index 40ad062d1bf7..1825deb1f460 100644
--- a/drivers/clk/qcom/gcc-sm6125.c
+++ b/drivers/clk/qcom/gcc-sm6125.c
@@ -4170,6 +4170,7 @@ static struct platform_driver gcc_sm6125_driver = {
 	.driver = {
 		.name = "gcc-sm6125",
 		.of_match_table = gcc_sm6125_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 9b4e4bb05963..c30dd75372a0 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -2566,6 +2566,7 @@ static struct platform_driver gcc_sm6350_driver = {
 	.driver = {
 		.name = "gcc-sm6350",
 		.of_match_table = gcc_sm6350_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 417a0fd242ec..01954b8880c0 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -3902,6 +3902,7 @@ static struct platform_driver gcc_sm6375_driver = {
 	.driver = {
 		.name = "gcc-sm6375",
 		.of_match_table = gcc_sm6375_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index 6b628178f62c..48c7d42d494b 100644
--- a/drivers/clk/qcom/gcc-sm7150.c
+++ b/drivers/clk/qcom/gcc-sm7150.c
@@ -3029,6 +3029,7 @@ static struct platform_driver gcc_sm7150_driver = {
 	.driver = {
 		.name = "gcc-sm7150",
 		.of_match_table = gcc_sm7150_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 70b067f3618c..feb22808a03d 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -3795,6 +3795,7 @@ static struct platform_driver gcc_sm8150_driver = {
 	.driver		= {
 		.name	= "gcc-sm8150",
 		.of_match_table = gcc_sm8150_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index b6cf4bc88d4d..3508ddaaad67 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3668,6 +3668,7 @@ static struct platform_driver gcc_sm8250_driver = {
 	.driver = {
 		.name = "gcc-sm8250",
 		.of_match_table = gcc_sm8250_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index af4a1ea28421..f0eb2e804113 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -3855,6 +3855,7 @@ static struct platform_driver gcc_sm8350_driver = {
 	.driver = {
 		.name = "sm8350-gcc",
 		.of_match_table = gcc_sm8350_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 84764cc3db4f..248709fb975e 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -3262,6 +3262,7 @@ static struct platform_driver gcc_sm8450_driver = {
 	.driver = {
 		.name = "gcc-sm8450",
 		.of_match_table = gcc_sm8450_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 277cd4f020ff..6c65634dbe54 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3368,6 +3368,7 @@ static struct platform_driver gcc_sm8550_driver = {
 	.driver = {
 		.name = "gcc-sm8550",
 		.of_match_table = gcc_sm8550_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-msm8998.c b/drivers/clk/qcom/gpucc-msm8998.c
index f929e0f2333f..39a5924fb532 100644
--- a/drivers/clk/qcom/gpucc-msm8998.c
+++ b/drivers/clk/qcom/gpucc-msm8998.c
@@ -343,6 +343,7 @@ static struct platform_driver gpucc_msm8998_driver = {
 	.driver		= {
 		.name	= "gpucc-msm8998",
 		.of_match_table = gpucc_msm8998_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpucc_msm8998_driver);
diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index 3f92f0b43be6..a760d09c5385 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -249,6 +249,7 @@ static struct platform_driver gpu_cc_sc7180_driver = {
 	.driver = {
 		.name = "sc7180-gpucc",
 		.of_match_table = gpu_cc_sc7180_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 1490cd45a654..b466dcee81cb 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -473,6 +473,7 @@ static struct platform_driver gpu_cc_sc7280_driver = {
 	.driver = {
 		.name = "gpu_cc-sc7280",
 		.of_match_table = gpu_cc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index ea1e9505c335..46ca242ba427 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -453,6 +453,7 @@ static struct platform_driver gpu_cc_sc8280xp_driver = {
 	.driver = {
 		.name = "gpu_cc-sc8280xp",
 		.of_match_table = gpu_cc_sc8280xp_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpu_cc_sc8280xp_driver);
diff --git a/drivers/clk/qcom/gpucc-sdm660.c b/drivers/clk/qcom/gpucc-sdm660.c
index d6b38a0b063d..9c5d5a3ce120 100644
--- a/drivers/clk/qcom/gpucc-sdm660.c
+++ b/drivers/clk/qcom/gpucc-sdm660.c
@@ -339,6 +339,7 @@ static struct platform_driver gpucc_sdm660_driver = {
 	.driver		= {
 		.name	= "gpucc-sdm660",
 		.of_match_table = gpucc_sdm660_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpucc_sdm660_driver);
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index 970d7414bdf0..b293fe136fe4 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -200,6 +200,7 @@ static struct platform_driver gpu_cc_sdm845_driver = {
 	.driver = {
 		.name = "sdm845-gpucc",
 		.of_match_table = gpu_cc_sdm845_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
index c84727e8352d..f2ef128d4606 100644
--- a/drivers/clk/qcom/gpucc-sm6115.c
+++ b/drivers/clk/qcom/gpucc-sm6115.c
@@ -495,6 +495,7 @@ static struct platform_driver gpu_cc_sm6115_driver = {
 	.driver = {
 		.name = "sm6115-gpucc",
 		.of_match_table = gpu_cc_sm6115_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpu_cc_sm6115_driver);
diff --git a/drivers/clk/qcom/gpucc-sm6125.c b/drivers/clk/qcom/gpucc-sm6125.c
index d4f1296a48ef..49981fcca06d 100644
--- a/drivers/clk/qcom/gpucc-sm6125.c
+++ b/drivers/clk/qcom/gpucc-sm6125.c
@@ -416,6 +416,7 @@ static struct platform_driver gpu_cc_sm6125_driver = {
 	.driver = {
 		.name = "gpucc-sm6125",
 		.of_match_table = gpu_cc_sm6125_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpu_cc_sm6125_driver);
diff --git a/drivers/clk/qcom/gpucc-sm6350.c b/drivers/clk/qcom/gpucc-sm6350.c
index ef15185a99c3..f17138f787c8 100644
--- a/drivers/clk/qcom/gpucc-sm6350.c
+++ b/drivers/clk/qcom/gpucc-sm6350.c
@@ -502,6 +502,7 @@ static struct platform_driver gpu_cc_sm6350_driver = {
 	.driver = {
 		.name = "sm6350-gpucc",
 		.of_match_table = gpu_cc_sm6350_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
index d8f4c4b59f1b..839877c32947 100644
--- a/drivers/clk/qcom/gpucc-sm6375.c
+++ b/drivers/clk/qcom/gpucc-sm6375.c
@@ -449,6 +449,7 @@ static struct platform_driver gpucc_sm6375_driver = {
 	.driver = {
 		.name = "gpucc-sm6375",
 		.of_match_table = gpucc_sm6375_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(gpucc_sm6375_driver);
diff --git a/drivers/clk/qcom/gpucc-sm8150.c b/drivers/clk/qcom/gpucc-sm8150.c
index 8422fd047493..dd502ffcbe05 100644
--- a/drivers/clk/qcom/gpucc-sm8150.c
+++ b/drivers/clk/qcom/gpucc-sm8150.c
@@ -312,6 +312,7 @@ static struct platform_driver gpu_cc_sm8150_driver = {
 	.driver = {
 		.name = "sm8150-gpucc",
 		.of_match_table = gpu_cc_sm8150_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sm8250.c b/drivers/clk/qcom/gpucc-sm8250.c
index 9c1f8ce32da4..ab407589c8f0 100644
--- a/drivers/clk/qcom/gpucc-sm8250.c
+++ b/drivers/clk/qcom/gpucc-sm8250.c
@@ -328,6 +328,7 @@ static struct platform_driver gpu_cc_sm8250_driver = {
 	.driver = {
 		.name = "sm8250-gpucc",
 		.of_match_table = gpu_cc_sm8250_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
index 5367ce654ac9..9c0ae16df813 100644
--- a/drivers/clk/qcom/gpucc-sm8350.c
+++ b/drivers/clk/qcom/gpucc-sm8350.c
@@ -618,6 +618,7 @@ static struct platform_driver gpu_cc_sm8350_driver = {
 	.driver = {
 		.name = "sm8350-gpucc",
 		.of_match_table = gpu_cc_sm8350_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 81a44a9a9abc..76f9483c7371 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -463,6 +463,7 @@ static struct platform_driver lcc_ipq806x_driver = {
 	.driver		= {
 		.name	= "lcc-ipq806x",
 		.of_match_table = lcc_ipq806x_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(lcc_ipq806x_driver);
diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f9211a14..30d7d7fb88ff 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -863,6 +863,7 @@ static struct platform_driver lpass_aon_cc_sc7280_driver = {
 		.name = "lpass_aon_cc-sc7280",
 		.of_match_table = lpass_aon_cc_sc7280_match_table,
 		.pm = &lpass_audio_cc_pm_ops,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 48432010ce24..e48e7406e5b4 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -154,6 +154,7 @@ static struct platform_driver lpass_cc_sc7280_driver = {
 	.driver		= {
 		.name	= "sc7280-lpasscc",
 		.of_match_table = lpass_cc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 010867dcc2ef..27f10dcdba13 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -469,6 +469,7 @@ static struct platform_driver lpass_core_cc_sc7180_driver = {
 		.name = "lpass_core_cc-sc7180",
 		.of_match_table = lpass_core_cc_sc7180_match_table,
 		.pm = &lpass_pm_ops,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
@@ -478,6 +479,7 @@ static struct platform_driver lpass_hm_sc7180_driver = {
 		.name = "lpass_hm-sc7180",
 		.of_match_table = lpass_hm_sc7180_match_table,
 		.pm = &lpass_pm_ops,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpasscorecc-sc7280.c
index 6ad19b06b1ce..8da95d0d4345 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7280.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
@@ -413,6 +413,7 @@ static struct platform_driver lpass_core_cc_sc7280_driver = {
 	.driver = {
 		.name = "lpass_core_cc-sc7280",
 		.of_match_table = lpass_core_cc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
@@ -438,6 +439,7 @@ static struct platform_driver lpass_hm_sc7280_driver = {
 	.driver = {
 		.name = "lpass_hm-sc7280",
 		.of_match_table = lpass_hm_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 02fc21208dd1..0dc828d3831a 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -3145,6 +3145,7 @@ static struct platform_driver mmcc_apq8084_driver = {
 	.driver		= {
 		.name	= "mmcc-apq8084",
 		.of_match_table = mmcc_apq8084_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(mmcc_apq8084_driver);
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 4273fce9a4a4..19104a5ddae8 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2801,6 +2801,7 @@ static struct platform_driver mmcc_msm8974_driver = {
 	.driver		= {
 		.name	= "mmcc-msm8974",
 		.of_match_table = mmcc_msm8974_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(mmcc_msm8974_driver);
diff --git a/drivers/clk/qcom/mmcc-msm8994.c b/drivers/clk/qcom/mmcc-msm8994.c
index 89c5f5fa7d9a..f021406b13b9 100644
--- a/drivers/clk/qcom/mmcc-msm8994.c
+++ b/drivers/clk/qcom/mmcc-msm8994.c
@@ -2611,6 +2611,7 @@ static struct platform_driver mmcc_msm8994_driver = {
 	.driver		= {
 		.name	= "mmcc-msm8994",
 		.of_match_table = mmcc_msm8994_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(mmcc_msm8994_driver);
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 80330dab4d81..01ef542bc62c 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3635,6 +3635,7 @@ static struct platform_driver mmcc_msm8996_driver = {
 	.driver		= {
 		.name	= "mmcc-msm8996",
 		.of_match_table = mmcc_msm8996_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(mmcc_msm8996_driver);
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 4490594bde69..cc6153490614 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2881,6 +2881,7 @@ static struct platform_driver mmcc_msm8998_driver = {
 	.driver		= {
 		.name	= "mmcc-msm8998",
 		.of_match_table = mmcc_msm8998_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(mmcc_msm8998_driver);
diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
index bc19a23e13f8..0afe71ec49fe 100644
--- a/drivers/clk/qcom/mmcc-sdm660.c
+++ b/drivers/clk/qcom/mmcc-sdm660.c
@@ -2859,6 +2859,7 @@ static struct platform_driver mmcc_660_driver = {
 	.driver		= {
 		.name	= "mmcc-sdm660",
 		.of_match_table = mmcc_660_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 module_platform_driver(mmcc_660_driver);
diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
index 5b9b54f616b8..13aeb02a4b42 100644
--- a/drivers/clk/qcom/videocc-sc7180.c
+++ b/drivers/clk/qcom/videocc-sc7180.c
@@ -234,6 +234,7 @@ static struct platform_driver video_cc_sc7180_driver = {
 	.driver = {
 		.name = "sc7180-videocc",
 		.of_match_table = video_cc_sc7180_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index 615695d82319..041317bfc702 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -306,6 +306,7 @@ static struct platform_driver video_cc_sc7280_driver = {
 	.driver = {
 		.name = "video_cc-sc7280",
 		.of_match_table = video_cc_sc7280_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
index c77a4dd5d39c..f14584800be0 100644
--- a/drivers/clk/qcom/videocc-sdm845.c
+++ b/drivers/clk/qcom/videocc-sdm845.c
@@ -337,6 +337,7 @@ static struct platform_driver video_cc_sdm845_driver = {
 	.driver		= {
 		.name	= "sdm845-videocc",
 		.of_match_table = video_cc_sdm845_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
index 1afdbe4a249d..3144e22dd660 100644
--- a/drivers/clk/qcom/videocc-sm8150.c
+++ b/drivers/clk/qcom/videocc-sm8150.c
@@ -253,6 +253,7 @@ static struct platform_driver video_cc_sm8150_driver = {
 	.driver = {
 		.name	= "video_cc-sm8150",
 		.of_match_table = video_cc_sm8150_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..fea6caad8d1f 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -399,6 +399,7 @@ static struct platform_driver video_cc_sm8250_driver = {
 	.driver	= {
 		.name = "sm8250-videocc",
 		.of_match_table = video_cc_sm8250_match_table,
+		.sync_state = qcom_cc_sync_state,
 	},
 };
 
-- 
2.34.1

