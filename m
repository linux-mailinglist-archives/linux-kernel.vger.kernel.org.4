Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDD6A5273
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjB1Ewg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjB1Ewc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:52:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C625298FD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:52:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmqpFNshiSVeEv/u567UxBnNzKKEGwJgoSeqQ5Sd1rjWeTW+rQEBC1+kW451bEqumd9Rcp9XsXRwQDYLAimNrBWLHkCb5Kt5QcJH5s3OM+cWhCjlyFqYQXB7Ez/dXWiAx3G8jNLPxyFbNOEv/+7Fs3nA660meKH/AsyYRzVRoupPx0Eagmprqx+FjX19oeGdAjskozaG/P0Cn5Kh+ThsRNb5A5l55mM5xNAw42n1EeCRUxMXqm1E3xAe62Uj0Vq4uKb7bGXGbcOnhn3QaThXFd3cPVB/OhF0zZVQjJglCp0S76GmKesLTzjwyXRcnom7y0utq9KuoKBt9f12ydhGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG2lHw9tThuBVkRk5qf4n/6XlYiRv6aTMt+qRf5ht6w=;
 b=Rm+L0/yhwwv/Z94Ke0bmmJ/1YPrrAFAlGcvtFux3pPFb38IvgiqPwMGIN6bHIeOR1VdMjOJURAtoMdoLe27+7Nq6D1np3hxWtX+OZ+//efcvO1hobtskCLdv0FdGxPZXqiJP4X8NKAjptERz4zupYKnZiEx8/bgE5L4lyTI7x0Ep+gNNS1cDpbMuAxUGNfUPSYcnmWr77agH+Zwq3oaPzWUv4HI0QH0TohNlrNNkuS9+lPLwULvFR3ij3gLTGYpM4FWpQ4NI9011EiYXDxCETvjSCshvSUjSyw6HiuU0uXCsoIZCp3IkvHYtJvyHB1mQD+Z6cRVuL+dDuDU+lq2Znw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG2lHw9tThuBVkRk5qf4n/6XlYiRv6aTMt+qRf5ht6w=;
 b=yAbA61niMue5WbxwrdtMSrdqQVXpLkz3+D/Qmlo8f8noaskmcykMHrU2eM2pzPCWWpa+pUzrhKNbg00iWNS4Q71o0O0IrN1pMNQ3gUss1tLAPpUZsZ/Av8z4gC38m2NP7mw4SErXagek8CcuXIE80kkEmr19Dp0N4/yxNgDjen0=
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Tue, 28 Feb
 2023 04:52:03 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c8) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.5 via Frontend
 Transport; Tue, 28 Feb 2023 04:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 04:52:02 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:51:59 -0600
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
Subject: [PATCH V3 4/4] sched/numa: Use hash_32 to mix up PIDs accessing VMA
Date:   Tue, 28 Feb 2023 10:20:22 +0530
Message-ID: <1fe47cde783101152d1fc66fd6411f42184f6de1.1677557481.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677557481.git.raghavendra.kt@amd.com>
References: <cover.1677557481.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: d29185d0-146f-420a-646d-08db194788c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmA8oTI/u3aOUyTCrnchsh+nfqJeJHOsYtSuhty3EM0xBVRec3urp5Tpj0xPBaPazyX4gD1DoDCR3hPUqpLXBIcmxi7kJE9qiP9CtplL7XmzjbExQY7QahQK5PGjIw4yfWIvn9BGPY+tQu70qdhD+tZi2qaVz7sKi6fDaN3R9Z1tUdFmCpi7TopiSa4/bLpxb9sglE012Qqr+kvQJONN9hXeknWtHURpECP6UN7YOkzXDGGMsQmiJn1RFqMA32ozOSOMd8Ta4y8wyp5Ovd8p1PQOR+gCZ8GiQFmyrgg8wUGBopmc8LalfCaX3xsqS4qbMODi6cViAc9nFabm12we8E+OO2sIEhbIWc7wtoH6P3sscrknIzyfe5GiJCO+PkpHpKyc6JiCJyuu/E+CHcIo/ZP0Ulhhjlh2e9HhqNwVrFLwNtpryUkOE+F6pBO8SpxiOi6gf/pcNldDVhJ2DAEK2nV02ctDBAUC1wa0szzQ5qHdEM/Z1iTkVnRFRKkRmGbEdb1G6s+ZkasZyvDulmuGfxa+PzRPafnFmq8yAjOf+ulYNFpsHaCRuVzo5K7762OvoHssexl2qPtIDhZavjoNq5+ng3l3QL3GRnLc4IxOz7tWZVVOP78qSzTAqitrBPFjIffbgrcX0jE1oz0NyUdaZA8Gz3TLLLbtif9bE4qUQkAYy3vvYo/tWEUmULBw6Vg5PkbMxWmqwQV5+UNNpHVAnShjP/Q3EDiX4s6SB+eaW6kMX5/AK2ELvm/YI+O8EB0V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(40480700001)(2616005)(356005)(316002)(36756003)(54906003)(478600001)(110136005)(40460700003)(7696005)(6666004)(41300700001)(70586007)(70206006)(4326008)(16526019)(26005)(82740400003)(186003)(336012)(8676002)(36860700001)(2906002)(426003)(8936002)(47076005)(83380400001)(81166007)(5660300002)(82310400005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:52:02.9661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29185d0-146f-420a-646d-08db194788c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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
The patch series overall improving autonuma cost by a huge
margin.
Kernbench anbd dbench showed around 5% improvement and
system time in mmtest autonuma showed 80% improvement

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h  | 2 +-
 kernel/sched/fair.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bd07289fc68e..8493697d1dce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1393,7 +1393,7 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 	unsigned int pid_bit;
 
-	pid_bit = current->pid % BITS_PER_LONG;
+	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
 	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->access_pids[1])) {
 		__set_bit(pid_bit, &vma->numab_state->access_pids[1]);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f76d5ecaf345..46fd9b372e4c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2929,7 +2929,7 @@ static bool vma_is_accessed(struct vm_area_struct *vma)
 		return true;
 
 	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
-	return test_bit(current->pid % BITS_PER_LONG, &pids);
+	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
 }
 
 #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
-- 
2.34.1

