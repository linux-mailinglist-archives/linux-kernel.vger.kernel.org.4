Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE772A456
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFIUTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjFIUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E41B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f660e57123so672655e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341960; x=1688933960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WM2lIBCQpaCLxOM0eZa+yyh2dei168j4wOh+tPpmJK0=;
        b=gzLNdXMGWdBPqiQA7B5eUoaMSuyncfwekHUkflRA8lMz23+qJngQv+qACsgkJypyrB
         L4YOfXAZZJkm+YrTYHP04+wg2xFGVbfthizUyYYPVvmXH3raZwYfpgPc0WNenG1lHrfi
         TZoks45l93ZkzdBmIHh3ctj7zs7P9uT1E9ZltSuICh5odV1ys9a7WOgM5326KXNf9TYW
         E0s1+sCNR7Z0podvlw7Q3wWBUTHBZKdLhEstLZaTmYDeoqifjXTmuKFaiWy0BArqSVBl
         Go7ktf6WKHM1FhfNmVNTNaxLK1LNULx9gJDZbFFccaH/DRDvGhTR942liPJZRNre7NZO
         j9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341960; x=1688933960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM2lIBCQpaCLxOM0eZa+yyh2dei168j4wOh+tPpmJK0=;
        b=HxTCbk6bF5zqb/+4FvB9KKVy0rMH4ICDUGyGPMFOvUsaz2AC0p1MT+J9p0xbdCOTeO
         60UCkURLeID5FQQdS8zFzuPnLAajlQDRMov7+9/1iS7XbJ2Dfd+BhD+5IOlty72MSX0f
         OUMCBkMHiwAlgE71xl+mrXi8iX0wVZf2LEGia9eOkesIanNiKkS6DRbxz8xYP1eX4ioc
         DNtEUGHxLtaqNGHM3QIjjjf1XM5pCTDiS+VmrM5lS87WJ+mByDZkMb3ZEd/p3FGNI2uQ
         5ou0+4FDi3mtSnAKq4+Q4x9Mtx4Na5UqaDNP737G+w6wujPsltgdqiACjaE7rAKz0lQy
         Rm5A==
X-Gm-Message-State: AC+VfDyyrUwUPx3khMXSsiDT8ONPWfk6UsWrD1s2oifM6HUi0Y5kK8Fy
        7NB8u0t5Vvs3XxJFYwpEWisBPQ==
X-Google-Smtp-Source: ACHHUZ5bAormfh7KWJB2oKW/wLRnPrxw7KV3qrmhKb8FDp+RbOt03uINWLVcMmt+Ires0ZrjJcgX/Q==
X-Received: by 2002:a05:6512:290:b0:4f3:a71a:9e5f with SMTP id j16-20020a056512029000b004f3a71a9e5fmr1497295lfp.65.1686341960341;
        Fri, 09 Jun 2023 13:19:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:09 +0200
Subject: [PATCH v2 04/22] clk: qcom: smd-rpm: Export clock scaling
 availability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-4-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=1931;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sfIIZ4nJOxKMuz78S/kJHIPdUookF7KrBzGOCFONLgY=;
 b=UGsFPui0AzaF8mwTfLqT11gqTSGaF6XKmO5msD2SsfjTYhDoq5xBBDwwF696aoGiYMWfJAghc
 0wMWoO20fcxAuSzyDyj4jpMiPdgh9nnfNMzxwC62Wa44XYgWEUOo4Hl
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

Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
clock rate requests will not be commited in hardware. This poses a
race threat since we're accessing the bus clocks directly from within
the interconnect framework.

Add a marker to indicate that we're good to go with sending new requests
and export it so that it can be referenced from icc.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
 include/linux/soc/qcom/smd-rpm.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 937cb1515968..482fe30ee6f0 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -151,6 +151,7 @@
 #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
 
 static struct qcom_smd_rpm *rpmcc_smd_rpm;
+static bool smd_rpm_clk_scaling;
 
 struct clk_smd_rpm {
 	const int rpm_res_type;
@@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
 	return r->rate;
 }
 
+bool qcom_smd_rpm_scaling_available(void)
+{
+	return smd_rpm_clk_scaling;
+}
+EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
+
 static int clk_smd_rpm_enable_scaling(void)
 {
 	int ret;
@@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
 		return ret;
 	}
 
+	smd_rpm_clk_scaling = true;
+
 	pr_debug("%s: RPM clock scaling is enabled\n", __func__);
 	return 0;
 }
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 8190878645f9..420f6c79d535 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -65,4 +65,6 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 		       u32 resource_type, u32 resource_id,
 		       void *buf, size_t count);
 
+bool qcom_smd_rpm_scaling_available(void);
+
 #endif

-- 
2.41.0

