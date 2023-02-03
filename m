Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32400688F78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBCGJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjBCGJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:09:16 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C574A52
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:09:07 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r9so3347480oig.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFGVK/R7IvXJOW0JsMc8GEWmuVlJkiZ67MQd9wzMPas=;
        b=f0lvHe+RIZvGMkZgAgwmx4KWkCK8Zp2/njSt24OxDyyvDxYCbuU0NB9H1p+yJaaWaC
         R39D0bvTg9tZI5OMnUlRROenCJ3zbi5yCRr8gu3E6BJqHVFR14wHLR3TB3sK0rKjLH3M
         jaMGlcn4dA0BcMl5zGDe0S4Cqimu2CUGQDE2ri3Ddy9cA4Ajj1+wFi5o6kjJ8v1PCuQ6
         6rhN3Vgs3RPulsjgWxlP4jEnghopSIoqgqPzYMA27MNLILBSkoMTBzXQb7vrSdDtyCIt
         doPnT9HRvNAIibc1HFN392CohVYLs6cbUtaPcQS7CLPLSyZbON6vm0211k5nzFcNEmQ8
         OtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFGVK/R7IvXJOW0JsMc8GEWmuVlJkiZ67MQd9wzMPas=;
        b=cQo5b1LyB8jofXsCtmt5yUfuSud6KCTcWPmYO+xf1jA/SFCXUYDDsDZChE+HB/bPDb
         Ee3jnwRZ5MDhKzQEgIcYDizfW1+dlaQjnldmpab3Qr595hLclQGIGMeGVLpPpV9Mpojl
         IOpFFKgs4R2PmKMTlWuHEz+HSGDmkOpgXGKMbIscK3qpLuaFCZhypmIyx5CwlYoskPjV
         KoraA1otMgOC1rBu+zqjKK3jDo6vhw1+p7qUOemaW+aJ/kT7SCjtwccesEWpMpuoMcc4
         o0hQhtMZbhI3ggc+/sinOTko8PfYvQ1SkRFe+WY8JAfS0qpQSXtnKYFSQ2bHanw7gpFy
         Cf2Q==
X-Gm-Message-State: AO0yUKWLqE+8xodadudmx02RBHjYeaDxWivkneIOvs9b46aA7n7JcCwX
        9blSQUs4059fAvVZwRs9MTh2kg==
X-Google-Smtp-Source: AK7set+hV484I96OKvacApzyMi+v5hfOAHMNKGNJFQ9Su+QkLejUQN0sLqyh94gC3wT3nxzXwkVYVg==
X-Received: by 2002:a05:6808:2021:b0:378:976a:9cb5 with SMTP id q33-20020a056808202100b00378976a9cb5mr6123598oiw.0.1675404546859;
        Thu, 02 Feb 2023 22:09:06 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id l18-20020a056830055200b00684152e9ff2sm781235otb.0.2023.02.02.22.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 22:09:06 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] clk: samsung: Extract parent clock enabling to common function
Date:   Fri,  3 Feb 2023 00:09:23 -0600
Message-Id: <20230203060924.8257-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203060924.8257-1-semen.protsenko@linaro.org>
References: <20230203060924.8257-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract parent clock enabling from exynos_arm64_register_cmu() to
dedicated function. No functional change.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos-arm64.c | 53 +++++++++++++++++---------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
index b921b9a1134a..361663223a24 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.c
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -56,6 +56,41 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
 	iounmap(reg_base);
 }
 
+/**
+ * exynos_arm64_enable_bus_clk - Enable parent clock of specified CMU
+ *
+ * @dev:	Device object; may be NULL if this function is not being
+ *		called from platform driver probe function
+ * @np:		CMU device tree node
+ * @cmu:	CMU data
+ *
+ * Keep CMU parent clock running (needed for CMU registers access).
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+static int __init exynos_arm64_enable_bus_clk(struct device *dev,
+		struct device_node *np, const struct samsung_cmu_info *cmu)
+{
+	struct clk *parent_clk;
+
+	if (!cmu->clk_name)
+		return 0;
+
+	if (dev)
+		parent_clk = clk_get(dev, cmu->clk_name);
+	else
+		parent_clk = of_clk_get_by_name(np, cmu->clk_name);
+
+	if (IS_ERR(parent_clk)) {
+		pr_err("%s: could not find bus clock %s; err = %ld\n",
+		       __func__, cmu->clk_name, PTR_ERR(parent_clk));
+		return PTR_ERR(parent_clk);
+	}
+
+	clk_prepare_enable(parent_clk);
+	return 0;
+}
+
 /**
  * exynos_arm64_register_cmu - Register specified Exynos CMU domain
  * @dev:	Device object; may be NULL if this function is not being
@@ -72,23 +107,7 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
 void __init exynos_arm64_register_cmu(struct device *dev,
 		struct device_node *np, const struct samsung_cmu_info *cmu)
 {
-	/* Keep CMU parent clock running (needed for CMU registers access) */
-	if (cmu->clk_name) {
-		struct clk *parent_clk;
-
-		if (dev)
-			parent_clk = clk_get(dev, cmu->clk_name);
-		else
-			parent_clk = of_clk_get_by_name(np, cmu->clk_name);
-
-		if (IS_ERR(parent_clk)) {
-			pr_err("%s: could not find bus clock %s; err = %ld\n",
-			       __func__, cmu->clk_name, PTR_ERR(parent_clk));
-		} else {
-			clk_prepare_enable(parent_clk);
-		}
-	}
-
+	exynos_arm64_enable_bus_clk(dev, np, cmu);
 	exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
 	samsung_cmu_register_one(np, cmu);
 }
-- 
2.39.0

