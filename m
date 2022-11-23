Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBE63616C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiKWOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiKWOUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:20:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328E65875
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e11so16700479wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1lUAZwE9nSwZrZSdCxi2YHNb0JUQOB8Boyf/UVQig4=;
        b=jOc1XuaGWH38fitbCYxMFv5hFLYeq7pX12rcKz/fMsYXYSmsmsGUT4SJjSM47/LH0m
         gu2YmRZwCK1CftnhROPVGI40VmKIB3nRytGvnFboD133QMCEsGsa7z0Bbmvw97Ac1fI+
         W5nzSGHHTdnpVlb1qF7piLTdFui1P44GtWU9jmeQs6G3KFmOD3lQpdKIovx6HIc9q8Ds
         RX4Xs8hbN+A1VVu8i2b+OkuB9E4/7cvhPwn9c3IadKS/fggEjZpuR03KSHsGyd/7eIUq
         3QoNXULFuNx8F+gXc3PW2xqu5pBAekAn6Pctcnk+c52nwR5S3m3YD74Uqgsa1uhl+mOj
         hSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1lUAZwE9nSwZrZSdCxi2YHNb0JUQOB8Boyf/UVQig4=;
        b=0hep8FnHQWCX8bASNwkCj1tijce5v79qOr0Xr/PwNoF3TyAG57FPukxxn1bnNscq9w
         DukPs41QKShjzGWUHEtIluNB9jkeuDwEcHeovja6LVB4l1zI3+v3S0RRx85KOO3UMGzj
         wd/vmqzFit+AbxXGFq0oD4oe0Ft/m6B3SUOz+2h6uB8A0lOVZ3js6cjW53fwUqPZsTcm
         kh4vS0c0CeAJbDWSVHK9nvCP0LV3R7ogpEqei0cPn4DWiFDtfz1dYnv4KmwQV2Qkvdl8
         PravU5/pL+TrsEF94MS6YEaIkzFbRym+ujEARE7EWDcgCQ6rg3DBwedA7hNKKs98mcR3
         H1zg==
X-Gm-Message-State: ANoB5pk+MJiBJbKuk7G4RdA/9CbQdnHpEBkFw0rVg24FfrOuYqKwKPPb
        NJ/al+m+PH1sOLOYmgCo++H/KQ==
X-Google-Smtp-Source: AA0mqf7KOwZUy2Dphz8/cE73GcxiXRlJsU/84TLZ6cfnJTS9LNACDALoOR0dgA4Or1a0N9RDxXFwiQ==
X-Received: by 2002:adf:dc11:0:b0:241:f5f7:ca0a with SMTP id t17-20020adfdc11000000b00241f5f7ca0amr1218849wri.233.1669213224433;
        Wed, 23 Nov 2022 06:20:24 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b003cfd58409desm2837438wmq.13.2022.11.23.06.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:20:24 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 3/9] clk: qcom: gdsc: Add configurable poll timeout
Date:   Wed, 23 Nov 2022 16:20:03 +0200
Message-Id: <20221123142009.594781-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123142009.594781-1-abel.vesa@linaro.org>
References: <20221123142009.594781-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the platform, the poll timeout delay might be different,
so allow the platform specific drivers to specify their own values.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

Changes since v1:
 * Added Konrad's R-b tag

 drivers/clk/qcom/gdsc.c | 5 ++++-
 drivers/clk/qcom/gdsc.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 0f21a8a767ac..3753f3ef7241 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -107,7 +107,7 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
 	do {
 		if (gdsc_check_status(sc, status))
 			return 0;
-	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
+	} while (ktime_us_delta(ktime_get(), start) < sc->poll_timeout);
 
 	if (gdsc_check_status(sc, status))
 		return 0;
@@ -454,6 +454,9 @@ static int gdsc_init(struct gdsc *sc)
 	if (ret)
 		goto err_disable_supply;
 
+	if (!sc->poll_timeout)
+		sc->poll_timeout = 500;
+
 	return 0;
 
 err_disable_supply:
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 803512688336..9a1e1fb3d12f 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -36,6 +36,7 @@ struct gdsc {
 	struct generic_pm_domain	*parent;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
+	unsigned int			poll_timeout;
 	unsigned int			collapse_ctrl;
 	unsigned int			collapse_mask;
 	unsigned int			gds_hw_ctrl;
-- 
2.34.1

