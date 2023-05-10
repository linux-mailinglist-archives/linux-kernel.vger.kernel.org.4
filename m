Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A86FE2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEJRBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjEJRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:01:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F32527C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4krfQOv3QA7KMUqTMvhl5q4UEG/tg21h/9b/pqMgu32PBBYMYP2ZoqlWNkj4PFEZJ7KsrLM1OS9xPp8a0Zyr5rrmw3PYyqX0v3BygkP1UvBeBfsk0nhwifF02yzM8OGDmv+8NMX7CsyxNTUWExH53vCljnxWv9d9MHegCj64J4I9YAi2FhmmdG4oa1Bk+gB2yKaD9Rr4nUlTD6rkJeFQDQQ/7KNt137kb8Ys8PcyNwcRAsI/Jrth52r9KO81lZPoSpGV9eeMALGR2yfw7Fby5EsVGw1s9n1y3K5zOHCbI1ZzILz5Sh6tDEu+as0bsC2uLe+qmOtUCKxgBVp5ywGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itVWZKmRUTotxJLd0BTZCVwmXmOyfUHHCteU7C6xKZU=;
 b=iZ7GHF0anULFGNf13uyn4KNj00+NJBH+AP3zg4VHIioQVg5P/ZE11BZTZBtTfgxiK9Rx3XtCvcuGy/ztfWiAtXRzs6z9sEyE+bOXcZ5wcabRdlBxWSxJMMIk8Mjtg9+6mwicq5lyMIskT/VNGYj5QrieZtljXsHtJsFJ49lXAtVMTltfG0Y2hcVywdYrRNE55xy+r+sqZr/O9uJVbqCI/g7I1/D5QBqwbJFgY51pQEEle5UeHc1Hp7Afpk3187XG1GGrUCp60ZfYDejUsO79ZZedwMv3ksiRzLe62Xn6J7zbRDVEATy5Lp59BiLl7B2FStxZu1Kh+hYZiztI0XMw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itVWZKmRUTotxJLd0BTZCVwmXmOyfUHHCteU7C6xKZU=;
 b=RWEqPxcNns+ODXxGtQxg4O9ORyUkiuEX9x56qZrUiEsW1iNoZzjgcQtyK3vwfBm+KUkTt+VXvvzXZvk4mZa8CdlzFhCc2al8UHY4UwTkJAhKezo0TZRO4iKpDSlF/oqy3m8JouPt/ftmmRLZZZ/C+HGtR8Jjf+xF3CpZOT6XdabGI2VI68AMQjqxhgMeCSt37LbcaidJdYvdYXf7s2TbDNsBFEBeTzTHl7oDsDBirzZirtMnm51w91EHkuGe8+11Tr5+r/2sKugc1FD9tuR5nhZo8jJtUDBrM7zN7jU89b2bKGKbrSrZ/EP2ABFECqMPus73QVVW/Vx+U81GLUsRrA==
Received: from DM6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:5:134::28)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 17:01:02 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::fe) by DM6PR13CA0051.outlook.office365.com
 (2603:10b6:5:134::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 17:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 17:01:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 10:00:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 10:00:47 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 10:00:47 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v4 0/3] Increase the number of IRQ descriptors for SPARSEIRQ
Date:   Wed, 10 May 2023 12:00:30 -0500
Message-ID: <20230510170033.3303076-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 905caf65-2650-4313-e242-08db5178228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Jt7NfsPZvZfT7+v4SLayp2kCNjZMj3CPIswaaku1lKp3AsWf0WfMeK405aEW+X03XD4Az68eSo2hgcvY2Bqt+llL9eQXGViF7Ljk4Dkow//zorn6TPT1IQ/IGbHim4YEIwsYRTLuYw+hkIVk4gUQLpwcwKHhND/Xg8d80o4+zAmy26fkDRd7XX5a+Pos6fscbBaiCNQoavlbwQdWLljsAQnsdf063o6A5IogLSi7afhDfcx/jRS2AjuvfBUysvXhF4aSacPfwD7fOuokGOqrmfFsfwK2sP8UEnpxcNk2IP8CyRDzwE1xChfYT9b+yWjIqJRD4E9RDmO/Kw8zqFy/omfffyYWUljso5iSVKQjDIRzq9dv7q/6/aFwMK9z76DEq23dH2NMS7vERk14vozShUfV3xNDofaBaJ9tgvqbHuyZJSbgU3ylHtRW3LXtMss4JDmx49rsUP8S2d7PiN0SUldly9X3IszHiV3+AffIe0SPMhtqZlEvb2JChmR3HXrSIaEOT30FyaEuSA0ZbwdcxnvIn+mGWfsKFSFGXZgBu0AHO8+9Y4Voa+H8fihoMuHbNuy0Ms16GqBaPz8NnsiyrefRVWqKgNVWCUq5aWicLHBS9ZaGmI6eYucWTL40BWaG7dA1S4eRdGXS8JlEbUolsA/V2I9VoO/yh+f69MK7PqFw5NkcDoG2O+Uw9SX4MewnuBhMIdp58ue1GXwzhpdg4IZXKcluEZo9mZYAulPYPPfN8sH5z2/yecBdgxL5U1/
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(54906003)(110136005)(6666004)(8936002)(7696005)(41300700001)(966005)(8676002)(316002)(26005)(1076003)(70206006)(478600001)(70586007)(4326008)(107886003)(2906002)(426003)(83380400001)(336012)(186003)(2616005)(40460700003)(82740400003)(40480700001)(356005)(7636003)(47076005)(36756003)(36860700001)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:01:01.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905caf65-2650-4313-e242-08db5178228d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Changes in v4:
  - Fix the iterator function using mt_find() instead of nt_next()
  - Tested CPU hot-unplug and hot-plug on ARM64 system. This is 
    completely broken before v4.

Changes in v3:
  - Edited commit text
  - Added a helper function irq_resend_init()
  - Rebased to v6.3-rc6

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
 kernel/irq/internals.h  |  6 ++--
 kernel/irq/irqdesc.c    | 77 +++++++++++++++++++++++++----------------
 kernel/irq/resend.c     | 47 ++++++++++++++++---------
 5 files changed, 86 insertions(+), 48 deletions(-)

-- 
2.25.1

