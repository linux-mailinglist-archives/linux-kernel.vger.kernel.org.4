Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3F66650B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjAKUvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAKUvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:51:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313663D9E2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:51:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bf43so25389224lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZVlKUhfc1i9OxoybHYHtIAo0AKIGGWqWJ2gIpTCzIM=;
        b=kosm8WJAxa8BwkKSfwwtXUZBKOjT5y21Dgn4xSAyNiKMjLtvJebhittim222BCFcDz
         +PtlOyLO9W/2+Mb+X9B+wjU85DUUwuF4LbU8QCpKkV65w+Amx3YkO3E9eksvnRagUuP5
         grlIxhZX8Tfily2HjjxLjkWz+xukRrh1Ai8XaxW5hzoxisjtqtIZ3UqSf5Ge4csjcpfc
         bSpx9kGbwb+p5HFthnYHqDFbGt3d3eqshaI/Q4yybHvSEdUuPADE6GcMSYmNq8PXE0NH
         7EVIhinKn4SIi3n0OL6ber55n5YD+zSKHl3DrGDj+k/xV5rmFn1k16x0t6Mjw5Zv1YzQ
         y3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZVlKUhfc1i9OxoybHYHtIAo0AKIGGWqWJ2gIpTCzIM=;
        b=8HjpCrNeGw+7CenXVxdDio7jej1RNSIuoXhNHLRUQMbTy4G2hHwIkCYdnuAAY5gNXs
         Kf165AfQHVvLvsIGwy83VhJNgvqprDmMdj80Dk6BCGmIcSY/vAIMoBoBJlYRlkqkih+H
         gCCb1Rlhh+I74ONibgqj+YbXEnMGQtGZwGZJsWzpkZtoZ1MqtnDOoTzJ9L1kAC0l40nD
         R4a41uwrs7I/ESuWPit4T/QCsz4Ot7NGqsSHSHOAp+ckJKmJuiLgsJ99Mq9xpeoBewgc
         oGW9v7l19Bjyxuzoc+R/d5C6lC1iep9mfx1TIuOI6IGxURXPZdFhFvC2YJ8bZk8g/d4f
         C9ow==
X-Gm-Message-State: AFqh2kqCMgLUOBrGN2bEeZ2344vfR/Seie5qq2oP7QsZewi27LLif2p9
        qGTiDQy2tbzb/uTwqVe7RGI2SQ==
X-Google-Smtp-Source: AMrXdXtL5bdHP+x3aZHb+F3kZF22VcBLLNZjyCGBmsJj4EEn23qL9UCqWMZuOG9S4FRGVBOZppIAKw==
X-Received: by 2002:a19:f514:0:b0:4b5:61e8:8934 with SMTP id j20-20020a19f514000000b004b561e88934mr18782486lfb.64.1673470292525;
        Wed, 11 Jan 2023 12:51:32 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b004cc9042c9cfsm928888lfr.158.2023.01.11.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:51:31 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: qcom-hw: Ensure only freq-domain regs are counted in num_domains
Date:   Wed, 11 Jan 2023 21:51:25 +0100
Message-Id: <20230111205125.1860858-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
References: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for CPRh-aware OSM programming, change the probe
function so that we determine the number of frequency domains by
counting the number of reg-names entries that begin with
"freq-domain", as the aforementioned changes require introduction
of non-freq-domain register spaces.

Fixes: 1a6a8b0080b0 ("cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2")
Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9505a812d6a1..89d5ed267399 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -651,8 +651,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *soc_node;
 	struct device *cpu_dev;
+	const char *reg_name;
 	struct clk *clk;
-	int ret, i, num_domains, reg_sz;
+	int ret, i, num_reg_names, num_domains = 0;
 
 	clk = clk_get(dev, "xo");
 	if (IS_ERR(clk))
@@ -684,19 +685,32 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (!soc_node)
 		return -EINVAL;
 
-	ret = of_property_read_u32(soc_node, "#address-cells", &reg_sz);
-	if (ret)
+	num_reg_names = of_property_count_strings(dev->of_node, "reg-names");
+	if (num_reg_names <= 0) {
+		ret = num_reg_names ? num_reg_names : -ENODATA;
 		goto of_exit;
+	}
 
-	ret = of_property_read_u32(soc_node, "#size-cells", &i);
-	if (ret)
-		goto of_exit;
+	for (i = 0; i < num_reg_names; i++) {
+		ret = of_property_read_string_index(dev->of_node, "reg-names", i, &reg_name);
+		if (ret < 0)
+			goto of_exit;
 
-	reg_sz += i;
+		/*
+		 * Check if the i-th reg is a freq-domain base, no need to add 1
+		 * more byte for idx, as sizeof counts \0 whereas strlen does not.
+		 */
+		if (strlen(reg_name) == sizeof("freq-domain")) {
+			/* Check if this reg-name begins with "freq-domain" */
+			if (!strncmp(reg_name, "freq-domain", sizeof("freq-domain") - 1))
+				num_domains++;
+		}
+	}
 
-	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * reg_sz);
-	if (num_domains <= 0)
-		return num_domains;
+	if (num_domains <= 0) {
+		ret = -EINVAL;
+		goto of_exit;
+	}
 
 	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
 					 GFP_KERNEL);
-- 
2.39.0

