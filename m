Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57B735BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjFSQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFSQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:13:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22B1B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:13:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b46bfa66d2so29012601fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191204; x=1689783204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmgYvNinjU/fT+erZeLft1aKLnZsg+oPmLA3CULSbeM=;
        b=PTEHzxVjoT1bF8b5NSp4p68xB+MVPrSsJJUY0khQid3MBOQ+0J/+/PjP5ztIJnoEte
         wnFd+gMhlzHN05KizStYKFgY0/J+neM+FabraUyIE4grK0b2Xy36NcJEcfAiw/eidaTL
         lBbCMzwMCHodFXALMzlUfFHUad8nkzCyoihpPCx6ZhelQM7cijXatQVr4/BNAib/4/zt
         EVBHsyAyofZh9OiQNOounIyW6aW5CrPCYY1bdmTzYy2IrpZSC51i0Todnq/bli6Xw9mS
         6D3ZYv9axSfxuK0o7pZQ2IxZZBVV5cteCUXqmOSQPNYe7B847ZjptQGNcfhNtWYSarSo
         LpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191204; x=1689783204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmgYvNinjU/fT+erZeLft1aKLnZsg+oPmLA3CULSbeM=;
        b=SfJRERLihdq3awOF2bthYcu1bGVt3pThkPHQhcZ8BN1UCOJ3GqLpNpXWmUxkkAFGFa
         wqYQ4odankmkQglq7ZM6vzrXGC1n/RYDdETV2p0DLU3JjAset083+4cDKH2yCfNquO+b
         Ee/hwSM8wwFqlsv+TE7q7vFGkQqpty+ZcahwQeWvSo+6Nm38Lc5z6Ag+ee/Sy/eVUw0J
         k7y5l3OT6n5IJbkTEfF8O5XSBcREAGWuqe1iqyrqqK289YGQjtfLcmDbDQ8yhKqS7NA/
         00Tzd4tYkIHWPe13h6cvXeSOF6KdufqwCtIo/Au2MdRUB3SEy27i3ro3CcBXe2KDATaR
         sv9g==
X-Gm-Message-State: AC+VfDxvgjHu10Ig12jT1+jTn0Rwi8qCwvX6GYmTm1AKGyUl2YcmhJpb
        jMIy0WtW3E4yYBfPKf6JrL7LOPcKAU1FeyyPKak=
X-Google-Smtp-Source: ACHHUZ5FVyfJK40+gm5ktlujj/AXdHiYmbvKw0KBnc6dK1hlmNuaf+P6ZagFHzrzYXyq0LyYIyYb4A==
X-Received: by 2002:a2e:960d:0:b0:2ad:d291:72e1 with SMTP id v13-20020a2e960d000000b002add29172e1mr6611945ljh.18.1687191204336;
        Mon, 19 Jun 2023 09:13:24 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e7c14000000b002b471efb253sm1011714ljc.46.2023.06.19.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:13:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:13:18 +0200
Subject: [PATCH 2/2] clk: qcom: gcc-sc8280xp: Add runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sc8280xp-clk-rpm-v1-2-1e5e1064cdb2@linaro.org>
References: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
In-Reply-To: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687191201; l=1628;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iLOsinGTJtv8sPDkEM7a2zWDxDnO0K1p+yOFG6UU878=;
 b=7gTXtpfYHcJ+0pwGRH82J2GexETpGG26Gyb/o04zQKY9qD5wnd1s78SdNgclCurw05CB4RlMi
 lEdx/i0XRbsDjfQmEAqtdOzVf3WwIQRHifziP649VUBKp7lkQLL5FK5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC block on SC8280XP is powered by the CX rail. We need to ensure
that it's enabled to prevent unwanted power collapse.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 04a99dbaa57e..b90c71637814 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 
@@ -7421,9 +7422,19 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	regmap = qcom_cc_map(pdev, &gcc_sc8280xp_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	/*
 	 * Keep the clocks always-ON
@@ -7445,7 +7456,10 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sc8280xp_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gcc_sc8280xp_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static const struct of_device_id gcc_sc8280xp_match_table[] = {

-- 
2.41.0

