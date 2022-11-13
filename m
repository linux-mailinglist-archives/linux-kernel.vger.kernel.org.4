Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B7626FD0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiKMNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiKMNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3B11C2F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koApI+W0sfq+ceIqZ6uCDWKw0Np+50XdSTd6QYAIKZL7mZ7k70ltoeoW0FHJ+ehCbU3cqvGaiUGphv82lKjVET8OstYcLNfKhwtYCTm+MYRQx16lCGQuz4zYzlyfIQKAVJkWbXkCa9YZrG3vpLao3jmyo8R2iVwOi1LHnAeX5SmHxH2bcE9996LhLWeETNbfvKnK+yoHjpDjoJuraj63Dhjw3cz3Wqikwr4kfzWKiOsRPQI7bNfcvlvO2iNOnm6iiwxQ4fKWgGTmw45oK6odLHyZZz+bJHT1LwihqMMe/KN+J/z9xOYkr/MrCLAnwsDHsiXUJj9rMePy/ME/DkK9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDOJqcy0OOLQko69+5KPSSZvn1pkDgfG8yrDj23ndCQ=;
 b=CYQzTlwUp9ETh2AUPUJXfFnEHn4pSxnILyH77IMxAEXN0l7agis/WtnSS55nCtCeqhAcyK5xZje9yg2NCDKKme05ERVLjuLz2a5TWlDWESiacfI1tTOxL3mq2hzvBLOvNESai1G0neZlgmOF5ni8ZhGwz+mWh+UPWDFnzgkqCgEd0dRTwaQz+PECxh2J80+TIQi9Gqu4u4vHbkvXTuij+s9kgx27LP50XYOnkipi8qbBjOLZCtUnC8gMmn0HUgsSK6p/6n4mzRYhDHrt5HlJF+z5q8SJfjB2Kcr9dTUFILygAKa89YJWqbW6mpMBEEtn1qpX/TrNBH7tryijqYn5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDOJqcy0OOLQko69+5KPSSZvn1pkDgfG8yrDj23ndCQ=;
 b=AGD2e6kJNWEFylgKqbcLMln2xw1CIPVmDXcQbNvmtvpvbHi4OJkJrm1eKdgc7lWEDEexSmyNYDfhd4XFj63fxmg2RyURjRGQO8NyafpndKOYJAV3Yp/YiZzbrkAPl3Bhxex2ctwGfeRFaoiKgD7y9Xmdd9VN6/38Nn65uOzWV9uKqV+7Ke4YUvslNRTVAPnVafP0yNTa9oipSIxfY+ExEWLAWFADrGdVcYAMd8dw2sVn5wwBgt/bK0V8TlygwU2n50b0Qd8+AntgGVobr3TJsvOwkW4TgjHT8mJI1OpMGk0mia5vTiZswysSPmX0OLnk7f70Ju3KQbsJk7SvEe65uw==
Received: from MN2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:208:178::28)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Sun, 13 Nov 2022 13:45:05 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::c5) by MN2PR19CA0015.outlook.office365.com
 (2603:10b6:208:178::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:44:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:44:53 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:44:51 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 2/7] vdpa/mlx5: Fix wrong mac address deletion
Date:   Sun, 13 Nov 2022 15:44:37 +0200
Message-ID: <20221113134442.152695-3-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: e602aa8a-77b5-41c9-19cb-08dac57d45b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3iBkS4bYxewvlVbOLri5U5Lr+Wg+EyLQntHO7OLKWW68OdvVJ08adf4Rq8g+hNSm+PIKHvYqgSDLyh6eBHSh5E+/Erv+MAjqv4dxiO1bCrigyvnXVprO2/NeBDa7DTypcOPMeLpd0tbs0Acc/eIw96SqxBYRFBSLG0no0LjuW+hogU+g6d4mk+lWHq5ZR/G+B1GgcKiTEPie3frjI0fWaLguw+VsR24LTk9HNElT1XU16ojWcnEg3k7hg6TStc8IlQGTn2icexm1qKUo86t5QX12Chj7kNaFoUi5LQt5/EEOGfTlGdO6E/HUU/KxhiQXS45vfoYnkUZLYVN3Ih/nfDD61mgJ0/QgxdbZ6c5XX2cfTMty0/1scY29xg8VnEq7Vue1vplv4bmQaMnmy0e0+aiAlabQTYUStBA+Wg+vYEPYiudIsuhgnZdJn3tv3OIgoFI79s5+bBeTB0s4+Ab3Iekca8iVjgMtryzhquG3nB8BE9yczY6Nc/zKsRKs3VAgNjtzVxOlafzk0bR5gLGCoF6JBY0rwJQxaEYKk6jXOso2doFkkBAbK45vnycngHIec6oN+niQ4QziLiX+LIPwRZC0+E8CATP7MAWHo+8ZX9N94yzZoRTXOyBzpysnNni0WKZGL6R1TzV/5cGw02OHJU75c1Y3CcuEQtnALBXktmTEKxA8Q/hhzmyals/IVRdO1YwrB47fIDwNnV3o6CfAkiv6Z6B0Ud/jtzRpaLE20ezRo/FE2tv8wPNXAIsJ7A8T/tDm9OUd+XJ82hX1n2Jew==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(2906002)(82310400005)(5660300002)(4744005)(36756003)(478600001)(8676002)(110136005)(54906003)(316002)(36860700001)(70206006)(70586007)(26005)(41300700001)(107886003)(4326008)(6666004)(7696005)(86362001)(40480700001)(83380400001)(336012)(426003)(1076003)(2616005)(186003)(356005)(7636003)(40460700003)(47076005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:05.5067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e602aa8a-77b5-41c9-19cb-08dac57d45b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the old MAC from the table and not the new one which is not there
yet.

Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ea95081eca0c..c54d5088ed4f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1686,7 +1686,7 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 		/* Need recreate the flow table entry, so that the packet could forward back
 		 */
-		mac_vlan_del(ndev, ndev->config.mac, 0, false);
+		mac_vlan_del(ndev, mac_back, 0, false);
 
 		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
 			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
-- 
2.38.1

