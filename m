Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD915B45F8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIJKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIJKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:54:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE0FDF99
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HumKqN8dKiC92tjduLHaiS08BJmTegfUTQhqoDc2We/ZNxK7d/mniMmIVmB2g3VU2gSZat1OqPVZk0SCV3H5VZWkW/TutwCJp7Qk2ryLhncTp03Vq/GpmchFlkPFuftgBzKPu3b4aZHUVCj+POKoYdeSdBycdC8S7DFzjExLoR9yhGMtxVnjGkY5EY3muAtOmE7pIG+7f75dWS0mNAmo6hI22+yhGwK9+Yh38vJ0QQSQRiA8kwA66jto5ZIL+UTwhWuodr8AlzefBsAhIWBPZS94ThxQRggHdNw40hvhY4RCTFwQpCSxjv26RGGXDVx0wY7Dn42Pwg0buZbRwyya7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulG8kJYPeTFTgoE8ugNXZPJcGjjkZCu97EVgyc/ztfE=;
 b=Vf3e6AW8jSpfDhztvf9apjWHQuo/hl74uO9RMxi0EqP1HP69IGnml1BrJGjw6w8SRLGqd7bfUZ7/wK6k+VRMyCwOrvtGlR7nwhLW4acQfAVEkDr5nyKsHUmx1QW8BMrOjJ2oWDFvlbkGen2P7AgJR3CqTZrLQ1K49wpeMOOuoWmqDoQj2EClAp1Duy7ZtPe+fbPoI+t9iEDGJCN//bqFXdqkUHZ4Pbs6wbKL/e7yqxlXkPbMDZWbDJxCC1Xc2WzSc46S9e8Gbi8FPe+cJiFQsbxVj54bhOFPB+YbhTEEd8gRrgy/Wbs+D+/cZuoqVoJHKYORO1deNc9dnBtW3NjWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulG8kJYPeTFTgoE8ugNXZPJcGjjkZCu97EVgyc/ztfE=;
 b=B2QVqrJKNK7Ou6RVGuN1hZUpfVyZT5lx0QrZYVd1UFjgMSmA8sjqlBeloeIo2ZIwreCGIyEJFDv0HdH9qm+Oz/qLMs5RQpAtL8+rIBOxd9XsewwYq85XIUb9zjfCPTRiuCL7lCVpTEA2UiFucz7M7OR50o/Lw8vWpJH7TwizFeA=
Received: from DM6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:5:14c::35)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Sat, 10 Sep
 2022 10:54:38 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::ad) by DM6PR11CA0058.outlook.office365.com
 (2603:10b6:5:14c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Sat, 10 Sep 2022 10:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Sat, 10 Sep 2022 10:54:37 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 10 Sep
 2022 05:54:30 -0500
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
Subject: [PATCH 2/5] prctl: Add interface and helper functions to set hints
Date:   Sat, 10 Sep 2022 16:23:23 +0530
Message-ID: <20220910105326.1797-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f505895-8a97-440c-e6e8-08da931adae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+EUIFrC7enGeky+N0fdyqKc4JX3Qd+oHdXBaBIU8i5e2ncWPFBrFm7UNgcDHpbDBeq19dOIRUX8veMECD7xX8+aLESR0Y9DjmmiUeu9bgnukAFqY0N1BJamcGOgN8u0RdDi1rKxrdCkB1kfItCKUUrgK2POUPkD6ZYfSCTkdYK//7xRY5dLBiJ7tfZAskcc5pn0KT5c8DVYKW+K2+R+kr2bwKhD85xTQclNCuILvmJxNhvIYdpHWv8LXh+LvNiYvGhitih3tH35gnbYvymRqTmGg2+MVt1WXYc2wkSiAEdbavPrVkLVx1tVia+i8LZksd3ZoH7M56/kTaMJquvMuowR864b1o7anLMlORypOIzn500lnXq1FzfCyf7EzZ/o0vrtviSUWNpAksHBmQ6m0sCSJBCIz+cdyKSJgHLRPyRlEJZVNcCKGTMVvJfy2oJyZrsMxCa6yw6IYLHIGLxcSf9OM/Waz+sVuqvSbnDuJ5LeY0fdPOQB7WjZwvnWUm1Gj7xDl4nhfJlInNwaU60RD/WVHJuoo+Na1IMsHc5CMjGom4cpjVzAVw+stj2naXietV0ayeaWRlIPLHiSlzi8GmVH9MlbFsyCiMaYAuMdcMeim+50hKxQryAMly8yc6DvUBOxE66FEPrJ0datD4cbE4F4vlqNjmPcTHbmyFMR5rU3anZ8uzqMPRtLiKgg/3/9X/VbutuiGiyTq8SVJ4NYGhWCjkdVOsfFDqLTTWEWbInvQO8o+mRFAIMIz+d35X3K+Ojw9xSMonVTvqH/vPRiPjBMtk2We76G9GgWotGREbDGdNfxgKps0yUUKoMinYbQOW3Sj/98q+7OUv+r3QfvBuIaO6k5vfLomZlWrXy+P08=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(40470700004)(46966006)(4326008)(86362001)(8676002)(70586007)(426003)(2906002)(83380400001)(70206006)(478600001)(47076005)(336012)(40460700003)(6666004)(1076003)(186003)(26005)(8936002)(16526019)(7416002)(2616005)(36756003)(41300700001)(81166007)(82310400005)(356005)(82740400003)(7696005)(316002)(54906003)(5660300002)(6916009)(40480700001)(36860700001)(121494005)(557034005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 10:54:37.5873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f505895-8a97-440c-e6e8-08da931adae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hints are low-level knobs that can influence task placement decisions
at various scheduler decision points.

- Design of wakeup hints

Hints are of two kinds:

    o fork time hints: These hints influence initial placement. It is
      observed that a correct initial placement can have a long lasting
      effect on workload performance. These hints override scheduler
      behavior when the system is not heavily loaded to overlook any
      pre-configured bias in scheduler (such as NUMA Imbalance) and
      place tasks in a way user finds beneficial.
      These hints are of the form PR_SCHED_HINT_FORK_* namely:
      	- PR_SCHED_HINT_FORK_AFFINE
      	- PR_SCHED_HINT_FORK_SPREAD

    o wakeup hints: These hints target a specific MC Domain during
      wakeup. The user can choose to bias the placement towards waker's
      LLC if we believe the waker-wakee follow a producer-consumer
      pattern. The user can also choose to bias the placement towards
      the MC domain where the tasks previously ran if we believe waker's
      signaling is just for synchronization and the wakee will continue
      to consume the data, it produced during its last run.
      These hints are of the form PR_SCHED_HINT_WAKE_* namely:
        - PR_SCHED_HINT_WAKE_AFFINE
      	- PR_SCHED_HINT_WAKE_HOLD

Only one hint of each type can be set at once currently. Failure to do
so will lead to prctl() call returning -EINVAL.

- API Design

An example of setting hint PR_SCHED_HINT_FORK_AFFINE and
PR_SCHED_HINT_WAKE_AFFINE for the current running process is a follows:

	#include <sys/prctl.h>

	prctl(PR_SCHED_HINT /* prctl() cmd */,
	      PR_SCHED_HINT_WAKE_AFFINE | PR_SCHED_HINT_FORK_AFFINE /* Hints */,
	      0 /* pid of task to set hint for. pid 0 sets hint current task */,
	      0, 0);

The above command sets PR_SCHED_HINT_WAKE_AFFINE and
PR_SCHED_HINT_FORK_AFFINE for the task calling the prctl(). For a hint
to be set, the task should be ftrace-able.

As hints can be inherited by childern, one can wrap the runner script
with a hint to avail the benefits and need not change the workload.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h      |  1 +
 include/uapi/linux/prctl.h |  8 ++++
 kernel/sched/core.c        | 81 ++++++++++++++++++++++++++++++++++++++
 kernel/sys.c               |  5 +++
 4 files changed, 95 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fc953c9e956a..84a630d7c529 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2405,5 +2405,6 @@ static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
+extern int sched_set_hint(unsigned int hint, pid_t pid);
 
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..0a5dd42f1eab 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,12 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/* Hint the scheduler of the expected task behavior */
+#define PR_SCHED_HINT			65
+# define PR_SCHED_HINT_DEFAULT		0
+# define PR_SCHED_HINT_FORK_AFFINE	(1U << 0) /* Initial placement close to forking CPU */
+# define PR_SCHED_HINT_FORK_SPREAD	(1U << 1) /* Initial placement biased towards idlest group */
+# define PR_SCHED_HINT_WAKE_AFFINE	(1U << 2) /* Subsequent wakeup target waker's MC domain */
+# define PR_SCHED_HINT_WAKE_HOLD	(1U << 3) /* Subsequent wakeup target last run's MC domain */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d289d87acf7..60bee250d7b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -71,6 +71,7 @@
 # endif
 #endif
 
+#include <uapi/linux/prctl.h>
 #include <uapi/linux/sched/types.h>
 
 #include <asm/switch_to.h>
@@ -7323,6 +7324,86 @@ static void __setscheduler_params(struct task_struct *p,
 	set_load_weight(p, true);
 }
 
+/*
+ * Check whether the hints are valid and clear.
+ * Returns 0 if the hints are invalid of if
+ * the set hints are ambiguous and can lead to
+ * inconsistent behavior.
+ * Returns 1 for valid hint.
+ */
+static int valid_hint(unsigned int hint) {
+	if (!hint)
+		return 1;
+
+	/*
+	 * Largest value of hint can be calculated by setting the hints
+	 * with the largest numeric value in each independent category.
+	 */
+	if (hint > (PR_SCHED_HINT_WAKE_HOLD | PR_SCHED_HINT_FORK_SPREAD))
+		return 0;
+
+	/*
+	 * Only one of the fork time hints must be
+	 * set. Consistent behavior cannot be
+	 * guarenteed with conflicting hints.
+	 */
+	if ((hint & PR_SCHED_HINT_FORK_AFFINE) &&
+	    (hint & PR_SCHED_HINT_FORK_SPREAD))
+		return 0;
+
+	/*
+	 * Only one of the wakeup hints must be
+	 * set for the same reason stated above.
+	 */
+	if ((hint & PR_SCHED_HINT_WAKE_AFFINE) &&
+	    (hint & PR_SCHED_HINT_WAKE_HOLD))
+		return 0;
+
+	return 1;
+}
+
+/* Called from prctl interface: PR_SCHED_HINT */
+int sched_set_hint(unsigned int hint, pid_t pid)
+{
+	struct task_struct *task;
+	int err = 0;
+
+	/*
+	 * Make sure hint is valid and the user has not
+	 * requested for conflicting behavior at any
+	 * given decision point.
+	 */
+	if (!valid_hint(hint))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (pid == 0) {
+		task = current;
+	} else {
+		task = find_task_by_vpid(pid);
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	WRITE_ONCE(task->hint, hint);
+out:
+	put_task_struct(task);
+	return err;
+}
+
 /*
  * Check the target process has a UID that matches the current process's:
  */
diff --git a/kernel/sys.c b/kernel/sys.c
index b911fa6d81ab..505ceea548bd 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2623,6 +2623,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_SCHED_HINT:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = sched_set_hint(arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.25.1

