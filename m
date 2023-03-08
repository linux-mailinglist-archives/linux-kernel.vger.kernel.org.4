Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624096B163D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCHXKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCHXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:09:43 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45862860
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:09:40 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g73-20020a9d12cf000000b006943a7df072so90687otg.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678316980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqP7runz9fYVY1TUY6ik+MRNc/PM8+/25wcHDRNrCqg=;
        b=pMeJTUMMw8Ia7l1IPPUUsdvR7xspLZEDohgXXQH/vDj7exFL9MWOAAnxhMUHw9xEi9
         q+EoBXK+9I748gNWpHzqG0R6Ara+yLGh1qbSF6lHBdxZT96b3l8MUa242OxPTQMV7xLg
         hQAO9hP8fvXLArgDEj6X/R7pw+WSgtBmchw/srR0PH0Ft+wypT5hIfZV9XqBF0c+KCLh
         kgInsvI7lf7pAiTiq8Fq0MFNkk+c2PfgzSbLju3iffONoUCZBqJWLlkBW1OlXYT+64/b
         JKK/cmWqYLctN66VueXT93bhwZC4VpTjIzoAhyRuG897cU84E4eWNfSe6pHN6KJ7ISLg
         nPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqP7runz9fYVY1TUY6ik+MRNc/PM8+/25wcHDRNrCqg=;
        b=v7vsjoio6WYR6qbM+q/Y2uL6V46PzzY1b9W8BaNrkqbYq6kh2kQo7uSfkSAUHvV3bv
         sl+AwlWHmwPhV5IrMwXM6dS1GCxaq/EWYXJSODemZ4p9YiR8tq32Ye3J2ZTgzU0vXWIb
         x7+WAOC6nR/YQa2t9H/LIBLXINcHPoVSoNQc0LVSKFJUXJvsXxqlSx+C7UdAirTzXYrX
         +69MkGAtk9mssrBPMLElKyX8nPwPElLBDfb1OnR8BCeyWtpSTraNUPvrju1UbCf5Ass7
         3/wR3Kc97CoixREEeI8+BtWKc9K9dLCrBHw5z8DAYCapMK8PH0MoMwet9isRGtKHNZhm
         wkxQ==
X-Gm-Message-State: AO0yUKXmXYiUCsDwpL5+0s+UKOdui+hpu/g3VGvT2pc6F1kDHUNyVCdX
        yOhJhh51cwHHnyrTtojwqwXagA==
X-Google-Smtp-Source: AK7set/tBJXhTZUXyy437vmJNBgUKb2EX1mJ5MLUT6s+oNNf/7TzTYa0XXmwK2tWKREM5hmGZM2/cQ==
X-Received: by 2002:a05:6830:3142:b0:68b:e4e6:cc9c with SMTP id c2-20020a056830314200b0068be4e6cc9cmr11426374ots.33.1678316980169;
        Wed, 08 Mar 2023 15:09:40 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id z25-20020a056830129900b00686574e98d6sm6919220otp.72.2023.03.08.15.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:09:39 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] soc: samsung: pm_domains: Add Exynos850 support
Date:   Wed,  8 Mar 2023 17:09:31 -0600
Message-Id: <20230308230931.27261-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308230931.27261-1-semen.protsenko@linaro.org>
References: <20230308230931.27261-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string for Exynos850, providing all HW specific
data, which enables Exynos PD support for this chip.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/soc/samsung/pm_domains.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index ec630a151247..795d8a9cd4b5 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -20,6 +20,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
+#include <dt-bindings/power/samsung,exynos850-power.h>
+
 /* Register offsets inside Power Domain area in PMU */
 #define EXYNOS_PD_CONF		0x0
 #define EXYNOS_PD_STATUS	0x4
@@ -132,6 +134,21 @@ static const struct exynos_pm_domain_config exynos5433_cfg = {
 	.local_pwr_cfg		= 0xf,
 };
 
+static const unsigned int exynos850_pd_offsets[] = {
+	[EXYNOS850_PD_HSI]	= 0x1c80,
+	[EXYNOS850_PD_G3D]	= 0x1d00,
+	[EXYNOS850_PD_MFCMSCL]	= 0x1d80,
+	[EXYNOS850_PD_DPU]	= 0x2000,
+	[EXYNOS850_PD_AUD]	= 0x2080,
+	[EXYNOS850_PD_IS]	= 0x2100,
+};
+
+static const struct exynos_pm_domain_config exynos850_cfg = {
+	.local_pwr_cfg		= 0x1,
+	.pd_offsets		= exynos850_pd_offsets,
+	.pd_offsets_num		= ARRAY_SIZE(exynos850_pd_offsets),
+};
+
 static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{
 		.compatible = "samsung,exynos4210-pd",
@@ -139,6 +156,9 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-pd",
 		.data = &exynos5433_cfg,
+	}, {
+		.compatible = "samsung,exynos850-pd",
+		.data = &exynos850_cfg,
 	},
 	{ },
 };
-- 
2.39.2

