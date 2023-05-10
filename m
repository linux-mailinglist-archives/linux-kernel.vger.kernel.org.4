Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3336C6FDCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbjEJLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbjEJLik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:38:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269CAC;
        Wed, 10 May 2023 04:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UznhiHq1srf4Qt5XxRtMxxDmSJ9g1UMsbXwaFySFyUL7UUlszln+w/XyT6acvj50dAfD0nkpurGUt+MMEzzzLLBF8HN7bp4yO+a/rNEFvbn4OEwR9NyistXRpqSUcqzwd/wFC0PpvXI36K3VWpWVCBmE/hxtvez/R1hVTP/Cz/+XO7KIn3QGRG7LnZAQeZMDec3AS9v1jQ9y8WHczT1UYQChPgldhZ4uoCKeWQqlLhaFNKLkoL5FRqtTK2bnp875bqBewvlBZmFCrfc1MrrO1unbk9VZuTb/bw7naonhcQV3KPMATdmPPDb+Lj+pfxHiIydQyQ3xxwXOhaMT3Hc90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+73DcCdZq2YYANSw7VdQ3E5WMxCn86IbJbCBCC3AI4=;
 b=IUf2z3MWiFJCH9QM2WEC671CiVnC9AmQjpadQWSEkldTZnzNIh2uAMgEnQBH0cAKEW+5iCYaB3WUp7oIKkP6HEPT65hSQLR45rly/c0fn1Ki9oxxJ5IxVucI1JTlHZiu6H5eZYF6sVihuhUQCgxYduYpfe8XmqOh0q05305fa/4Kejqfstny01pCjKKiMTy/j330hUj9d5ISElGJ2P8ZT8PvajzKZr+YWc5kwrirKV0BA330dmgAT6hrARZldwo7vZV3P8n8LXdJIw1GSO1YNVCoUuuTCAyR/3/z+2pC69fm4ejsFh10ny3S9sfrOHKcJ0tdeIBCykT8Fl6YtI/OCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+73DcCdZq2YYANSw7VdQ3E5WMxCn86IbJbCBCC3AI4=;
 b=JVAziJb1RcWdgVM7Y8vFyqCfC6ERizDXVzPgk+XHLDJob5StTveyGeazXwXoA//KxkI8xLhe/tiyp6PwHPNshIHdypyW2tOnzsYx+N+YXLq7CpIEzUX+WBCkhWjzGEiVvtMfq48wjWfxgDtVZVuvmer1wlvVF2JgpYZV7/q2R9El5d7R1MXT6aboL5KXTw4a4bEp+jigfUtLvnAlzJbFP7Yf7FUBh/5g0Pk81BQcS4mg+3mWMbWExEWVKpkxvju3tkOzWQoMEkd/36PAB2VbXN9MZ85UdMvEfyisOVNXzWoBthfrLpOlyXQ7oZ8Nh8nbau2iBfEm8TXO4n+C81hiNA==
Received: from BN9PR03CA0917.namprd03.prod.outlook.com (2603:10b6:408:107::22)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Wed, 10 May
 2023 11:38:23 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::aa) by BN9PR03CA0917.outlook.office365.com
 (2603:10b6:408:107::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 11:38:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:38:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:38:08 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:38:05 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: [PATCH v2 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
Date:   Wed, 10 May 2023 14:31:36 +0300
Message-ID: <20230510113129.4167493-7-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c07478e-1fee-4d70-1854-08db514b0f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mF9FBREuGlQiICNv4qZo/KVasuSpksZFU5Pup4uX57OdCzSehJ9neXzd2uMM/Ms4atVr283Go29heQ46FwmzTxzGIJRpUaQEDAHeDejy1bP//mLKA5UvM7b24v2FhuKJfOfNcQMxMDSMqXw1SSmPaktKY5MehnJsZcSFEiMRJ+TKsDBCZj/fClK3elQiQb6QzhfSYzrl/vHIjMaIb7gMrKwcyxjAvzbnSOprN+6lIdg9zUXUgm20Zln56/7XXJxoNzE83yJd8cP10MXHimVBCwqSDMGJGvopvtjymXURkyeh47SgQSWRxON7QlsoJfPGOTWDAj7qjV4DTd1bUTP4cRBGfwWGGn0E/hG4OWxYcziWKGTMTWtpeSmQjr/CcD/zE84pNEMH1XtcK2M1SR/feO0ooCdDsh+fQWav9Yobr3Jas/AzEehJ3a1OKsQteXa65+/Jz2xx/cKZ02RK9lApZMa28usRDagywNOJOGVlLYY18COovFqqJ/jCmvOn//Pli3+cZ1RzoV4uDkQfE/7+l4gdik3PvgXyVo4XEhO1/zT/YTBCbPSVnPKd/GYYsdIP6DTDsKil6fr1T2FutzOqTGLrktbTD8nDMiRgza38z4w26AgvsVbb87eTG/Ybk7ebQtPZq232oA96aMcZestvxZt4/+DLXVZppNPEWlEmyoX/sd+z4y2yJpCS3whCQV7rR3v72u0f1BE9aK62wZpVBQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(82310400005)(6666004)(36756003)(336012)(426003)(47076005)(36860700001)(86362001)(40480700001)(7636003)(82740400003)(186003)(356005)(26005)(2616005)(40460700003)(107886003)(1076003)(7696005)(70206006)(110136005)(8936002)(2906002)(70586007)(54906003)(4326008)(41300700001)(6636002)(316002)(5660300002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:38:22.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c07478e-1fee-4d70-1854-08db514b0f9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
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

