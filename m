Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A06FF2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbjEKNYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjEKNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:24:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810C106E9;
        Thu, 11 May 2023 06:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROQxhfMUX2QuGIW8gfA+1A4O6OUD9QrPhUBDA20Y1SLfrwduz2YA8s9zJC3OJvpuqlK/RBvuSnUQRMq0QXLs1up7+1yXL8XOnaP1xca5vgg2JPnW55tfxqX9irH1nuJbCRJnme1lB2vIYGP9IU9yofITZrm2iNn7v9vQiaCqGVp0xZykNOW281yct/3TKYt5Qbd2Rp3OKcjpOeukTFTOQnQsP/lIlTLaypPBGsc+eFoWAw3bdNXyFWlopq5A0R+B6rLgGrNzCeFc9XeCUbbRheULPNMOysWCuJMNzpxDSQH1OHBfH671BJjvneHIGtSVXCtRHVd9PRJn6Uns49T3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyVTa1jWzql6wEoP6JxQCPR/nJU3bBPiVN1sBSEW2BY=;
 b=OWTqTxO9I+fsQv3StudsoiyTRISIWq1phSwSyDrXAyGVjEzKK9RdQpdkAbHuzaP04Hnl7ZL/GgrspZ3lx6EmLOJmQInpsdf5cbEbx89hHkZ3dnP8O1av4YcKEKnZg2G9rtdz7/WvhI/mWsnSB1GCdrNLXEbX7zREN9R5bDHRW7fxABBGWQU43XOUn2blCM3Dgsk05rjpOaJwXzVBtXI7hwpOTza53orFI1yRdb+EWaxv6LaEVcZ5dE34MF52oOKZgqEAcU4IQnX3gtsetTvzRIFfXaxWmUXGg+i7gJAj63SK0xxtNf5KqnGDSFortByS1Iup7p1czzJYOumxRBi3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyVTa1jWzql6wEoP6JxQCPR/nJU3bBPiVN1sBSEW2BY=;
 b=L4KW87dVlbTN7NnXjTSzCcs0/OVX1Xuyw8CQ2TkBfzLOJ6FYGdphGVc4IlIiK+YQAIpHYhXz6fgW0jFNl4BYodiSY2Hw8ju2M0KzsSWxjbUe6/fjDsAVMFL+/S8XMaIvzGO/gQsg0Kin9LiXJEszj7W+9VJrmoAg/aHVrtOt74jNp2l93DFY8wzNNxU1lajB1UILUBknMGdHJgqCtFUTRsXt70u948pLEk1GCyT9/tYb0MQ0uoiQ50RXqybiBdwyTBdyDRFTRIxL8gG674/Z4FNuAcqZ+2YWuIq8IFHVlO0vDh3DlQkfyc/i6Px2qolu7FTvmnkwfVvvdbXB6BYE1w==
Received: from DM6PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:40::48) by
 PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 13:22:03 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::d3) by DM6PR03CA0035.outlook.office365.com
 (2603:10b6:5:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22 via Frontend
 Transport; Thu, 11 May 2023 13:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 13:22:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:21:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:21:51 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:21:48 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>
CC:     <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>, <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
Date:   Thu, 11 May 2023 16:20:51 +0300
Message-ID: <20230511132048.1122075-7-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 056f5e2e-1e79-4e74-5269-08db5222b5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/j+vMRo6aBEJnlJ4ZBIsv8iPN6ykZVwYZN8UhKOh4jyUz1j5YO99WeLQg+n99B1hsiKb0OBSQF3x1ld98uGucZ9x0SmWII4IzCfbVOgU74SOB6w9hOfBra6MRzY1mBV0qhu/ZyzISqf5EJ6xUFk9ybnJpc+IRhjXQtyL+cLMGvYEeHH8wYupS+ZuCmv4Faa7rBF42Zsn3YQlXISjCb1pr20cRd/MdgnLTfnakIusCqPwUu5GwaPwbrffz+WOd8DfjoBX2OT3BSUUEU4HMTmTITgQlz7pSjqrj9IS8N7kgZqK1Nd2mrWQTJ8O4nEsyWEgDf9mKFftsBfq4wHO7+wCOTbBXCi5yXEXliGXJdnw+Z+0ayf8VEdzwfn8GD9md79mIxxluT3yjn1l1ZdT1cIAdplt+pOXXM/QuWrrddLirLyBiRWeznTkFuogzlKm+ije+KwmjhHv4D5zpb8AkH3TcLIYEkXE/D4WIYHFFJRzFzzqdi7d0CXqkJHtkcgwPw3W9cJcpnKbhyoUp4GStQObJtwIPaTG/vT/Pw7/+pZ+Qf/GWaHwVXkbvgSmhNks0mALW4MQZEJWNjEPFViyuFn1pq4DOcuipJFBlUrVRrVgzqHUeIPWTfJ8abN2EiG8TRONVDZ6H3YBW8Lr0bVP413e4MEAO3gNf3vRFmGHhyprWBxivAvzpugd8fpsT2jpb6Wh9A4y8iJqJCRJGw7y6+hvWPS20GDzAFZtJ2Czery4PqqF/U+lzSCPZykNDlsMvfd
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(54906003)(83380400001)(356005)(70586007)(316002)(7636003)(7696005)(47076005)(36756003)(186003)(6636002)(82740400003)(70206006)(4326008)(2906002)(426003)(41300700001)(6666004)(36860700001)(336012)(86362001)(110136005)(1076003)(26005)(82310400005)(40460700003)(2616005)(8676002)(8936002)(40480700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:22:03.6245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056f5e2e-1e79-4e74-5269-08db5222b5ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for DRAM MRQ GSCs.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/firmware/tegra/bpmp-tegra186.c | 232 ++++++++++++++++++-------
 drivers/firmware/tegra/bpmp.c          |   4 +-
 2 files changed, 168 insertions(+), 68 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
index 2e26199041cd..74575c9f0014 100644
--- a/drivers/firmware/tegra/bpmp-tegra186.c
+++ b/drivers/firmware/tegra/bpmp-tegra186.c
@@ -4,7 +4,9 @@
  */
 
 #include <linux/genalloc.h>
+#include <linux/io.h>
 #include <linux/mailbox_client.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <soc/tegra/bpmp.h>
@@ -13,12 +15,21 @@
 
 #include "bpmp-private.h"
 
+enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_DRAM };
+
 struct tegra186_bpmp {
 	struct tegra_bpmp *parent;
 
 	struct {
-		struct gen_pool *pool;
-		void __iomem *virt;
+		union {
+			struct {
+				void __iomem *virt;
+				struct gen_pool *pool;
+			} sram;
+			struct {
+				void *virt;
+			} dram;
+		};
 		dma_addr_t phys;
 	} tx, rx;
 
@@ -26,6 +37,8 @@ struct tegra186_bpmp {
 		struct mbox_client client;
 		struct mbox_chan *channel;
 	} mbox;
+
+	enum tegra_bpmp_mem_type type;
 };
 
 static inline struct tegra_bpmp *
@@ -118,8 +131,17 @@ static int tegra186_bpmp_channel_init(struct tegra_bpmp_channel *channel,
 	queue_size = tegra_ivc_total_queue_size(message_size);
 	offset = queue_size * index;
 
-	iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);
-	iosys_map_set_vaddr_iomem(&tx, priv->tx.virt + offset);
+	if (priv->type == TEGRA_SRAM) {
+		iosys_map_set_vaddr_iomem(&rx, priv->rx.sram.virt + offset);
+		iosys_map_set_vaddr_iomem(&tx, priv->tx.sram.virt + offset);
+	} else if (priv->type == TEGRA_DRAM) {
+		iosys_map_set_vaddr(&rx, priv->rx.dram.virt + offset);
+		iosys_map_set_vaddr(&tx, priv->tx.dram.virt + offset);
+	} else {
+		dev_err(bpmp->dev, "Inconsistent state %d of priv->type detected in %s\n",
+				priv->type, __func__);
+		return -EINVAL;
+	}
 
 	err = tegra_ivc_init(channel->ivc, NULL, &rx, priv->rx.phys + offset, &tx,
 			     priv->tx.phys + offset, 1, message_size, tegra186_bpmp_ivc_notify,
@@ -158,54 +180,135 @@ static void mbox_handle_rx(struct mbox_client *client, void *data)
 	tegra_bpmp_handle_rx(bpmp);
 }
 
-static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
+static void tegra186_bpmp_teardown_channels(struct tegra_bpmp *bpmp)
 {
-	struct tegra186_bpmp *priv;
-	unsigned int i;
-	int err;
+	size_t i;
+	struct tegra186_bpmp *priv = bpmp->priv;
 
-	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	for (i = 0; i < bpmp->threaded.count; i++) {
+		if (!bpmp->threaded_channels[i].bpmp)
+			continue;
 
-	bpmp->priv = priv;
-	priv->parent = bpmp;
+		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
+	}
+
+	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
+	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
 
-	priv->tx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
-	if (!priv->tx.pool) {
+	if (priv->type == TEGRA_SRAM) {
+		gen_pool_free(priv->tx.sram.pool, (unsigned long)priv->tx.sram.virt, 4096);
+		gen_pool_free(priv->rx.sram.pool, (unsigned long)priv->rx.sram.virt, 4096);
+	} else if (priv->type == TEGRA_DRAM) {
+		memunmap(priv->tx.dram.virt);
+	}
+}
+
+static int tegra186_bpmp_sram_init(struct tegra_bpmp *bpmp)
+{
+	int err;
+	struct tegra186_bpmp *priv = bpmp->priv;
+
+	priv->tx.sram.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
+	if (!priv->tx.sram.pool) {
 		dev_err(bpmp->dev, "TX shmem pool not found\n");
 		return -EPROBE_DEFER;
 	}
 
-	priv->tx.virt = (void __iomem *)gen_pool_dma_alloc(priv->tx.pool, 4096, &priv->tx.phys);
-	if (!priv->tx.virt) {
+	priv->tx.sram.virt = (void __iomem *)gen_pool_dma_alloc(priv->tx.sram.pool, 4096,
+								&priv->tx.phys);
+	if (!priv->tx.sram.virt) {
 		dev_err(bpmp->dev, "failed to allocate from TX pool\n");
 		return -ENOMEM;
 	}
 
-	priv->rx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
-	if (!priv->rx.pool) {
+	priv->rx.sram.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
+	if (!priv->rx.sram.pool) {
 		dev_err(bpmp->dev, "RX shmem pool not found\n");
 		err = -EPROBE_DEFER;
 		goto free_tx;
 	}
 
-	priv->rx.virt = (void __iomem *)gen_pool_dma_alloc(priv->rx.pool, 4096, &priv->rx.phys);
-	if (!priv->rx.virt) {
+	priv->rx.sram.virt = (void __iomem *)gen_pool_dma_alloc(priv->rx.sram.pool, 4096,
+								&priv->rx.phys);
+	if (!priv->rx.sram.virt) {
 		dev_err(bpmp->dev, "failed to allocate from RX pool\n");
 		err = -ENOMEM;
 		goto free_tx;
 	}
 
+	priv->type = TEGRA_SRAM;
+
+	return 0;
+
+free_tx:
+	gen_pool_free(priv->tx.sram.pool, (unsigned long)priv->tx.sram.virt, 4096);
+
+	return err;
+}
+
+static int tegra186_bpmp_dram_init(struct tegra_bpmp *bpmp)
+{
+	int err;
+	resource_size_t size;
+	struct resource res;
+	struct device_node *np;
+	struct tegra186_bpmp *priv = bpmp->priv;
+
+	np = of_parse_phandle(bpmp->dev->of_node, "memory-region", 0);
+	if (!np)
+		return -ENOENT;
+
+	err = of_address_to_resource(np, 0, &res);
+	if (err) {
+		dev_warn(bpmp->dev,  "Parsing memory region returned: %d\n", err);
+		return -EINVAL;
+	}
+
+	size = resource_size(&res);
+	if (size < SZ_8K) {
+		dev_warn(bpmp->dev,  "DRAM region must be larger than 8 KiB\n");
+		return -EINVAL;
+	}
+
+	priv->tx.phys = res.start;
+	priv->rx.phys = res.start + SZ_4K;
+
+	priv->tx.dram.virt = memremap(priv->tx.phys, size, MEMREMAP_WC);
+	if (priv->tx.dram.virt == NULL) {
+		dev_warn(bpmp->dev,  "DRAM region mapping failed\n");
+		return -EINVAL;
+	}
+	priv->rx.dram.virt = priv->tx.dram.virt + SZ_4K;
+	priv->type = TEGRA_DRAM;
+
+	return 0;
+}
+
+static int tegra186_bpmp_setup_channels(struct tegra_bpmp *bpmp)
+{
+	int err;
+	size_t i;
+	struct tegra186_bpmp *priv = bpmp->priv;
+
+	priv->type = TEGRA_INVALID;
+
+	err = tegra186_bpmp_dram_init(bpmp);
+	if (err == -ENOENT)
+		err = tegra186_bpmp_sram_init(bpmp);
+	if (err < 0)
+		return err;
+
 	err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
 					 bpmp->soc->channels.cpu_tx.offset);
 	if (err < 0)
-		goto free_rx;
+		return err;
 
 	err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
 					 bpmp->soc->channels.cpu_rx.offset);
-	if (err < 0)
-		goto cleanup_tx_channel;
+	if (err < 0) {
+		tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
+		return err;
+	}
 
 	for (i = 0; i < bpmp->threaded.count; i++) {
 		unsigned int index = bpmp->soc->channels.thread.offset + i;
@@ -213,9 +316,42 @@ static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
 		err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
 						 bpmp, index);
 		if (err < 0)
-			goto cleanup_channels;
+			break;
 	}
 
+	if (err < 0)
+		tegra186_bpmp_teardown_channels(bpmp);
+
+	return err;
+}
+
+static void tegra186_bpmp_reset_channels(struct tegra_bpmp *bpmp)
+{
+	size_t i;
+
+	tegra186_bpmp_channel_reset(bpmp->tx_channel);
+	tegra186_bpmp_channel_reset(bpmp->rx_channel);
+
+	for (i = 0; i < bpmp->threaded.count; i++)
+		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
+}
+
+static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
+{
+	int err;
+	struct tegra186_bpmp *priv;
+
+	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	bpmp->priv = priv;
+	priv->parent = bpmp;
+
+	err = tegra186_bpmp_setup_channels(bpmp);
+	if (err < 0)
+		return err;
+
 	/* mbox registration */
 	priv->mbox.client.dev = bpmp->dev;
 	priv->mbox.client.rx_callback = mbox_handle_rx;
@@ -226,63 +362,27 @@ static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
 	if (IS_ERR(priv->mbox.channel)) {
 		err = PTR_ERR(priv->mbox.channel);
 		dev_err(bpmp->dev, "failed to get HSP mailbox: %d\n", err);
-		goto cleanup_channels;
+		tegra186_bpmp_teardown_channels(bpmp);
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
+	tegra186_bpmp_teardown_channels(bpmp);
 }
 
 static int tegra186_bpmp_resume(struct tegra_bpmp *bpmp)
 {
-	unsigned int i;
-
-	/* reset message channels */
-	tegra186_bpmp_channel_reset(bpmp->tx_channel);
-	tegra186_bpmp_channel_reset(bpmp->rx_channel);
-
-	for (i = 0; i < bpmp->threaded.count; i++)
-		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
+	tegra186_bpmp_reset_channels(bpmp);
 
 	return 0;
 }
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

