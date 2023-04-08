Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE56DBC4B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDHRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHRPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:15:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DA9039
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD332fSgpksFkl52WP6rya4EBEZCiFeHte7SA0ChIIrkpnbMmP6VI41Kps64T2K2HyxGhU5pihr3Mb8Pw8YiFTuhEgqpzW1WVQ7cn75DjJXL+BcTcNve6tkkvqtDfTa9orZcjLRTl4/x9SqwEAwnD0VOgVCfPfJyhaKExnPm/TeybY755v4xmmpY9J324+RZ62/fm61vlMJ+OFzxL2E7kKLlIhVCZzSoS+g/PoD6do7zcxC1FYRDUp720LKShXheuxVBLreN7ZJRA2H0/Hh7M8m1omKdINBBI53MVbk0m0NP2r9K4v8Lr1y/ExBnvqcbdLkDPOIl9J1vBq8dFEcY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V/CVnM1oV5/aB0TgsQUJB0Kj5td5Ui8rEtPCWIoNYM=;
 b=OwYwUhyA673Nl40SVFueDdUTWzAeFvdlzn6F7oqa+x1yKquKGu2rOyz4qYe0D/G2wUF5Rzn4+8MCGYsFtMUi7f1vD2y2uD9KgwR6af1Na9BOfVNKAtTpKIoIyUocr7zptVe1A6vUzOQdhuyKSoxXtUT1LrDnUbIQMb8DSJv+E0CW2p0nabkauqHSXPRD9NRx+g3CyzL6TErKF3az919q9NDC3TCwibz5HdsK1f8oOk8IQ/bhuKZ8do3KcevTF4VckaLnXjk4EpToMA1Ziaq5OeKOFf+0jsHO63wQ/ssSVqb8Bma03tDkWTa+X7su1gjNRotCsPAi+VGNcJAfPthy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V/CVnM1oV5/aB0TgsQUJB0Kj5td5Ui8rEtPCWIoNYM=;
 b=Pv/p0GVtkQQXAFXgJo9ju55k/Yq/PeId7VliMvrvHqyceIXgjAZsAYCIkSke+r5SFlsTEc43CnNt+tXpZh+qVJOa9TM3JPYgC93jBKatIfkw/CT8ivB+0tH/+fKiA44GaNY8fmq6ZbsMZHdbelqiBVqI7WEzpz+wbTBjG+Pvpz+hnF5gjq8E0mUGcOSSd6ZEs7MbI2EtSldO3ahXbEBYsnIeWb1Lr3GuYv2yWjrNU19UFfYb7RMeWLEB+qrNhV/50mRVSXj7YC97HTjJYNrCWoBtsqMSTcgG8gbdi2jwB8RtlBk6210rfKzcMbZ0GUVjlKrF7Q/WiMN5FvHTltXqmg==
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Sat, 8 Apr
 2023 17:15:29 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::63) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Sat, 8 Apr 2023 17:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.21 via Frontend Transport; Sat, 8 Apr 2023 17:15:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 8 Apr 2023
 10:15:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 8 Apr 2023 10:15:28 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sat, 8 Apr 2023 10:15:28 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 0/3] Increase the number of IRQ descriptors for SPARSEIRQ
Date:   Sat, 8 Apr 2023 12:15:23 -0500
Message-ID: <20230408171526.3059039-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f05d28-f6fa-4641-28af-08db3854da47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjT6rMMmeHgR7fVt9iPUpt35aylvZ8qKKhQnXozy++FBY7DiOgkMy1yosXUPXEpy+HCpetLZyRr5xO0zQS5P1dnHl/OsuBee+EZPhWhS22AJESudWzLLp27QmWBuW2x1UuG2pyxPA8Y+nELBCKNrvtd15+k7XbqgShC2tK0Ah2cFrXyudjONC4y58KFld/DYBuwIB+k21Z5whvvnNiAdLexC0xLAvx7woBIorJgrZUknNssKuKbp4YAddoqgPyO9Ii3ENhMSFgqZF3emBiFOzysQU1rptxV48n8u3I8ugL9+xTK+IQcDWCvXZfzng3Mxq1AfzNf5Ogkyuh0RQRJY9XtyIXUe+/bzmQ5k/J6tT72EevlLtS8ZlJyrg1N4eqsiIdsX/b/C5t0v3UA9Jj42c/eAPhABX7oK6YuIswcV7BlpcptAmv8AhgPsWHYv2Dvspn5xfQlC1btG11HjGWSsYUgPyEtaLW0a/0EpCrmAZWBO4o3w5FLHcXb/IxmcBdE2B3vw+j3YtuZdw5tCIBbSbpqBT4FC0iuYWV3L5ZERGQ+763Km9Wcxs++/j4okDNiThJb9fOvhYx5ivsVdxKrgUQmtM8oW5E4BJ1Wv27ujZrSwN33EbcSo7GDKs3XJeUY6QPQ7/wQuvz4GRFQbIT18cHQBEuWojjWJze0o/r4vMHWPrBm4uCI3aLQ8q2yGJlkDUGmUMKkX8iZlLmjFFtEAlR8tQbTgPa9n1CHQ4zerP/eEb/XCvjyyjoiZ5hAN4hUQBcTXVJus8cdbI47YvCyn+u0fumqy2pd1Ahb/iFinjeGQYq9VSxl1I0p8qgPE1OdNGJNqCJr3B/OsjGC7wdf//Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(426003)(336012)(2616005)(83380400001)(966005)(36860700001)(47076005)(478600001)(6666004)(7696005)(186003)(316002)(1076003)(26005)(54906003)(110136005)(4326008)(5660300002)(2906002)(40460700003)(36756003)(82740400003)(70206006)(70586007)(356005)(7636003)(41300700001)(82310400005)(40480700001)(8936002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 17:15:29.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f05d28-f6fa-4641-28af-08db3854da47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM64 architecture uses SPARSEIRQ with a default value of NR_IRQS,
which is set to 64. This means that only 64+8192 IRQ descriptors are
allowed, which may not be sufficient for modern ARM64 servers that
have a large number of IO devices and GIC hardware that supports
direct vSGI and vLPI injection features.

This limitation has caused issues when attempting to launch multiple
virtual machines with GICv4.1 features, resulting in the error message
'kvm_err("VPE IRQ allocation failure\n")'. The root cause of this issue
is the ~8K IRQ descriptor limit.

To address this issue, an initial proposal was made to define NR_IRQS
to 2^19 for ARM64. However, Marc Zyngier suggested implementing a
generic solution instead of hard-coded values. Thomas Gleixner advised
to use the maple tree data structure and provided most of the necessary
functions.

For more information, refer to the discussion thread at
https://lore.kernel.org/linux-arm-kernel/20230104023738.1258925-1-sdonthineni@nvidia.com/.

This patch series converts the static memory allocation to dynamic using
the maple tree, and increases the maximum number of IRQ descriptors to
INT_MAX from NR_IRQS+8192. This change has been tested on an ARM64 server
with CONFIG_SPARSE_IRQ=y, where 256 virtual machines were launched,
creating a total of 128K+ IRQ descriptors, and IRQ injection was verified.

The maple_tree RCU mode fixes are prerequisites, expecting all these
changes will be available in v6.4-rc1.
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/lib/maple_tree.c?h=next-20230406
   - maple_tree: add RCU lock checking to rcu callback functions
   - maple_tree: add smp_rmb() to dead node detection
   - maple_tree: fix write memory barrier of nodes once dead for RCU mode
   - maple_tree: remove extra smp_wmb() from mas_dead_leaves()
   - maple_tree: fix freeing of nodes in rcu mode
   - maple_tree: detect dead nodes in mas_start()
   - maple_tree: be more cautious about dead nodes

Changes in v2:
  - The patches have been updated to v6.3-rc5.
  - The patches 2/5 and 4/5 have been removed as they are unnecessary.
  - The review comments from Thomas have been addressed.

Shanker Donthineni (3):
  genirq: Use hlist for managing resend handlers
  genirq: Encapsulate sparse bitmap handling
  genirq: Use the maple tree for IRQ descriptors management

 include/linux/irqdesc.h |  3 ++
 kernel/irq/chip.c       |  1 +
 kernel/irq/internals.h  |  5 +--
 kernel/irq/irqdesc.c    | 80 ++++++++++++++++++++++++++---------------
 kernel/irq/resend.c     | 41 ++++++++++++---------
 5 files changed, 82 insertions(+), 48 deletions(-)

-- 
2.25.1

