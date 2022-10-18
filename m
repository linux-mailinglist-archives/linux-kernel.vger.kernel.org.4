Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA77602457
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJRGZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJRGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:25:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE4876B4;
        Mon, 17 Oct 2022 23:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R59WqWUIJ24x7DqUY6Kxakavfk/ZtSPzXOBRA0cKadgQwFh8bWPROHh2ekbnWgKj9/pP5iU19k3FW3wB8pDwnovG95o+A9gjXBkHf0+uBmxHV2hTY+MhLeRNpuHJqTabugb01flBFowPVtFrgUlOEY8kO/IAk6PLdSJpnhLrVhr/2evl7LaP3IoexQivPJoghSuCy6YNZJi6c45lDdG9Pq8EMDE+ohYRT/xXIFZOCewc8cP9ITFyMFXJQHi+Wl1tyWI9GtzzyRVht92UyOvBy/kY3dFdWVOGh9GiESQwVTu0w01hyWJvBiGAi29Ik+LyJb+DgatEBJLUMnI6BimjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydXluo0khmE1sjgdjQRIPWCm4SRPJa0D0iS2YeZcxRk=;
 b=lSIrw8b17uWcsWzKS3dgytrc7a9syLJAKH9Yp1eNoWeVWiq6X1HGM49BOqpcBasnp+50t2SsQKhg/pnYb/yk450E0D+44vTcaTtVvGPvH9LquLGXUuFSLJM3gksWJFeAY1cuyQ2INyQXTzyzQ0dOneQoUk0v3u2OqSDUvgjvEHkOzb1EtZ2fP7deH71VWjDxi/WAA0gk8fPsIoP1iyQpWwpXXbWL18XPfMRTxKjZuhvOCAVe6V8m80qfgIIjTREy3u0rvF1Xen1USr2gBG0ha+emOOoMYazzl9cmQTwVzKHMijM9URNMxFhlyIdokrPAqMMfRX//BqbYa1Qh3Z0MlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydXluo0khmE1sjgdjQRIPWCm4SRPJa0D0iS2YeZcxRk=;
 b=abDGp7nNUr14B5+rRrOWTWQJllUNGpd3Dy3YCZQ8VpLlkyepcrlkh+3EFYFtxKvY/BMT0F/4AgLfqP1QLX9HOy+ynCT8g/W834epIHo3keoSBUXBhU1EszAW90XRgWpSWCR5xPVF67Cu+xOIv5IbsEzlmfDiKfWEh4PVobpfu7izpZ1GkR3WkkkhqTaXUtRT1Sir76K6l7R+wtdC7x3oHVS94Rlz/nTKTw8F9JvDB9NmzCxtQ/jTxdndlp2pWpX2we0rgupBRZ3AE8a8fDu76WqWwTjgmPzdAPHpF1MuPzQaZU5qXgmWD4lJdnCD9JmbFLel172LLlNAKykh2zh7IQ==
Received: from DM5PR08CA0031.namprd08.prod.outlook.com (2603:10b6:4:60::20) by
 PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 06:25:29 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::87) by DM5PR08CA0031.outlook.office365.com
 (2603:10b6:4:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 18 Oct 2022 06:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 06:25:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 23:25:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 23:25:15 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 23:25:12 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <ldewangan@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <swarren@nvidia.com>,
        <akhilrajeev@nvidia.com>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: tegra: read DMA status before terminating
Date:   Tue, 18 Oct 2022 11:55:10 +0530
Message-ID: <1666074311-12764-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 663478d9-d233-4bd8-3e4b-08dab0d18cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwzJ61ZDuZUopR/KAkROpTeQ4Pmz79OFA3PDMlzy+ix36WXjqe2sEHPSr8RgWDirzq/28ozQOG60C1RpQAysyuWgNfRvhsj+7YeYqktaQvB94QkTdaMQKrodSQWvj71b5xRcauH/Tbjcizq0yUMOG6bQMBe6Prm1JsqMNrAEjssxcl+xcGHbfOQxIxJRFnPs+6btEF+XSiOjQDULQnTI3E/iQWRDshKLe5IvUSK6gyh2PVTVNZJeDpIIVf2yPTLCJp2H6XmWE8mxObutGIttF5CUbMLIpfbOs2quuSAEOacHiLMQ/1Ymr5BvF0uxfOnjYiuNit5DeYMM6iat2Cz6BdglaWV0EUH0L9xmaqBooGdYvvUO6XfQ18pwxTQJ2skbZLyBcYqQhnFZHHwp6qw0l6eJkfPLWGiQyMhPjx9Tuj7a6t8dpxLWoNnXgqVXKBBHteALzm/cQBZbM/6cHZMLXc3eGpF/PRRKU0pogzIAMR8zuZAlPvsKe/31a081HKXqofQynuuBzG+rcjU1wg36McGK68ELgmzWphj+hRv+oo7Dvef9a3z3aExXvEGD2Lln1Dtiu80w5qLdde7TqFw0IZkPwffHJundoPgSfFtNAyQRn5bEHxJGk5ELj63R+zCrPycgS0uPmS8A9n97ZeI5Ar6WwszYhWsOXy2Q7r0AD0iLVJOD4LZGP997XIqVOnZwUH2N8ZqXTwcrmVJl667uF9nYvbjqNci/gIWs5MBANpN2YbtE4W8NRYwwp+hR4xuc80f7CSSkSCja1SKdQVDhkFO44qCbdynaEvW4mn5vqJM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82740400003)(40460700003)(2906002)(921005)(7636003)(356005)(8936002)(5660300002)(70586007)(41300700001)(70206006)(8676002)(36860700001)(316002)(83380400001)(110136005)(186003)(40480700001)(82310400005)(7696005)(426003)(36756003)(47076005)(2616005)(336012)(26005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 06:25:28.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663478d9-d233-4bd8-3e4b-08dab0d18cf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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

