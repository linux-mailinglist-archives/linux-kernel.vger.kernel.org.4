Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46FF6AD34E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCGAYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCGAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:24:29 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBF3E63E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:24:27 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-176b90e14a9so5854705fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678148666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv6Wgdtj8RZLS4H2AomeQE2GOqJIiXhuR2ajMG2mqtc=;
        b=UN9OKuOHO8iuHXVI4ErW+QS44kcgNZsPiv1zVHpyjmLpXzOG1lJDd5Zo0GJXFQZnce
         lfLuk48mWRmM1pr0M6/ZfU+/Mw0iyfl2HCCCqD16uoq2dkvLkRNUBFWvyesiQX9zQHlR
         StgM9zj4CV2C48N36rh0f9b+R3nwTmkg0Cu7C3FYajpyVMNGz9wKXmwnNL1qg7sdS/9Y
         aw2/UStkcYkPz0UhI9a4XALay1O4BOTFubKsOBlPw3OVO6nWAPuHhn++DWaXP3AjcNVj
         FkIRw03c6jMtCHjYGNRWlL+BsSa/5qFUOXh5Wu49tNW7GNozoM7nEAYqVn5GlDt450D/
         iJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv6Wgdtj8RZLS4H2AomeQE2GOqJIiXhuR2ajMG2mqtc=;
        b=Y4jm6Rn0AgcglKMJ2fGYJk7pI2uCg240tn5j4ng84GEA7QpQg6mNcdKWLrxEBtF6ot
         HtyoiVJcbYaTFD8tv1I9rlYehzAvdqERiKcMEMFH1MLwxWNJRHZBlx64frc0fBgDeS17
         jKzYCPLTAiiJco1CBpnvDwUf44/HxJODSkRshRNlM7OTUYQ2H5VIvel92+/wdpFfm4+r
         Uex+w1NJDJjRpP2y/DFrOAlg/V/x3Gp46EdkrK/Ix3hCi1T5VdLbrgiAE6cDzreuThQr
         DCXCJCSPNS1dGA+OpPxMPu78Uy45xdXUJr2PbcQP9EGB1cPni2JUG8FOEuCs7OQMsq7f
         KVKQ==
X-Gm-Message-State: AO0yUKWY5IJg3dDNMYzDoqQi4bsO0IHuJN3mF/Kyuc/SRWtJ3xGVwjID
        Jv7de6m9C3ng5VpZpwWOKBMKDA==
X-Google-Smtp-Source: AK7set83G3Y6yCzwjCvNQMe6wpqKX+L2ZY6edKKE+jBMr3KCInuPOin2gkkEdGmVH8g5QuU/nxVvnw==
X-Received: by 2002:a05:6870:2113:b0:176:55ae:57d0 with SMTP id f19-20020a056870211300b0017655ae57d0mr8557304oae.34.1678148666445;
        Mon, 06 Mar 2023 16:24:26 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id e26-20020a05683013da00b0068663820588sm1700399otq.44.2023.03.06.16.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:24:26 -0800 (PST)
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
Subject: [PATCH v4 2/3] clk: samsung: Extract parent clock enabling to common function
Date:   Mon,  6 Mar 2023 18:24:22 -0600
Message-Id: <20230307002423.24454-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307002423.24454-1-semen.protsenko@linaro.org>
References: <20230307002423.24454-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract parent clock enabling from exynos_arm64_register_cmu() to
dedicated function.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - Rebased on top of krzk/linux.git/for-next tree
  - Reworked exynos_arm64_enable_bus_clk() user code to only print an
    error message if that function fails

Changes in v3:
  - Rebased on top of latest soc/for-next tree
  - Added Marek's Acked-by tag

Changes in v2:
  - Rebased on top of latest soc/for-next tree
  - Improved English in kernel doc comment
  - Added clk_prepare_enable() return value check
  - Added exynos_arm64_enable_bus_clk() check in
    exynos_arm64_register_cmu()
  - Changed the commit message to reflect code changes

 drivers/clk/samsung/clk-exynos-arm64.c | 57 ++++++++++++++++++--------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
index b921b9a1134a..60fd820c14aa 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.c
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -56,6 +56,37 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
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
+ * Return: 0 on success or a negative error code on failure.
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
+	if (IS_ERR(parent_clk))
+		return PTR_ERR(parent_clk);
+
+	return clk_prepare_enable(parent_clk);
+}
+
 /**
  * exynos_arm64_register_cmu - Register specified Exynos CMU domain
  * @dev:	Device object; may be NULL if this function is not being
@@ -72,22 +103,16 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
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
+	int err;
+
+	/*
+	 * Try to boot even if the parent clock enablement fails, as it might be
+	 * already enabled by bootloader.
+	 */
+	err = exynos_arm64_enable_bus_clk(dev, np, cmu);
+	if (err)
+		pr_err("%s: could not enable bus clock %s; err = %d\n",
+		       __func__, cmu->clk_name, err);
 
 	exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
 	samsung_cmu_register_one(np, cmu);
-- 
2.39.2

