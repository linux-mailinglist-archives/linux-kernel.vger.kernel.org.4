Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71D5FC791
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJLOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJLOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:39:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08A9081B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:38:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CCuk5A018747;
        Wed, 12 Oct 2022 14:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0//PYTbYVrI3z70oeGvjtrPIGrjbJO2IwlHL+Mp55KU=;
 b=GIH0dcc+QrzNYSQsseUX3edrGjq4dfw7qu5DNWwnWT5lepy/k++Nx2oOauVRiqKK3AqN
 U8ZKs8JgyFt3j/FgtfHEpB6lQNyRP3HfpeeqAtKXrtU0edpjeDOm1jf0qpEo+ak/IIWM
 Jz/R7rujhP9hlsrkbrAsSYzNFy0QKPy1eT9DehAI0wK8MM1B4wM4+Qb869WtRSk0D9s+
 0qRAfWWtGPRuNOqzxMBuAcGgBLPCcwRTYSvJ/1CLLXyhXuTPuZzf2qdmoWIRaX+aW6iz
 oRCGa4z7ttKctQG6pVuvUINQ/G1QAm8CFcACbGe9QevdiXf0Cl/NUSbSSgA/Etj0ZnWh PQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5j7b2706-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:38:38 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29CEcbZR025936;
        Wed, 12 Oct 2022 14:38:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 3k3jqakg40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:38:37 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CEcagM025925;
        Wed, 12 Oct 2022 14:38:36 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 29CEcaXL025920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 14:38:36 +0000
Received: from [10.216.35.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 07:38:32 -0700
Message-ID: <d31605a0-440b-989d-3762-d5e162ec79a6@quicinc.com>
Date:   Wed, 12 Oct 2022 20:08:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/2] locking/rwsem: Limit # of null owner retries for
 handoff writer
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221012133333.1265281-1-longman@redhat.com>
 <20221012133333.1265281-3-longman@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221012133333.1265281-3-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: saxh4T4u47dL9aAIaDWYqEqDlaQme-42
X-Proofpoint-ORIG-GUID: saxh4T4u47dL9aAIaDWYqEqDlaQme-42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120096
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/2022 7:03 PM, Waiman Long wrote:
> Commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically
> spin on owner") assumes that when the owner field is changed to NULL,
> the lock will become free soon.  That assumption may not be correct
> especially if the handoff writer doing the spinning is a RT task which
> may preempt another task from completing its action of either freeing
> the rwsem or properly setting up owner.
> 
> To prevent this live lock scenario, we have to limit the number of
> trylock attempts without sleeping. The current limit is now set to 8
> to allow enough time for the other task to hopefully complete its action.
> 
> By adding new lock events to track the number of NULL owner retries with
> handoff flag set before a successful trylock when running a 96 threads
> locking microbenchmark with equal number of readers and writers running
> on a 2-core 96-thread system for 15 seconds, the following stats are
> obtained. Note that none of locking threads are RT tasks.
> 
>    Retries of successful trylock    Count
>    -----------------------------    -----
>               1                     1738
>               2                       19
>               3                       11
>               4                        2
>               5                        1
>               6                        1
>               7                        1
>               8                        0
>               X                        1
> 
> The last row is the one failed attempt that needs more than 8 retries.
> So a retry count maximum of 8 should capture most of them if no RT task
> is in the mix.
> 
> Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 3839b38608da..12eb093328f2 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1123,6 +1123,7 @@ static struct rw_semaphore __sched *
>   rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   {
>   	struct rwsem_waiter waiter;
> +	int null_owner_retries;
>   	DEFINE_WAKE_Q(wake_q);
>   
>   	/* do optimistic spinning and steal lock if possible */
> @@ -1164,7 +1165,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   	set_current_state(state);
>   	trace_contention_begin(sem, LCB_F_WRITE);
>   
> -	for (;;) {
> +	for (null_owner_retries = 0;;) {
>   		if (rwsem_try_write_lock(sem, &waiter)) {
>   			/* rwsem_try_write_lock() implies ACQUIRE on success */
>   			break;
> @@ -1190,8 +1191,21 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>   			owner_state = rwsem_spin_on_owner(sem);
>   			preempt_enable();
>   
> -			if (owner_state == OWNER_NULL)
> +			/*
> +			 * owner is NULL doesn't guarantee the lock is free.
> +			 * An incoming reader will temporarily increment the
> +			 * reader count without changing owner and the
> +			 * rwsem_try_write_lock() will fails if the reader
> +			 * is not able to decrement it in time. Allow 8
> +			 * trylock attempts when hitting a NULL owner before
> +			 * going to sleep.
> +			 */
> +			if ((owner_state == OWNER_NULL) &&
> +			    (null_owner_retries < 8)) {

define MAX_NULL_OWNER_RETRY		8

??

> +				null_owner_retries++;
>   				goto trylock_again;
> +			}
> +			null_owner_retries = 0;
>   		}
>   

Thanks for considering this patch.

LGTM.
Reviewed-and-Tested-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   		schedule();
