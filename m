Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDF5B45F6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIJKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIJKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:54:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B446475498
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyBaSELu43LhtNyplQaJbp9k/6PQyhyXf/Kx6KDxCSCnyjiaPfzACYLkYd5OX0uZHD2YX/bBJqRJAd30KKbNf9MmOnlxWUbH/ROpZ50qJSCGm8uQ0A4QriQJ1N9353zkSND4AgAEsbW6lV3eh++20PcADk6EnQdKgvOiMiLZLCRDfrFQCS5Kp/jR3ffGmhOlaHCeL2gow06JgBNtxnlOFxdHlL/Vr/HbiAswicgwVL99nb7TM0uFttKrwbUuHGnbgrxRlJjNo6wNhL71Ka3KpzSy3a/loSoGQ5I/Go7512lZ35zsP8gEMvGYX3Zj+meYJlF74mpJOKwvlc+70uT1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyfB89CyX9zg46zzrPCIK7yeupDiGt/ISg+1JvemhQw=;
 b=eMfON8e69T1GzTXPD73N782GEu0ljhea+JyCMpjoaH/BRHvWoySGE85ap4PdVhKv76M2Afo/YrJ/mqPuNr5oY0uq4GvHHIVRTCc9MAhhPjKTR+B1IaJFpwyoe2XcPLY0Vxj6oOTWJJ1fXAUybL8Ht2CsW+uorPG/muCHis0QxsPDk/YqdYv2mpZmkHoKleFFwDf5Z0buDBSXx8X+WdBbrahzj7ucTuxnC97KKuXH6ISv6ci5/m1RdFz1IuAGGkTgJ8KfAGhVd2QoLfdIXbkd5DTmeoOJvK/rOZMWWacon5kQktQztBknooeuTuiNAQG0UOTMewG/+myYLC2uiWdPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyfB89CyX9zg46zzrPCIK7yeupDiGt/ISg+1JvemhQw=;
 b=d5v+DfguYhQDUt0vhCYV1eENHPk0IcjLCTH8ebaVWJmvzcNBYR+BQNbqcjniw3/5HScS0K6JdwVq8yvMKvSPE6cdf2jX+kZ71IxI8P7IoNoba/R8kSNdXYQlD5gpVffeIAnNqTuxlHW02qA1TlE5mxIbgppAXDg1JTRx+t7BhrM=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Sat, 10 Sep
 2022 10:54:12 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::7f) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Sat, 10 Sep 2022 10:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Sat, 10 Sep 2022 10:54:11 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 10 Sep
 2022 05:54:05 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <libo.chen@oracle.com>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <peterz@infradead.org>, <song.bao.hua@hisilicon.com>,
        <srikar@linux.vnet.ibm.com>, <tglx@linutronix.de>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        <wuyun.abel@bytedance.com>, <wyes.karny@amd.com>,
        <yu.c.chen@intel.com>, <yangyicong@huawei.com>
Subject: [PATCH 1/5] task_struct: Add field for per-task userspace scheduler hint
Date:   Sat, 10 Sep 2022 16:23:22 +0530
Message-ID: <20220910105326.1797-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910105326.1797-1-kprateek.nayak@amd.com>
References: <20220910105326.1797-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ddc50b-b5af-414f-32eb-08da931acb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptiPvvitnscJu3qSXrptfxRo3miqB/xZBMp0t8VaCdD8rsyX9oEHh2fH4k4UyH6EVcH3teDt/vgF32/EhoHoOYl3EWYaT2+qL0kZWQPke/EVr+xEIVn/K7Zf9fTeshTTRrnJqIjFaLE+SFfmQRexDC/Gup3mZF90lEoI36kXIH9acR4EBgWaa7LngVLZIRil76MU1PQtoM7PpKg9jcuvImK1O1caiLr/IGDGa7sLE9j3C0OsJXIQMluHroxYyLJjrm3ga12Km6wk5HUHdGWc0uMeFhwbRGG7MYpKkyooeiSIe5GSMTYHSYo/nPZR9qQ5QrWe2djV7LHB19vQaJwOigHq7MjJL0ZiM/ydDcddpm4O38v6zktR+9z5SHUty2cYTDzRfoJktc+Poi6N2XyDbh7C9oTKCa4CYJbqzd0I8KVYaJb7wJGEF9T2+4V7Fv96haAh9GSyS7feiC8nPLygbQIQg5XOz5GM8qGlfFfObm+MECxh0i+FEitMHs4+p4shGNASiZFt0LZJilNVis+z0nDyvRorVl24VUJMzWZG/N6c00vVWZO5vxNr6bgK8/81BFQL4+Tw8PByqQnW90i/ghBZ/xX9K+dZYfoo8byRvpXxWDclREuXVHUJunTXJl9GL51s2j5jCMB1i3x8kFMrXvZdhaR2B/n3tVUJnW4M0qCx9icrg5gj2XG0HWYw7MWrYsqL0H9zHZQr3nA8XhVJTQfFtQJNZztuiFXCymFKHozXEaaBzqwBmifKYtdmBhiibLLpK04yWC/JWTk84/ZgsxSfCHHqYpO42xJqQiHM+kw1ifoGYX4LNAKn585kjn+B
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(86362001)(81166007)(186003)(47076005)(336012)(36860700001)(6666004)(7696005)(2616005)(16526019)(478600001)(26005)(1076003)(426003)(70586007)(5660300002)(8936002)(40480700001)(41300700001)(4326008)(7416002)(8676002)(2906002)(70206006)(36756003)(82310400005)(356005)(316002)(82740400003)(54906003)(40460700003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 10:54:11.6747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ddc50b-b5af-414f-32eb-08da931acb6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a field named "hint" to store the per-task userspace scheduler
  hint set via the prctl() interface.
- Hints are inherited from parent on fork. Inherited hints can be reset
  from the same prctl() interface used to set hint to default or any
  other value.
- Hints are best effort case and scheduler doesn't make any guarantees
  of strictly adhering to it.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h | 1 +
 init/init_task.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..fc953c9e956a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -769,6 +769,7 @@ struct task_struct {
 	int				wake_cpu;
 #endif
 	int				on_rq;
+	unsigned int			hint;
 
 	int				prio;
 	int				static_prio;
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..f5208e6a1934 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -79,6 +79,7 @@ struct task_struct init_task
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
 	.policy		= SCHED_NORMAL,
+	.hint		= 0,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
-- 
2.25.1

