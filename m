Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA99626E94
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiKMIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiKMIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4329B4B8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 00:51:27 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AD8nX7r028832;
        Sun, 13 Nov 2022 08:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hLdxzrFVlJZEbaCxWDQ6zbhK4CRN1hXW8wjFLLufZ/c=;
 b=B3z0h22oa5Qrfiv5SXEtHkYCWDtgaFjRvxBcVe6RlxS8h1CdlouEf6b7Ugousa/9AlO8
 ay/5cMBGN/swFL250HOAAxEO2vqrrpMVIZ8QZEv145z2wK4+lag2/xx8X5IF/g024I5E
 NhlOZm+XQvkCNlxaWeZE/VtxZhUOam3k2u1Kd4fSGHdqME4pCwNNFuHbHnArhJfnVDlb
 HsCJIOnLw8cSvwq1oiLXxMbylVfUmVJQNNdnj7j0DcLYANsqqy22ZdkqyT3zxEISFH7X
 8pKnSzNFKLExLt1qjAnWaKAPH1V0D6xbJBXLnExZEjZA2j+aoJzKRwEEbAOLE6741ZuP 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ktwdn80mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:50:50 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AD8oOi3031251;
        Sun, 13 Nov 2022 08:50:49 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ktwdn80fa-26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:50:49 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AD8adeU013285;
        Sun, 13 Nov 2022 08:39:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3kt34972n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:39:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AD8drPR55902580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 08:39:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97DC158051;
        Sun, 13 Nov 2022 08:39:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA3AD5805F;
        Sun, 13 Nov 2022 08:39:42 +0000 (GMT)
Received: from [9.160.60.23] (unknown [9.160.60.23])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 13 Nov 2022 08:39:42 +0000 (GMT)
Message-ID: <dbdb2a45-5e81-7cb8-04c6-e10c0e1a3184@linux.vnet.ibm.com>
Date:   Sun, 13 Nov 2022 14:09:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 5/9] sched/fair: Take into account latency priority at
 wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-6-vincent.guittot@linaro.org>
From:   shrikanth suresh hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20221028093403.6673-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iJ-XaSKKvYPUYhi5Mt08n7_UP8QVfkh-
X-Proofpoint-ORIG-GUID: NnA5hXkzOZz0Scw55kErpGlq0qfv0ZQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211130054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   /*
>    * Preempt the current task with a newly woken task if needed:
>    */
> @@ -4566,7 +4568,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>   {
>   	unsigned long ideal_runtime, delta_exec;
>   	struct sched_entity *se;
> -	s64 delta;
> +	s64 delta, offset;
>   
>   	ideal_runtime = sched_slice(cfs_rq, curr);
>   	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> @@ -4591,10 +4593,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>   	se = __pick_first_entity(cfs_rq);
>   	delta = curr->vruntime - se->vruntime;
>   
> -	if (delta < 0)
> +	offset = wakeup_latency_gran(curr, se);
> +	if (delta < offset)
>   		return;
>   
> -	if (delta > ideal_runtime)
> +	if ((delta > ideal_runtime) ||
> +	    (delta > get_latency_max()))
>   		resched_curr(rq_of(cfs_rq));
>   }
>   
>
Hi Vincent,

I am not sure if i have understood this below change correctly.

wakeup_latency_gran - this function returns difference in latency nice offsets.
Hence the more negative the value, it means se has more latency requirement
compared to current. Hence se should preempt the current here right?

we are comparing delta to get_latency_max and ideal_runtime, both of which can
be higher positive value, hence we will not preempt. that is not what we want
right?

