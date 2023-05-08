Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9E06FAFFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjEHM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjEHM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:29:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCE37601;
        Mon,  8 May 2023 05:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTIIGI5eh4+njvwMlPBBH7c+RtG6jlPEV2QkJQC9g7zQRK82dH6OJVmKVOWVx1uwZ6Fcu3hjD2/EIwywEBKkIIcrcX/hN3cwE/4NrhuEQjN2e9nmcb6a1WiOxlSXTv40CI1GxC+CXUYNohGSqnfjHuf8yRalg1U14Cc+xeZ33Q3EM50jnJylbZN6zyeLuEutHLQVKumZxcrY+0QDFmjYj8aFRGl9Ve90ETwcfnkJhqxMIawvYhbXJTo0okIpwc9jvx2MJrx8sYHGh+nduzlAGCG5pSba+UIHIa2Y5B1xV/5LJscWW/jux1nwN0E7syXRw6mWgWQFEV3p8oXDAIMUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WP0nIrW0puSZZb0FzvEsxvFWz7wvg3IdKUl5/vBVps=;
 b=bQq2SOh9nB/V77Gah9ocdV9r5LfpPEa1ZpAGYhD/hgOZUpWrGF30uT8rWnpTTmlkhygNCYAuEyUaupXz8MVSWwgT3SRC8JE0KtK4hjEF3yWglwhRyeybyuSZHppKlDOhB5ZAMW2csoreg1KIfo7d50iNCP4G7sCjOa8YD1Vdw8CI7BvCAOVLXk2+PUy3wEt1puTWLW5tEvPoJt/t/aWebNccMmw3DVXN1DlbPCGwHuxlzqeqvMZjoToJGTe8XlH+hokxeEK+YkXS0i/GUmVit3eCqG+4JLEa7CBte85DoRrWWUY11lE5XTq24gdEIPFxgBxnweayfLsdtAn2WEbKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WP0nIrW0puSZZb0FzvEsxvFWz7wvg3IdKUl5/vBVps=;
 b=tAiPMG1igM6oIm0AbLWeYogJ40NtqXU1buWGuxn7HsKJcqn1ujrNqyjDYbVfzztn7uCiyVXJ9ICg64UqCwlWfSQK5ENKSM+cX5nsrhZxT9tm5FM6aN7JfLPOsvPtSDM8ybClchqYJj8j3S/4W+wUztf2PY+LNFzdOZBOQccrcRvP93XwyCMrhSgproZUky8ISIuM0pZaCR3ckpWzsCQISTSo0YwjVl7CIUm7ptzVfF6/pcOGGb5/t2w7+qwMnxNJyXWM3AgZjrU5jSyJ3w6QzN0A1TtMAl2upoFNoNcNSEonDcH6ZBabdz/7dAZblMNGafi+8r1ADyhUYqpcFsAZJw==
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:28:46 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::33) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Mon, 8 May 2023 12:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 12:28:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 05:28:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 05:28:35 -0700
Received: from mallet.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 05:28:33 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH 5/5] firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
Date:   Mon, 8 May 2023 15:20:54 +0300
Message-ID: <20230508122048.99953-6-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508122048.99953-1-pdeschrijver@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: afd4eac4-0093-4879-ebf7-08db4fbfc4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifgF48vNxunyLoiMb8HVwo8Q57bMkA/CUrk5Y5HtU7DGqwiKWez6kJSElbOvG1exzEL0qOIlbf03c+34nUVSialEmNpNJ544XElYq7e7Jr5T8dTGXJtMMzdGYedI2P2N/jo0FLobeH56ye7WFSiroLNv2ak1NoG4p/ZGB60F95w8dq7hj/j+dc9DwYyOK4rbrYDnDwtyk18KRPNZNjey+F/Pj/E75TzFTQv/VK/t26wQNWE/eIKQEg+RrU54pARTuAV+0Koyu6gcVYp5zfQWTwjX4lbvk44jiHBGteniITCNb1L8n5cQKMa0Y18zkwKiR7a8UfLAHZ+I+K03zMSQkgWu/K6cCfxLAkp5Ge9uXZu8DPtb/Oz4l/nLS/SpIajRBclwPUbf4N7HsOLOK8A1H6VST7FCnmrGlPtpv8+Jtf8K7poY5TBIy12PpEcIfNfm9vBrn2muMBDyW9Qw2olU4KsH38fImejaTcT2mkAdFr51ECu4TaK4YdqLpO5o3ZmP5hnzDY4bJ8ip14/xRMRHueJTc3Z2YLGIhJAHTilirGqtWR+QiDeePXRU3srqYvIOC8cjF3UjGwps8bGWwQWI0MUpJBQYAnVhXga4HRsALNcLo6e5MHc+8w+c+gflyZt3m3fSBThW1ujnziXoBBVevH87+ePwGjheylQLHCotEX0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(86362001)(36756003)(6666004)(316002)(110136005)(54906003)(6636002)(4326008)(70586007)(7696005)(70206006)(478600001)(82310400005)(40480700001)(5660300002)(8676002)(2906002)(8936002)(356005)(41300700001)(7636003)(82740400003)(186003)(107886003)(36860700001)(26005)(1076003)(47076005)(336012)(83380400001)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:28:46.0772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd4eac4-0093-4879-ebf7-08db4fbfc4c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for DRAM MRQ GSCs.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/firmware/tegra/bpmp-tegra186.c | 208 ++++++++++++++++++-------
 drivers/firmware/tegra/bpmp.c          |   4 +-
 2 files changed, 150 insertions(+), 62 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
index 2e26199041cd..000acf0fe183 100644
--- a/drivers/firmware/tegra/bpmp-tegra186.c
+++ b/drivers/firmware/tegra/bpmp-tegra186.c
@@ -4,8 +4,11 @@
  */
 
 #include <linux/genalloc.h>
+#include <linux/io.h>
 #include <linux/mailbox_client.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/range.h>
 
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
@@ -13,11 +16,12 @@
 
 #include "bpmp-private.h"
 
+enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_RMEM };
+
 struct tegra186_bpmp {
 	struct tegra_bpmp *parent;
 
 	struct {
-		struct gen_pool *pool;
 		void __iomem *virt;
 		dma_addr_t phys;
 	} tx, rx;
@@ -26,6 +30,12 @@ struct tegra186_bpmp {
 		struct mbox_client client;
 		struct mbox_chan *channel;
 	} mbox;
+
+	struct {
+		struct gen_pool *tx, *rx;
+	} sram;
+
+	enum tegra_bpmp_mem_type type;
 };
 
 static inline struct tegra_bpmp *
@@ -158,64 +168,171 @@ static void mbox_handle_rx(struct mbox_client *client, void *data)
 	tegra_bpmp_handle_rx(bpmp);
 }
 
-static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
+static void tegra186_bpmp_channel_deinit(struct tegra_bpmp *bpmp)
+{
+	int i;
+	struct tegra186_bpmp *priv = bpmp->priv;
+
+	for (i = 0; i < bpmp->threaded.count; i++) {
+		if (!bpmp->threaded_channels[i].bpmp)
+			continue;
+
+		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
+	}
+
+	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
+	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
+
+	if (priv->type == TEGRA_SRAM) {
+		gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
+		gen_pool_free(priv->sram.rx, (unsigned long)priv->rx.virt, 4096);
+	} else if (priv->type == TEGRA_RMEM) {
+		memunmap(priv->tx.virt);
+	}
+}
+
+static int tegra186_bpmp_channel_setup(struct tegra_bpmp *bpmp)
 {
-	struct tegra186_bpmp *priv;
 	unsigned int i;
 	int err;
 
-	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
+					 bpmp->soc->channels.cpu_tx.offset);
+	if (err < 0)
+		return err;
 
-	bpmp->priv = priv;
-	priv->parent = bpmp;
+	err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
+					 bpmp->soc->channels.cpu_rx.offset);
+	if (err < 0) {
+		tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
+		return err;
+	}
+
+	for (i = 0; i < bpmp->threaded.count; i++) {
+		unsigned int index = bpmp->soc->channels.thread.offset + i;
 
-	priv->tx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
-	if (!priv->tx.pool) {
+		err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
+						 bpmp, index);
+		if (err < 0)
+			break;
+	}
+
+	if (err < 0)
+		tegra186_bpmp_channel_deinit(bpmp);
+
+	return err;
+}
+
+static void tegra186_bpmp_reset_channels(struct tegra_bpmp *bpmp)
+{
+	unsigned int i;
+
+	tegra186_bpmp_channel_reset(bpmp->tx_channel);
+	tegra186_bpmp_channel_reset(bpmp->rx_channel);
+
+	for (i = 0; i < bpmp->threaded.count; i++)
+		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
+}
+
+static int tegra186_bpmp_sram_init(struct tegra_bpmp *bpmp)
+{
+	int err;
+	struct tegra186_bpmp *priv = bpmp->priv;
+
+	priv->sram.tx = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
+	if (!priv->sram.tx) {
 		dev_err(bpmp->dev, "TX shmem pool not found\n");
 		return -EPROBE_DEFER;
 	}
 
-	priv->tx.virt = (void __iomem *)gen_pool_dma_alloc(priv->tx.pool, 4096, &priv->tx.phys);
+	priv->tx.virt = gen_pool_dma_alloc(priv->sram.tx, 4096, &priv->tx.phys);
 	if (!priv->tx.virt) {
 		dev_err(bpmp->dev, "failed to allocate from TX pool\n");
 		return -ENOMEM;
 	}
 
-	priv->rx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
-	if (!priv->rx.pool) {
+	priv->sram.rx = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
+	if (!priv->sram.rx) {
 		dev_err(bpmp->dev, "RX shmem pool not found\n");
 		err = -EPROBE_DEFER;
 		goto free_tx;
 	}
 
-	priv->rx.virt = (void __iomem *)gen_pool_dma_alloc(priv->rx.pool, 4096, &priv->rx.phys);
+	priv->rx.virt = gen_pool_dma_alloc(priv->sram.rx, 4096, &priv->rx.phys);
 	if (!priv->rx.virt) {
 		dev_err(bpmp->dev, "failed to allocate from RX pool\n");
 		err = -ENOMEM;
 		goto free_tx;
 	}
 
-	err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
-					 bpmp->soc->channels.cpu_tx.offset);
-	if (err < 0)
-		goto free_rx;
+	priv->type = TEGRA_SRAM;
 
-	err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
-					 bpmp->soc->channels.cpu_rx.offset);
-	if (err < 0)
-		goto cleanup_tx_channel;
+	return 0;
 
-	for (i = 0; i < bpmp->threaded.count; i++) {
-		unsigned int index = bpmp->soc->channels.thread.offset + i;
+free_tx:
+	gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
 
-		err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
-						 bpmp, index);
+	return err;
+}
+
+static enum tegra_bpmp_mem_type tegra186_bpmp_dram_init(struct tegra_bpmp *bpmp)
+{
+	int err;
+	struct resource res;
+	struct device_node *np;
+	struct tegra186_bpmp *priv = bpmp->priv;
+
+	np = of_parse_phandle(bpmp->dev->of_node, "memory-region", 0);
+	if (!np)
+		return TEGRA_INVALID;
+
+	err = of_address_to_resource(np, 0, &res);
+	if (err) {
+		dev_warn(bpmp->dev,  "Parsing memory region returned: %d\n", err);
+		return TEGRA_INVALID;
+	}
+
+	if ((res.end - res.start + 1) < 0x2000) {
+		dev_warn(bpmp->dev,  "DRAM region less than 0x2000 bytes\n");
+		return TEGRA_INVALID;
+	}
+
+	priv->tx.phys = res.start;
+	priv->rx.phys = res.start + 0x1000;
+
+	priv->tx.virt = memremap(priv->tx.phys, res.end - res.start + 1, MEMREMAP_WC);
+	if (priv->tx.virt == NULL) {
+		dev_warn(bpmp->dev,  "DRAM region mapping failed\n");
+		return TEGRA_INVALID;
+	}
+	priv->rx.virt = priv->tx.virt + 0x1000;
+
+	return TEGRA_RMEM;
+}
+
+static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
+{
+	struct tegra186_bpmp *priv;
+	int err;
+
+	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	bpmp->priv = priv;
+	priv->parent = bpmp;
+
+	priv->type = tegra186_bpmp_dram_init(bpmp);
+	if (priv->type == TEGRA_INVALID) {
+		err = tegra186_bpmp_sram_init(bpmp);
 		if (err < 0)
-			goto cleanup_channels;
+			return err;
 	}
 
+	err = tegra186_bpmp_channel_setup(bpmp);
+	if (err < 0)
+		return err;
+
 	/* mbox registration */
 	priv->mbox.client.dev = bpmp->dev;
 	priv->mbox.client.rx_callback = mbox_handle_rx;
@@ -226,51 +343,22 @@ static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
 	if (IS_ERR(priv->mbox.channel)) {
 		err = PTR_ERR(priv->mbox.channel);
 		dev_err(bpmp->dev, "failed to get HSP mailbox: %d\n", err);
-		goto cleanup_channels;
+		tegra186_bpmp_channel_deinit(bpmp);
+		return err;
 	}
 
-	tegra186_bpmp_channel_reset(bpmp->tx_channel);
-	tegra186_bpmp_channel_reset(bpmp->rx_channel);
-
-	for (i = 0; i < bpmp->threaded.count; i++)
-		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
+	tegra186_bpmp_reset_channels(bpmp);
 
 	return 0;
-
-cleanup_channels:
-	for (i = 0; i < bpmp->threaded.count; i++) {
-		if (!bpmp->threaded_channels[i].bpmp)
-			continue;
-
-		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
-	}
-
-	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
-cleanup_tx_channel:
-	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
-free_rx:
-	gen_pool_free(priv->rx.pool, (unsigned long)priv->rx.virt, 4096);
-free_tx:
-	gen_pool_free(priv->tx.pool, (unsigned long)priv->tx.virt, 4096);
-
-	return err;
 }
 
 static void tegra186_bpmp_deinit(struct tegra_bpmp *bpmp)
 {
 	struct tegra186_bpmp *priv = bpmp->priv;
-	unsigned int i;
 
 	mbox_free_channel(priv->mbox.channel);
 
-	for (i = 0; i < bpmp->threaded.count; i++)
-		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
-
-	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
-	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
-
-	gen_pool_free(priv->rx.pool, (unsigned long)priv->rx.virt, 4096);
-	gen_pool_free(priv->tx.pool, (unsigned long)priv->tx.virt, 4096);
+	tegra186_bpmp_channel_deinit(bpmp);
 }
 
 static int tegra186_bpmp_resume(struct tegra_bpmp *bpmp)
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 8b5e5daa9fae..17bd3590aaa2 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -735,6 +735,8 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 	if (!bpmp->threaded_channels)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, bpmp);
+
 	err = bpmp->soc->ops->init(bpmp);
 	if (err < 0)
 		return err;
@@ -758,8 +760,6 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "firmware: %.*s\n", (int)sizeof(tag), tag);
 
-	platform_set_drvdata(pdev, bpmp);
-
 	err = of_platform_default_populate(pdev->dev.of_node, NULL, &pdev->dev);
 	if (err < 0)
 		goto free_mrq;
-- 
2.40.0

