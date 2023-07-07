Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8074AC2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjGGHqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGGHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:45:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228E6268A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:45:32 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3677gBEp026344;
        Fri, 7 Jul 2023 07:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=9/9D+YduQ6I/Ud8m/oU6CbAYKc918wbXzzCu3lcmSvg=;
 b=bOs+Jxy4fltCpXzFEafRZLv2/6Hq+6c0chMmoIqvZ2sBCKy2Aby8L8NU5ZOOpb00ziQa
 igJC5RmUPEKpEMlgnUdTYBdMDQ0hPf1PqbZ/t9CiC+AraQBbAaIAIJ0xKWLm4QN/SnKc
 AEp7a+iJIu2jZCMoyvCatef0Xe7LTIb/sFg8fdbG/nkqag9IXFlh8gjpjL4ju1/OrNNk
 d/HhFdgFRm6b+7ge/v7LbjVu6nlFVcwBxEmwN8FPmCNvnXjsyYiwM9YqGNfWkJ9xVl+a
 eLvj8S2hflXXbs5Pl8exwr+tEbrWz0vHkca7S4+nG6sIIeNKEJhCnmGnAI4O/Gca1usf xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpe6b0ejc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:45:20 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3677iDUc031327;
        Fri, 7 Jul 2023 07:45:18 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpe6b0ej3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:45:18 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 366LCIC7001850;
        Fri, 7 Jul 2023 07:45:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3rjbs59pjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:45:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3677jGjH45482312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 07:45:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B6775804E;
        Fri,  7 Jul 2023 07:45:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 783185803F;
        Fri,  7 Jul 2023 07:45:15 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 07:45:15 +0000 (GMT)
MIME-Version: 1.0
Date:   Fri, 07 Jul 2023 09:45:15 +0200
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] sched/fair: Consider asymmetric scheduler groups in
 load balancer
In-Reply-To: <de856969-5d78-f771-96ff-4afce3a6e776@linux.vnet.ibm.com>
References: <20230515114601.12737-1-huschle@linux.ibm.com>
 <20230515114601.12737-2-huschle@linux.ibm.com>
 <de856969-5d78-f771-96ff-4afce3a6e776@linux.vnet.ibm.com>
Message-ID: <8a29c5d6b0af0321316a88b924b8322f@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AMOoIwPhpy4uAFGEAXkARoOvMuAPXB8g
X-Proofpoint-ORIG-GUID: 9J5glT53i1nQRwtz6TprbAilNn95Dpr0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307070068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-06 19:19, Shrikanth Hegde wrote:
> On 5/15/23 5:16 PM, Tobias Huschle wrote:
>> The current load balancer implementation implies that scheduler 
>> groups,
>> within the same domain, all host the same number of CPUs. This is
>> reflected in the condition, that a scheduler group, which is load
>> balancing and classified as having spare capacity, should pull work
>> from the busiest group, if the local group runs less processes than
>> the busiest one. This implies that these two groups should run the
>> same number of processes, which is problematic if the groups are not
>> of the same size.
>> 
>> The assumption that scheduler groups within the same scheduler domain
>> host the same number of CPUs appears to be true for non-s390
>> architectures. Nevertheless, s390 can have scheduler groups of unequal
>> size.
>> 
>> This introduces a performance degredation in the following scenario:
>> 
>> Consider a system with 8 CPUs, 6 CPUs are located on one CPU socket,
>> the remaining 2 are located on another socket:
>> 
>> Socket   -----1-----    -2-
>> CPU      1 2 3 4 5 6    7 8
>> 
>> Placing some workload ( x = one task ) yields the following
>> scenarios:
>> 
>> The first 5 tasks are distributed evenly across the two groups.
>> 
>> Socket   -----1-----    -2-
>> CPU      1 2 3 4 5 6    7 8
>>          x x x          x x
>> 
>> Adding a 6th task yields the following distribution:
>> 
>> Socket   -----1-----    -2-
>> CPU      1 2 3 4 5 6    7 8
>> SMT1     x x x          x x
>> SMT2                    x
>> 
>> The task is added to the 2nd scheduler group, as the scheduler has the
>> assumption that scheduler groups are of the same size, so they should
>> also host the same number of tasks. This makes CPU 7 run into SMT
>> thread, which comes with a performance penalty. This means, that in
>> the window of 6-8 tasks, load balancing is done suboptimally, because
>> SMT is used although there is no reason to do so as fully idle CPUs
>> are still available.
>> 
>> Taking the weight of the scheduler groups into account, ensures that
>> a load balancing CPU within a smaller group will not try to pull tasks
>> from a bigger group while the bigger group still has idle CPUs
>> available.
>> 
>> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 48b6f0ca13ac..b1307d7e4065 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -10426,7 +10426,8 @@ static struct sched_group 
>> *find_busiest_group(struct lb_env *env)
>>  	 * group's child domain.
>>  	 */
>>  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
>> -	    busiest->sum_nr_running > local->sum_nr_running + 1)
>> +	    busiest->sum_nr_running * local->group_weight >
>> +			local->sum_nr_running * busiest->group_weight + 1)
>>  		goto force_balance;
>> 
> 
> 
> I assume its SMT2 here. sched group is enclosed in 
> [busy_cpus/idle_cpus/weight]
> 
> Lets take an example:  we will begin the with the said imbalance.
> [3/9/12] -- local group
> [3/1/4] -- busy group.
> we will evaluate 3*12 > (4*(3+1)) is true and proceeds further to 
> balance.
> but calculate_imbalance will lead to zero as the imbalance no? in case
> of prefer sibling
> case it find the difference of sum_nr_running of the two groups. It
> will be 3-3 = 0
> 
> this would need modifications to calculate_imbalance.
> Maybe something like this will help? NOT TESTED AT ALL.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..e027d4086edc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10296,7 +10296,9 @@ static inline void calculate_imbalance(struct
> lb_env *env, struct sd_lb_stats *s
>                         return;
>                 }
> 
> -               if (busiest->group_weight == 1 || sds->prefer_sibling) 
> {
> +               if (busiest->group_weight == 1 ||
> +                       (sds->prefer_sibling &&
> +                        busiest->group_weight == local->group_weight)) 
> {
>                         unsigned int nr_diff = busiest->sum_nr_running;
>                         /*
>                          * When prefer sibling, evenly spread running 
> tasks on
> @@ -10305,6 +10307,11 @@ static inline void calculate_imbalance(struct
> lb_env *env, struct sd_lb_stats *s
>                         env->migration_type = migrate_task;
>                         lsub_positive(&nr_diff, local->sum_nr_running);
>                         env->imbalance = nr_diff;
> +               }
> +               if (sds->prefer_sibling &&
> +                   busiest->group_weight != local->group_weight) {
> +                       env->migration_type = migrate_task;
> +                       env->imbalance = 1;
>                 } else {
> 

I also had a look at this when Vincent pointed out that this part is 
missing.
The formula proposed by Vincent works pretty well, it is not even 
necessary
to add additional if-statements here.
> 
> ---------------------------------------------------------------------------------------------------
> On a tangential dimension.
> 
> 
> Since prefer_siblings make inherent assumption that all groups have
> equal weight,
> it will cause  complications when group_weights are different. I think
> that becomes very
> tricky when there are more than two groups. Depending on which cpu is 
> doing
> load_balance there can be unnecessary migrations.
> 
> 
> Currently even in NUMA this can be similar case right? There will be
> unequal number of CPU's right?
> If we fix that case and remove prefer siblings in your arch, will that 
> work?
> 
> Maybe something like this? NOT TESTED AT ALL.
> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..fc6377f48ced 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10514,6 +10514,7 @@ static struct sched_group
> *find_busiest_group(struct lb_env *env)
>                         goto out_balanced;
> 
>                 if (busiest->group_weight > 1 &&
> +                   busiest->group_weight == local->group_weight &&
>                     local->idle_cpus <= (busiest->idle_cpus + 1))
>                         /*
>                          * If the busiest group is not overloaded
> @@ -10526,6 +10527,11 @@ static struct sched_group
> *find_busiest_group(struct lb_env *env)
>                          */
>                         goto out_balanced;
> 
> +               if ((busiest->group_weight != local->group_weight) &&
> +                     (local->idle_cpus * busiest->group_weight <=
> +                              local->group_weight * 
> (busiest->idle_cpus + 1)))
> +                       goto out_balanced;
> +
>                 if (busiest->sum_h_nr_running == 1)
>                         /*
>                          * busiest doesn't have any tasks waiting to 
> run
> 
> 
> 
> 
> 
>>  	if (busiest->group_type != group_overloaded) {

I played around with alternate solutions as well, yours could be 
interesting in order
to declare the problematic state as balanced essentially. I wouldn't be 
opposed to
remove prefer_siblings. The question would be if it is necessary to 
address both
scenarios anyway.


