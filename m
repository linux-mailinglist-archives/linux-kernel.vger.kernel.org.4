Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883A0602456
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJRGZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJRGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:25:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD6392F59;
        Mon, 17 Oct 2022 23:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JolkYSQOnLRBbDXxz97Q9mxgFLfaG99+Iee6at3iqTa3lhzP50iyCvIJjtWh/yg5DOMvv0uBjSRWNOb2Emsn0dbwIv8+VmFUmiQVKNlY8ih42BjUtyUZeCSCz9eQh6578ur8IUh1frgbRj8kqbK/YoF+xsqDigrdFe9U5xTR5uqNLmVRXcSPwusH6sI+YHypq9pTaKt1uvcmhgga0ipi6XVuz5kgAt7Z3dlt0jX7XG9MTizG8oan5tWLaf3uNgQsb5ovrxOuwsiYJxIFzNtIkGai3yeDifq3ytB5qEs896IdJMACKasgfWGIUlIbaaPcJyf/X3c3EmdYtniDP2NQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydXluo0khmE1sjgdjQRIPWCm4SRPJa0D0iS2YeZcxRk=;
 b=C9YJ43oYObeysPSaBvK4QtOcp0WRSXy4MdIl2cIJwZhlLzQWqE1e2hC/xPtEDmcU+T+peDPC4O7Z5Jub+LkH8B5d4p0paeQHF/rfpi+rCIpbm06R+3Oob0iRO7h1YfqJPteHW7Stadc2h7xKJv62wKDI+mOLHcMPtT1quCSnb6H0tm2Vl+lrSrreXM2CTalcRd1dr1CoURifSxmsBPqEpOQkIwqsBCpsyU2f7yX2KUDs7i/dgnKefAzhJcpRJ4/pSy6L9iMETCVtx0o1P1q9S1qeVWvUCDr6CPlhN2PJLDkPnY/COjMGM2SficFdtcej6YAP9rNbcu8skN3P+Fa/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydXluo0khmE1sjgdjQRIPWCm4SRPJa0D0iS2YeZcxRk=;
 b=ta/Ir00yzow6QmNK69hk5/5bSv/BpDoVXY/g6RGF9ArCPre6RTSOPKit4IZvDJaoVryh5Hkxask5sm4g0R0KEKDA51+GpgMy87w1Y2gncOJBzvBXp/JKPBOvUeeCtv5JXqMIsgdJs6yEA69UaUlhO0R4pxdpluLNXmEuSIB2mDNCoI1U8xyjYCSGXSzF7uhJlaaI1AXaseX0GtNJxFno66X9u3OSd+b/clgYTkdhHCGa5s5M8aHXDXDKUt4mIMazzUGWQ5aqdSRBUarYpdrlvG0tOk0aM/BiUC7cH53sQC/yFOv2s9tONovbmsAd8oOUSCkKD9Cs1Sv4S8hO4OEjqg==
Received: from DM6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:5:bc::32) by
 SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Tue, 18 Oct
 2022 06:25:30 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::17) by DM6PR13CA0019.outlook.office365.com
 (2603:10b6:5:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Tue, 18 Oct 2022 06:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 06:25:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 23:25:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 23:25:19 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 23:25:16 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <ldewangan@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <swarren@nvidia.com>,
        <akhilrajeev@nvidia.com>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: tegra: read DMA status before terminating
Date:   Tue, 18 Oct 2022 11:55:11 +0530
Message-ID: <1666074311-12764-2-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666074311-12764-1-git-send-email-kkartik@nvidia.com>
References: <1666074311-12764-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a663629-b093-4072-052f-08dab0d18e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiMo5mj/N9cjByEl/I47cB32F6RprQJRvTYs12McgTkqaujjNQ/4Oeom9+1Jdtd2EC8LLjaWyj/cd5AdV8CEJDC6IxTU04mGpNkBYY+y/7XVX+W/q8SmNht/2P9UmhHaibxOCEcrQcNGUT6SyQH41vvYmfQxXp2a74Vl8hmaq63iU9eC9memAWdzbZdGRJANDeaahPXGdHaqsgZ0dNlmUz5Uknvnwa1p8lSdtzkKOsmKG68tG8rYPvcuCYve3WYN+4IbWkOepKwWP5EH0DHLlgSQBoou1Oaf+VwPHFrdMnrnmL/7jPGEhmoZEKqC46ddxAZCfsHmWGMpsDAeIBcueisAd9qXZFqqJ3wl2QJ9crcT2yLIXkaZ8z6Ve5HUxpUd7eth7fqrwVJeW7TeMGa+jyuNfHA8uP6PqBrG4WK6RFCGxc7XkmUaqtmDejLMZI0CSJEkV7K6u6RkfEHW0gngK/SV/Lagm/FUePO4XRn5NmKBaATJ9BF/5fzggryaVFloupmHWUN+JB2sQyssyllNaZsfko1wmVAwN+9EJsgqzU3JKBcYds8FsmcflNk2X2y4ZR59V3SZXjV1cY+lqZH/o1U2lirpmvbgkz2kTaz8JJNxdcJWee2HhuzRT0P380bIh/6+xaBPjAZPLNwvpp6DeTm0ksgC479OUHIQctHgKmCu5Qqvx/5tyDTbVr3QQJi/ocF65TEkgZd8+n7MJlZloTm0GRmHM13qFx95Yi/AukP3YSNSgJaYwAKmXytcfE0YxcjIOuFg+SipFBBHEPV2cgtBodAuonALFNuWcyWeAow=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(316002)(186003)(110136005)(36756003)(2616005)(40460700003)(7696005)(26005)(2906002)(5660300002)(8936002)(83380400001)(41300700001)(86362001)(40480700001)(336012)(426003)(70206006)(70586007)(6666004)(47076005)(8676002)(921005)(82310400005)(36860700001)(82740400003)(478600001)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 06:25:30.7227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a663629-b093-4072-052f-08dab0d18e4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the valid data, read DMA status before terminating the DMA. As
dmaengine_terminate_all() deletes the DMA desc.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b7170cb9a544..2779b4491f02 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -619,8 +619,8 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
 		return;
 
-	dmaengine_terminate_all(tup->tx_dma_chan);
 	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
+	dmaengine_terminate_all(tup->tx_dma_chan);
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
 	uart_xmit_advance(&tup->uport, count);
@@ -763,8 +763,8 @@ static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
 		return;
 	}
 
-	dmaengine_terminate_all(tup->rx_dma_chan);
 	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
+	dmaengine_terminate_all(tup->rx_dma_chan);
 
 	tegra_uart_rx_buffer_push(tup, state.residue);
 	tup->rx_dma_active = false;
-- 
2.17.1

