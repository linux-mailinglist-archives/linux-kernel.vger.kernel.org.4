Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB66FE00D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbjEJOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjEJOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B7DD96;
        Wed, 10 May 2023 07:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5KpS5v5Dw9Vyqle+FIbwsqmYX0XKGM9gYCDlWDDvCqqak2y+L29f5EjCEMwHGXym7uxQNKCvcgVbus4VUkiAPenz0tbx1ERo5DB1/vqxXGQJjMLP2MjgEmmT9L0JK9HU/0opBIwiNeWog5/89qkBeV6vc8lyYCzFCVU0KDFFbQpJ5IWFBKtpFK2/wN67br3SQOhMXEN4X7ekp+7DOmbfIrRaeeWBmOy+ezfkZ+CUMKApKKlAqJ4Ps9Jyqxb3xL8EoHvGR89rfsNze7yKBK6aXIiuu/95AblRhhfe2Umwv8x6B68eVYr+lzwwp4THJzS0bnekrrlH4tLrNo4bo8ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+73DcCdZq2YYANSw7VdQ3E5WMxCn86IbJbCBCC3AI4=;
 b=kf2Oz+qSYTNs1wk4Vzl2ruY+mT4Tk8Gw/vM9U1DM/oKLguC0P5nJBFTfVPsrBYRtKuf0RNYq8B/ARz20KUftxkGULQgVooE7TXmwVTnZRVKH7CjlTykvN+P2/6y5W7IZkodQ3QAocbuOHKh1LJlvTAcVTnOMQel78I172jS+HjFKdpQ8ZUQ9h1iD6hcY6r54uOpC88UaNxW3r1kztuwcJvJAgwKVw7nOTaaDCJXrdPuEXVe7indCSKXN4MzdbyL8+7kfJyiChw3G3X2iDfLgAhluv5SYNdLMwemJKkjZwjgjqWQav2Jt3IoeWA5rrYv7A4dziOTBKfYKRnazPJbPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+73DcCdZq2YYANSw7VdQ3E5WMxCn86IbJbCBCC3AI4=;
 b=jK6KydWpgI1N5iK8iZn95vMd+mkhOlwr7n+8/E8qPwJH3rIvi87TFtK8PD7ESCLzuIGbCO2h3ahz+d7+knCihwDyPQESJNTQ/czg3WCwy7EPS/C1g7XCU1kS970EAvFWWUUzaU8DWrVUzer4UWd0pw9U7TVURH3YYLCdBoDiJvJSSCBOe8662cdUvVziW5w85UaSfj02uAFF1qd/YEnlf9A1pMKihPBi6VfKHiS4dd7O4dNfUklkOvq0Go9ucM1OTXfaDOWUlA1JDTWf4Q1VXR8ECdduZPT8HMFDlHK9/7Eof6Rq/G0aeXe+IQesg584M6TeBwSc5ffLcgw/IsqB5A==
Received: from MW4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:303:6a::21)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Wed, 10 May
 2023 14:23:37 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::1c) by MW4PR04CA0046.outlook.office365.com
 (2603:10b6:303:6a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 14:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.19 via Frontend Transport; Wed, 10 May 2023 14:23:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:23:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:23:25 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:23:23 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v3 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
Date:   Wed, 10 May 2023 17:22:48 +0300
Message-ID: <20230510142248.183629-7-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c5e5b0-07a3-4662-54e0-08db51622524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYNKKy5WwKKF0vqt8QlSP2dZqnfkPTO6svFsos1QXwnROaJQLARPvM7f6qmnE+/O8ViaO3jh9yE2LWDT4F6ZPtD8m4SzSzpWu+XUDWnFvm6C2cvvAzO8MGIU3xJV9HiJ8/1fW1ewYl7nRzAcR/6gWpmwgj+mFYpxLXnxMPx/nMS8FgBTkTbiioPP7BuysqgzsIoKjVmSdMnChEWn59o9PcG3IQJsLyV3VatJ4XPd3x61B4UAjR5+rMuoIks2TW2De18S4hsH+x+Zbu2IBvgR5h3rQsjOtcVpYVhCKZzrLEyZg7LZIQH8jCjmMVuUrI6BA1d3kiB+/7i6tvXNmen6s9p4FjAFZTIRQj/BPJWudnkX5CN5o5xKwi/vk1sYFePtS7uqb3JqzQeJkojZzAFYNac8PwIsuAEw3+NSrKUizEVl2i9TdR8KT+C11k8PAfvcQuSpId41knBhX5MboiFoHSgo8/D5Qj02IQ3Twbt9NozRNB9kxDNDqVQyI/+vzfZXW8ROzzTr/KssPQ3lWhwKsRYchvRqEFGX9wFWZEKjE6LgLSOFHxkocNpLD+S4ZgAyhn0EF6wa8Y2p07oSLDAaiP//McnPca7m3fDe9I0sJJGi24zhtkLZQAxHbEYWglhnMny6gvMEbUWvGbxUTTVo1nV69K4Vkw/bLUWg2Ai468wRUKwFGbGTTGkX5+48j1O+rUS41MsXHAO56IHUZBwcdQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(316002)(4326008)(478600001)(6666004)(6636002)(70206006)(54906003)(110136005)(70586007)(36756003)(86362001)(2616005)(7696005)(426003)(83380400001)(26005)(36860700001)(1076003)(107886003)(2906002)(40480700001)(356005)(5660300002)(8936002)(82310400005)(8676002)(41300700001)(82740400003)(7636003)(47076005)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:37.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5e5b0-07a3-4662-54e0-08db51622524
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for DRAM MRQ GSCs.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/firmware/tegra/bpmp-tegra186.c | 214 +++++++++++++++++--------
 drivers/firmware/tegra/bpmp.c          |   4 +-
 2 files changed, 153 insertions(+), 65 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
index 2e26199041cd..43e2563575fc 100644
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
@@ -13,12 +16,13 @@
 
 #include "bpmp-private.h"
 
+enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_RMEM };
+
 struct tegra186_bpmp {
 	struct tegra_bpmp *parent;
 
 	struct {
-		struct gen_pool *pool;
-		void __iomem *virt;
+		void *virt;
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
@@ -118,8 +128,8 @@ static int tegra186_bpmp_channel_init(struct tegra_bpmp_channel *channel,
 	queue_size = tegra_ivc_total_queue_size(message_size);
 	offset = queue_size * index;
 
-	iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);
-	iosys_map_set_vaddr_iomem(&tx, priv->tx.virt + offset);
+	iosys_map_set_vaddr_iomem(&rx, (void __iomem *)priv->rx.virt + offset);
+	iosys_map_set_vaddr_iomem(&tx, (void __iomem *)priv->tx.virt + offset);
 
 	err = tegra_ivc_init(channel->ivc, NULL, &rx, priv->rx.phys + offset, &tx,
 			     priv->tx.phys + offset, 1, message_size, tegra186_bpmp_ivc_notify,
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
2.34.1

