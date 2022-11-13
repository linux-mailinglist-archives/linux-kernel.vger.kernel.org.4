Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560A626FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiKMNpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiKMNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:45:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01A11148
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 05:45:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1ohuW1qyEa76eaMd2sK4kjidXtCogqdI+a4h2lPOgExBcvk3FJaOx7XpVbafMUbAjls3jYVr1IAi/FKvu3CyY2cZ4iiqWPfDlKUd7aYKmlfMh2NmYrqHXYq3Rreycg9OLtu6RN1yh1IhA5HqE0OH2RAlOq9s8oOGRkEQxLQn6nICUaj1++DDq/0ga3SpROid2VipWUAKatcIgB+tFuXTvfdmxZ2TSwjDT36dWGs840wqr2g+ZBaP6mpFF0ancadXBC7zDUgecxL5VDhyyvaTm15vic2cu4jf5jEkR6Ud29kUyXZXYzdMmpcohLJgWwo569vkroW9sTP19W9GMp9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abzNm99DUtIPgIjzi1rJfgyxr/lYcForE+3dYaCyLts=;
 b=lOmLLdJX53gBA6bZC8GS3ygfJ96GpfxViZoSGy7HStmtYdPYoCryU+ovCuJLsuCieO74/CJTPzDpw+1V3AjVzO7MC5UHTQPAqGpzhQY4K3oRyninr6F05eLZsbc5SyUTinbBnC7XpoZSE++iTsxA8ay8582A0Pia8xOTp88k1wTi6efTio2nEaHj1Pl4Yu+ODiFiLGw25hGV+ZwzFqZaKuFSGuyFXisJft1yPeDNF1QCMtvWtYCtnrIChnb9OigkK9HGbG46oOH4CoTOgYkSvuIYIwogszsECmdXpGfhQYb2YayPcIY5OVhQwu4mptpbem//C7Yg9CUEOCa6ds4muQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abzNm99DUtIPgIjzi1rJfgyxr/lYcForE+3dYaCyLts=;
 b=cwntQVCQxlD7LX76YT3f0h5VizbtoRbhzr0TbZZOTUsLyeIumP0OAeGyfPmXYq1pnjZFCSH6178hz6amgq67zn+If0Bwe6RvbqFu2qSMtoXa9AOeTrvS5nto4zb9c9Zd93xXL0onbjg7JIUZcXBU5i8lAQeIiVhFkwym22AOGck4h72Jio1600Q/q7VxZTubXlExRGOSXLQwGxKowAjktDaI9kePSfBon51ZX5YtfcP37vL9h5vf68OQRyF1h0EjZ+K15iGdE6/g1xOxvIgxbBlQbMofH1nIXGhurKQQHIpBC4416dfkFk73y5Cf0XG4Z59KfJmYaZ47FA2YelorXQ==
Received: from BN0PR04CA0032.namprd04.prod.outlook.com (2603:10b6:408:e8::7)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 13:45:01 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::59) by BN0PR04CA0032.outlook.office365.com
 (2603:10b6:408:e8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Sun, 13 Nov 2022 13:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Sun, 13 Nov 2022 13:45:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 13 Nov
 2022 05:44:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 13 Nov
 2022 05:44:47 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 13 Nov
 2022 05:44:45 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Date:   Sun, 13 Nov 2022 15:44:35 +0200
Message-ID: <20221113134442.152695-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf1bbc5-8f63-4a1c-5934-08dac57d42ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9sCOT5I2N3AAN0oLFsrMlZWkf0qQ6cU5dPjlP9ZGnxGsWCXi/Ls+hFRLvx7c9Neirhtz7FBrEK9seDZ3FDpUKNcKel2BRj2GEx/b7yKIyUIX8Ss1cOHnslxQI8FxeJg+CqVZLf7uBcX8JZQlkyFBEZPGEoc3O9xy75fJrFRZSDSXeWTdFzzdkBCVtoWZb09XzHwomfwnJx7p0RhhJaPDWGpQYo7+nu6FtAop/O6kCSb4o9vin9O/4WEIjCH0/pkB79kfx6XxGjxHqEUIaEGDTU2453HHSg3Z0zZjrhmmg/XPFdWivXpCzzJXh/aThkmd7HaWPHT9hbFauRCssHsioCQXExFVmAi8jRICHUIXsHIRGOrgso38nUdvXcqSJXhpb8LLTOEyNx4NcuaGGcdqpu4jw10D4jBgnodKdCL7XLY8Utd0lJPayKICMlIOWTQYj0xWb9Wfoq+vzpe+xSuT4RtyB2JAl8mzvExLuarOXeWYdPrw2ETFTGV+NrTsf8+VIIglHMLyLC/DK+UDq0g8ZvHVG/RUYugfGIJyh8mXm0u1HW5ShfIfvZnJD9ag3sUC3zs9W/Y27CZfDQEXQ0XYalLf4olcsYwPQUICS9m6/Vyit3bhDHHocgP4wadN95Hfw4HAaCSDJk9DENcXOhluw/QZ39E0//CSHabdkrEgPi+0tXZoJUIGq33WxUIaPyfQ1+b5eQMnRKxa/EXdwui3mWEkO7gJXpSsRJn5FF1iA0RWd3iQKK4fPv+oKWlhPDcL6ztzglIVH+7TfcFXWi3dQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(36756003)(8936002)(36860700001)(5660300002)(70206006)(70586007)(41300700001)(4326008)(8676002)(316002)(86362001)(54906003)(40460700003)(110136005)(478600001)(7636003)(40480700001)(82740400003)(356005)(186003)(6666004)(83380400001)(426003)(2616005)(1076003)(47076005)(336012)(107886003)(7696005)(82310400005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 13:45:00.9773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf1bbc5-8f63-4a1c-5934-08dac57d42ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a resend of previously sent patch list. It adds a few
fixes so I treat as a v0 of a new series.

It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG that when
eabled allows to read rx unicast and multicast counters per tagged or untagged traffic.

Examples:
$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
$ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes


Eli Cohen (7):
  vdpa/mlx5: Fix rule forwarding VLAN to TIR
  vdpa/mlx5: Fix wrong mac address deletion
  vdpa/mlx5: Move some definitions to a new header file
  vdpa/mlx5: Add debugfs subtree
  vdpa/mlx5: Add RX counters to debugfs
  vdpa/mlx5: Avoid using reslock in event_handler
  vdpa/mlx5: Avoid overwriting CVQ iotlb

 drivers/vdpa/Kconfig               |  12 ++
 drivers/vdpa/mlx5/Makefile         |   2 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
 drivers/vdpa/mlx5/core/mr.c        |  44 ++---
 drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 248 ++++++++++++++---------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
 7 files changed, 411 insertions(+), 146 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/debug.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.38.1

