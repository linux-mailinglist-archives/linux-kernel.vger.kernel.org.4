Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473BC63156E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKTRTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKTRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:19:10 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0C23168
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 09:19:09 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wnyBohc3Ubw2uwnyFoEd9Y; Sun, 20 Nov 2022 18:19:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Nov 2022 18:19:07 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] cpufreq: tegra186: Use flexible array to simplify memory allocation
Date:   Sun, 20 Nov 2022 18:19:02 +0100
Message-Id: <f6b75a33df6f5fd94da3cfecb1e9e7590bf8cd37.1668963937.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
References: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flexible array to simplify memory allocation.
It saves some memory, avoids an indirection when reading the 'clusters'
array and removes some LoC.


Detailed explanation:
====================
Knowing that:
  - each devm_ allocation over-allocates 40 bytes for internal needs
  - Some rounding is done by the memory allocator on 8, 16, 32, 64, 96,
    128, 192, 256, 512, 1024, 2048, 4096, 8192 boundaries

and that:
  - sizeof(struct tegra186_cpufreq_data) = 24
  - sizeof(struct tegra186_cpufreq_cluster) = 16

Memory allocations in tegra186_cpufreq_probe() are:
  data:           (24 + 40) = 64 		      => 64 bytes
  data->clusters: (2 * 16 + 40) = 72     => 96 bytes
So a total of 160 bytes are allocated.
56 for the real need, 80 for internal uses and 24 are wasted.


If 'struct tegra186_cpufreq_data' is reordered so that 'clusters' is a
flexible array:
  - it saves one pointer in the structure
  - only one allocation is needed

So, only 96 bytes are allocated:
  16 + 2 * 16 + 40 = 88  => 96 bytes

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/cpufreq/tegra186-cpufreq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 6c88827f4e62..f98f53bf1011 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -65,8 +65,8 @@ struct tegra186_cpufreq_cluster {
 
 struct tegra186_cpufreq_data {
 	void __iomem *regs;
-	struct tegra186_cpufreq_cluster *clusters;
 	const struct tegra186_cpufreq_cpu *cpus;
+	struct tegra186_cpufreq_cluster clusters[];
 };
 
 static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
@@ -221,15 +221,12 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 	struct tegra_bpmp *bpmp;
 	unsigned int i = 0, err;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev,
+			    struct_size(data, clusters, TEGRA186_NUM_CLUSTERS),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->clusters = devm_kcalloc(&pdev->dev, TEGRA186_NUM_CLUSTERS,
-				      sizeof(*data->clusters), GFP_KERNEL);
-	if (!data->clusters)
-		return -ENOMEM;
-
 	data->cpus = tegra186_cpus;
 
 	bpmp = tegra_bpmp_get(&pdev->dev);
-- 
2.34.1

