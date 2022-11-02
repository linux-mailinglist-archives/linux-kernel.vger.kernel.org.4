Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF6615DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKBIdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKBIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:33:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753E2793B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:33:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so15877094plz.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UeGRLt0I6Ca0YYYt9StoKBqh2LnPMLZ6623L26cNAw=;
        b=IH0U1tsxJITrnpwgUR/Hzctz5g/bXvQYOc1TdCZde+I0rJQPoXhlaI+SRAOLsOUEZr
         AOaBS0r+QFPEOqsT+mb35BORHxvc8zXuTai8otYkmJS+JBg/Wkkcrgz9bIj8Q1DsO1iN
         /4FrWb+0BS3j9gm6nJmkGgowOh8h+Fxrkqdotw9vlY/IfM++mED0fWloaRZyPUvNlTPG
         vrrQgUkmes2d7/c5RoGR304O0OfECoowUSggvz2LjCPR7KY7LaOglXkb77Kv8x1YIsLI
         7woxPdKQlviakM3Vil07FTjQjgH3B3GdgPvpwDkEgQ4y9akdsvgsZEI1cas6dDQU3mHz
         fP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UeGRLt0I6Ca0YYYt9StoKBqh2LnPMLZ6623L26cNAw=;
        b=c7LlKItPy/Ydkp5MaHwkwudIOd5Erg8ZElVpcgblEddmTCLkGmpOCVIrz1Sa4CbUry
         JSpGhBpmBwVpxP+95uTLRIv6h0RAhG/2UGf+MUBaJ8mtTlNzgmeuNOcRNd4bmbz3OicE
         1odf8HmPtovINdv3wlOPbaQSkWqj5fX0X7OPJdcaZXLO7Ato69DiQY+oJwpnlvcdVd+4
         q9PGZUqk1h3Z5/wzTTTSefnBDRhmdsVFWTBBjJAgw5Ter1JA99q56dHORhobk0oDQXlY
         c7vu/7eruKjcj8tPfolv9GAUicuV3LfNUiYS9ciFCiJOd7yzBbW+5xEGe4+UlRpiwz98
         +n8A==
X-Gm-Message-State: ACrzQf0BTkwzZYDAfGTvlBFYgQ6WAjc9NhkpxLDywFJ+MED1nIzrUa01
        NKG/l8dkr3lBDzFr4/zOVhQLfz0xZ+nA
X-Google-Smtp-Source: AMsMyM5t0U7P8BEhY2X9jqqV+oFtJTEnd/5oerb6BW5BVAAOZBz/FMM4/sXo/NGticgGEmBMQqFZBg==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr40598415pjs.222.1667377982313;
        Wed, 02 Nov 2022 01:33:02 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00176acd80f69sm7682256pln.102.2022.11.02.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:33:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] cpufreq: qcom-hw: Use cached dev pointer in probe()
Date:   Wed,  2 Nov 2022 14:02:38 +0530
Message-Id: <20221102083239.53826-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
References: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances of dev pointer used in the probe() function.
Instead of referencing pdev->dev all the time, let's use a cached dev
pointer to simplify the code.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 1842e9facaa1..bc991ef10c05 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -604,18 +604,19 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device *cpu_dev;
 	struct clk *clk;
 	int ret, i, num_domains;
 
-	clk = clk_get(&pdev->dev, "xo");
+	clk = clk_get(dev, "xo");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	xo_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	clk = clk_get(&pdev->dev, "alternate");
+	clk = clk_get(dev, "alternate");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -634,11 +635,11 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
-	num_domains = of_property_count_elems_of_size(pdev->dev.of_node, "reg", sizeof(u32) * 4);
+	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * 4);
 	if (num_domains <= 0)
 		return num_domains;
 
-	qcom_cpufreq.data = devm_kzalloc(&pdev->dev, sizeof(struct qcom_cpufreq_data) * num_domains,
+	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
 					 GFP_KERNEL);
 	if (!qcom_cpufreq.data)
 		return -ENOMEM;
@@ -650,7 +651,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (IS_ERR(base)) {
-			dev_err(&pdev->dev, "Failed to map resource %pR\n", res);
+			dev_err(dev, "Failed to map resource %pR\n", res);
 			return PTR_ERR(base);
 		}
 
@@ -660,9 +661,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
-		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+		dev_err(dev, "CPUFreq HW driver failed to register\n");
 	else
-		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
+		dev_dbg(dev, "QCOM CPUFreq HW driver initialized\n");
 
 	return ret;
 }
-- 
2.25.1

