Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4776A0FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBWS7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjBWS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:59:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026E928D0B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:59:47 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NIfR6G030206;
        Thu, 23 Feb 2023 18:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=pgHJVP5VYAB4nsdnPBhd1aExXHIe+MpwPHey0VXdhgM=;
 b=P2nLzLNUe4E9HmL+B44SAraZ/UogDoOR6IUa36etmOOovzz6wjtCSauRIhgB/ER3ha3m
 1mINB/XlsFaotznBK9T0k7xlAs912nqMTSuyy0lAHG0ziVWq2BWlMXHfcfXBgbixpbXd
 axHNHEGVG6b0S2QVmI7sn73mQPhLSxCzE/m3OrImm88Ut2PHfR4kGOzCwjVtFauAGNLP
 H1kwrTt//wHRQUzSCBn4GmF60UO6WIY1kz3DQl1a+j34lRd0cx1+MlQH2XdwId3tKV5b
 d04JEjqHlcqAey6wQaYAH8vL6mNQRhPJDdln25D/YVdzGPkkHCOQMGVojfrOH+MSy8+N vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxdn28c3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 18:59:38 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31NIwN9C025850;
        Thu, 23 Feb 2023 18:59:37 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxdn28c2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 18:59:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31N7b4E2008529;
        Thu, 23 Feb 2023 18:59:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ntnxf5b3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 18:59:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31NIxWvQ27001152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 18:59:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9BA20043;
        Thu, 23 Feb 2023 18:59:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B380320040;
        Thu, 23 Feb 2023 18:59:29 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.26.209])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Feb 2023 18:59:29 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, bsegall@google.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        sshegde@linux.vnet.ibm.com
Subject: [PATCH V3] sched/fair: Interleave cfs bandwidth timers for improved single thread performance at low utilization
Date:   Fri, 24 Feb 2023 00:29:18 +0530
Message-Id: <20230223185918.1500132-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PLT2yhRzo-0jhUGzZ9W1MIq7Hd2GaCLF
X-Proofpoint-ORIG-GUID: AmDG70y_If7XxXN99oD8V7VceV585wUI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230153
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU cfs bandwidth controller uses hrtimer. Currently there is no initial
value set. Hence all period timers would align at expiry.
This happens when there are multiple CPU cgroup's.

There is a performance gain that can be achieved here if the timers are
interleaved when the utilization of each CPU cgroup is low and total
utilization of all the CPU cgroup's is less than 50%. If the timers are
interleaved, then the unthrottled cgroup can run freely without many
context switches and can also benefit from SMT Folding. This effect will
be further amplified in SPLPAR environment.

This commit adds a random offset after initializing each hrtimer. This
would result in interleaving the timers at expiry, which helps in achieving
the said performance gain.

This was tested on powerpc platform with 8 core SMT=8. Socket power was
measured when the workload. Benchmarked the stress-ng with power
information. Throughput oriented benchmarks show significant gain up to
25% while power consumption increases up to 15%.

Workload: stress-ng --cpu=32 --cpu-ops=50000.
1CG - 1 cgroup is running.
2CG - 2 cgroups are running together.
Time taken to complete stress-ng in seconds and power is in watts.
each cgroup is throttled at 25% with 100ms as the period value.
           6.2-rc6                     |   with patch
8 core   1CG    power   2CG     power  |  1CG    power  2 CG    power
        27.5    80.6    40      90     |  27.3    82    32.3    104
        27.5    81      40.2    91     |  27.5    81    38.7     96
        27.7    80      40.1    89     |  27.6    80    29.7    106
        27.7    80.1    40.3    94     |  27.6    80    31.5    105

Latency might be affected by this change. That could happen if the CPU was
in a deep idle state which is possible if we interleave the timers. Used
schbench for measuring the latency. Each cgroup is throttled at 25% with
period value is set to 100ms. Numbers are when both the cgroups are
running simultaneously. Latency values don't degrade much. Some
improvement is seen in tail latencies.

		6.2-rc6        with patch
Groups: 16
50.0th:          39.5            42.5
75.0th:         924.0           922.0
90.0th:         972.0           968.0
95.0th:        1005.5           994.0
99.0th:        4166.0          2287.0
99.5th:        7314.0          7448.0
99.9th:       15024.0         13600.0

Groups: 32
50.0th:         819.0           463.0
75.0th:        1596.0           918.0
90.0th:        5992.0          1281.5
95.0th:       13184.0          2765.0
99.0th:       21792.0         14240.0
99.5th:       25696.0         18920.0
99.9th:       33280.0         35776.0

Groups: 64
50.0th:        4806.0          3440.0
75.0th:       31136.0         33664.0
90.0th:       54144.0         58752.0
95.0th:       66176.0         67200.0
99.0th:       84736.0         91520.0
99.5th:       97408.0        114048.0
99.9th:      136448.0        140032.0

Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>

Initial RFC PATCH, discussions and details on the problem:
Link1: https://lore.kernel.org/lkml/5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com/
Link2: https://lore.kernel.org/lkml/9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com/

---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff4dbbae3b10..2a4a0969e04f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5923,6 +5923,10 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
+
+	/* Add a random offset so that timers interleave */
+	hrtimer_set_expires(&cfs_b->period_timer,
+			    get_random_u32_below(cfs_b->period));
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->slack_started = false;
--
2.31.1

