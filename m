Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6C62811A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiKNNSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiKNNSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:18:15 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B52C119
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:18:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwe+ZqaTpRbaLeJ7GdVefOQrGkJ3VuV79zg7VGsl4U1vawD9BUTCIrKr3ttufV9p7PROHrDvzH1n2M9bF22Zw9+M2HNI9jqKlJFuULr0eypNWhsV2aKFYI9EyRNBXuD/SbM2oj4tqDoHb29RFAGOSk/tPNcQTo54cmXqVVI++ay9Jfv76fH3lg5+CbmJMroIdXWIw1TBDOc1XZBsP0A4X3Dmte1Ms/DKM7e4dZeFRH1ZVmnb32QUTjj/qLXeS4MvQ7vCBnNh8we5iA8zcMYW4JDHa3LKxfZYIK+3CLP6u3d3/65YpkvtKl9CFPpzTPsn1RMzaK4nBK6hU4W+41qevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kBsYhcw/CHSm3pp6x1bM2HXMkeW/u8fTbDKtZNKc+A=;
 b=aLszb29zSSeHo3N2xcS38EaI2BvAhLaGMa7OYZ96aU4yfDKQuws1q/moGlNwf4NtmPq2nX92tU6L7xEbPHHqkftpJoTJeUAAn32PDtjhiiTSmDji8ad3ByT2V+BNetxhrVOXeoMnuehg5H2ad91HGaUifs74q6KXfCIbo4k0kwQlxd18SnpHmK7rsVW6aHvVyPWoTS8QL03hA8Flsvp8vdGtqNL8rBW7MS/oCl+1ngydlIItU92kNguKtADWmJP6inFCVsiQbcJZNe/Tih45K5PdbZofPu01wXwZhz+LnVFmEA/CwcWwlXuZXdf7Fs8c55WCdpThadLOB8LH9gkN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kBsYhcw/CHSm3pp6x1bM2HXMkeW/u8fTbDKtZNKc+A=;
 b=GlqPfEzNdb9rU45vYjHZkqFx4X8nNbx/3foPDdA31ffHkfS4n2W4jZS0QubeecKROBkyVwweIwiERYIg+1/symMgoxKon9jOP2LsYt4ger/6OdB8c2JTYCNoy+YlfwUchTZ8MCCsgAwciEkEbvTcgBfHQTUDTa0KsqeQ18OODEjXmMYnVGraOPjq7AQvcn+WQ7FWek/DR+scyG66Mvbv2Ea2dEsexiIR27z9KTxwiZoX8lIvYLtuQmQbX5WAYf2nBcr8UMPPPSbM+BGwP+FhJBKuDqyWHqFDtG+gKabNV7ZGZBSZBpe/tlRjEkhwlZm84X1YoqPk9KCAKnINplr38w==
Received: from DM6PR07CA0046.namprd07.prod.outlook.com (2603:10b6:5:74::23) by
 CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 13:18:12 +0000
Received: from DS1PEPF0000E657.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::34) by DM6PR07CA0046.outlook.office365.com
 (2603:10b6:5:74::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 13:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000E657.mail.protection.outlook.com (10.167.18.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 13:18:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 05:18:05 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 05:18:04 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 05:18:02 -0800
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
Date:   Mon, 14 Nov 2022 15:17:51 +0200
Message-ID: <20221114131759.57883-1-elic@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E657:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: c54a2de3-793b-4820-e275-08dac642ae6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9OMMO9ES4aWJXq7PDM+R7wGxb0oTet8/1ing1hIB1M++ldHoWX/OcL9ntPe5iKrG5J65Q0npKJ2pxKv8jhYF301sDh6Dyd0MLIW5U53pg1zuCVJ/bBnYLlacbxve10DqNbpkXZXqPiGJbS2301KgWPPSGN1+80LFYr7r26Xjor38QhCccuxQ20jkA064DwSZB60L1+dRSFEnvtA9yfrQl/2EawBxQfmd7QIkTzwMiAEvuEJ3uNL+13G4AKNW5YyvfMBQ6lGFiW2xiV/3ecMgl7GytMqQOcxVxp0fYGmAxX8uhvXO1i7vZCD0w3rbz4QzMcTLYwtPY6SKwD1ro2zm1U9T9TegwExZs/Hk9SZljn+VmpCNku/8UdQ39FiP2baLpUtpghsYnB/U5uL+NEOoH7INoMx6YfF0KMVJ3P/bMV9dzF31IuruPXgpEGe85jC+/VcAVtSzoN8rcLirmOobA4mZE7H/oe6UmgYyUoSBkTwd440Sz6anVpQQOtnvtP0Lz3VUlrQ7IHY8WYDU3UHh474aiafFPL/RtaHrlHfJ95E9pWkKUbLqRU9uZmh+j8ggL9/V1REYS3QFKOsjczU5vjcsrJKAN5GvOEP/tUAri6Cd/m1oPMrYHzQLh4v79Th1GHKvQNZAizHUYRFJ6Op1ZECI5iI+vOgoQ5iVQLfV4tJrxdymd1UCtTw5uRCSS5yDU4duj7OmVFCvDKB6+fKr7orGips3T1+P6M2rNO+ZNsuNXbsDJK56rFcS+TKckayP4gQX5wgZ4uJYmJPbL6/kQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(86362001)(316002)(110136005)(2906002)(70206006)(54906003)(40460700003)(4326008)(8676002)(36756003)(6666004)(70586007)(107886003)(47076005)(40480700001)(2616005)(5660300002)(36860700001)(426003)(336012)(186003)(1076003)(83380400001)(7696005)(82740400003)(41300700001)(8936002)(26005)(82310400005)(7636003)(356005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 13:18:12.1452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54a2de3-793b-4820-e275-08dac642ae6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E657.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v1->v2:
1. Reorder patches so fixes are first
2. Break "Fix rule forwarding VLAN to TIR" into two patches
3. Squash fix for bug in first patch from "Add RX counters to debugfs"
4. Move clearing of nb_registered before calling mlx5_notifier_unregister() in mlx5_vdpa_dev_del()


Eli Cohen (8):
  vdpa/mlx5: Fix rule forwarding VLAN to TIR
  vdpa/mlx5: Return error on vlan ctrl commands if not supported
  vdpa/mlx5: Fix wrong mac address deletion
  vdpa/mlx5: Avoid using reslock in event_handler
  vdpa/mlx5: Avoid overwriting CVQ iotlb
  vdpa/mlx5: Move some definitions to a new header file
  vdpa/mlx5: Add debugfs subtree
  vdpa/mlx5: Add RX counters to debugfs

 drivers/vdpa/Kconfig               |  12 ++
 drivers/vdpa/mlx5/Makefile         |   2 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
 drivers/vdpa/mlx5/core/mr.c        |  44 ++---
 drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 250 ++++++++++++++---------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
 7 files changed, 412 insertions(+), 147 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/debug.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.38.1

