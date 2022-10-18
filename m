Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA42F6029F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJRLNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJRLM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:12:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F38B6001
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqH9DxOFbkJZjrdfrP5dWTqqr3amKC0JRoX1i6q7F65OsfRpC/QDQm1+DAY/qi4910mtwkx32Kp5hRoXf9JKrLmHh9GFMX5YJ5AO9NCSu6zblNT0YBaEkO4Ya3VF3frpm43Y5kmkv3pak8quzy0F55DfAEfsrxkKOqkjNAjivT3BK12oPYb4vaEqw0Rb4f3EhWJit8CrJ45maosgSMmX88NOwWNwJF9UnWiKczeH2+TwMHJBJrSA3v3AldL0h88L+wPdoYmRBd6YfVlTSttqe+0HEsFz/henCxFrI/Qmupb/w3UhvSX2tow0OAoAygB75m2dQMP5uorEVuLIdGMScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45Iz2mQCw3NL/3jnejqQNKhMOeAVsFDBnt42sesz8aM=;
 b=HRCnBBUyYZrkFOfkwZ/TKSAkfefSJ1Fh2D0iHGlrswVjfF9WW+4YgdYMGySCRH2paXiX367qq04ws1DpYPWYZwB0Xf/nJhd8unipkXEP3dvqM+qiyp0PHatrz56XGJQfs+PxopwhXx+ecTEaSPK5NclSipe0z/IrjnOwkOAcervy2BV38o/OMbF7vUe9q29I49s9jS+CHW0yzYOEO+4n3ZzO8iGae4RQ14HP6Lw6EYIYEcm2Gs96y72NFiuk/QzYDzrnK37FB00iPjmYR+ffEiVvvxfXAERChCCkzv3vjc+gXbSDJ78Mc/Lb2bXK5hiyUnr2K7PjFlSXqEnlqdnwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45Iz2mQCw3NL/3jnejqQNKhMOeAVsFDBnt42sesz8aM=;
 b=hpjJMXwNBODNdkzFcuxhnxFuv0N0KaYpAtpquKkwTS44p1vDL9WxSbGmoBBaK63C7Ofe80zqsVwSZa3Nd+S3qfhEulyTxPpvPFQYSkrsUbSz0mPzmFbw4Si0mi0JF6KHBoGctpzBDZ17I8aNQNs/3o2+3Z7ia8Su2aGZB7H4fhrP5h0vhDQfYSEtbC4aXL7jnGqox4SyEw2pnPQeqp6Q6laPz645qYrilGR2AmrnNzV7xK38qRdTxSUV66loPAf7ygIcymHiQPtY3iNCaWXOSPKwIb/trkRDcoGU/6eOBXW7dNGC91V7uH50FY79ityGfAMt+LXwRjQFq03liEhqLQ==
Received: from MW4PR04CA0080.namprd04.prod.outlook.com (2603:10b6:303:6b::25)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 11:12:53 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f6) by MW4PR04CA0080.outlook.office365.com
 (2603:10b6:303:6b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Tue, 18 Oct 2022 11:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 11:12:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 04:12:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 04:12:41 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Tue, 18 Oct
 2022 04:12:38 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 0/4] vdpa:/mlx5: Add debugfs subtree
Date:   Tue, 18 Oct 2022 14:12:28 +0300
Message-ID: <20221018111232.4021-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 842f2d26-4f81-445c-7048-08dab0f9b390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXe9j7JSq3/tvW8OQj1WSuk1rRB8E0Z7BWq8WatS9V/fbuLTibNq0O5UYrX1Uut+IgOR8fawEPqbXDbyImrdz0L+c39o24kG8PpVGmlzAJRpQTUi5QJUr7/ckX8vJWg07QtVANMFBfvmpTpLIyEK4p+e9jND4ZrJhi6O8iXCHj3ARnGpqV2KiOZOlV7HNa0f5//mxAAsS4dFqPHREuSdFLO6r3CjyzkqPrunBDN6TJEbb/cQCHAe2d3ut92M3bAPmaX3KanIV1f1E13xYSCiNIzV0ofzs3ws/dVeaFoRc8rB4wRyI6hCGVA0Qzmo6bG9jIzBlmj/A+ILXA9dlVScofFkV9+rs1zr9uBei+2QH2X297vgBJy0V/T8N6Th3aBXjp7AKHrit8RQ/noeYEkhjVD2Fxe3lEbe2LMVe+PhczrQ5rG9UEnBaogvuQnYPtt+O2bPxpXrl6B5CWHWgDM0ESgYlHG/sG0n4pIDbWE6bDcIdhBxoYggsv0XCNDFAoYfJzRrk3IroqAsnjofs1Iaz0/a+x0rxMVbpMTvYP4AJcihRPlCm1OPovSop3lbKCBNhNhV/WCz0uzzG7OA+awe1baQ59R252PU6eg+ZKh6K8k+UsQ0Bh4TlNjoGwl8QjJMTvrvbS4HlBWuoyLmP4tTjXM649zKh37GGRU5QxN5iYdqMus36ksBtp9EiChIo8Igz5DI1Hwv68h3zQBs6coh6O8BTjK2Xbf8KrGlBs0C4HWLgeyOd7Tu1QscLXdy4VWu47nu0pjk0XpdDQBCVzNqgw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(82740400003)(41300700001)(70586007)(70206006)(8676002)(4326008)(86362001)(36756003)(356005)(7636003)(2906002)(40480700001)(40460700003)(110136005)(7696005)(26005)(186003)(47076005)(426003)(336012)(2616005)(82310400005)(478600001)(6666004)(107886003)(36860700001)(83380400001)(54906003)(316002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:12:53.1341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842f2d26-4f81-445c-7048-08dab0f9b390
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
be filtered.

Following three patches add debugfs subtree.
First one just moves definitions to a new header file. These definitions
are needed for following patches.
Second patch adds entries to read flow table number and TIR number.
Third patch adds multicast and unicast packets and bytes counters for
for each untagged or VLAN tagged incoming traffic. This is depends on
MLX5_VDPA_STEERING_DEBUG config option and is off by default.

Eli Cohen (4):
  vdpa/mlx5: Fix rule forwarding VLAN to TIR
  vdpa/mlx5: Move some definitions to a new header file
  vdpa/mlx5: Add debugfs subtree
  vdpa/mlx5: Add RX counters to debugfs

 drivers/vdpa/Kconfig              |  12 +++
 drivers/vdpa/mlx5/Makefile        |   2 +-
 drivers/vdpa/mlx5/net/debug.c     | 148 +++++++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 152 +++++++++++++++++-------------
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  94 ++++++++++++++++++
 5 files changed, 339 insertions(+), 69 deletions(-)
 create mode 100644 drivers/vdpa/mlx5/net/debug.c
 create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

-- 
2.35.1

