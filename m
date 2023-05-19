Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC847098B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjESNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjESNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:49:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1AB7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qq2vhF3PwHlYWrSYAMIqcaU0JqANHdLnnYbe5Js8t7WTMoHlJ1ngcZ2B1T+stRTTq5ohuI/S74xpXWVj83yYj1sv1yxQSV+PtqzD5Lvr+FGmE8CBXRngwhou8CQ9y21ea8RHWc+W54MuujZkoCF1Zcq0VkitrYn+YMksxq8WKHaccEYmsRjcdJw0wEGKiypiPp+IEb0KaO7+Ex4X++GrEpq0avWTxfuw9FW54AABy/q2c5f1bghoKUAiQylvHfjet8uOGD6N3h/6xBCl0P6aNQngHqnDzo5oXhxc6bSUlxmjAJ7emiiVHpUvEXDqJPCNl55iYCDqwZ2PwfjRpqZWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNdZZa7Dc6hs4P0S4BVnFCSsuaC/COnoNWC6s5xYuVs=;
 b=NKFqnlirZOHpizrVPHrcz4Pto+DhUv/GtJb9gAh2a+IC1t7HcH1QUrOi9UqucJjQrIfKno196vE8YuHIt29FKPTmUaSu1iR0MYLcu66Q8BXkvhTFJDhNEMMHHeOXcmFEhaBKcmfDID0OzB8fuJoAFn/19+wuLGrbMidKfpJJQBqkDLIVEcEfv/0VY2Ir3nJRkXuWVy0K57uv6dJJkzW/mexv+HLc4pRJu6aIQj5tE4frc8yqmI7oRUTcSmV+gS1gEkRVLSmW8A55TH1833BaS5x/vxV2aAMkbHxA9wU9+mwKej33qrVR/SzchPD5qPucHX90kXT+RFofKkYEPVQWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNdZZa7Dc6hs4P0S4BVnFCSsuaC/COnoNWC6s5xYuVs=;
 b=q1XxHtvKymXL6qPvbcgsvq9BgXOFg0B4RswFQ1zYnQj9vtWohbxA0YlD5YFcSqqtAP/gZq/hD2oMGraGFq5V/r834mbO1xjp5qgqDohV5Ffpp4ZYCYVUt0UXzZkjXqUW3v6FVu9/OSLKehnLwkQH/noJGLS7mW6wWHvtReMNBu/vaKVmr0MQUiDpoW5RTl8+0eNGOBibFtPt0fCAiUtSCpAhmrwX/4IAaqfeI1MqP3ym9Ve2L//z2JZOklJBBZgDdrQj+3OxuLhklpf9am/qDxJ3jDWF6d5mIfg8xwX7faiQ50D2aKJe7Vu9ckf7jt+3DQMEVCSsCjCGWA/wBTfDyg==
Received: from BN0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:408:e5::31)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 13:49:24 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::51) by BN0PR02CA0056.outlook.office365.com
 (2603:10b6:408:e5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 13:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 13:49:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 06:49:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 06:49:12 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 06:49:11 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        "Jason Sequeira" <jsequeira@nvidia.com>
Subject: [PATCH v5 0/3] Increase the number of IRQ descriptors for SPARSEIRQ
Date:   Fri, 19 May 2023 08:48:59 -0500
Message-ID: <20230519134902.1495562-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed87924-022b-4974-aaba-08db586fdb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSeWHZEkx58+fvWJaoq+WwZEYN1pGzeb8RCb3fnAOg2MxHjSrhykYnVJvo/EnLtpfFluXK2VDR+3YjIYqVq9zRTouhBRqt5EIFS+ug0kj3753mqvAw9XI1k19VIYx+hCdfNCDw40fCaEjDd1Sm3jf2CPXeNbE7jlsrGIz0fLMw3w6QDaANaFHyq0KLLZVbHnCld7mDBsyp4o1KpcyjIvVSftGmz9HHnRqYV/28azxoZ4EBhIBxGMPGKONZ3YKQYSGWAFHOXAnLgANZIbOLnoe9axZkIKikaZrJDKeWr0Z7dJBBA0ToMI86Hr5/m1UKBAlDGzOq59gAEPKRNP/BZr27OC4MJVIpol2L21KfJYd1Ut3XrLeSDDe4wQjkW/Sn12dR0H2T7vwrMCLb8nXF/8TJYMuZMpEhp+TTTSsMTmWDk7B8VJV8gXcMn12tCLVEzohFUIjSjwF4Yk4q3+ogE4OkN1Vg6z5G7tMxHlLwg8UIVtGZ64Sw5P4d8h2kUo7KXkDQ5FAuTTXFcPEKs/WTg9yguUXR7//CY6ymhFLFrYNuTVk0Jf5MxRJ5adk5yUJ4GRNlAAW7S3gTLIcqkdkSYLUWr3KFNsW4SF93F6BAYH6BBblpkznw77TvEl6beFbw7y8aFwM4AXJHYO+TSee1z5TvwP/ZwM8KD3egLYMqjzq31nsrS3b7Xudu4VwK6tDGyqIdUtbmoUZLX8XpCBOLTx5jsSJyxGOAIHyxBIi1qxn0jgw/pU0DffFY9fwyNcG6y76RKbg2skHeRx4ZpSijg8YKivLcecM6AYuI1n4pmpzS8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(86362001)(8676002)(4326008)(82740400003)(356005)(8936002)(82310400005)(336012)(54906003)(2616005)(7636003)(70586007)(70206006)(316002)(110136005)(36756003)(2906002)(83380400001)(478600001)(47076005)(36860700001)(426003)(40480700001)(6666004)(7696005)(966005)(5660300002)(26005)(107886003)(40460700003)(186003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:49:24.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed87924-022b-4974-aaba-08db586fdb40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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

Teted on ARM64 system:
  - Normal boot with ~200 cores
  - CPU hot-unplug/hot-plug using sysfs
  - Booted virtual machines with PCIe device pass-through
  - Hot-unplug of CPU where vfio-pci interrupts are bounded

Changes in v5:
  - Change function name irq_find_next_irq() to irq_find_at_or_after()
  - Update comment to reflect the return value of irq_get_next_irq()

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

