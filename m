Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC62682421
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjAaFtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:49:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C93B0E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:49:16 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V4F8TC007979;
        Tue, 31 Jan 2023 05:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : to : cc : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=IxOZrTVrU0xGgEeKrc+jBlAafyfABV43pEr6S8If81Q=;
 b=MOXSoBC9Bk92osbb6SBx3hyFyPGh/fRzetZN7QbDJI/b2kJ09vgf1nOrvnI+gvHTiEHP
 ff7Q6zsKZ+HjTtY1HRpnEa8Dgu+CBAqR+DFi4Ah0aMHPu0SxPNA13DY7cv0rdX4Q4ZW2
 gfee1o2fYa+0H7odP7VVPa9wf/Hs2zcqPgpW160EYkNHMz1tal7tp65Di3M3p4g+5LBf
 HJrHxXxidAMIblrDTRFFqYfKeF8/arO7EITGske8HG1oFBafsDsxABrI/6DLtBt1/nMO
 UXOVwmML0WV+qzPEKTnJM6Z3BxmXI4uDNA4JiIQnAOCXpCZp8zhnvG2Fses7GQMxVGDO LA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3neusy1u8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 05:48:51 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30V3VaOt028521;
        Tue, 31 Jan 2023 05:48:51 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuyeffk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 05:48:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30V5moTB5636748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 05:48:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 384945805D;
        Tue, 31 Jan 2023 05:48:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD3CC5805F;
        Tue, 31 Jan 2023 05:48:46 +0000 (GMT)
Received: from [9.160.34.223] (unknown [9.160.34.223])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 05:48:46 +0000 (GMT)
Message-ID: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
Date:   Tue, 31 Jan 2023 11:18:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, arjan@linux.intel.com, mingo@kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: [RFC PATCH] hrtimer: interleave timers for improved single thread
 performance at low utilization
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ZNnmouWlmvETVF-a6o9K494lLCTcUzc
X-Proofpoint-ORIG-GUID: 8ZNnmouWlmvETVF-a6o9K494lLCTcUzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per current design of hrtimer, it uses the _softexpires to trigger the
timer function.  _softexpires is set as multiple of the period/interval value.
This will benefit the power saving by less wakeups. Due to this, different
timers of the same period/interval values align and the callbacks functions
will be called at the same time.

CPU bandwidth controller (CPU cgroup) uses these hrtimers to implement period
and quota.  Period timer refills the quota and allow the throttled cgroups to
start running again.  When there are multiple such cgroup's, if their period
values are same, then these period timers will be aligned.  Hence multiple
cgroup's timer fire at the same time and ends up unthrottling each cgroups
runqueues. Since all cgroups start, they would compete for CPU and use all SMT
threads likely.

There is performance gain that can be achieved here if the timers are
interleaved when the utilization of each CPU cgroup is low and total
utilization of all the CPU cgroup's is less than 50%. This is likely true when
using containers. If the timers aren't rounded-off, then the unthrottled
cgroup can run freely without many context switches and can also benefit of SMT
Folding[1]. This effect will be further amplified in SPLPAR environment[2] as
this would cause less hypervisor preemptions. There can be benefit due to less
IPI storm as well. Docker provides a config option of period timer value,
whereas the kubernetes only provides millicore option. Hence with typical
deployment period values will be set to 100ms as kubernetes millicore will
set the quota accordingly without altering period values.

[1] SMT folding is a mechanism were processor core reconfigured to lower SMT
mode to improve performance when some sibling threads are idle. In a SMT8 core,
when only one or two threads are running on a core, we get the best throughput
compared to running all 8 threads.

[2] SPLPAR is an Shared Processor Logical PARtition. There can be many SPLPARs
running on the same physical machine sharing the CPU resources.  One SPLPAR can
consume all CPU resource it can, if the other SPLPARs are idle. Processors
within the SPLPAR are called vCPU. vCPU can be higher than CPU.  Hence at an
instance of time if there are more requested vCPU than CPU, then vCPU can be
preempted. When the timers align, there will be spike in requested vCPU when
the timers expire. This can lead to preemption when the other SPLPARs are not
idle.

Came up with a naive patch, more of hack. Other alternative is to use a
slightly modified API for cgroups, so that all other timers align and wakeups
remain reduced. New hrtimer api is likely better, i can send out the patch
quickly.  Here i am trying to misalign by setting the softexpire at multiple of
interval/10 instead of interval. Ran the stress-ng with two cgroups. The
numbers are with patch and without patch on Power10 machine with SMT=8. Below
table shows time taken by each group to complete. In the last column, both
cgroup's are run together and data shows average time taken by cgroups to
complete. Here each cgroup is assigned 25% runtime.

workload: stress-ng --cpu=4 --cpu-ops=100000 data shows time it took to
complete in seconds for each run.

Without Patch:
period/quota    cgroup1 runs    cgroup2 runs    cgroup1 &cgroup2
                    alone           alone         run together
100ms/200ms         120s            120s            155s
                     120s            120s            155s
                     120s            120s            155s
With Patch:
period/quota    cgroup1 runs    cgroup2 runs    cgroup1 & cgroup2
                    alone           alone         run together
100ms/200ms         120s            120s            131s
                     120s            120s            155s
                     120s            120s            121s

There is no benefit at higher utilization of 50% or more. There is no
degradation also.

Signed-off by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
  kernel/time/hrtimer.c | 11 +++++++++++
  1 file changed, 11 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3ae661ab6260..d160f49f0cce 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1055,6 +1055,17 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)

  		orun = ktime_divns(delta, incr);
  		hrtimer_add_expires_ns(timer, incr * orun);
+		/*
+		 * Avoid timer round-off, so that all cfs bandwidth timers
+		 * don't start at the same time
+		 */
+		if (incr >= 100000000ULL) {
+			s64 interleave = 0;
+			interleave = ktime_sub_ns(delta,  incr * orun);
+			interleave = interleave - (ktime_to_ns(delta) % (incr/10));
+			if (interleave > 0)
+				hrtimer_add_expires_ns(timer, interleave);
+		}
  		if (hrtimer_get_expires_tv64(timer) > now)
  			return orun;
  		/*
--
2.35.3
