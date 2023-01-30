Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE668035D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjA3A5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjA3A5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:57:38 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93810429
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:57:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBG55vx48Am2GQjwPNgkU4rmJvXusjBzP/jMlpaxmQqJs7xBvfIN+DYbK8vhvJvMsZgrfrPZsUwXIgCeuPvhiYVfcMbwmtabnrjp5xbvIJsSTDtHHcVPSPMsSANmgeYNRjfshd6jT6VwPZTOK0HEup6i/eee4Rakq/anAHzNRBrgJYxt5osko5TEkOFgcHu/WdL/SZYot3FIbFecjPduqJwjpNQFZRfb3EgFez/fZnEGAuoF5Fs02wpBCxuXgj3mI5WOGD3hPyOO8DphEuJroceK6j2nwMqKuoKmI0f9jc3gKhdr38572cVEb3bfLj2GvzFBxfMstzCMs0h8mU4dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5+hfeHOVGNJnj25qIND1H6nLH45g+PRVAK/8jbTwp8=;
 b=eMhtmC9qe+EyvC6aq2h3JRsHW+Bd66tYmarPkV9ax9h49ENPLc922PPNYHA/kncvfbzQNFP4qL1vx5fr/KbMSG4G3tRWMmfXZdgQ0F99hvdm9oUL0h6RSsPDU9XO7BWwtc1BF7YXWAFBD0zXhcBdd7AGWz75ot+NZ+8WtjSCeUrulENpQryvGlMVw2Dgc1GzkUks6fexfFd/cP8QagBF+MbuCH+4xxNPGR/ErmQUrUvYujk0s1/50784IuR0lXsWJqQgqS5BshRi/G88TZixYMSusgsc2RjNzEswoUZAV7joWBeMQv5XlsvZT9VWGtagvXnzZbrcizJUU5t42lsWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5+hfeHOVGNJnj25qIND1H6nLH45g+PRVAK/8jbTwp8=;
 b=hveCK5h64BTkHuv/wkJIwCeyZQB9g5W5bv/7zWRN+aAiMd2cjLPG9Gcpmkmbcv3MjhkrGjtyRW/rmBTfMDFmQYi1LvDeFLRKHHTIKXUD6pzK0Rp+rebhYk+ttxP5Tv5M6k7AD5ghvGZzI3peUwHj0pxXg1XUCkZYPpdFO2lF+Vpeh33ooq0Jh1ub+e23u2R0V/70hcy/2r+RTctiYtavyytLqZzntUuYaUwcdMe6LXh0utc/Mj0W/8/yTv+hN9vF5VgipvTdcFEpgQ/P2Z+WiECkxYnitO6ZHXEy0ZgQnuL957tSl/PNaqGHI8UHIC9LoIyCZEtW9+myiRIOtoATnQ==
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.30; Mon, 30 Jan 2023 00:57:34 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::6f) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 00:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 00:57:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:27 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 16:57:26 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 16:57:26 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] Increase the number of IRQ descriptors for SPARSEIRQ
Date:   Sun, 29 Jan 2023 18:57:20 -0600
Message-ID: <20230130005725.3517597-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: d8861552-528f-4dab-e547-08db025cf8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8crjOP3QmQCfTJuHYzfgh2caNHLGQzayDeZ5Ivnf9PhgPiRBrAYcaXwswdPy6hEijJrRnvgIMSxiGfVWGwxROmvt0ZuhWpUCEAqVb/yMc55K5+9t5U6pwxqe774R2VSaxpo3SUO25Y1EdgY/yASvuq2lZ+moVdTDiCVopdi390mF+muBAXW/qz4jrFykyY1rwOql+rzFMpk69GY8UHQBt2zSZUJvveYeO4Al09Td3HRqzYf4Cmzx0uWCygI/3WIKVGiZWnAkBBQ2g2QRZQsCJ1Q/3UxHelunWcGeWnNW44dbHFmFtMTfgufasAJ5xUv0kM2hBCMnGtMoqhvZGksgRp7BB3E0nWKP38mmEf2CvHrEYeQMFghWBPv9yfFqh0MCSz0yyQyKiSbkJMp5EPFE3rjB7baIV9MZDqWtWx3IpBarVqoKfb4FZtSsz8uO8+Vf72IYgWeA5oVSFmJqHnCOf8lK+9JT2dWGYXN6FQOXSYSxQxtcrwNxqyPV1eog4eBw5OjYXaM6rUN9gR8INh+qOwoN0EVQrgMwsqTG8YiVfGPsKEf0IkyUIaR6RJh/zTHsGWrFFivQHv4939SsAWD/vdasyf33t7X39TXETC0ZwcUIsEoJXxUrYJehuu1L/C99IUvKTGRAHZyyQcW+Yu1fhQwvxfPzhZya7Wzp6yi6s6EDNSRWj7wwvJvOmoIIYnd3Fke/3xZMrE7godbtsv0DFzazsapLCvHsG02VMX5ubJvM9rOdve3DOVZynYo1AL+OrNtB3GQkNXEeJ6qNBUV8qg/EnA+DH5OWtzQifkZg+kKYe8H2ocnaYYVG2/OmsSQP6eAr01iabpajHapiEGbbuA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(2616005)(7636003)(82740400003)(40460700003)(36756003)(1076003)(186003)(356005)(26005)(40480700001)(7696005)(6666004)(966005)(86362001)(2906002)(478600001)(82310400005)(316002)(54906003)(110136005)(5660300002)(70206006)(47076005)(36860700001)(41300700001)(4326008)(70586007)(83380400001)(426003)(8676002)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 00:57:33.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8861552-528f-4dab-e547-08db025cf8e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Tested with v6.2-rc5 along with Maple-Tree RCU mode bug fixes, as per the
information available at this link: 
 https://lore.kernel.org/all/20230109205336.3665937-1-surenb@google.com/

 [PATCH 1/41]  maple_tree: Be more cautious about dead nodes
 [PATCH 2/41]  maple_tree: Detect dead nodes in mas_start()
 [PATCH 3/41]  maple_tree: Fix freeing of nodes in rcu mode
 [PATCH 4/41]  maple_tree: remove extra smp_wmb() from mas_dead_leaves()
 [PATCH 5/41]  maple_tree: Fix write memory barrier of nodes once dead for RCU mode
 [PATCH 6/41]  maple_tree: Add smp_rmb() to dead node detection

Shanker Donthineni (5):
  genirq: Use hlist for managing resend handlers
  genirq: Allocate IRQ descriptors at boot time for !SPARSEIRQ
  genirq: Introduce two helper functions
  genirq: Use the common function irq_expand_nr_irqs()
  genirq: Use the maple tree for IRQ descriptors management

 include/linux/irqdesc.h |   3 ++
 kernel/irq/chip.c       |   1 +
 kernel/irq/internals.h  |   5 +-
 kernel/irq/irqdesc.c    | 117 ++++++++++++++++++++++------------------
 kernel/irq/resend.c     |  36 +++++++------
 5 files changed, 94 insertions(+), 68 deletions(-)

-- 
2.25.1

