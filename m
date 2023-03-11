Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3D6B5789
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCKB0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCKBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:25:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FD13B295;
        Fri, 10 Mar 2023 17:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPQrLEVxSlo6AWzt4AnIOr5DGxgG9yFVJ9K0EqpNVAJYbx9IyHxvYUq+xXwU0wuJRp1uyse4LiS2awrOyU5FZQCYxMp9rDYtZDj+r4rhwW+qWxIA017q7TRSfG3JDE2942BlYWfWhTYEW5EiicbKBZM39HeBgDafENMgnpXWyZwEgrCkDgvzDUfUIjL8mMRSMIB+tcKq9yZHLUOsfRMA7rN+p/88NhusYgirHz6Y5W2jqk/y5kNOeiqz4SAcuUh+UtBIhubjYJe1TCXlXkI+5h07wXP60/hXgpsWJdxxSjOPFoFdHWf4gn3wPCp42XqPpZekFFXRV16I1mGPv/1Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljybPwxd123VRCUzHa+Yt9ii1TuK+Oc8Nn+ybFcXrvk=;
 b=ijtoeB6N0+e06bhWp+221pAL8Qkf/oty6PAaJvUfza7cCnh9NJia/E9aqgR0E46il8E+5dE74fNz1YBIs7xwon/DZ0NJUKrSo4A+Ay1GuOVUIMSP8TQnQoQjbLfM5RC1Pa54sXH/X3stzWZqzW4Sr31rWVukBquKPztaB8bfRTBGl+cQMzhNnvsmkjFzP/B+hI22wuZDNBeHZSNY1/AcnXUze/bU4vbTfvYjHbGpmyqTaeryzilSMkIOzUW62Dnc7h2FV+r5Cul00IpumsAkjKDtam+RBjpWnIuBVdWYIDS+Na2U6N7ooK50j4arohr43bZ9ZKJIBlp8J8cHKIdd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljybPwxd123VRCUzHa+Yt9ii1TuK+Oc8Nn+ybFcXrvk=;
 b=NGP+VM7XfdMHU6EjkZAb3CZFkH73EUu/YC99QQLEdxgh+vTFIZ1j29GvtV2D0h2FcO9WTqZ3mKbtNh5k5GKx+naT79Ggk2WyF6Nv4aKrdWeIjk0YU4vMbHz/96AFydAT9cs+zDQHaW6YnrYPqq+ZJF5amDuVS0H2WIMufByA3x4=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Sat, 11 Mar
 2023 01:24:27 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::77) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Sat, 11 Mar 2023 01:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Sat, 11 Mar 2023 01:24:27 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 19:24:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 17:24:26 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 Mar 2023 19:24:25 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 0/5] drivers: remoteproc: xilinx: add mailbox support
Date:   Fri, 10 Mar 2023 17:24:03 -0800
Message-ID: <20230311012407.1292118-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbf2ea5-d881-4ed9-9664-08db21cf5b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktLGt11xA2uPU/j/hwkneHC3E7u6KNarft3RMHa6nRv5pvRb3aF6v5EhQr4kQX78VKi3yuHCEwvg1lz5wZAr/uaYtZQUQs+S5djLUwhjaLk1tp+z2syzUsVjfs0OGfd/PPNkXYqyA+QCJSJq5w6C+wVQYgx3Yc8qfGhW7VZc3SAWLp3VIu/DqsqCUkRdbslgr3NqWlPfop/CuI39tuIpDhKt6M53vmKLm/m/jaHv8zChuYDeJ14aE3weNKfoCSZxv53iC9ybKOes6qPgsjD8oAwIu690B6D9qowTlAw6YLj5E9XTGkcUNKg7iP6cvd6TkVUgl1+E3NeKnuVgyAHj9mUYIur2J9+HO4RCyCPoBu0XmtkRjpL5X4uoYnjQ6W495p9nSVNDu58Tdqx5z+IvBvobdA/m6fIc7oZ44HKNCawGbaCeSsv4TZuXIO8XXfmi4Y+kZsQjg9lQxvpjxXcNWvZEAOzzWsaMISZi8FgDE4T9HWIXJdzUbDLpRhQnTzn6GMSArO3kPkuCqlRTudGth9fa5UIAcuGn8uEhiswKciFpT9/0lJr5Y0Qe8yXiYCbhF0u/G2aAOeH22CfVmZgpP55t51lV9vuyGL3nRiTE63ybPnlUEGP3K8zj4L6X/zx00qSekYX/g689VArL/rxUfKfHFOFvSzu4xqehMBFNU1fiiGMOxoQ0P3ewnO+VgmPzhrQilh4Y1G3pqz//z7EJguGuPd73bMclq47r0Zcx8tY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(336012)(426003)(47076005)(110136005)(316002)(54906003)(6636002)(40460700003)(36756003)(356005)(40480700001)(81166007)(86362001)(82740400003)(36860700001)(1076003)(26005)(82310400005)(186003)(2616005)(6666004)(83380400001)(966005)(5660300002)(478600001)(8936002)(2906002)(41300700001)(44832011)(4326008)(70206006)(15650500001)(70586007)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:24:27.3412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbf2ea5-d881-4ed9-9664-08db21cf5b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds mailbox support required for rpmsg communication
in Xilinx remoteproc driver. It also fixes few bugs in Xilinx
zynqmp-ipi driver that handles corner cases.

---

Changes in v5:
  - mailbox node count should not be 0 for driver to probe
  - Remove spurious change
  - Include kick op regardless status of mailbox nodes in dts

Changes in v4:
  - split mailbox driver patch into 3 different patches
  - use of_phandle_iterator_next to get memory-region nodes
  - move zynqmp_r5_setup_mbox from zynqmp_r5_add_rproc_core to
    zynqmp_r5_cluster_init

Changes in v3:
  - split single patch into multiple patches
  - add appropriate fixes tag for patches fixing previous bug in the driver
  - make enhancements in zynqmp-ipi driver that handles corener cases
  - fix memory-region carveout names
  - fix multi-line comment format
  - do not mixup mailbox information with memory-regions
  - fix redundant dev_warn for split mode
  - Setting up mailboxes should return an error code
  - Move mailbox setup during driver probe
  - Add .kick function only if mailbox setup is success

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/


Tanmay Shah (5):
  mailbox: zynqmp: fix counts of child nodes
  mailbox: zynqmp: fix IPI isr handling
  mailbox: zynqmp: fix typo in IPI documentation
  drivers: remoteproc: xilinx: fix carveout names
  remoteproc: xilinx: add mailbox channels for rpmsg

 drivers/mailbox/zynqmp-ipi-mailbox.c       |  13 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c    | 308 ++++++++++++++++-----
 include/linux/mailbox/zynqmp-ipi-message.h |   2 +-
 3 files changed, 247 insertions(+), 76 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.25.1

