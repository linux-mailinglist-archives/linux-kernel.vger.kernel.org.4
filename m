Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6A3742A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjF2QCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF2QBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:01:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A83598;
        Thu, 29 Jun 2023 09:01:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc41398ebso234825e9.2;
        Thu, 29 Jun 2023 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688054496; x=1690646496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gsmv6hf2525Hm87eytBpP6IhRhbC+0TTOWS/M346Fc=;
        b=KQjpimQAniH1Yl2lpRpziQ7tpEh16m26TfOymSGWZEsEKeAvUtOcSE2fiS7n2lgGnR
         a5lqwyqZeFOcT3/yx6tAV656jMDHnlXjIQletIgLVN+H2vzUHVgXwjRAmdNDstv7M7sV
         ETHB//7pbMqUGrhb0t1BIhrIfWMIAgJ2touPpxkhYQPG6O7rJilToExMu+7I0yW/Aqpk
         QVMC/ZXg7C/lq4le1FDke/pJdXh0R493AvuuSNy0X8r/DA3uY7Vj0zJl0MgyVKM7Fn4Z
         viIuKtNH4oPguboU/OSSQPtvyL1h/ErGulOYypJ/tLW4Ei+Q8S9zT9hzqa/YQI+QRXZR
         pi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054496; x=1690646496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gsmv6hf2525Hm87eytBpP6IhRhbC+0TTOWS/M346Fc=;
        b=LQ2k4HbvEZoRmvtfWLyOOP2hjBnTpqZ8Fn4wWaxLySHadAvf98uYsxOWj0jqb6nJxp
         EmytM+XGLth7Bswm8sToa0drOlR4cdCzGdOoSSEJE/FQj8MvEej3Q+I6B0RyRfgnhXW4
         2RHVEzY7eAzjP2i9y9QCXSfvnVtnYXWnSEFxo5C7dw7jsULb8tX+l16uHmLEfvLTsCO1
         cQWxXGUcXS+/BjQljU31mARWit+QaQlq9XNrVC/Bjwaa8HQ8cgFGKX6m+OWSqSOM03pi
         ikF/G9TPo+wnHhmN/07y7Td9sAVpGaXYZM7uohBnm+nQfpR/b8C6NUxGWlp9ryAUJBV9
         DNzw==
X-Gm-Message-State: AC+VfDwDgO0dsiZDuGfHc7ZMsKkg68YtQh9pFMTl9CuTsV/LbJiOwXfX
        1wxTmajSEJjTZCUaR2CW+XU=
X-Google-Smtp-Source: ACHHUZ5m6CveLPuWx+vITbqDaN1hglhEj52VjJ6Cap/PhCKCLqBy8GiJoOvTCovLqVJD3lKi7/Hm6A==
X-Received: by 2002:a5d:4c49:0:b0:311:19f9:5824 with SMTP id n9-20020a5d4c49000000b0031119f95824mr26228985wrt.55.1688054496233;
        Thu, 29 Jun 2023 09:01:36 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c024500b003fbb00599e4sm5055826wmj.2.2023.06.29.09.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:01:35 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Date:   Thu, 29 Jun 2023 18:01:32 +0200
Message-ID: <20230629160132.768940-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
interconnect support in Tegra234"), the PCI driver on Tegra194 and later
requires an interconnect provider. However, a provider is currently only
exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
indefinitely.

Fix this by adding a dummy implementation on Tegra194. This allows nodes
to be provided to interconnect consumers, but doesn't do any bandwidth
accounting or frequency scaling.

Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 37 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c | 23 +-------------------
 include/soc/tegra/mc.h          |  3 +++
 4 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 4a750da1c12a..deb6e65b59af 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -755,6 +755,43 @@ const char *const tegra_mc_error_names[8] = {
 	[6] = "SMMU translation error",
 };
 
+struct icc_node *tegra_mc_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
+	struct icc_node *node;
+
+	list_for_each_entry(node, &mc->provider.nodes, node_list) {
+		if (node->id == spec->args[0])
+			return node;
+	}
+
+	/*
+	 * If a client driver calls devm_of_icc_get() before the MC driver
+	 * is probed, then return EPROBE_DEFER to the client driver.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int tegra_mc_icc_get(struct icc_node *node, u32 *average, u32 *peak)
+{
+	*average = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int tegra_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	return 0;
+}
+
+const struct tegra_mc_icc_ops tegra_mc_icc_ops = {
+	.xlate = tegra_mc_icc_xlate,
+	.aggregate = icc_std_aggregate,
+	.get_bw = tegra_mc_icc_get,
+	.set = tegra_mc_icc_set,
+};
+
 /*
  * Memory Controller (MC) has few Memory Clients that are issuing memory
  * bandwidth allocation requests to the MC interconnect provider. The MC
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index b2416ee3ac26..26035ac3a1eb 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1355,6 +1355,7 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.icc_ops = &tegra_mc_icc_ops,
 	.ch_intmask = 0x00000f00,
 	.global_intstatus_channel_shift = 8,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 78daa61ccd46..2fe8a61928e6 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -909,27 +909,6 @@ static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	return 0;
 }
 
-static struct icc_node*
-tegra234_mc_of_icc_xlate(struct of_phandle_args *spec, void *data)
-{
-	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
-	unsigned int cl_id = spec->args[0];
-	struct icc_node *node;
-
-	list_for_each_entry(node, &mc->provider.nodes, node_list) {
-		if (node->id != cl_id)
-			continue;
-
-		return node;
-	}
-
-	/*
-	 * If a client driver calls devm_of_icc_get() before the MC driver
-	 * is probed, then return EPROBE_DEFER to the client driver.
-	 */
-	return ERR_PTR(-EPROBE_DEFER);
-}
-
 static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
 {
 	*avg = 0;
@@ -939,7 +918,7 @@ static int tegra234_mc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *pea
 }
 
 static const struct tegra_mc_icc_ops tegra234_mc_icc_ops = {
-	.xlate = tegra234_mc_of_icc_xlate,
+	.xlate = tegra_mc_icc_xlate,
 	.aggregate = tegra234_mc_icc_aggregate,
 	.get_bw = tegra234_mc_icc_get_init_bw,
 	.set = tegra234_mc_icc_set,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index fc3001483e62..a5ef84944a06 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -175,6 +175,9 @@ struct tegra_mc_icc_ops {
 	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 };
 
+struct icc_node *tegra_mc_icc_xlate(struct of_phandle_args *spec, void *data);
+extern const struct tegra_mc_icc_ops tegra_mc_icc_ops;
+
 struct tegra_mc_ops {
 	/*
 	 * @probe: Callback to set up SoC-specific bits of the memory controller. This is called
-- 
2.41.0

