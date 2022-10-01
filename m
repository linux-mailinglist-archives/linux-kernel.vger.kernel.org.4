Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB15F1C22
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJAMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJAMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:22:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF717F11E;
        Sat,  1 Oct 2022 05:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBJor5CpNzB9/ejDYD+HihIY95nQQsUVLYmT49FD0nVKjee9OHhrPdMuxA7Y8rhVqpmqqUb2Itz8fyUeIi6CNkT9bCMjS+VvH4I7MInOBiQJXLs3B/F/kgnBSwGpWn4W0rWk7QEQEwRr6v4R70fnHbi557V4J5WVJxjgdMzG8DmDJdR8gk6E408kInYzVvFcfQlqKUjL4U3x4hGEELAWH8rHu9pQbroY/85DpYiUv8aYCqLmf6CORXgq74xFSc3izu2AqsCkuMvBRhE/9IS1omrHzLmMBcnPcisrN+QUx8XtWfNsmxkNMhSUvP+d2LIhNqqaDAw1/kBov06djt//ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyJQgfEl9sCZFy7qbtkVrcC8ao3gTPpdbs2pwhCgxzE=;
 b=a/4HLgheSli3j8hDhBq9H9WL2/I9290UC0yNuM2JQDe7pJzy05k3mQCPw88j3VSqRERHaNJrxHCF7v8KxakSGBJfmaJnhDuqWmRvo+zpn80QHslrRuKotBJ/IAfQMxCA883i9p7MZGFHCMLWXx10G916uXRObXk4ws26NNgzDacIgXQtilf7umyCfLGx5Ij2TMOKtCjWB6Ddi34AZjf1EGTjf3wddvIkLz1Xj1a7od4tqbUgYh61R4awKMItSKSbGsJXDAvb1XIX6hDr6ibyN3DzuetCH5EMqw/4jntcRHIwr1+QJLhEsGlRwSHtLV1hHStgmEMdboHJR4Nkh/3u9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyJQgfEl9sCZFy7qbtkVrcC8ao3gTPpdbs2pwhCgxzE=;
 b=g2kfvmhROsEspAMaHYGQ+7UBY7evAb3vkgHsB3zP8v1qhzvUR2ZSIfZ/TBi04r1WjmWjkRgUp7fkM6rIxvBFWi6D2SvxaAGaCfEacsh2yAgy0lCAhwtzYP7uhL1Jihqz9IuFpAKNnR3N6MYHd2fQytCgn9qiqiChN1WCvOhdUKAMwZsqBS+dGvAvNdgvFacDG2R/vQHTBtvh+V4mRXxYtEOeSrBXgC9q6CJexYlTv8KI/6neTeRW3fLLy3NCUNy3k3OsV1N2BJttKhQp1OgyokrlVRoFx4yFGRbblVKlZsuxjL8QZnKwNHOBWZEjeJy7or6dYJ5u+y+0S8buuKRQfw==
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Sat, 1 Oct
 2022 12:22:06 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ca) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Sat, 1 Oct 2022 12:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sat, 1 Oct 2022 12:22:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 1 Oct 2022
 05:22:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 1 Oct 2022
 05:22:03 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 1 Oct 2022 05:22:00 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 3/5] spi: tegra210-quad: Use nbits in combined seq
Date:   Sat, 1 Oct 2022 17:51:46 +0530
Message-ID: <20221001122148.9158-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221001122148.9158-1-kyarlagadda@nvidia.com>
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: d60b9fa4-c6f5-4783-e824-08daa3a78dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hX80AZh+5kKQfD7HtcBt5HyVv3xon4cmbDLgrNpLNU7gRZuPn7feilj1e4W5nn8O//eZbBgRCWjK0dw2w2/YSD4jRcaLf4BQXQ9pG/HieJexHa1t3OgXKd41pPvnTILX02tXDlFLZYNkTu5TS21SF9WQW+z9RBLENURLI/9k5VYgLNX2ZPEjifcyGS/2YASzq543vS5RDRk1KJMAAvXh+jDeJQIGIHORsdB1g0ZEGQiDyT5Z2NxQVlZc4fJ9MocaWeYx8vcD4pVa4aL5hHs98uD0nrzqT/Q9zfuIJaUZpuLR63dE0vX4+/P9dP9kefx+WH1bBJyzxXy5+ACE0MZU0mH/gSSSingc0qfXLkobsx+aWo831T9TnTFDuHixoaxT3M+Lc/ZMSjqIKpoywBiA4MOg9FU863ddJAoF/Txr/z2uU2S3A2uR0GfpH6bAK1QLA64xllu7mBKo5hmx1B61Soa8LXpkSdMGwq0HQ9/PKx/66IWntJf90W35zRH41Hnh/cvlfIIeJdhhSKiWOI6DYLpdmDS1yecYz26nvKjq5W36P7b/NIB2Mr9CxG/WvERksOMR0kALf3wFXHeBvMhTcrlk7JbHifMN53FGAzwDMXephssVVuKtj9+CV9lmG2lwjjH2SbE8j8yZU0dHQh+4aOwKnGn6oIWu+2iuG0it6cAXH/x8XPdAWfoL3ovpF1CfADVTbM6tg/8b3PIMkmig9RDbovtVISWkBhfqKjcWOCI9Z8lYgmeJpbz7Io2dKfgldGe1RX8D6nYvPknj/3R7A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(82310400005)(8936002)(356005)(41300700001)(5660300002)(186003)(426003)(47076005)(36756003)(83380400001)(2616005)(107886003)(26005)(7636003)(6666004)(7696005)(336012)(1076003)(36860700001)(2906002)(316002)(86362001)(54906003)(110136005)(40480700001)(70586007)(478600001)(8676002)(70206006)(4326008)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 12:22:05.8439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60b9fa4-c6f5-4783-e824-08daa3a78dbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combined sequence currently forces cmd and addr transfers in X1.
Check nbits for CMD and ADDR xfers and update config registers.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 06bf19d0cfc1..be11daafb7d4 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -135,7 +135,7 @@
 #define QSPI_COMMAND_VALUE_SET(X)		(((x) & 0xFF) << 0)
 
 #define QSPI_CMB_SEQ_CMD_CFG			0x1a0
-#define QSPI_COMMAND_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_COMMAND_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_COMMAND_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_COMMAND_SDR_DDR			BIT(12)
 #define QSPI_COMMAND_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -147,7 +147,7 @@
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
 
 #define QSPI_CMB_SEQ_ADDR_CFG			0x1ac
-#define QSPI_ADDRESS_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_ADDRESS_X1_X2_X4(x)		((((x) >> 1) & 0x3) << 13)
 #define QSPI_ADDRESS_X1_X2_X4_MASK		(0x03 << 13)
 #define QSPI_ADDRESS_SDR_DDR			BIT(12)
 #define QSPI_ADDRESS_SIZE_SET(x)		(((x) & 0xFF) << 0)
@@ -1029,10 +1029,6 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 addr_config = 0;
 
-	/* Extract Address configuration and value */
-	is_ddr = 0; //Only SDR mode supported
-	bus_width = 0; //X1 mode
-
 	if (is_ddr)
 		addr_config |= QSPI_ADDRESS_SDR_DDR;
 	else
@@ -1066,13 +1062,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 		switch (transfer_phase) {
 		case CMD_TRANSFER:
 			/* X1 SDR mode */
-			cmd_config = tegra_qspi_cmd_config(false, 0,
+			cmd_config = tegra_qspi_cmd_config(false, xfer->tx_nbits,
 							   xfer->len);
 			cmd_value = *((const u8 *)(xfer->tx_buf));
 			break;
 		case ADDR_TRANSFER:
 			/* X1 SDR mode */
-			addr_config = tegra_qspi_addr_config(false, 0,
+			addr_config = tegra_qspi_addr_config(false, xfer->tx_nbits,
 							     xfer->len);
 			address_value = *((const u32 *)(xfer->tx_buf));
 			break;
-- 
2.17.1

