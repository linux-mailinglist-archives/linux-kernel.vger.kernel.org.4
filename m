Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB9609942
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJXEkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJXEkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:40:10 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4722BB13;
        Sun, 23 Oct 2022 21:39:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6E02E42508;
        Mon, 24 Oct 2022 04:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666586394; bh=yMbEwflzqPvq1z+7biOy/IUVCweTSxh7aHPaxBSZMtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yEf0FUNHoy/2ES74xJsxu/jKCPVa4yBrgjz9IPfCXBYFCKNRSovPXszbYdIumxaka
         eCS9xnqqCjB1QgtNkmaQ5yYshTfmfIrfG4qVhpFKj4+DAVrZ6WzpCT9nrHgnH4/EsD
         2ZQK652mihrJTpQ5luntG2RFPextkHcCVuWRTSFbetEXRHEKeF8b2vYOrJVHth6HD3
         I1cZBDD/xzVaBzVpNJHy/uOLzAYNDM3qmIiD9Hq3cFsKFtQtQPxfZXozRDG9Hxd1IV
         AJzBJw8nDyHsNplVP5xosYQSmaxDgDFHU+z9Xxv2sF0/RzGO/dq1++Zd8GqO159rrl
         EVIfkpLK/XTng==
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] cpufreq: Generalize of_perf_domain_get_sharing_cpumask phandle format
Date:   Mon, 24 Oct 2022 13:39:23 +0900
Message-Id: <20221024043925.25379-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024043925.25379-1-marcan@marcan.st>
References: <20221024043925.25379-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_perf_domain_get_sharing_cpumask currently assumes a 1-argument
phandle format, and directly returns the argument. Generalize this to
return the full of_phandle_args, so it can be used by drivers which use
other phandle styles (e.g. separate nodes). This also requires changing
the CPU sharing match to compare the full args structure.

Also, make sure to of_node_put(args.np) (the original code was leaking a
reference).

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 14 +++++++++-----
 include/linux/cpufreq.h               | 28 +++++++++++++++------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index f0e0a35c7f21..f80339779084 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -160,6 +160,7 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	struct mtk_cpufreq_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct of_phandle_args args;
 	void __iomem *base;
 	int ret, i;
 	int index;
@@ -168,11 +169,14 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	if (!data)
 		return -ENOMEM;
 
-	index = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
-						   "#performance-domain-cells",
-						   policy->cpus);
-	if (index < 0)
-		return index;
+	ret = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
+						 "#performance-domain-cells",
+						 policy->cpus, &args);
+	if (ret < 0)
+		return ret;
+
+	index = args.args[0];
+	of_node_put(args.np);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	if (!res) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d5595d57f4e5..6a94a6eaad27 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1110,10 +1110,10 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 }
 
 static inline int parse_perf_domain(int cpu, const char *list_name,
-				    const char *cell_name)
+				    const char *cell_name,
+				    struct of_phandle_args *args)
 {
 	struct device_node *cpu_np;
-	struct of_phandle_args args;
 	int ret;
 
 	cpu_np = of_cpu_device_node_get(cpu);
@@ -1121,41 +1121,44 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
 		return -ENODEV;
 
 	ret = of_parse_phandle_with_args(cpu_np, list_name, cell_name, 0,
-					 &args);
+					 args);
 	if (ret < 0)
 		return ret;
 
 	of_node_put(cpu_np);
 
-	return args.args[0];
+	return 0;
 }
 
 static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
-						     const char *cell_name, struct cpumask *cpumask)
+						     const char *cell_name, struct cpumask *cpumask,
+						     struct of_phandle_args *pargs)
 {
-	int target_idx;
 	int cpu, ret;
+	struct of_phandle_args args;
 
-	ret = parse_perf_domain(pcpu, list_name, cell_name);
+	ret = parse_perf_domain(pcpu, list_name, cell_name, pargs);
 	if (ret < 0)
 		return ret;
 
-	target_idx = ret;
 	cpumask_set_cpu(pcpu, cpumask);
 
 	for_each_possible_cpu(cpu) {
 		if (cpu == pcpu)
 			continue;
 
-		ret = parse_perf_domain(cpu, list_name, cell_name);
+		ret = parse_perf_domain(cpu, list_name, cell_name, &args);
 		if (ret < 0)
 			continue;
 
-		if (target_idx == ret)
+		if (pargs->np == args.np && pargs->args_count == args.args_count &&
+		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
 			cpumask_set_cpu(cpu, cpumask);
+
+		of_node_put(args.np);
 	}
 
-	return target_idx;
+	return 0;
 }
 #else
 static inline int cpufreq_boost_trigger_state(int state)
@@ -1185,7 +1188,8 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 }
 
 static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
-						     const char *cell_name, struct cpumask *cpumask)
+						     const char *cell_name, struct cpumask *cpumask,
+						     struct of_phandle_args *pargs)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.35.1

