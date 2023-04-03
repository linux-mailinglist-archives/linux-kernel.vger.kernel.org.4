Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770E06D3E52
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjDCHn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCHny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:43:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FB5B80
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:43:27 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3336dQoY029554;
        Mon, 3 Apr 2023 07:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4uSObPYBad5kEVrRZAMWyHysgNKqtOJmPjfIgwr8GxI=;
 b=nvu4hpfEaN0Ra7CfRb9Dh48nWz0OqLIz0wPmQjfrmdauspnEk/2nk/4YXvBzWpxe9CQZ
 X7aCMqf91YKyI3/tLQA/SmWBKui3MnZpV4g+47MW+oPnFU2KVFcmY3Rjm/Zak9ESpO6L
 1A02GeZ9TGnp47xf0vviFaVSP6VHr1P3pWA2lxkF0JEiDdkFq2CL3ucREsjmc161L+Tc
 HWmdMge+NHc+SAIy5th1AL01qpFWSwPHbijTugy4wWFkwukdQlH9HEusLiJnTKaegfPF
 nYqADXMMNpfdZufVmi1IHqnDZZP4rFRCcjStbj1Z9lwzYi1mmmvvzFLD/4+Q8rgary6V YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxfpgbe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 07:42:32 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3337Gcfe020664;
        Mon, 3 Apr 2023 07:42:32 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ppxfpgbdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 07:42:31 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3336D4u9031565;
        Mon, 3 Apr 2023 07:42:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ppc87vmun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 07:42:30 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3337gT6Y5571186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 07:42:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 207E158052;
        Mon,  3 Apr 2023 07:42:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A12EA58050;
        Mon,  3 Apr 2023 07:42:10 +0000 (GMT)
Received: from [9.211.132.72] (unknown [9.211.132.72])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Apr 2023 07:42:10 +0000 (GMT)
Message-ID: <a79014e6-ea83-b316-1e12-2ae056bda6fa@linux.vnet.ibm.com>
Date:   Mon, 3 Apr 2023 13:12:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/17] sched: EEVDF using latency-nice
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        mingo@kernel.org, vincent.guittot@linaro.org,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>
References: <20230328092622.062917921@infradead.org>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230328092622.062917921@infradead.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CR_8A2kC_0LQD7T3KU5E9hrQ6dF-Z7nU
X-Proofpoint-GUID: rbyiovHqZWzmzsJvXrnYJeRgt3CruiCF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_04,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030057
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URI_DOTEDU autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 2:56 PM, Peter Zijlstra wrote:
> Hi!
>
> Latest version of the EEVDF [1] patches.
>
> Many changes since last time; most notably it now fully replaces CFS and uses
> lag based placement for migrations. Smaller changes include:
>
>  - uses scale_load_down() for avg_vruntime; I measured the max delta to be ~44
>    bits on a system/cgroup based kernel build.
>  - fixed a bunch of reweight / cgroup placement issues
>  - adaptive placement strategy for smaller slices
>  - rename se->lag to se->vlag
>
> There's a bunch of RFC patches at the end and one DEBUG patch. Of those, the
> PLACE_BONUS patch is a mixed bag of pain. A number of benchmarks regress
> because EEVDF is actually fair and gives a 100% parent vs a 50% child a 67%/33%
> split (stress-futex, stress-nanosleep, starve, etc..) instead of a 50%/50%
> split that sleeper bonus achieves. Mostly I think these benchmarks are somewhat
> artificial/daft but who knows.
>
> The PLACE_BONUS thing horribly messes up things like hackbench and latency-nice
> because it places things too far to the left in the tree. Basically it messes
> with the whole 'when', by placing a task back in history you're putting a
> burden on the now to accomodate catching up. More tinkering required.
>
> But over-all the thing seems to be fairly usable and could do with more
> extensive testing.
>
> [1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
>
> Results:
>
>   hackbech -g $nr_cpu + cyclictest --policy other results:
>
> 			EEVDF			 CFS
>
> 		# Min Latencies: 00054
>   LNICE(19)	# Avg Latencies: 00660
> 		# Max Latencies: 23103
>
> 		# Min Latencies: 00052		00053
>   LNICE(0)	# Avg Latencies: 00318		00687
> 		# Max Latencies: 08593		13913
>
> 		# Min Latencies: 00054
>   LNICE(-19)	# Avg Latencies: 00055
> 		# Max Latencies: 00061
>
>
> Some preliminary results from Chen Yu on a slightly older version:
>
>   schbench  (95% tail latency, lower is better)
>   =================================================================================
>   case                    nr_instance            baseline (std%)    compare% ( std%)
>   normal                   25%                     1.00  (2.49%)    -81.2%   (4.27%)
>   normal                   50%                     1.00  (2.47%)    -84.5%   (0.47%)
>   normal                   75%                     1.00  (2.5%)     -81.3%   (1.27%)
>   normal                  100%                     1.00  (3.14%)    -79.2%   (0.72%)
>   normal                  125%                     1.00  (3.07%)    -77.5%   (0.85%)
>   normal                  150%                     1.00  (3.35%)    -76.4%   (0.10%)
>   normal                  175%                     1.00  (3.06%)    -76.2%   (0.56%)
>   normal                  200%                     1.00  (3.11%)    -76.3%   (0.39%)
>   ==================================================================================
>
>   hackbench (throughput, higher is better)
>   ==============================================================================
>   case                    nr_instance            baseline(std%)  compare%( std%)
>   threads-pipe              25%                      1.00 (<2%)    -17.5 (<2%)
>   threads-socket            25%                      1.00 (<2%)    -1.9 (<2%)
>   threads-pipe              50%                      1.00 (<2%)     +6.7 (<2%)
>   threads-socket            50%                      1.00 (<2%)    -6.3  (<2%)
>   threads-pipe              100%                     1.00 (3%)     +110.1 (3%)
>   threads-socket            100%                     1.00 (<2%)    -40.2 (<2%)
>   threads-pipe              150%                     1.00 (<2%)    +125.4 (<2%)
>   threads-socket            150%                     1.00 (<2%)    -24.7 (<2%)
>   threads-pipe              200%                     1.00 (<2%)    -89.5 (<2%)
>   threads-socket            200%                     1.00 (<2%)    -27.4 (<2%)
>   process-pipe              25%                      1.00 (<2%)    -15.0 (<2%)
>   process-socket            25%                      1.00 (<2%)    -3.9 (<2%)
>   process-pipe              50%                      1.00 (<2%)    -0.4  (<2%)
>   process-socket            50%                      1.00 (<2%)    -5.3  (<2%)
>   process-pipe              100%                     1.00 (<2%)    +62.0 (<2%)
>   process-socket            100%                     1.00 (<2%)    -39.5  (<2%)
>   process-pipe              150%                     1.00 (<2%)    +70.0 (<2%)
>   process-socket            150%                     1.00 (<2%)    -20.3 (<2%)
>   process-pipe              200%                     1.00 (<2%)    +79.2 (<2%)
>   process-socket            200%                     1.00 (<2%)    -22.4  (<2%)
>   ==============================================================================
>
>   stress-ng (throughput, higher is better)
>   ==============================================================================
>   case                    nr_instance            baseline(std%)  compare%( std%)
>   switch                  25%                      1.00 (<2%)    -6.5 (<2%)
>   switch                  50%                      1.00 (<2%)    -9.2 (<2%)
>   switch                  75%                      1.00 (<2%)    -1.2 (<2%)
>   switch                  100%                     1.00 (<2%)    +11.1 (<2%)
>   switch                  125%                     1.00 (<2%)    -16.7% (9%)
>   switch                  150%                     1.00 (<2%)    -13.6 (<2%)
>   switch                  175%                     1.00 (<2%)    -16.2 (<2%)
>   switch                  200%                     1.00 (<2%)    -19.4% (<2%)
>   fork                    50%                      1.00 (<2%)    -0.1 (<2%)
>   fork                    75%                      1.00 (<2%)    -0.3 (<2%)
>   fork                    100%                     1.00 (<2%)    -0.1 (<2%)
>   fork                    125%                     1.00 (<2%)    -6.9 (<2%)
>   fork                    150%                     1.00 (<2%)    -8.8 (<2%)
>   fork                    200%                     1.00 (<2%)    -3.3 (<2%)
>   futex                   25%                      1.00 (<2%)    -3.2 (<2%)
>   futex                   50%                      1.00 (3%)     -19.9 (5%)
>   futex                   75%                      1.00 (6%)     -19.1 (2%)
>   futex                   100%                     1.00 (16%)    -30.5 (10%)
>   futex                   125%                     1.00 (25%)    -39.3 (11%)
>   futex                   150%                     1.00 (20%)    -27.2% (17%)
>   futex                   175%                     1.00 (<2%)    -18.6 (<2%)
>   futex                   200%                     1.00 (<2%)    -47.5 (<2%)
>   nanosleep               25%                      1.00 (<2%)    -0.1 (<2%)
>   nanosleep               50%                      1.00 (<2%)    -0.0% (<2%)
>   nanosleep               75%                      1.00 (<2%)    +15.2% (<2%)
>   nanosleep               100%                     1.00 (<2%)    -26.4 (<2%)
>   nanosleep               125%                     1.00 (<2%)    -1.3 (<2%)
>   nanosleep               150%                     1.00 (<2%)    +2.1  (<2%)
>   nanosleep               175%                     1.00 (<2%)    +8.3 (<2%)
>   nanosleep               200%                     1.00 (<2%)    +2.0% (<2%)
>   ===============================================================================
>
>   unixbench (throughput, higher is better)
>   ==============================================================================
>   case                    nr_instance            baseline(std%)  compare%( std%)
>   spawn                   125%                      1.00 (<2%)    +8.1 (<2%)
>   context1                100%                      1.00 (6%)     +17.4 (6%)
>   context1                75%                       1.00 (13%)    +18.8 (8%)
>   =================================================================================
>
>   netperf  (throughput, higher is better)
>   ===========================================================================
>   case                    nr_instance          baseline(std%)  compare%( std%)
>   UDP_RR                  25%                   1.00    (<2%)    -1.5%  (<2%)
>   UDP_RR                  50%                   1.00    (<2%)    -0.3%  (<2%)
>   UDP_RR                  75%                   1.00    (<2%)    +12.5% (<2%)
>   UDP_RR                 100%                   1.00    (<2%)    -4.3%  (<2%)
>   UDP_RR                 125%                   1.00    (<2%)    -4.9%  (<2%)
>   UDP_RR                 150%                   1.00    (<2%)    -4.7%  (<2%)
>   UDP_RR                 175%                   1.00    (<2%)    -6.1%  (<2%)
>   UDP_RR                 200%                   1.00    (<2%)    -6.6%  (<2%)
>   TCP_RR                  25%                   1.00    (<2%)    -1.4%  (<2%)
>   TCP_RR                  50%                   1.00    (<2%)    -0.2%  (<2%)
>   TCP_RR                  75%                   1.00    (<2%)    -3.9%  (<2%)
>   TCP_RR                 100%                   1.00    (2%)     +3.6%  (5%)
>   TCP_RR                 125%                   1.00    (<2%)    -4.2%  (<2%)
>   TCP_RR                 150%                   1.00    (<2%)    -6.0%  (<2%)
>   TCP_RR                 175%                   1.00    (<2%)    -7.4%  (<2%)
>   TCP_RR                 200%                   1.00    (<2%)    -8.4%  (<2%)
>   ==========================================================================
>
>
> ---
> Also available at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/eevdf
>
> ---
> Parth Shah (1):
>       sched: Introduce latency-nice as a per-task attribute
>
> Peter Zijlstra (14):
>       sched/fair: Add avg_vruntime
>       sched/fair: Remove START_DEBIT
>       sched/fair: Add lag based placement
>       rbtree: Add rb_add_augmented_cached() helper
>       sched/fair: Implement an EEVDF like policy
>       sched: Commit to lag based placement
>       sched/smp: Use lag to simplify cross-runqueue placement
>       sched: Commit to EEVDF
>       sched/debug: Rename min_granularity to base_slice
>       sched: Merge latency_offset into slice
>       sched/eevdf: Better handle mixed slice length
>       sched/eevdf: Sleeper bonus
>       sched/eevdf: Minimal vavg option
>       sched/eevdf: Debug / validation crud
>
> Vincent Guittot (2):
>       sched/fair: Add latency_offset
>       sched/fair: Add sched group latency support
>
>  Documentation/admin-guide/cgroup-v2.rst |   10 +
>  include/linux/rbtree_augmented.h        |   26 +
>  include/linux/sched.h                   |    6 +
>  include/uapi/linux/sched.h              |    4 +-
>  include/uapi/linux/sched/types.h        |   19 +
>  init/init_task.c                        |    3 +-
>  kernel/sched/core.c                     |   65 +-
>  kernel/sched/debug.c                    |   49 +-
>  kernel/sched/fair.c                     | 1199 ++++++++++++++++---------------
>  kernel/sched/features.h                 |   29 +-
>  kernel/sched/sched.h                    |   23 +-
>  tools/include/uapi/linux/sched.h        |    4 +-
>  12 files changed, 794 insertions(+), 643 deletions(-)
>

Tested the patch on power system with 60 cores with SMT=8. Total of 480 CPU's.
System has four NUMA nodes.

TL;DR

Real life workload like daytrader shows improvement in different cases, while
microbenchmarks shows gains and regress as well.

Tested with microbenchmarks (hackbench, schbench, unixbench, STREAM and lmbench)
and DB workload called day trader. daytrader simulates the real life trading
activities which gives total transaction/s. It uses around 70% CPU.

Comparison is between tip/master vs +this_patch. tip/master was at 4b7aa0abddff
small nit: Applies cleanly to tip/master. patch fails to apply cleanly for
sched/core. sched/core is at 05bfb338fa8d
===============================================================================
Summary of methods and observations.
===============================================================================
Method 1:    Ran microbenchmarks on an idle system without any cgroups.
Observation: hackbench, unixbench shows gain. schbench shows regression.
             Stream and lmbench values are same.

Method 2:    Ran microbenchmarks on an idle system. Created a cgroup and ran
	     benchmarks in that cgroup. Latency values are assigned to the cgroup.
	     This is almost same as Method 1.
Observation: hackbench pipe shows improvement. schbench shows regression. lmbench and stream
	     are same more or less.

Method 3:    Ran microbenchmarks in a cgroup and in another terminal running stress-ng
             at 50% utilization. here, also tried different latency nice values
	     for cgroup.
Observation: Hackbench shows gain in latency values. Schbench shows good gain in
             latency values except, 1 thread case. lmbench and stream regress
	     slightly. unixbench is mixed.

	     One concerning throughput is 4 X Shell Scripts (8 concurrent) which
	     shows 50% regression. This is verified with additional run. The
	     same holds true for 25% utilization as well.

Method 4:    Ran daytrader with no cgroups on idle system.
Observation: we see around 7% gain in throughput.

Method 5:    Ran daytrader in a cgroup and running stress-ng at 50% utilization.
Observation: we see around 9% gain in throughput.

===============================================================================

Note:
positive values show improvement and negative values shows regression.

hackbench has 50 iterations.
schbench has 10 iterations
unixbench has 10 iterations.
lmbench has 50 iterations.

# lscpu
Architecture:            ppc64le
  Byte Order:            Little Endian
CPU(s):                  480
  On-line CPU(s) list:   0-479
  Thread(s) per core:    8
  Core(s) per socket:    15
  Socket(s):             4
  Physical sockets:      4
  Physical chips:        1
  Physical cores/chip:   15

NUMA:
  NUMA node(s):          4
  NUMA node0 CPU(s):     0-119
  NUMA node1 CPU(s):     120-239
  NUMA node2 CPU(s):     240-359
  NUMA node3 CPU(s):     360-479


===============================================================================
Detailed logs from each method.
================
Method 1:
================
This is to compare the out of box performance of the two. no load on the system
benchmarks are run without any cgroup.

Hackbench shows improvement. schbench results are mixed. But schebench has run
to variance. stream and lmbench are same.

-------------------------------------------------------------------------------
lmbench                          tip/master      eevdf
-------------------------------------------------------------------------------
latency process fork       :     120.56,     120.32(+0.20)
latency process Exec       :     176.70,     177.22(-0.30)
latency process Exec       :       5.59,       5.89(-5.47)
latency syscall fstat      :       0.26,       0.26( 0.00)
latency syscall open       :       2.27,       2.29(-0.88)
AF_UNIX sock stream latency:       9.13,       9.34(-2.30)
Select on 200 fd's         :       2.16,       2.15(-0.46)
semaphore latency          :       0.85,       0.85(+0.00)

-------------------------------------------------------------------------------
Stream                           tip/master      eevdf
-------------------------------------------------------------------------------
copy latency                :       0.58,       0.59(-1.72)
copy bandwidth              :   27357.05,   27009.15(-1.27)
scale latency               :       0.61,       0.61(0.00)
scale bandwidth             :   26268.65,   26057.07(-0.81)
add latency                 :       1.25,       1.25(0.00)
add bandwidth               :   19176.21,   19177.24(0.01)
triad latency               :       0.74,       0.74(0.00)
triad bandwidth             :   32591.51,   32506.32(-0.26)

-------------------------------------------------------------------------------
Unixbench                              tip/master    eevdf
-------------------------------------------------------------------------------
1 X Execl Throughput               :    5158.07,    5228.97(1.37)
4 X Execl Throughput               :   12745.19,   12927.75(1.43)
1 X Pipe-based Context Switching   :  178280.42,  170140.15(-4.57)
4 X Pipe-based Context Switching   :  594414.36,  560509.01(-5.70)
1 X Process Creation               :    8657.10,    8659.28(0.03)
4 X Process Creation               :   16476.56,   17007.43(3.22)
1 X Shell Scripts (1 concurrent)   :   10179.24,   10307.21(1.26)
4 X Shell Scripts (1 concurrent)   :   32990.17,   33251.73(0.79)
1 X Shell Scripts (8 concurrent)   :    4878.56,    4940.22(1.26)
4 X Shell Scripts (8 concurrent)   :   14001.89,   13568.88(-3.09)

-------------------------------------------------------------------------------
Schbench    tip/master      eevdf
-------------------------------------------------------------------------------
1 Threads
50.0th:       7.20,       7.00(2.78)
75.0th:       8.20,       7.90(3.66)
90.0th:      10.10,       8.30(17.82)
95.0th:      11.40,       9.30(18.42)
99.0th:      13.30,      11.00(17.29)
99.5th:      13.60,      11.70(13.97)
99.9th:      15.40,      13.40(12.99)
2 Threads
50.0th:       8.60,       8.00(6.98)
75.0th:       9.80,       8.80(10.20)
90.0th:      11.50,       9.90(13.91)
95.0th:      12.40,      10.70(13.71)
99.0th:      13.50,      13.70(-1.48)
99.5th:      14.90,      15.00(-0.67)
99.9th:      27.60,      23.60(14.49)
4 Threads
50.0th:      10.00,       9.90(1.00)
75.0th:      11.70,      12.00(-2.56)
90.0th:      13.60,      14.30(-5.15)
95.0th:      14.90,      15.40(-3.36)
99.0th:      17.80,      18.50(-3.93)
99.5th:      19.00,      19.30(-1.58)
99.9th:      27.60,      32.10(-16.30)
8 Threads
50.0th:      12.20,      13.30(-9.02)
75.0th:      15.20,      17.50(-15.13)
90.0th:      18.40,      21.60(-17.39)
95.0th:      20.70,      24.10(-16.43)
99.0th:      26.30,      30.20(-14.83)
99.5th:      30.50,      37.90(-24.26)
99.9th:      53.10,      92.10(-73.45)
16 Threads
50.0th:      20.70,      19.70(4.83)
75.0th:      28.20,      27.20(3.55)
90.0th:      36.20,      33.80(6.63)
95.0th:      40.70,      37.50(7.86)
99.0th:      51.50,      45.30(12.04)
99.5th:      62.70,      49.40(21.21)
99.9th:     120.70,      88.40(26.76)
32 Threads
50.0th:      39.50,      38.60(2.28)
75.0th:      58.30,      56.10(3.77)
90.0th:      76.40,      72.60(4.97)
95.0th:      86.30,      82.20(4.75)
99.0th:     102.20,      98.90(3.23)
99.5th:     108.00,     105.30(2.50)
99.9th:     179.30,     188.80(-5.30)

-------------------------------------------------------------------------------
Hackbench			  tip/master     eevdf
-------------------------------------------------------------------------------
Process 10 groups          :       0.19,       0.19(0.00)
Process 20 groups          :       0.24,       0.26(-8.33)
Process 30 groups          :       0.30,       0.31(-3.33)
Process 40 groups          :       0.35,       0.37(-5.71)
Process 50 groups          :       0.41,       0.44(-7.32)
Process 60 groups          :       0.47,       0.50(-6.38)
thread  10 groups          :       0.22,       0.23(-4.55)
thread  20 groups          :       0.28,       0.27(3.57)
Process(Pipe) 10 groups    :       0.16,       0.16(0.00)
Process(Pipe) 20 groups    :       0.26,       0.24(7.69)
Process(Pipe) 30 groups    :       0.36,       0.30(16.67)
Process(Pipe) 40 groups    :       0.40,       0.35(12.50)
Process(Pipe) 50 groups    :       0.48,       0.40(16.67)
Process(Pipe) 60 groups    :       0.55,       0.44(20.00)
thread (Pipe) 10 groups    :       0.16,       0.14(12.50)
thread (Pipe) 20 groups    :       0.24,       0.22(8.33)


================
Method 2:
================
This was to compare baseline performance with the eevdf by assigning different
latency nice values. In order to do that, created a cgroup and assigned latency
nice values to cgroup. microbenchmarks are run from that cgroup.

hackbench pipe shows improvement. schbench shows regression. lmbench and stream
are same more or less.

-------------------------------------------------------------------------------
lmbench                     tip/master   eevdf(LN=0)   eevdf(LN=-20)  eevdf(LN=19)
-------------------------------------------------------------------------------
latency process fork       :  121.20,  121.35(-0.12),  121.75(-0.45), 120.61(0.49)
latency process Exec       :  177.60,  180.84(-1.82),  177.93(-0.18), 177.44(0.09)
latency process Exec       :    5.80,    6.16(-6.27),    6.14(-5.89),   6.14(-5.91)
latency syscall fstat      :    0.26,    0.26(0.00) ,    0.26(0.00) ,   0.26(0.00)
latency syscall open       :    2.27,    2.29(-0.88),    2.29(-0.88),   2.29(-0.88)
AF_UNIX sock_stream latency:    9.31,    9.61(-3.22),    9.61(-3.22),   9.53(-2.36)
Select on 200 fd'si        :    2.17,    2.15(0.92) ,    2.15(0.92) ,   2.15(0.92)
semaphore latency          :    0.88,    0.89(-1.14),    0.88(0.00) ,   0.88(0.00)

-------------------------------------------------------------------------------
Stream          tip/master   eevdf(LN=0)       eevdf(LN=-20)      eevdf(LN=19)
-------------------------------------------------------------------------------
copy latency   :     0.56,      0.58(-3.57),      0.58(-3.57),       0.58(-3.57)
copy bandwidth : 28767.80,  27520.04(-4.34),  27506.95(-4.38),   27381.61(-4.82)
scale latency  :     0.60,      0.61(-1.67),      0.61(-1.67),       0.61(-1.67)
scale bandwidth: 26875.58,  26385.22(-1.82),  26339.94(-1.99),   26302.86(-2.13)
add latency    :     1.25,      1.25(0.00) ,      1.25(0.00) ,       1.25(0.00)
add bandwidth  : 19175.76,  19177.48(0.01) ,  19177.60(0.01) ,   19176.32(0.00)
triad latency  :     0.74,      0.73(1.35) ,      0.74(0.00) ,       0.74(0.00)
triad bandwidth: 32545.70,  32658.95(0.35) ,  32581.78(0.11) ,   32561.74(0.05)

--------------------------------------------------------------------------------------------------
Unixbench                         tip/master  eevdf(LN=0)      eevdf(LN=-20)   eevdf(LN=19)
--------------------------------------------------------------------------------------------------
1 X Execl Throughput            :  5147.23,    5184.87(0.73),     5217.16(1.36),     5218.21(1.38)
4 X Execl Throughput            : 13225.55,   13638.36(3.12),    13643.07(3.16),    13636.50(3.11)
1 X Pipe-based Context Switching:171413.56,  162720.69(-5.07),  163420.54(-4.66),  163446.67(-4.65)
4 X Pipe-based Context Switching:564887.90,  554545.01(-1.83),  555561.24(-1.65),  547421.20(-3.09)
1 X Process Creation            :  8555.73,    8503.18(-0.61),    8556.39(0.01),     8621.36(0.77)
4 X Process Creation            : 17007.47,   16372.44(-3.73),   17002.88(-0.03),   16611.47(-2.33)
1 X Shell Scripts (1 concurrent): 10104.23,   10235.09(1.30),    10171.44(0.67),    10275.76(1.70)
4 X Shell Scripts (1 concurrent): 33752.14,   32278.50(-4.37),   32885.92(-2.57),   32256.58(-4.43)
1 X Shell Scripts (8 concurrent):  4864.71,    4909.30(0.92),     4914.62(1.03),     4896.45(0.65)
4 X Shell Scripts (8 concurrent): 14237.17,   13395.20(-5.91),   13599.52(-4.48),   12923.93(-9.22)


-------------------------------------------------------------------------------
schbench    tip/master   eevdf(LN=0)       eevdf(LN=-20)      eevdf(LN=19)
-------------------------------------------------------------------------------
1 Threads
50.0th:       6.90,       7.30(-5.80),       7.30(-5.80),      7.10(-2.90)
75.0th:       7.90,       8.40(-6.33),       8.60(-8.86),      8.00(-1.27)
90.0th:      10.10,       9.60(4.95),       10.50(-3.96),      8.90(11.88)
95.0th:      11.20,      10.60(5.36),       11.10(0.89),       9.40(16.07)
99.0th:      13.30,      12.70(4.51),       12.80(3.76),      11.80(11.28)
99.5th:      13.90,      13.50(2.88),       13.60(2.16),      12.40(10.79)
99.9th:      15.00,      15.40(-2.67),      15.20(-1.33),     13.70(8.67)
2 Threads
50.0th:       7.20,       8.10(-12.50),      8.00(-11.11),     8.40(-16.67)
75.0th:       8.30,       9.20(-10.84),      9.00(-8.43),      9.70(-16.87)
90.0th:      10.10,      11.00(-8.91),      10.00(0.99),      11.00(-8.91)
95.0th:      11.30,      12.60(-11.50),     10.60(6.19),      11.60(-2.65)
99.0th:      14.40,      15.40(-6.94),      11.90(17.36),     13.70(4.86)
99.5th:      15.20,      16.10(-5.92),      13.20(13.16),     14.60(3.95)
99.9th:      16.40,      17.30(-5.49),      14.70(10.37),     16.20(1.22)
4 Threads
50.0th:       8.90,      10.30(-15.73),     10.00(-12.36),    10.10(-13.48)
75.0th:      10.80,      12.10(-12.04),     11.80(-9.26),     12.00(-11.11)
90.0th:      13.00,      14.00(-7.69),      13.70(-5.38),     14.30(-10.00)
95.0th:      14.40,      15.20(-5.56),      14.90(-3.47),     15.80(-9.72)
99.0th:      16.90,      17.50(-3.55),      18.70(-10.65),    19.80(-17.16)
99.5th:      17.40,      18.50(-6.32),      19.80(-13.79),    22.10(-27.01)
99.9th:      18.70,      22.30(-19.25),     22.70(-21.39),    37.50(-100.53)
8 Threads
50.0th:      11.50,      12.80(-11.30),     13.30(-15.65),    12.80(-11.30)
75.0th:      15.00,      16.30(-8.67),      16.90(-12.67),    16.20(-8.00)
90.0th:      18.80,      19.50(-3.72),      20.30(-7.98),     19.90(-5.85)
95.0th:      21.40,      21.80(-1.87),      22.30(-4.21),     22.10(-3.27)
99.0th:      27.60,      26.30(4.71) ,      27.60(0.00),      27.30(1.09)
99.5th:      30.40,      32.40(-6.58),      36.40(-19.74),    30.00(1.32)
99.9th:      56.90,      59.10(-3.87),      66.70(-17.22),    60.90(-7.03)
16 Threads
50.0th:      19.20,      20.90(-8.85),      20.60(-7.29),     21.00(-9.38)
75.0th:      25.30,      27.50(-8.70),      27.80(-9.88),     28.30(-11.86)
90.0th:      31.20,      34.60(-10.90),     35.10(-12.50),    35.20(-12.82)
95.0th:      35.40,      38.90(-9.89),      39.50(-11.58),    39.20(-10.73)
99.0th:      44.90,      47.60(-6.01),      47.50(-5.79),     47.60(-6.01)
99.5th:      48.50,      50.50(-4.12),      50.20(-3.51),     55.60(-14.64)
99.9th:      70.80,      84.70(-19.63),     81.40(-14.97),   103.50(-46.19)
32 Threads
50.0th:      39.10,      38.60(1.28),       36.10(7.67),      39.50(-1.02)
75.0th:      57.20,      56.10(1.92),       52.00(9.09),      57.70(-0.87)
90.0th:      74.00,      73.70(0.41),       65.70(11.22),     74.40(-0.54)
95.0th:      82.30,      83.50(-1.46),      74.20(9.84),      84.50(-2.67)
99.0th:      95.80,      98.60(-2.92),      92.10(3.86),     100.50(-4.91)
99.5th:     101.50,     104.10(-2.56),      98.90(2.56),     108.20(-6.60)
99.9th:     185.70,     179.90(3.12),      163.50(11.95),    193.00(-3.93)

-------------------------------------------------------------------------------
Hackbench                tip/master   eevdf(LN=0)   eevdf(LN=-20)  eevdf(LN=19)
-------------------------------------------------------------------------------
Process 10 groups       :   0.19,    0.19(0.00),    0.19(0.00),    0.19(0.00)
Process 20 groups       :   0.24,    0.25(-4.17),   0.26(-8.33),   0.25(-4.17)
Process 30 groups       :   0.30,    0.31(-3.33),   0.31(-3.33),   0.30(0.00)
Process 40 groups       :   0.35,    0.37(-5.71),   0.38(-8.57),   0.38(-8.57)
Process 50 groups       :   0.43,    0.44(-2.33),   0.44(-2.33),   0.44(-2.33)
Process 60 groups       :   0.49,    0.52(-6.12),   0.51(-4.08),   0.51(-4.08)
thread  10 groups       :   0.23,    0.22(4.35),    0.23(0.00),    0.23(0.00)
thread  20 groups       :   0.28,    0.28(0.00),    0.27(3.57),    0.28(0.00)
Process(Pipe) 10 groups :   0.17,    0.16(5.88),    0.16(5.88),    0.16(5.88)
Process(Pipe) 20 groups :   0.25,    0.24(4.00),    0.24(4.00),    0.24(4.00)
Process(Pipe) 30 groups :   0.32,    0.29(9.38),    0.29(9.38),    0.29(9.38)
Process(Pipe) 40 groups :   0.39,    0.34(12.82),   0.34(12.82),   0.34(12.82)
Process(Pipe) 50 groups :   0.45,    0.39(13.33),   0.39(13.33),   0.38(15.56)
Process(Pipe) 60 groups :   0.51,    0.43(15.69),   0.43(15.69),   0.43(15.69)
thread(Pipe)  10 groups :   0.16,    0.15(6.25),    0.15(6.25),    0.15(6.25)
thread(Pipe)  20 groups :   0.24,    0.22(8.33),    0.22(8.33),    0.22(8.33)

================
Method 3:
================
Comparing baseline vs eevdf when the system utilization is 50%. A cpu cgroup is
created and  different latency nice values are assigned to it. on another bash
terminal stress-ng is running at 50% utilization(stress-ng --cpu=480 -l 50).

Hackbench shows gain in latency values. Schbench shows good gain in latency values
except, 1 thread case. lmbench and stream regress slightly. unixbench is mixed.

One concerning throughput is 4 X Shell Scripts (8 concurrent) which shows 50%
regression. This is verified with additional run. The same holds true for 25%
utilization as well.

-------------------------------------------------------------------------------
lmbench                     tip/master   eevdf(LN=0)   eevdf(LN=-20)  eevdf(LN=19)
-------------------------------------------------------------------------------
latency process fork       :152.98,   158.34(-3.50),  155.07(-1.36),   157.57(-3.00)
latency process Exec       :214.30,   214.08(0.10),   214.41(-0.05),   215.16(-0.40)
latency process Exec       : 12.44,    11.86(4.66),    10.60(14.79),    10.58(14.94)
latency syscall fstat      :  0.44,     0.45(-2.27),    0.43(2.27),      0.45(-2.27)
latency syscall open       :  3.71,     3.68(0.81),     3.70(0.27),      3.74(-0.81)
AF_UNIX sock stream latency: 14.07,    13.44(4.48),    14.69(-4.41),    13.65(2.99)
Select on 200 fd'si        :  3.97,     4.16(-4.79),    4.02(-1.26),     4.21(-6.05)
semaphore latency          :  1.83,     1.82(0.55),     1.77(3.28),      1.75(4.37)

-------------------------------------------------------------------------------
Stream          tip/master   eevdf(LN=0)       eevdf(LN=-20)        eevdf(LN=19)
-------------------------------------------------------------------------------
copy latency   :       0.69,       0.69(0.00),       0.76(-10.14),      0.72(-4.35)
copy bandwidth :   23947.02,   24275.24(1.37),   22032.30(-8.00),   23487.29(-1.92)
scale latency  :       0.71,       0.74(-4.23),      0.75(-5.63),       0.77(-8.45)
scale bandwidth:   23490.27,   22713.99(-3.30),  22168.98(-5.62),   21782.47(-7.27)
add latency    :       1.34,       1.36(-1.49),      1.39(-3.73),       1.42(-5.97)
add bandwidth  :   17986.34,   17771.92(-1.19),  17461.59(-2.92),   17276.34(-3.95)
triad latency  :       0.91,       0.93(-2.20),      0.91(0.00),        0.94(-3.30)
triad bandwidth:   27948.13,   27652.98(-1.06),  28134.58(0.67),    27269.73(-2.43)

-------------------------------------------------------------------------------------------------
Unixbench                          tip/master    eevdf(LN=0)      eevdf(LN=-20)   eevdf(LN=19)
-------------------------------------------------------------------------------------------------
1 X Execl Throughput            :   4940.56,    4944.30(0.08),    4991.69(1.03),     4982.80(0.85)
4 X Execl Throughput            :  10737.13,   10885.69(1.38),   10615.75(-1.13),   10803.82(0.62)
1 X Pipe-based Context Switching:  91313.57,  103426.11(13.26), 102985.91(12.78),  104614.22(14.57)
4 X Pipe-based Context Switching: 370430.07,  408075.33(10.16), 409273.07(10.49),  431360.88(16.45)
1 X Process Creation            :   6844.45,    6854.06(0.14),    6887.63(0.63),     6894.30(0.73)
4 X Process Creation            :  18690.31,   19307.50(3.30),   19425.39(3.93),    19128.43(2.34)
1 X Shell Scripts (1 concurrent):   8184.52,    8135.30(-0.60),   8185.53(0.01),     8163.10(-0.26)
4 X Shell Scripts (1 concurrent):  25737.71,   22583.29(-12.26), 22470.35(-12.69),  22615.13(-12.13)
1 X Shell Scripts (8 concurrent):   3653.71,    3115.03(-14.74),  3156.26(-13.61),   3106.63(-14.97)    <<<<< This may be of concern.
4 X Shell Scripts (8 concurrent):   9625.38,    4505.63(-53.19),  4484.03(-53.41),   4468.70(-53.57)    <<<<< This is a concerning one.

-------------------------------------------------------------------------------
schbench    tip/master   eevdf(LN=0)       eevdf(LN=-20)      eevdf(LN=19)
-------------------------------------------------------------------------------
1 Threads
50.0th:      15.10,      15.20(-0.66),      15.10(0.00),       15.10(0.00)
75.0th:      17.20,      17.70(-2.91),      17.20(0.00),       17.40(-1.16)
90.0th:      20.10,      20.70(-2.99),      20.40(-1.49),      20.70(-2.99)
95.0th:      22.20,      22.80(-2.70),      22.60(-1.80),      23.10(-4.05)
99.0th:      45.10,      51.50(-14.19),     37.20(17.52),      44.50(1.33)
99.5th:      79.80,     106.20(-33.08),    103.10(-29.20),    101.00(-26.57)
99.9th:     206.60,     771.40(-273.38),  1003.50(-385.72),   905.50(-338.29)
2 Threads
50.0th:      16.50,      17.00(-3.03),      16.70(-1.21),      16.20(1.82)
75.0th:      19.20,      19.90(-3.65),      19.40(-1.04),      18.90(1.56)
90.0th:      22.20,      23.10(-4.05),      22.80(-2.70),      22.00(0.90)
95.0th:      24.30,      25.40(-4.53),      25.20(-3.70),      24.50(-0.82)
99.0th:      97.00,      41.70(57.01),      43.00(55.67),      45.10(53.51)
99.5th:     367.10,      96.70(73.66),      98.80(73.09),     104.60(71.51)
99.9th:    3770.80,     811.40(78.48),    1414.70(62.48),     886.90(76.48)
4 Threads
50.0th:      20.00,      20.10(-0.50),      19.70(1.50),       19.50(2.50)
75.0th:      23.50,      23.40(0.43),       22.80(2.98),       23.00(2.13)
90.0th:      28.00,      27.00(3.57),       26.50(5.36),       26.60(5.00)
95.0th:      37.20,      29.50(20.70),      28.90(22.31),      28.80(22.58)
99.0th:    2792.50,      42.80(98.47),      38.30(98.63),      37.00(98.68)
99.5th:    4964.00,     101.50(97.96),      85.00(98.29),      70.20(98.59)
99.9th:    7864.80,    1722.20(78.10),     755.40(90.40),     817.10(89.61)
8 Threads
50.0th:      25.30,      24.50(3.16),       24.30(3.95),       23.60(6.72)
75.0th:      31.80,      30.00(5.66),       29.90(5.97),       29.30(7.86)
90.0th:      39.30,      35.00(10.94),      35.00(10.94),      34.20(12.98)
95.0th:     198.00,      38.20(80.71),      38.20(80.71),      37.40(81.11)
99.0th:    4601.20,      56.30(98.78),      85.90(98.13),      65.30(98.58)
99.5th:    6422.40,     162.70(97.47),     195.30(96.96),     153.40(97.61)
99.9th:    9684.00,    3237.60(66.57),    3726.40(61.52),    3965.60(59.05)
16 Threads
50.0th:      37.00,      35.20(4.86),       33.90(8.38),       34.00(8.11)
75.0th:      49.20,      46.00(6.50),       44.20(10.16),      44.40(9.76)
90.0th:      64.20,      54.80(14.64),      52.80(17.76),      53.20(17.13)
95.0th:     890.20,      59.70(93.29),      58.20(93.46),      58.60(93.42)
99.0th:    5369.60,      85.30(98.41),     124.90(97.67),     116.90(97.82)
99.5th:    6952.00,     228.00(96.72),     680.20(90.22),     339.40(95.12)
99.9th:    9222.40,    4896.80(46.90),    4648.40(49.60),    4365.20(52.67)
32 Threads
50.0th:      59.60,      56.80(4.70),       55.30(7.21),       56.00(6.04)
75.0th:      83.70,      78.70(5.97),       75.90(9.32),       77.50(7.41)
90.0th:     122.70,      95.50(22.17),      92.40(24.69),      93.80(23.55)
95.0th:    1680.40,     105.00(93.75),     102.20(93.92),     103.70(93.83)
99.0th:    6540.80,     382.10(94.16),     321.10(95.09),     489.30(92.52)
99.5th:    8094.40,    2144.20(73.51),    2172.70(73.16),    1990.70(75.41)
99.9th:   11417.60,    6672.80(41.56),    6903.20(39.54),    6268.80(45.10)

-------------------------------------------------------------------------------
Hackbench                tip/master   eevdf(LN=0)   eevdf(LN=-20)  eevdf(LN=19)
-------------------------------------------------------------------------------
Process 10  groups     :   0.18,     0.18(0.00),    0.18(0.00),     0.18(0.00)
Process 20  groups     :   0.32,     0.33(-3.13),   0.33(-3.13),    0.33(-3.13)
Process 30  groups     :   0.42,     0.43(-2.38),   0.43(-2.38),    0.43(-2.38)
Process 40  groups     :   0.51,     0.53(-3.92),   0.53(-3.92),    0.53(-3.92)
Process 50  groups     :   0.62,     0.64(-3.23),   0.65(-4.84),    0.64(-3.23)
Process 60  groups     :   0.72,     0.73(-1.39),   0.74(-2.78),    0.74(-2.78)
thread  10  groups     :   0.19,     0.19(0.00),    0.19(0.00),     0.19(0.00)
thread  20  groups     :   0.33,     0.34(-3.03),   0.34(-3.03),    0.34(-3.03)
Process(Pipe) 10 groups:   0.17,     0.16(5.88),    0.16(5.88),     0.16(5.88)
Process(Pipe) 20 groups:   0.25,     0.23(8.00),    0.23(8.00),     0.23(8.00)
Process(Pipe) 30 groups:   0.36,     0.31(13.89),   0.31(13.89),    0.31(13.89)
Process(Pipe) 40 groups:   0.42,     0.36(14.29),   0.36(14.29),    0.36(14.29)
Process(Pipe) 50 groups:   0.49,     0.42(14.29),   0.41(16.33),    0.42(14.29)
Process(Pipe) 60 groups:   0.53,     0.44(16.98),   0.44(16.98),    0.44(16.98)
thread(Pipe)  10 groups:   0.14,     0.14(0.00),    0.14(0.00),     0.14(0.00)
thread(Pipe)  20 groups:   0.24,     0.24(0.00),    0.22(8.33),     0.23(4.17)


================
Method 4:
================
Running daytrader on an idle system without any cgroup. daytrader is a trading
simulator application which does buy/sell and intraday trading etc. It is a
throughput oriented workload running with Jmeter.
reference: https://www.ibm.com/docs/en/linux-on-systems?topic=bad-daytrader

We see around 7% improvement in throughput with eevdf.

--------------------------------------------------------------------------
daytrader			tip/master		eevdf
--------------------------------------------------------------------------
Total throughputs                  1x			1.0717x(7.17)


================
Method 5:
================
Running daytrader on a system where utilization is 50%. created a cgroup and ran
microbenchmark in it and assigned different latency values to it. On another
bash terminal stress-ng is running at 50% utilization.

At LN=0, we see a 9% improvement with eevdf compared to baseline.

-------------------------------------------------------------------------
daytrader	   tip/master   eevdf	      eevdf          eevdf
				(LN=0)       (LN=-20)       (LN=19)
-------------------------------------------------------------------------
Total throughputs      1x      1.0923x(9.2%)   1.0759x(7.6)    1.111x(11.1)


Tested-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

