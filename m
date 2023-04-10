Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849006DC8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDJP5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:57:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5A83
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLYksbZITsdForqitOnziXhCpwUzCgeJRhklKwRBxZ8hB4mYZ5rZeg7cztKSUweRDOLMVKeus56+TIVTCiPkkZ4d74fJK3jp3OQBly+uHiEG1O9K1IK1vz7HFxAxK0DQPPn/0ZnuCop3SYxxzB2jyLQ7TNHb7AYzQMGpNeAGQZq1UkGS/zN6ZHjl7VsEM+tmmkuTwrn7wa48JqKRnLy82ZCCkJVX6e7Tik+Ns6lqDVVgILOtSucy2dhwdlZFMgFlswsQFIOnE5xTSGI0ETiesnvrr8rCAGtcogZrWY5lVncaQVOj4aN5znFMK+Zy+W9UbmdZ5Z9OtsaiTUScpPdBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+C31CwP27YVNGWGZXfDeXjRnIAWwy30G3ykKi+Opec=;
 b=BI0fHbcxGnEpvNkdBPNYyjxfQMehGL24/c+lzY2+ljn37rizA8m3YEEIYZD7G1um0GotkeZzniMp6KfpdSRENbWe5Sw9wdRHpMEK0UJkbS0T3y9f6GQQX7YqJmoHJzD6PdAc+xY1ILdhFETTBzwiSA5iYqFwfmlITfOGaM0IAXIxekBvNMGGk8ZyoY1xdImsPiMbBy7vB07eb6KeBaoFa02NFid7juWfJ2ZWWLVbAbE+VgizP6KPqp4ZMW8CtngY7XpeKTwOz/3ZjJtpN79tq2xQCXXgnVw1oPzsxM2fuLceONd/w4uhjUCy1wgVXNPrboQ2OPUnzqNMboJnaFFSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+C31CwP27YVNGWGZXfDeXjRnIAWwy30G3ykKi+Opec=;
 b=myAyb/TA41l9px4jWNcTkSGIxMSKxj3gVk5EGSa+iFC3vqvfxG/2MdW2lFfVsZEs4gbFzQUZvaKc4IrwhNv1hX4ENLCQ9dS5UsQc/Q25LmqPWAsM9Q7Bd+xGzBGznpKpLGwTxYGOR5E808x0bIW0bMFzJ3glLlyxl2igOwW5pR1yqD7qkm833TTFeuW0vnC5i3ZG6WXM11hWf7VV2S9RXX2wRO6cG4jeuEwQmtgRdgu9IrmMFoP2OnOCl8GbULho8NS12tkYZ8QSFEfmyjERlB41H27lJJd0UqG2rS/ddB9fUHBurHsmzOqJ/2av+raXUgoui7OfomNphIglIJ6iNA==
Received: from DM6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:5:177::18)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 15:57:29 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::45) by DM6PR02CA0041.outlook.office365.com
 (2603:10b6:5:177::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Mon, 10 Apr 2023 15:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 15:57:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 08:57:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 08:57:23 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 10 Apr 2023 08:57:23 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH v3 0/3] Increase the number of IRQ descriptors for SPARSEIRQ
Date:   Mon, 10 Apr 2023 10:57:18 -0500
Message-ID: <20230410155721.3720991-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de02d9a-0dec-4a40-6b50-08db39dc4953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+b0vJTe3Mlt4iHVr3F9S1Jza2jcRFYoq1e0vOisXR++KO/0dIUYrOSwqjOl9JPQpHA63uscYxAmjmbxipUb9pQXK/B6vsVcdeQZdNzZDzEt5ZYMrNP2TBdXV7YBfF4nhDe5YcollBMz5hluBTLN4UIrdOzFaxAB8Mo9RIOJD4rrcvfF43DHuritDmyaDsHu9taX34qTbeanbTfdxs2/5+pV1egVCfyGbURfuEPILx96x1p+e4DT6W2t7sNOmlzhU64ly7XqMiBMhYrahis+1FuaJxK6BE71lKDt3N3Cfpzv5Jnqu+actPzFo3+nJ76eH2AxUH0p7Z6+Tx1udHqaw6GgfNxEdzu2pwpfRzHTYj6lN1q5c3NAzLUJpsnI49kKukhnj35Eg78Ovnrco94ReuyoOhfalyOs9tww5Ct7dHzwRS3CXzo9+EXCZ1kgVX5n4pDuqKZcCoqbuM3ibxsxY+4ZyFO2BM6n4kE52Ue6sEFV5VWPMROZUwPLd6lSROI/aTdj22m6HqZXY10O1TTQeQ9pR5cXXm2TFsdvamfZC2M2BBVzvbniF37uL9U47YMC4bqq5/93Y1S/yMisyKFQ4wnMa96GZPRvRPp3kpDLkyiNvnoKp4abyP410aUONxLHMoKfeMrJrMUGldFmv4wrWO4zEGE+xs7PrE6eWoeHmgRQ2wMtr4rEHS+OL7BRBiTInzHse959k8+vH/39lH1JAXT0ymQ3AeiDG1AA22OrOTJWvbFqwKgzHJmAg+GMSn5Mo/R9C4x6tVWFqke0tQ12GwMQSq2oM4yO+gCMxiKpbL0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(7636003)(5660300002)(356005)(41300700001)(40480700001)(478600001)(107886003)(82310400005)(2616005)(36860700001)(8676002)(8936002)(82740400003)(83380400001)(47076005)(2906002)(336012)(426003)(186003)(40460700003)(1076003)(26005)(86362001)(70206006)(70586007)(4326008)(110136005)(316002)(7696005)(54906003)(36756003)(6666004)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 15:57:28.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de02d9a-0dec-4a40-6b50-08db39dc4953
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
 kernel/irq/irqdesc.c    | 76 +++++++++++++++++++++++++----------------
 kernel/irq/resend.c     | 47 ++++++++++++++++---------
 5 files changed, 85 insertions(+), 48 deletions(-)

-- 
2.25.1

