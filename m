Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E79604647
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiJSNEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiJSNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:03:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2741E3EF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG9wVlJNAX9xIkh84dScFgLmjMRN7nKnVOwIy6wEgTayOh5bfmfDDjyglMVYAAuJDu2uTkTyWEjH4ET5Wy68tQyWXSkgUMbpo4wwvzdOEok5mWJEeDWZkOOebCZh+YqeC16xTUueoLUAKSYohkaBb2ClpDhQ+npn/WsC/mndpk6jHd6soFLmjjLLmNaKK8KovGEr7vSXSnB8RUFAlgHY1kozk9u9LxHHSnAVVVaBZuqcS/3te/cP7bJxK7GcunSKDRZdR9Y+ZgUSPWBYplwsTsyFZmjIsTuFjZmsEUTLd5SDgzExAre2ggvrVpUOigg1KUo1PggUQ/eBBpszIPVesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AXTlFj36GEzARTTCj6LLD+H5Te5pvd5Kubd0kITwgM=;
 b=HJeAUtowycsjbPMshTTQOXDFKL7dgFTlckLiAjP6ogPWnsUcsSaky5f9/tcSKWcbqCz1cKx6gUFvaGRP/46peZIJ+ep8OuuiogUs37j5C38HDi1aNa3JEM5+BY6w1nMeFzKKmBSzPV2CEkJ8KYQnYG4m4WFWq9N9UeofN4FJNm5OJTn6U35Vp2THWLnMEMqf6Bgkq/3DNYaDPRCwQsFO+MixfMp0o6Jk6BS0bFpxka4pKN7y9T03/LbO2I9BOT0DlaNakvRkSVHstfEu4Ur9nvjXIAfOLyOjn84Bh0UGOaaVEGOzRN62PxWOKVmVhCoKZMteVw0wElpsn3Plwvctyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AXTlFj36GEzARTTCj6LLD+H5Te5pvd5Kubd0kITwgM=;
 b=Rld99uUI6AGl0xh0R8zrpNDj3/fD8smHHWlQSQ+vTbFbLKbrcYwo6CJ+0uxq0j8xEZQUwVcHbWfIGHYDph7oT5GZOBXSV1JdRpVrt3gXLFKTx3trsNIte8Acc59U9KHFqG+ai+wiH034Y3NMWASbK1NWXy6wNZ4Pg1E9OIeXK6UDNWKz+YJbYKITJBf/UcQf2ajTeCj7N1aXGaGVfZ3ABWvQXucvTGKhx4mrMHgkjnLsJvlUcAYlxsF18VmZH0wZjfRTz+/c+GKNmcuFYNjHwcBQTJOGsixcR6U/KSb2AwXsHvHtrlI0r+tQCSEn1FzuQtpz3xksWv4sO7c1Tt/PIg==
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 12:46:27 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::fe) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 12:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 12:46:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 19 Oct
 2022 05:46:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 19 Oct 2022 05:46:15 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 19 Oct 2022 05:46:13 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH v2 0/4] vdpa:/mlx5: Add debugfs subtree 
Date:   Wed, 19 Oct 2022 15:46:06 +0300
Message-ID: <20221019124610.208113-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 04554380-d81c-4990-3728-08dab1cff05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzRdjiUYRd36GEKSQON1STs0WLQEdkDl0/iC68XmmhWdcS+mm/sqsMlBBRzgNi2FRPJd+MXuSF3R/AgdjVVMST3lTHqVsqgxEuBIderwndadvQp8QIAx/COaAdtX1EVMcHmbyzfFEQbO1I05wimpeaIp3yEt5Hkn6FRcJAeoCfHv+ZGYurA4LBHWzRNF4kmx+NUVPhysqe1LdyY+ZlHOQDXmGsFT0dZ95yI7mdRR8uNFd/bruxkdU5JmDVxCwBy5iNlsHLplubyKvuJ/OkwMb1EqeuN8eHiSqxW7unXT5rP1ot/mCUdA+pgHw0knW8yzRZ3/Gd4Q6azwoTmvlQq7L7/Aaz+pJsv0uB/61+QpveZ7a5JTRdxJ4g7CjMkpfB3cJl+5mnYVlIel7/vkRFEkPPJ9qsVO7B1jWkwkSTZhxUmtzP4s2J9SPzmqcYfEkijBweswCPIC3QMDbyCKPUkxPKoXRZ2Vt/aTnXK2GCmvVZ2adfiKn5RDJ4yHcmhyYHh1ICbV8xQ3NsVy9e577pdoAZCmEpgKfNsAwgIyODaA8qAVWmqrm73+4tLRVxuBEC+V5XsChcmHDptv0Ha+G0Gk6Htf/Z2rjH+hIf7yQBiyq21++rCOvlrAp7/9Cxkvjg60+B5lGN0kYYvmQM8jx+KuMsL57YyKkIsqGO75ZOgIQa/Ad6tSz9Jm7vjmIvN15VNcEoKnYvjy1tfAWmtBKvXFo9up7JKv+IXfFk33sWHogzPSWdWe8v/5QgG3TOpQZ9YzcKX5aNGFzhRmScUFynnWhg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(426003)(47076005)(83380400001)(82740400003)(82310400005)(36756003)(7636003)(356005)(40460700003)(40480700001)(86362001)(36860700001)(6666004)(107886003)(70586007)(70206006)(316002)(54906003)(110136005)(4743002)(5660300002)(8936002)(186003)(1076003)(2906002)(336012)(2616005)(478600001)(7696005)(26005)(41300700001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:46:27.4265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04554380-d81c-4990-3728-08dab1cff05b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

