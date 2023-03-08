Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197366B0C46
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjCHPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCHPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:14:37 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA923ACBA9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:14:35 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328DuWHA021007;
        Wed, 8 Mar 2023 15:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xiBZY+5w+xr1Av01gSos1OwtkegXWKgxXF3dlkeSkJ0=;
 b=K31CpLTKbUT09h1pgWfdTxbKFQVSg3/WPo7dYPFXtxwB0CLSkGAWl3KWGkjhC5o0fD4r
 zeG2pbd/PjwaRTm5ItevTmrRKFZqtJcMffkx5cU58JqkifjfPw80MeOyrBNilwYu6MWb
 qhy3pFGTRcjGpcANREzUHPpyUDTE2yEBJkha7h9LlJiPCeMrBt+w1vu5W5bHKgrPrfUS
 9p7+2sc7heJ6QwxXGLQsdGy+y/uvl1qK5iDIgMD+HAi8fdQR6zOUcf8RYLq3zpJ5mIHy
 S6JFLk18fTASJ7yGAJcqAY57n1esiwFuzt5IOOLl1qg2XawglVjJqwHz9XlS23sNjrIT FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6suk50d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:13:49 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DKYmP011694;
        Wed, 8 Mar 2023 15:13:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6suk50cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:13:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328EjoPN025628;
        Wed, 8 Mar 2023 15:13:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3p6g9j3neu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:13:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328FDkwL35783320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:13:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09B9258062;
        Wed,  8 Mar 2023 15:13:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15B0858064;
        Wed,  8 Mar 2023 15:13:38 +0000 (GMT)
Received: from [9.43.49.64] (unknown [9.43.49.64])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:13:37 +0000 (GMT)
Message-ID: <2fe2fb1c-345f-adca-d201-ed3ed6f418cc@linux.vnet.ibm.com>
Date:   Wed, 8 Mar 2023 20:43:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/10] sched: EEVDF using latency-nice
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        mingo@kernel.org, vincent.guittot@linaro.org
References: <20230306132521.968182689@infradead.org>
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230306132521.968182689@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZmYFUcIPpWLiO-B8RnX0BAMDshJW8wbh
X-Proofpoint-ORIG-GUID: HHIVkuN4Ji1N4COfVajqswd4q_tGprNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> Hi!
>
> Ever since looking at the latency-nice patches, I've wondered if EEVDF would
> not make more sense, and I did point Vincent at some older patches I had for
> that (which is here his augmented rbtree thing comes from).
>
> Also, since I really dislike the dual tree, I also figured we could dynamically
> switch between an augmented tree and not (and while I have code for that,
> that's not included in this posting because with the current results I don't
> think we actually need this).
>
> Anyway, since I'm somewhat under the weather, I spend last week desperately
> trying to connect a small cluster of neurons in defiance of the snot overlord
> and bring back the EEVDF patches from the dark crypts where they'd been
> gathering cobwebs for the past 13 odd years.
>
> By friday they worked well enough, and this morning (because obviously I forgot
> the weekend is ideal to run benchmarks) I ran a bunch of hackbenck, netperf,
> tbench and sysbench -- there's a bunch of wins and losses, but nothing that
> indicates a total fail.
>
> ( in fact, some of the schbench results seem to indicate EEVDF schedules a lot
>   more consistent than CFS and has a bunch of latency wins )
>
> ( hackbench also doesn't show the augmented tree and generally more expensive
>   pick to be a loss, in fact it shows a slight win here )
>
>
>   hackbech load + cyclictest --policy other results:
>
>
> 			EEVDF			 CFS
>
> 		# Min Latencies: 00053
>   LNICE(19)	# Avg Latencies: 04350
> 		# Max Latencies: 76019
>
> 		# Min Latencies: 00052		00053
>   LNICE(0)	# Avg Latencies: 00690		00687
> 		# Max Latencies: 14145		13913
>
> 		# Min Latencies: 00019
>   LNICE(-19)	# Avg Latencies: 00261
> 		# Max Latencies: 05642
>
>
> The nice -19 numbers aren't as pretty as Vincent's, but at the end I was going
> cross-eyed from staring at tree prints and I just couldn't figure out where it
> was going side-ways.
>
> There's definitely more benchmarking/tweaking to be done (0-day already
> reported a stress-ng loss), but if we can pull this off we can delete a whole
> much of icky heuristics code. EEVDF is a much better defined policy than what
> we currently have.
>
Tested the patch series on powerpc systems. This test is done in the same way
that was done for vincent's V12 series.

Creating two cgroups. In cgroup2 running stress-ng -l 50 --cpu=<total_cpu> and
in cgroup1 running micro benchmarks. Different latency values are assigned to
cgroup1.

Tested on two different system. One system has 480 CPU and other one has 96
CPU.

++++++++
Summary:
++++++++
For hackbench, 480 CPU system shows good improvement.
96 CPU system shows same numbers as 6.2. Smaller system was showing regressing 
results as discussed in Vincent's V12 series. With this patch, there is no regression.

Schbench shows good improvement compared to v6.2 at LN=0 or LN=-20. Whereas
at LN=19, it shows regression.

Please suggest if any variation of the benchmark or a different benchmark to be run.


++++++++++++++++++
480 CPU system
++++++++++++++++++

==========
schbench
==========

		 v6.2		|  v6.2+LN=0    |  v6.2+LN=-20 |  v6.2+LN=19
1 Threads
  50.0th:	 14.00          |   12.00      |   14.50       |   15.00
  75.0th:	 16.50          |   14.50      |   17.00       |   18.00
  90.0th:	 18.50          |   17.00      |   19.50       |   20.00
  95.0th:	 20.50          |   18.50      |   22.00       |   23.50
  99.0th:	 27.50          |   24.50      |   31.50       |   155.00
  99.5th:	 36.00          |   30.00      |   44.50       |   2991.00
  99.9th:	 81.50          |   171.50     |   153.00      |   4621.00
2 Threads
  50.0th:	 14.00          |   15.50      |   17.00       |   16.00
  75.0th:	 17.00          |   18.00      |   19.00       |   19.00
  90.0th:	 20.00          |   21.00      |   22.00       |   22.50
  95.0th:	 23.00          |   23.00      |   25.00       |   25.50
  99.0th:	 71.00          |   30.50      |   35.50       |   990.50
  99.5th:	 1170.00        |   53.00      |   71.00       |   3719.00
  99.9th:	 5088.00        |   245.50     |   138.00      |   6644.00
4 Threads
  50.0th:	 20.50          |   20.00      |   20.00       |   19.50
  75.0th:	 24.50          |   23.00      |   23.00       |   23.50
  90.0th:	 31.00          |   27.00      |   26.50       |   27.50
  95.0th:	 260.50         |   29.50      |   29.00       |   35.00
  99.0th:	 3644.00        |   106.00     |   37.50       |   2884.00
  99.5th:	 5152.00        |   227.00     |   92.00       |   5496.00
  99.9th:	 8076.00        |   3662.50    |   517.00      |   8640.00
8 Threads
  50.0th:	 26.00          |   23.50      |   22.50       |   25.00
  75.0th:	 32.50          |   29.50      |   27.50       |   31.00
  90.0th:	 41.50          |   34.50      |   31.50       |   39.00
  95.0th:	 794.00         |   37.00      |   34.50       |   579.50
  99.0th:	 5992.00        |   48.50      |   52.00       |   5872.00
  99.5th:	 7208.00        |   100.50     |   97.50       |   7280.00
  99.9th:	 9392.00        |   4098.00    |   1226.00     |   9328.00
16 Threads
  50.0th:	 37.50          |   33.00      |   34.00       |   37.00
  75.0th:	 49.50          |   43.50      |   44.00       |   49.00
  90.0th:	 70.00          |   52.00      |   53.00       |   66.00
  95.0th:	 1284.00        |   57.50      |   59.00       |   1162.50
  99.0th:	 5600.00        |   79.50      |   111.50      |   5912.00
  99.5th:	 7216.00        |   282.00     |   194.50      |   7392.00
  99.9th:	 9328.00        |   4026.00    |   2009.00     |   9440.00
32 Threads
  50.0th:	 59.00          |   56.00      |   57.00       |   59.00
  75.0th:	 83.00          |   77.50      |   79.00       |   83.00
  90.0th:	 118.50         |   94.00      |   95.00       |   120.50
  95.0th:	 1921.00        |   104.50     |   104.00      |   1800.00
  99.0th:	 6672.00        |   425.00     |   255.00      |   6384.00
  99.5th:	 8252.00        |   2800.00    |   1252.00     |   7696.00
  99.9th:	 10448.00       |   7264.00    |   5888.00     |   9504.00

=========
hackbench
=========

Process		 10	 0.19   |   0.18      |   0.17      |   0.18
Process		 20 	 0.34   |   0.32      |   0.33      |   0.31
Process		 30 	 0.45   |   0.42      |   0.43      |   0.43
Process		 40 	 0.58   |   0.53      |   0.53      |   0.53
Process		 50 	 0.70   |   0.64      |   0.64      |   0.65
Process		 60 	 0.82   |   0.74      |   0.75      |   0.76
thread 		 10 	 0.20   |   0.19      |   0.19      |   0.19
thread 		 20 	 0.36   |   0.34      |   0.34      |   0.34
Process(Pipe)	 10 	 0.24   |   0.15      |   0.15      |   0.15
Process(Pipe)	 20 	 0.46   |   0.22      |   0.22      |   0.21
Process(Pipe)	 30 	 0.65   |   0.30      |   0.29      |   0.29
Process(Pipe)	 40 	 0.90   |   0.35      |   0.36      |   0.34
Process(Pipe)	 50 	 1.04   |   0.38      |   0.39      |   0.38
Process(Pipe)	 60 	 1.16   |   0.42      |   0.42      |   0.43
thread(Pipe)	 10 	 0.19   |   0.13      |   0.13      |   0.13
thread(Pipe)	 20 	 0.46   |   0.21      |   0.21      |   0.21


++++++++++++++++++
96 CPU system
++++++++++++++++++

===========
schbench
===========
		 v6.2        |  v6.2+LN=0    |  v6.2+LN=-20 |  v6.2+LN=19
1 Thread
  50.0th:	 10.50       |   10.00       |   10.00      |   11.00
  75.0th:	 12.50       |   11.50       |   11.50      |   12.50
  90.0th:	 15.00       |   13.00       |   13.50      |   16.50
  95.0th:	 47.50       |   15.00       |   15.00      |   274.50
  99.0th:	 4744.00     |   17.50       |   18.00      |   5032.00
  99.5th:	 7640.00     |   18.50       |   525.00     |   6636.00
  99.9th:	 8916.00     |   538.00      |   6704.00    |   9264.00
2 Threads
  50.0th:	 11.00       |   10.00       |   11.00      |   11.00
  75.0th:	 13.50       |   12.00       |   12.50      |   13.50
  90.0th:	 17.00       |   14.00       |   14.00      |   17.00
  95.0th:	 451.50      |   16.00       |   15.50      |   839.00
  99.0th:	 5488.00     |   20.50       |   18.00      |   6312.00
  99.5th:	 6712.00     |   986.00      |   19.00      |   7664.00
  99.9th:	 9856.00     |   4913.00     |   1154.00    |   8736.00
4 Threads
  50.0th:	 13.00       |   12.00       |   12.00      |   13.00
  75.0th:	 15.00       |   14.00       |   14.00      |   15.00
  90.0th:	 23.50       |   16.00       |   16.00      |   20.00
  95.0th:	 2508.00     |   17.50       |   17.50      |   1818.00
  99.0th:	 7232.00     |   777.00      |   38.50      |   5952.00
  99.5th:	 8720.00     |   3548.00     |   1926.00    |   7788.00
  99.9th:	 10352.00    |   6320.00     |   7160.00    |   10000.00
8 Threads
  50.0th:	 16.00       |   15.00       |   15.00      |   16.00
  75.0th:	 20.00       |   18.00       |   18.00      |   19.50
  90.0th:	 371.50      |   20.00       |   21.00      |   245.50
  95.0th:	 2992.00     |   22.00       |   23.00      |   2608.00
  99.0th:	 7784.00     |   1084.50     |   563.50     |   7136.00
  99.5th:	 9488.00     |   2612.00     |   2696.00    |   8720.00
  99.9th:	 15568.00    |   6656.00     |   7496.00    |   10000.00
16 Threads
  50.0th:	 23.00       |   21.00       |   20.00      |   22.50
  75.0th:	 31.00       |   27.50       |   26.00      |   29.50
  90.0th:	 1981.00     |   32.50       |   30.50      |   1500.50
  95.0th:	 4856.00     |   304.50      |   34.00      |   4046.00
  99.0th:	 10112.00    |   5720.00     |   4590.00    |   8220.00
  99.5th:	 13104.00    |   7828.00     |   7008.00    |   9312.00
  99.9th:	 18624.00    |   9856.00     |   9504.00    |   11984.00
32 Threads
  50.0th:	 36.50       |   34.50       |   33.50      |   35.50
  75.0th:	 56.50       |   48.00       |   46.00      |   52.50
  90.0th:	 4728.00     |   1470.50     |   376.00     |   3624.00
  95.0th:	 7808.00     |   4130.00     |   3850.00    |   6488.00
  99.0th:	 15776.00    |   8972.00     |   9060.00    |   9872.00
  99.5th:	 19072.00    |   11328.00    |   12224.00   |   11520.00
  99.9th:	 28864.00    |   18016.00    |   18368.00   |   18848.00


==========
Hackbench
=========

Type	      groups    v6.2	  | v6.2+LN=0  | v6.2+LN=-20 | v6.2+LN=19
Process		10	0.33      |   0.33     |   0.33      |   0.33
Process		20	0.61      |   0.56     |   0.58      |   0.57
Process		30	0.87      |   0.82     |   0.81      |   0.81
Process		40	1.10      |   1.05     |   1.06      |   1.05
Process		50	1.34      |   1.28     |   1.29      |   1.29
Process		60	1.58      |   1.53     |   1.52      |   1.51
thread		10	0.36      |   0.35     |   0.35      |   0.35
thread		20	0.64	  |   0.63     |   0.62      |   0.62
Process(Pipe)	10	0.18      |   0.18     |   0.18      |   0.17
Process(Pipe)   20	0.32      |   0.31     |   0.31      |   0.31
Process(Pipe)   30	0.42      |   0.41     |   0.41      |   0.42
Process(Pipe)   40	0.56      |   0.53     |   0.55      |   0.53
Process(Pipe)   50	0.68      |   0.66     |   0.66      |   0.66
Process(Pipe)   60	0.80      |   0.78     |   0.78      |   0.78
thread(Pipe)	10	0.20      |   0.18     |   0.19      |   0.18
thread(Pipe)	20	0.34      |   0.34     |   0.33      |   0.33

Tested-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>


