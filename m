Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80560467F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiJSNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJSNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:11:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCEDE24
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVTQpWy3XrYsyEOXTXl4ZH1UXShDWbvypgjo14YYLIvZ8kxVwxposlfu43EzbUpNr6TxLE2GCHgEFO6x9t6NSZi1tOkH4JZehzW8SDuFuVmWsF2yqrPFBuiwKHgfw0OWgXrys33w8D/ranO9/k2WoG0c0rOV6UgiBtsUDZ+EwnQ0rbwsmaFKmyD2Lwqg6OsPIRaW5cEW1nIRHRZOtLfG+ElRwpDzJotiqj54Rq5rwBz+0uLLC4Nlacq6JQZrFQr4yr0n409X4tNVDOvQ8mW6/fw0LdU7EPfEreysAz7+i0N0MXPmIm46OOMzcC15TPLvTY8XTGD+f+iGsg91DfJsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AXTlFj36GEzARTTCj6LLD+H5Te5pvd5Kubd0kITwgM=;
 b=QhLD2jrKDuQB1l8RAW3qeWJd/+Ao216f0g7qx1rSw9xEN6eLbYxPIsxio+a41Gfyg6M+ufMwn6l+XbU+A3ygDT6MflXGwqyhYF7raAHlAKDXZkwa2taCpDfOn/+jp61/DYHqRuvx0GCsKpn0+LmyI+6qqGaX2yJDPBkkSplFjd8z5r06QDv+aQbQXqLVzkDquHzP3Iwlim8NfGSFSJF26I6dk90Z/q6lV272H5t6XGO1M91e4EiQ+S3WizYZFEupWR0i3qQIeUHa5/dxFeWez5vhI01EJ0Tg0QrQP75RlhJxiB2NMZWF3Fj/o1kotH/i8+qocGNdIQ+pdGwU57Z3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AXTlFj36GEzARTTCj6LLD+H5Te5pvd5Kubd0kITwgM=;
 b=OdRzhcD760vlsaunJXMs49dKU/gRgj8bDD16BOfCTVbVBcKfO5By6z4EooNAbYGr1jYB4C+1PdL7vXSIW5pOJ5CHz1R1EYP+pOkarXm+6aGBxCDJ3FursvUXcWsPvNtSsD66L2m/Y/ilWIGq23AmtZkmb3TKDPt+gtQV3mepDXFBTsBrJ8isT67IXs/gfMJpYHtNfQT25VdpuBCd722bkInGqgfzbvwJIqXEIP8kGwxUMQ4P3vBD32Z6cBwXkhAMuRZ2dNmt3WnJSYOPr4ff5Rh86Y3xH1Nf7K/mnUAC7sJ6j63plKV3OfEd207v+0KKC9KsLkIYpMiiJoPMnHKXcA==
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 12:55:18 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::1f) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 12:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:55:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:55:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 05:55:06 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 19 Oct
 2022 05:55:04 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 resend 0/4] vdpa:/mlx5: Add debugfs subtree 
Date:   Wed, 19 Oct 2022 15:54:56 +0300
Message-ID: <20221019125500.208841-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|CH0PR12MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: af8d5a55-f658-4176-7404-08dab1d12ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fD502gCbiM5r72YgOHkaNciOPWwcrKmryliAUT5aLN6C6t4VkUGcTG9us/t3w/xdGq+85Xczp5FZ3plcPemWU9eaOoi2HKUDY56jzWLEjT/BoCpsP3/Avu3+l2+xiZtKqD0m3hUQaImPWCrdxa3T5dH4EXwVpeT2SrIh4yCHOLSCb+Op0XDVFUwaoOxmNwrLuc1XA123LgyOKjlgv4H1teej3EMHIOVsbB/CfiMeGHuWaFfi+0EipswcKyuw2aibOPLjcc8lFv6tZpV9IA8ZTC5rHMN63S/OTrmRTKXe4QDJLbN/3/wrRoT5UEQ2hdalRZvS2AyuKbT0MFOopD1meHYfZJNEt2Zr2wcqPxgoHQfKLPZhRwBCXMO5cQ6LpWDrpW1m63UFvvlcelkOj61qumT6G6pybjrvaS/YVhBWJJn/719/ZX5mktJqBdOjWgc8vzY1z4VCXhPETpO5cUzhHBMWcTTif1h10J1ZDthMoLXLhyBr57oxGAj07XE6+du6xRxB/XFa/ILIB775TBupXo8He1Fm/0E9CQZO1jKjzCtPM94T+u9XI7gYkWDGZbl5l7Kh+/s1uEGf0FgGk0/0D4PviujuQJfA6gKadAlcuLH1z7Wtg0MTCk9N5q+qm9shrqE9IlBCtYcMH/hBQwBlNNjuLscBel4Fr6zNU433etrWPGPIDEA/z3HR9dJUj0jLfaQu3hCVfzlYa9fHmzQzetf81ox1ypHUZM7nS5egEN0uFmQGPSiZ+Gl5vTR1vTI7uHZLH+V9R9sUHg18MZO76Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(110136005)(4326008)(54906003)(8676002)(426003)(47076005)(70206006)(86362001)(83380400001)(41300700001)(7696005)(36756003)(26005)(4743002)(70586007)(5660300002)(336012)(316002)(36860700001)(8936002)(40480700001)(6666004)(107886003)(82740400003)(2906002)(2616005)(1076003)(356005)(7636003)(186003)(40460700003)(478600001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:55:18.2389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8d5a55-f658-4176-7404-08dab1d12ccf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch fixes a copy paste error causing VLAN tagged packets to no
be filtered.In addition it modifies the logic so VLAN filtering is
enforced only if VIRTIO_NET_F_CTRL_VLAN is negotiated.

Following three patches add debugfs subtree.
First one just moves definitions to a new header file. These definitions
are needed for following patches.
Second patch adds entries to read flow table number and TIR number.
Third patch adds multicast and unicast packets and bytes counters for
for each untagged or VLAN tagged incoming traffic. This is depends on
MLX5_VDPA_STEERING_DEBUG config option and is off by default.

v1->v2:
1. Enforce VLAN filtering onl if VIRTIO_NET_F_CTRL_VLAN is negotiated.
2. Error flow cleanups.

Eli Cohen (4):
  vdpa/mlx5: Fix rule forwarding VLAN to TIR
  vdpa/mlx5: Move some definitions to a new header file
  vdpa/mlx5: Add debugfs subtree
  vdpa/mlx5: Add RX counters to debugfs

 drivers/vdpa/Kconfig              |  12 ++
 drivers/vdpa/mlx5/Makefile        |   2 +-
 drivers/vdpa/mlx5/net/debug.c     | 152 +++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 181 ++++++++++++++++++------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  94 ++++++++++++++++
 5 files changed, 366 insertions(+), 75 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/debug.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.35.1

