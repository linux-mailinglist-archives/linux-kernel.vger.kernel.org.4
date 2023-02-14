Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087316967F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjBNPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjBNPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:24:50 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE12A156
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:24:48 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EEiI9j020099;
        Tue, 14 Feb 2023 15:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=UTTqlNNS/QQPHXKCh8ZQ6mVdepgrzyAdZi2b5bpiPVM=;
 b=B0dHgM3no8XQGASBGVg+6UwelXwkM/r+E0FNmf32HUA/tB3xr6hWiooyH8lnReNcK60z
 5jyWtOVb7WGDjCjLzq8D6VpMqQmlF+wmxXUDJkuJb/1FuEq4q8AIgVmh1TfunrPfLEra
 +K2e3DhMy3zF1peXeRbJbA6YSdYQ6nMoohtrTFMO3oT+Ie5NUfEcmI93Xt9s0p3yvL6w
 k0+Ur1HJ+20ttiOp+rE32Ws7xEdLgQqDLYolD8qPy0MbpwRtCVeTKLbLEE21SlILl7Vo
 r0nxp9nscqX2WWHtp58pYX7mIwTdYwx8PHNPZPdLcs0lbhWXNe5hLurtzQE2evdbMNkB /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrcaqh7k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 15:24:19 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31EEjUb6025074;
        Tue, 14 Feb 2023 15:24:18 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrcaqh7jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 15:24:18 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31EF59CF007056;
        Tue, 14 Feb 2023 15:24:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3np2n74b8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 15:24:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31EFOGF08782340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:24:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D46758054;
        Tue, 14 Feb 2023 15:24:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF2DC58052;
        Tue, 14 Feb 2023 15:24:11 +0000 (GMT)
Received: from [9.43.103.97] (unknown [9.43.103.97])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 15:24:11 +0000 (GMT)
Message-ID: <9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com>
Date:   Tue, 14 Feb 2023 20:54:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     dietmar.eggemann@arm.com, bsegall@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
Subject: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for improved
 single thread performance at low utilization
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2PQWcjnX1YNAmFk2DFY5RZuhEhWK6Elf
X-Proofpoint-ORIG-GUID: NysmwG9FwnqORATnQByKw_RSpLieljy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU cfs bandwidth controller uses hrtimer called period timer. Quota is
refilled upon the timer expiry and re-started when there are running tasks
within the cgroup. Each cgroup has a separate period timer which manages
the period and quota for that cgroup.

start_cfs_bandwidth calls hrtimer_forward_now which set the expiry value
based on the below logic. expiry = $initial_value + $N * $period

However, start_cfs_bandwidth doesn't set any initial value. Hence
multiple such timers would align on expiry if their period value is
same. This happens when there are multiple cgroups and each has runnable
task. Upon expiry each timer will unthrottle respective rq's and all the
rq would start at same time, competing for CPU time and use all
the SMT threads likely.

There is performance gain that can be achieved here if the timers are
interleaved when the utilization of each CPU cgroup is low and total
utilization of all the CPU cgroup's is less than 50%. This is likely
true when using containers. If the timers are interleaved, then the
unthrottled cgroup can run freely without many context switches and can
also benefit from SMT Folding[1]. This effect will be further amplified in
SPLPAR environment[2] as this would cause less hypervisor preemptions.
There can be benefit due to less IPI storm as well. Docker provides a
config option of period timer value, whereas the kubernetes only
provides millicore option. Hence with typical deployment period values
will be set to 100ms as kubernetes millicore will set the quota
accordingly without altering period values.

[1] SMT folding is a mechanism where processor core is reconfigured to
lower SMT mode to improve performance when some sibling threads are
idle. In a SMT8 core, when only one or two threads are running on a
core, we get the best throughput compared to running all 8 threads.

[2] SPLPAR is an Shared Processor Logical PARtition. There can be many
SPLPARs running on the same physical machine sharing the CPU resources.
One SPLPAR can consume all CPU resource it can, if the other SPLPARs are
idle. Processors within the SPLPAR are called vCPU. vCPU can be higher
than CPU.  Hence at an instance of time if there are more requested vCPU
than CPU, then vCPU can be preempted. When the timers align, there will
be spike in requested vCPU when the timers expire. This can lead to
preemption when the other SPLPARs are not idle.

Since we are trading off between the performance vs power here,
benchmarked both the numbers. Frequency is set to 3.00Ghz and
socket power has been measured. Ran the stress-ng with two
cgroups. The numbers are with patch and without patch on a Power
system with SMT=8. Below table shows time taken by each group to
complete. Here each cgroup is assigned 25% runtime. period value is
set to 100ms.

workload: stress-ng --cpu=4 --cpu-ops=50000
data shows time it took to complete in seconds for each run.
Tried to interleave by best effort with the patch.
1CG - time to finish when only 1 cgroup is running.
2CG - time to finish when 2 cgroups are running together.
power - power consumed in Watts for the socket running the workload.
Performance gain is indicated in +ve percentage numbers and power
increase is indicated in -ve numbers. 1CG numbers are same as expected.
We are looking at improvement in 2CG Mainly.

             6.2.rc5                           with patch
        1CG    power   2CG    power   | 1CG  power     2CG        power
1Core   218     44     315      46    | 219    45    277(+12%)    47(-2%)
        219     43     315      45    | 219    44    244(+22%)    48(-6%)
	                              |
2Core   108     48     158      52    | 109    50    114(+26%)    59(-13%)
        109     49     157      52    | 109    49    136(+13%)    56(-7%)
                                      |
4Core    60     59      89      65    |  62    58     72(+19%)    68(-5%)
         61     61      90      65    |  62    60     68(+24%)    73(-12%)
                                      |
8Core    33     77      48      83    |  33    77     37(+23%)    91(-10%)
         33     77      48      84    |  33    77     38(+21%)    90(-7%)

There is no benefit at higher utilization of 50% or more. There is no
degradation also.

This is RFC PATCH V2, where the code has been shifted from hrtimer to
sched. This patch sets an initial value as multiple of period/10.
Here timers can still align if the time started the cgroup is within the
period/10 interval. On a real life workload, time gives sufficient
randomness. There can be a better interleaving by being more
deterministic. For example, when there are 2 cgroups, they should
have initial value of 0/50ms or 10/60ms so on. When there are 3 cgroups,
0/3/6ms or 1/4/7ms etc. That is more complicated as it has to account
for cgroup addition/deletion and accuracy w.r.t to period/quota.
If that approach is better here, then will come up with that patch.

Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff4dbbae3b10..7b69c329e05d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5939,14 +5939,25 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)

 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
-	lockdep_assert_held(&cfs_b->lock);
+	struct hrtimer *period_timer = &cfs_b->period_timer;
+	s64 incr = ktime_to_ns(cfs_b->period) / 10;
+	ktime_t delta;
+	u64 orun = 1;

+	lockdep_assert_held(&cfs_b->lock);
 	if (cfs_b->period_active)
 		return;

 	cfs_b->period_active = 1;
-	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+	delta = ktime_sub(period_timer->base->get_time(),
+			hrtimer_get_expires(period_timer));
+	if (unlikely(delta >= cfs_b->period)) {
+		orun = ktime_divns(delta, incr);
+		hrtimer_add_expires_ns(period_timer, incr * orun);
+	}
+
+	hrtimer_forward_now(period_timer, cfs_b->period);
+	hrtimer_start_expires(period_timer, HRTIMER_MODE_ABS_PINNED);
 }

 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
--
2.31.1
