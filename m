Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787096A6C35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCAMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCAMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:21:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038F3D924
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:20:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNsf2aPvzoqczlB90Yj+spHLDgev4xcv6HC55MvCqhRylyXp2qgDxvP18fgiiqWnwLeHVBwOaahTvlKU5kOoo0jIAYwVdCMrsz9Z/aC7gbuEmhsNie+YiOAmeoEHV6stD+I7DXjAtOKw/7kzS5rPyXktkMCHUSbirjfSWgdd0W+cFKS1h7GLJZimP4JSyh7ap3xpmSDs/6hgdOvWsCPqeexWvJwOvtJy49yzyssUCWIO6+ykfblfrs6Y+njXNUFXpqm4JdAt8eyvypBTo6Ws9YevD05BDdA5eDiHnF2Ap9RHs8Gbq6at5aobENx9MJl2TYutKOQpsKmUsysW/8HAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdMpUlZfRBZwN1PTr9bWybieMaYFtQSQWlJlEbRQxwM=;
 b=Il1NgZgeQJomduZG1nMQ9UAZWNx9ONTvWC2bYSB5myEAXonE7hy7JKQ5Oh7223WLALq/PT3V30m5BYSD9QrR+M64n7jjT4CRT5iLAfOKguWMM29wBMqEYPQElQknGaIgnaPDxazkx5oBOTzwj2NSZMw2c0BQEEaf45ZK5TM7TuvQyxBjzV/yUkD7XGmTUPwSluZxX1oxMWF/FIS9591SUN0tYeDfZTwiZNdbgVJ48KrNf8gWKuuAihMd8dqJUeArULufEFcGv8im6ov3ThQ1HPCv68udYIxT2M14i39UW8BPt7bu/pBmXOi5beQdX93qzPqTpNu0hTgWtdlNm5UJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdMpUlZfRBZwN1PTr9bWybieMaYFtQSQWlJlEbRQxwM=;
 b=Rmu06Bt7FLjf++7Rt11aqHe8g5V+xIFq83p6OfQjsIR4lxpnzj+S6Tkh+F+Ek5Ls5S2/N30nl2K0Bv30mup/B8RJJwX6YesvwCKKpFT+JgEG5XML4dxDd6ylqNUdRCzVIbOu9gk6Ed6iQbw2J2ev7QUstF9iNeeORE4foxTTupE=
Received: from DS7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:8:54::13) by
 DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Wed, 1 Mar 2023 12:20:45 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::ae) by DS7PR06CA0046.outlook.office365.com
 (2603:10b6:8:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 12:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 12:20:45 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 06:20:41 -0600
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
Subject: [PATCH REBASE V3 4/4] sched/numa: Use hash_32 to mix up PIDs accessing VMA
Date:   Wed, 1 Mar 2023 17:49:03 +0530
Message-ID: <d5a9f75513300caed74e5c8570bba9317b963c2b.1677672277.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677672277.git.raghavendra.kt@amd.com>
References: <cover.1677672277.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8772a753-7205-425b-4101-08db1a4f61f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUyQQgl9aFxV85LK8rx/q3JVAvv44lxplMSP7vlD54/pLOEIAmeCypYMOtR5c3crYehAU79/0IRA62FD/kUlh0HL0jGuyL1GKpcd3rYtmGRN3wJo4vIIn995Tdf84b5Y5hMWqVNBC5sIy8cFBej3IjmCDW7XNzKbKdXwz1IGRxRBUg/Cq0dv0+FLV7thVIjp1Pd07jM6lTk0guTdVG5HrBZuyw+urR/qh606yuSgkj1VqPEhKlQBQzGRxncVmXwgCNcNtihcsRKhYBhuLUaXJhtzQsSq4PWge/vcgr8o51btB7rtm8NEcCmDvfEO54gemZNDEyfmO4i+UNhsDRKeCsxHJyuufD0ud7TcQ4GDYK7RlWxge7A3mpP4Vldgx0qwWl4eLnQDIM8EKPjUKtZR7Lh2rUF4B8pf6kiEvg0+6qYkFDD6uZ3UU2yQgnvBP02637n1RWUBcomC28/duUZkvn7lfuqNwgfUNwfkrNf5x2SOpLXGfQpoDxzSiYa/Vintub8Dn+X2CU9BszrVtwMky9h8p068r1JM/Rc1lPndjYsMwFBakEFt4IA183CAa1Y/UOvJZlRlAdchFJION4wuGEhfLePgFoCEzbFDp3OSoInqL+wJwb4W+IatFzJmMI/8hfSuOBS4U4M9/eyYtw3HQmOfZ4W58Q1Ng2m8FmV7oCyPgvF74OYzSZx9NiB/88m3t4GVOtu8GUZ1lPEbOxmR6ew9VdbFUI69vr+NHl6iRhrCninftSZXpel5K/UibrWS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(186003)(16526019)(36860700001)(26005)(82310400005)(426003)(6666004)(40460700003)(83380400001)(81166007)(40480700001)(82740400003)(356005)(36756003)(336012)(2616005)(4326008)(8676002)(70206006)(2906002)(8936002)(5660300002)(70586007)(7696005)(41300700001)(110136005)(316002)(54906003)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:20:45.0215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8772a753-7205-425b-4101-08db1a4f61f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

before: last 6 bits of PID is used as index to store
information about tasks accessing VMA's.

after: hash_32 is used to take of cases where tasks are
created over a period of time, and thus improve collision
probability.

Result:
The patch series overall improving autonuma cost.

Kernbench around more than 5% improvement and
system time in mmtest autonuma showed more than 80%
improvement

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h  | 2 +-
 kernel/sched/fair.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5232ebb34145..1b9be34a24fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1671,7 +1671,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 	unsigned int pid_bit;
 
-	pid_bit = current->pid % BITS_PER_LONG;
+	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
 	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids[1])) {
 		__set_bit(pid_bit, &vma->numab_state->access_pids[1]);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a93e7a33281f..8592941dd565 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2941,7 +2941,7 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 		return true;
 
 	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
-	return test_bit(current->pid % BITS_PER_LONG, &pids);
+	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
-- 
2.34.1

