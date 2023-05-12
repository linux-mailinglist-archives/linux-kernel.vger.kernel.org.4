Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E8700EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbjELSjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbjELSjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:39:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92BBC1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:39:15 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CIAoUa007779;
        Fri, 12 May 2023 18:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oiKRhkFMWlyjNAH8Cr/h7nWWbNogngMKvoTBZWSzGuo=;
 b=lk+3l2sMWwA/sR6ZpsIzOAcskpWo7VA+50umU++LdDjorUitezY1Z6hoYYacAmUyVm5D
 fmOJskJfitxpaiY1ObryhQN2tX8Uofd0lSwfRq4ynBr9rhuJ+91e+6hBiS70tPLS3W66
 qkCym/EyeJycA28mQ+e5tLDme3yJuO64/9+c6IuN9E/ILjPGHjLERBAXMwApT9Df1leb
 g9g6hM78knZtIYLGewgLuAp1h6hodu0Kyy0f2AxomheJiTYkdSL8ftOl/bGZvLsQJvj8
 o4cs0K6ijn89zO9FqkQh4eaCSfJfyIrITXkLLWkEwK/u69mqwzwaUrdQmUVw0PNSXBsz 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qht8e8kpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:24:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CIDfka013890;
        Fri, 12 May 2023 18:24:58 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qht8e8kne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:24:58 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFuPxV014614;
        Fri, 12 May 2023 18:23:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qf7eypfhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:23:59 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34CINwjk37618036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:23:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C35858061;
        Fri, 12 May 2023 18:23:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA1458060;
        Fri, 12 May 2023 18:23:50 +0000 (GMT)
Received: from [9.43.118.245] (unknown [9.43.118.245])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 12 May 2023 18:23:50 +0000 (GMT)
Message-ID: <de79bd2c-42cb-23f2-a951-5a5caab0bacf@linux.vnet.ibm.com>
Date:   Fri, 12 May 2023 23:53:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
 <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MJ0wGtHwHIbGtWoAdN8Tw_-JfMJhUiAW
X-Proofpoint-GUID: 0lghyLgLmVjwGVBpmklUql-oiKwZWNcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120151
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/23 9:02 PM, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 01:31:36PM -0700, Ricardo Neri wrote:
>> Hi,
>>
>> This is v4 of this series. Previous versions can be found here [1], [2],
>> and here [3]. To avoid duplication, I do not include the cover letter of
>> the original submission. You can read it in [1].
>>
>> This patchset applies cleanly on today's master branch of the tip tree.
>>
>> Changes since v3:
>>
>> Nobody liked the proposed changes to the setting of prefer_sibling.
>> Instead, I tweaked the solution that Dietmar proposed. Now the busiest
>> group, not the local group, determines the setting of prefer_sibling.
>>
>> Vincent suggested improvements to the logic to decide whether to follow
>> asym_packing priorities. Peter suggested to wrap that in a helper function.
>> I added sched_use_asym_prio().
>>
>> Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
>> rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
>> does not assume that all child domains have the requested flag.
>>
>> Tim found that asym_active_balance() needs to also check for the idle
>> states of the SMT siblings of lb_env::dst_cpu. I added such check.
>>
>> I wrongly assumed that asym_packing could only be used when the busiest
>> group had exactly one busy CPU. This broke asym_packing balancing at the
>> DIE domain. I limited this check to balances between cores at the MC
>> level.
>>
>> As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks()
>> and placed its logic in sched_asym(). Also, sched_asym() uses
>> sched_smt_active() to skip checks when not needed.
>>
>> I also added a patch from Chen Yu to enable asym_packing balancing in
>> Meteor Lake, which has CPUs of different maximum frequency in more than
>> one die.
> 
> Is the actual topology of Meteor Lake already public? This patch made me
> wonder if we need SCHED_CLUSTER topology in the hybrid_topology thing,
> but I can't remember (one of the raisins why the endless calls are such
> a frigging waste of time) and I can't seem to find the answer using
> Google either.
> 
>> Hopefully, these patches are in sufficiently good shape to be merged?
> 
> Changelogs are very sparse towards the end and I had to reverse engineer
> some of it which is a shame. But yeah, on a first reading the code looks
> mostly ok. Specifically 8-10 had me WTF a bit and only at 11 did it
> start to make a little sense. Mostly they utterly fail to answer the
> very fundament "why did you do this" question.
> 
> Also, you seem to have forgotten to Cc our friends from IBM such that
> they might verify you didn't break their Power7 stuff -- or do you have
> a Power7 yourself to verify and forgot to mention that?

Very good patch series in addressing asym packing. Interesting discussions as
well. Took me quite sometime to get through to understand and do a little bit
of testing.

Tested this patch a bit on power7 with qemu. Tested with SMT=4. sched domains
show ASYM_PACKING present only for SMT domain.

We don't see any regressions/gain due to patch. SMT priorities are honored when
tasks are scheduled and load_balanced.


> 
>> Chen Yu (1):
>>   x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
>>     processors
>>
>> Ricardo Neri (11):
>>   sched/fair: Move is_core_idle() out of CONFIG_NUMA
>>   sched/fair: Only do asym_packing load balancing from fully idle SMT
>>     cores
>>   sched/fair: Simplify asym_packing logic for SMT cores
>>   sched/fair: Let low-priority cores help high-priority busy SMT cores
>>   sched/fair: Keep a fully_busy SMT sched group as busiest
>>   sched/fair: Use the busiest group to set prefer_sibling
>>   sched/fair: Do not even the number of busy CPUs via asym_packing
>>   sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()
>>   sched/topology: Remove SHARED_CHILD from ASYM_PACKING
>>   x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
>>   x86/sched/itmt: Give all SMT siblings of a core the same priority
>>
>>  arch/x86/kernel/itmt.c         |  23 +---
>>  arch/x86/kernel/smpboot.c      |   4 +-
>>  include/linux/sched/sd_flags.h |   5 +-
>>  kernel/sched/fair.c            | 216 +++++++++++++++++----------------
>>  kernel/sched/sched.h           |  22 +++-
>>  5 files changed, 138 insertions(+), 132 deletions(-)
> 
> I'm going to start to queue this and hopefully push out post -rc1 if
> nobody objects.
