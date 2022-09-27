Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D515EB9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiI0Ffw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiI0Ffs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:35:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1575CE0;
        Mon, 26 Sep 2022 22:35:47 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R4FDTZ003052;
        Tue, 27 Sep 2022 05:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8rSZifAt0/8sDAV2os4E9EEjO3mjK/L6/fG0BOQhOTQ=;
 b=Pmc7VYNQrBh3hIv0xQxgmsV5IMqPyh6pmbv39rBr9h9t0XkdOiY9eB6IfLGQ5vJq36hz
 RzxrqvtEZXmJusnG5TifJLLWQICgHGqs/UCuGjOFAVzv1n3/KZB78XE8kqIoBG7d/hXe
 w8ZQh2Gzk6aknyyEhpfIxkg35Oy/T6kNcudGoMBXSyDfOHfwxDRKPr7CO+GjFBKyoP82
 nS4r+Q7OYkN1ROkOFZeIdmkwU0YXT3TLCdDTRhuAYBGfqdddGV0m9u7SDSuuTKL7iSgD
 84rDBPje5cMsMAGSaF8s1V+ghw62vdfUdv7PQhV3YNYbngrl6pll/oaDPMnDI1E1J5pw oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jut03hupv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 05:35:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R5Xn0P016843;
        Tue, 27 Sep 2022 05:35:20 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jut03hunt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 05:35:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R5MEq1005843;
        Tue, 27 Sep 2022 05:35:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jssh9bbd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 05:35:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R5ZFhC8585752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 05:35:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE4F111C050;
        Tue, 27 Sep 2022 05:35:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3941D11C04C;
        Tue, 27 Sep 2022 05:35:15 +0000 (GMT)
Received: from [9.171.17.43] (unknown [9.171.17.43])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Sep 2022 05:35:15 +0000 (GMT)
Message-ID: <985463a3-5e33-95d2-b2bb-824707a2f819@linux.ibm.com>
Date:   Tue, 27 Sep 2022 07:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Amit Shah <amit@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
 <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
 <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
 <YzHt2nG0Hb7xLlNj@hirez.programming.kicks-ass.net>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YzHt2nG0Hb7xLlNj@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mi6-W2vGd5VnXJkrLCPMIWSPcqU47Tpg
X-Proofpoint-GUID: Pe_cc4-P2ayaCtxwviYRD4z4w247SsYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270031
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 26.09.22 um 20:22 schrieb Peter Zijlstra:
> On Mon, Sep 26, 2022 at 08:06:46PM +0200, Peter Zijlstra wrote:
> 
>> Let me go git-grep some to see if there's more similar fail.
> 
> I've ended up with the below...

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

Kind of scary that nobody else has reported any regression. I guess the freezable variant is just not used widely.
> 
> ---
>   include/linux/wait.h | 2 +-
>   kernel/hung_task.c   | 8 ++++++--
>   kernel/sched/core.c  | 2 +-
>   3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 14ad8a0e9fac..7f5a51aae0a7 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -281,7 +281,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
>   
>   #define ___wait_is_interruptible(state)						\
>   	(!__builtin_constant_p(state) ||					\
> -		state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)		\
> +	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
>   
>   extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
>   
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index f1321c03c32a..4a8a713fd67b 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -191,6 +191,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   	hung_task_show_lock = false;
>   	rcu_read_lock();
>   	for_each_process_thread(g, t) {
> +		unsigned int state;
> +
>   		if (!max_count--)
>   			goto unlock;
>   		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
> @@ -198,8 +200,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   				goto unlock;
>   			last_break = jiffies;
>   		}
> -		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
> -		if (READ_ONCE(t->__state) == TASK_UNINTERRUPTIBLE)
> +		/* skip the TASK_KILLABLE tasks -- these can be killed */
> +		state == READ_ONCE(t->__state);
> +		if ((state & TASK_UNINTERRUPTIBLE) &&
> +		    !(state & TASK_WAKEKILL))
>   			check_hung_task(t, timeout);
>   	}
>    unlock:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1095917ed048..12ee5b98e2c4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8885,7 +8885,7 @@ state_filter_match(unsigned long state_filter, struct task_struct *p)
>   	 * When looking for TASK_UNINTERRUPTIBLE skip TASK_IDLE (allows
>   	 * TASK_KILLABLE).
>   	 */
> -	if (state_filter == TASK_UNINTERRUPTIBLE && state == TASK_IDLE)
> +	if (state_filter == TASK_UNINTERRUPTIBLE && state & TASK_NOLOAD)
>   		return false;
>   
>   	return true;
