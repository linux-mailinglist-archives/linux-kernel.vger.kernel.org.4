Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A216B16B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCHXi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCHXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:38:34 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C158B7C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:38:32 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id c11so384707oiw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678318712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfnUNqAxuAYnW+uBC0eeR8bX/4fPfr5shHESRUBLMio=;
        b=uLvZoGmQBxkLibP85KJwwV9I0Dug6Qn7VOBCLNaopen2OfM/66LoxydINuuqPQo3zo
         S7tCsm9HBml14rIWOjSCYSSjMiluxQ9ETeLN669ZGi4+2XwbpXOByh0W5SnoRCxPhRfv
         6qCazivlQc0xR3rKvSop0+qqzmhyGBaXnnDjk6/JI87aac2p4Sofpzuf4b2Lwu1B64Y0
         0iYxJ4jOlo+NIoDGNKHeTZVVgUu3iqBYkXEJmRJrb13s5APFzrgvryqwa0ZqpQX2IAqY
         XyxMNDQ5D9VtUwCRWzL4ujnDvb8FdHwQaDk0PiDhVfhjg72+4k3l39VA99gfaq5Vdt8K
         KpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfnUNqAxuAYnW+uBC0eeR8bX/4fPfr5shHESRUBLMio=;
        b=jdKUtYWdMXic2XSIfcR/ABQknvjDWbyUrUbbeBRpDYXG26e7esLpkP+8ZX4oOpD8UX
         pe7N7/SW/MQ+kvHkDxmNWTswdZnTJJ34RdBZg2RE4dbtWHsV2+7y7oyVZ+V+GO9CVq+1
         m0z01mtmnBoN0oB78vlZzX1MVcu/7qp8hiqpoS7e9/FzLJSp3jgvgE83z/CGBfXA9AZg
         CV4jjlh/tp3266cc9RHxKeiqEQIekjewJj2uvEmylG+KqpiPQ+27BvFCyTv3IfxzTdKl
         4YkNWXs4AeD6NlHZ9TUsoSUM/zgcwE4GQY1Ttz1BD+EjcPI8XejwGoEvJ1hWonXF/wdd
         wfFg==
X-Gm-Message-State: AO0yUKV04V95eYiGSd7V2EbTzf7bJj+qQLXe+QquFC4UrhVCELJIQ9p/
        WK10ZZ2GupQ6GWMnVathqjROdA==
X-Google-Smtp-Source: AK7set+LdKfl2pV7rFrK7MHlgWGS3BOHTe4zWqh2BQ94RSgtvMfaZ+LHiZ0J7LRnfOojDpCNdSs1Vw==
X-Received: by 2002:a05:6808:3b0:b0:384:352f:9810 with SMTP id n16-20020a05680803b000b00384352f9810mr7700050oie.31.1678318711881;
        Wed, 08 Mar 2023 15:38:31 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id s81-20020acadb54000000b00383f58e7e95sm6985322oig.17.2023.03.08.15.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:38:31 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] clk: samsung: exynos850: Enable PM support in clk-exynos850
Date:   Wed,  8 Mar 2023 17:38:21 -0600
Message-Id: <20230308233822.31180-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308233822.31180-1-semen.protsenko@linaro.org>
References: <20230308233822.31180-1-semen.protsenko@linaro.org>
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

Some CMUs in Exynos850 SoC belong to power domains. In order to support
"power-domains" property for such CMUs, use
exynos_arm64_register_cmu_pm() API instead of
exynos_arm64_register_cmu() in the probe function, and also provide PM
ops for suspend/resume accordingly.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 5664d17bae83..bbf0498dd0b0 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -9,8 +9,8 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <dt-bindings/clock/exynos850.h>
 
@@ -1909,13 +1909,7 @@ static const struct samsung_cmu_info dpu_cmu_info __initconst = {
 
 static int __init exynos850_cmu_probe(struct platform_device *pdev)
 {
-	const struct samsung_cmu_info *info;
-	struct device *dev = &pdev->dev;
-
-	info = of_device_get_match_data(dev);
-	exynos_arm64_register_cmu(dev, dev->of_node, info);
-
-	return 0;
+	return exynos_arm64_register_cmu_pm(pdev, true);
 }
 
 static const struct of_device_id exynos850_cmu_of_match[] = {
@@ -1950,11 +1944,19 @@ static const struct of_device_id exynos850_cmu_of_match[] = {
 	},
 };
 
+static const struct dev_pm_ops exynos850_cmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(exynos_arm64_cmu_suspend, exynos_arm64_cmu_resume,
+			   NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+};
+
 static struct platform_driver exynos850_cmu_driver __refdata = {
 	.driver	= {
 		.name = "exynos850-cmu",
 		.of_match_table = exynos850_cmu_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &exynos850_cmu_pm_ops,
 	},
 	.probe = exynos850_cmu_probe,
 };
-- 
2.39.2

