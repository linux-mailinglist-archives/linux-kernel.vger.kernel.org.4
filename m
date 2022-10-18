Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E66D602E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJROPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJROPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:15:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299503FD55
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:15:09 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ICXHmg014937;
        Tue, 18 Oct 2022 14:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K3J37H7EPKyuTx7uG9gYu0BVPFpLlEwR75+6u3rXCec=;
 b=U6EmwjwdmX9XXdweiqtSZHSLhNXi/XQfq+l53IDnII1LAguXp4i2ScP+rt3TM/fd37kR
 0CN+trX0Ix/KxuR+zWAYO93tEFLvPdNinAZdwW1YDdVhbJEO1UunBa3IXvfvfhq4HiYw
 nHRchtKZA3iB3iW98Hpo7w4/NhLGocsu5i6/3e2KEHwNTNFs6Wo+d7B2Cmdglbsvy7Wi
 XimF3TTZwxh3bRp2jHimr7Oku3ULOuM5zBQ2VLPpvgyX3Asp2lsaXM/N7Q8b3slaKlqC
 x7LwxuADKLSEFINpVz6TtpkrfmYviZyKs4yCHVWUNy0AK04UOuajCpL4ju6TJQ9ah5NA Jg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9ktr9897-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:14:40 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEEdl3021561;
        Tue, 18 Oct 2022 14:14:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3k7nxkqk9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:14:39 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29IEEdSM021556;
        Tue, 18 Oct 2022 14:14:39 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 29IEEdbx021555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:14:39 +0000
Received: from [10.216.40.217] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 07:14:35 -0700
Message-ID: <9b63611e-8d9a-529b-dcdc-05b10a8a712a@quicinc.com>
Date:   Tue, 18 Oct 2022 19:43:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/5] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>, Waiman Long <longman@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>, <john.p.donnelly@oracle.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221018111424.1007-1-hdanton@sina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221018111424.1007-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U1HOZlofg8wKd-xITAVd5j7J61gQ6LbD
X-Proofpoint-ORIG-GUID: U1HOZlofg8wKd-xITAVd5j7J61gQ6LbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=721 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210180080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/2022 4:44 PM, Hillf Danton wrote:
> On 17 Oct 2022 17:13:55 -0400 Waiman Long <longman@redhat.com>
>> @@ -1067,13 +1119,33 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>>   			return sem;
>>   		}
>>   		adjustment += RWSEM_FLAG_WAITERS;
>> +	} else if ((count & RWSEM_FLAG_HANDOFF) &&
>> +		  ((count & RWSEM_LOCK_MASK) == RWSEM_READER_BIAS)) {
> 
> Could a couple of CPUs go read slow path in parallel?
> 
>> +		/*
>> +		 * If the waiter to be handed off is a reader, this reader
>> +		 * can piggyback on top of top of that.
>> +		 */
>> +		if (rwsem_first_waiter(sem)->type == RWSEM_WAITING_FOR_READ)
>> +			adjustment = 0;
>> +		rwsem_handoff(sem, adjustment, &wake_q);
>> +
>> +		if (!adjustment) {
>> +			raw_spin_unlock_irq(&sem->wait_lock);
>> +			wake_up_q(&wake_q);
>> +			return sem;
>> +		}
>> +		adjustment = 0;
>>   	}
>>   	rwsem_add_waiter(sem, &waiter);
> 
> Why can this acquirer pigyback without becoming a waiter?
> 
>>   
>> -	/* we're now waiting on the lock, but no longer actively locking */
>> -	count = atomic_long_add_return(adjustment, &sem->count);
>> -
>> -	rwsem_cond_wake_waiter(sem, count, &wake_q);
>> +	if (adjustment) {
>> +		/*
>> +		 * We are now waiting on the lock with no handoff, but no
>> +		 * longer actively locking.
>> +		 */
>> +		count = atomic_long_add_return(adjustment, &sem->count);
>> +		rwsem_cond_wake_waiter(sem, count, &wake_q);
>> +	}
>>   	raw_spin_unlock_irq(&sem->wait_lock);
>>   
>>   	if (!wake_q_empty(&wake_q))
>> @@ -1120,7 +1192,6 @@ static struct rw_semaphore __sched *
>>   rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>   {
>>   	struct rwsem_waiter waiter;
>> -	int null_owner_retries;
> 
> This reverts 2/5 and feel free to drop it directly.

I think, he intents to tag the first two patches to go to stable branches.

-Mukesh
> 
> Hillf
