Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0A602F06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJRO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJRO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:58:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1274DAC49;
        Tue, 18 Oct 2022 07:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcNWZwxufyzqhyexizxIE7aNN9l0NAmeOVgVGF2g7GNsIGXnrWQLERzz6w2I+9zq2Wu3XNcJWoPgs4dkP7Pm+LOR8vyr+tA1dX3udGXJ6niTa2uC68HtG6M4IST+r6KeogAm61+GugsDdzm7W7xQHTnE4otq8yR2yKTAvAEcVMxz+PddGNZJoQ6d7r7IVUWm1Y7oF21HGx5ZcsCPP0fLqzBTGlPCs/TmW0DYQSI16T9YCsCa8PTlaETydZD2PLHM4APkdfoAJ/qLiQdG4hHR91ZW3zLUy12+Int2dgJs931p7pq/9qyEPMmGKBHPtOVAMLOv24WQ8JlD/2llzDX9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNQJMUWdUyNpksAtq1QU0JbiYRy4ThfuGCkfcAU58bM=;
 b=l+/KXS/8tFGXSwUYzB4n/pMFYvH0UnwCLZaoMIiIn4ZANkdzt3K4KSBB/MgOClkcjtEvmSewkamKSsSoDUyPR1lCYXCnzao1yIkQ5WuOII6/+HbNHtmpPYiVIdEWlJFQlMQLitS+Fj3Wfj/paa9/GoSigIMdXPuOhsBMCcUpdjz1E2vt2C26gTSn4tBxL989NG6D24nZ/elS4IeaoQZL6BKiD/6fGO8LMBTVWlSwS+JDQeHE2ys5lRv2Jl0iPjTX5c0+jDKH3or2Hy4aJEsaQjNoeWSFZkysWlonD3xaD7ZYF7eoTPeXCIMgM8KOTfdRZxWSXHa8ZqLIvE2MxZnvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNQJMUWdUyNpksAtq1QU0JbiYRy4ThfuGCkfcAU58bM=;
 b=Wu1fKjMCQwEkcYxQNzHpQaEKc3TCTinWlmoEXtmxG6w5Ht8iExYe8DlW41oj3unXQCso3JCTwdkQjrJ6wQIthhKxqLBG4zifNy7QRtNFRtCBD8bmvzUTgXSo9fwSXoi+9A+FuvO7x+mWnxlACVlrPXO0mwhdtu9UIM3imuirlqCWuhh4hBAAZlTVMd8DumHJBVN1ZwkPu5dDSp5dXPd33oV3Gi8eKajDm+UdCkJPAidnJcHZB7IBKZOZBvuuN851CKvlmGjzTKvZjISP2PD1CRsuE3mKNNcCNseoTM2rJFolYTc1gXoSwjAKwSuWfJDo8frjqthN3T01sSW87Yrzag==
Received: from MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17) by
 DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Tue, 18 Oct 2022 14:58:21 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::15) by MW2PR16CA0004.outlook.office365.com
 (2603:10b6:907::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 18 Oct 2022 14:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 14:58:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 07:58:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 07:58:11 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 07:58:07 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <ldewangan@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alan@linux.intel.com>,
        <swarren@nvidia.com>, <akhilrajeev@nvidia.com>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] serial: tegra: Read DMA status before terminating
Date:   Tue, 18 Oct 2022 20:28:06 +0530
Message-ID: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4f7a00-47ba-4895-152e-08dab1193330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZmDflVE8GlCneUTUHT6CdhVgMARyDYqzFgwEZYh4IajzFEiEYLnWIHr1DGs8tpYFsGI0KjGfk8Mzl0DPPf+EcXQ1n6k/kcOsrqncprBkRecFJUbxdO/lYrhBsX00SI1w8wO2Z18gYmmdgEjpcZUIHUN13O+o2H1defYAOdJ23EN7T3oBMNIYdGzb3ONOQFqXvPhbhq6gS3UZJ6/lWpcUrsIin6PvUOCDHLuKjIMbtDW3ne+ZSfJ4/N+9s2r3KL4lnVcnQoLfoWo2KOoVYkHVH3IteNNWj+fYAgMUwA/7IBwVYHFlge0s8RGQ06VyTfi86B2gj7YQHXAtE6bBUo3iijVkPV7tvncL64uHssOhphwK4TkxKk0qSDIBHtZtCz3RiO7zLfVggkKDOeQ9WYzhbuPGSg95ZqpEJIuaqFCATICG43MbUHoi7xBK8G8BZbUJ4eb6hJIFyebXqNB6KSKrx58OI+f3LwIHOx5L4kFtRl+LoxjQYkzsbI5z74sXh0Y9WW/VgWoIuFk8+M6nG9Kv+xWcUszTl4y/Nes0YjBr0k8ef4ZNJOGVAY18frqnVNJcx2LYgzCvRST5zSZwEh4AWFpepg+322hEUBQaz3IPe1LaFzJDKwJWlON0sLFkuO3Unbu2V95LmjN1BOQwgo4SHYyyfuwBiZCTU66fFmLYWWJZMAKEd1JjEUf0VP+G6DVu8i65mvGtj4jknGriKFv5DXRsp05/Ny66stxpOSY2rop4cnwmwZgTj/qpdZHTM3XlTtEAny87wNX1CQKh6isnokcKxtJl4yOw/4oxnXBTM0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(316002)(70206006)(336012)(478600001)(110136005)(7696005)(70586007)(41300700001)(8676002)(26005)(186003)(2906002)(8936002)(2616005)(86362001)(83380400001)(47076005)(82740400003)(36756003)(356005)(7636003)(82310400005)(921005)(426003)(36860700001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 14:58:21.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4f7a00-47ba-4895-152e-08dab1193330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the DMA status before terminating the DMA, as doing so deletes
the DMA desc.

Also, to get the correct transfer status information, pause the DMA
using dmaengine_pause() before reading the DMA status.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Kartik <kkartik@nvidia.com>
---
v1->v2:
 * Pause the DMA before reading the DMA status.
 * Updated commit message.

 drivers/tty/serial/serial-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b7170cb9a544..cda9cd4fa92c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -619,8 +619,9 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
 		return;
 
-	dmaengine_terminate_all(tup->tx_dma_chan);
+	dmaengine_pause(tup->tx_dma_chan);
 	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
+	dmaengine_terminate_all(tup->tx_dma_chan);
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
 	uart_xmit_advance(&tup->uport, count);
@@ -763,8 +764,9 @@ static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
 		return;
 	}
 
-	dmaengine_terminate_all(tup->rx_dma_chan);
+	dmaengine_pause(tup->rx_dma_chan);
 	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+	dmaengine_terminate_all(tup->rx_dma_chan);
 
 	tegra_uart_rx_buffer_push(tup, state.residue);
 	tup->rx_dma_active = false;
-- 
2.17.1

