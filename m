Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC75EAD45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiIZQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIZQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:55:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8F51C430;
        Mon, 26 Sep 2022 08:49:45 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QEU2s4004827;
        Mon, 26 Sep 2022 15:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BAAkQPJUniW6I4A73h7YeiR4tAVwoqmwhjv/IGoOmHI=;
 b=k/yBCckOBvx1iMXNsL71sJv9WNl9LC1BBxlU9w0v8VL+WVh68sPA+UkcDTGRhJP1srry
 3jNDpHNsYYjJbqZObEkfusJ8DY/evuTplAEpO2SIVeHfE4YMVAHb68Fj8Tw7Qgz1geos
 XJcycuKWhhWmJga2Himc6/5vyjBp4oUlBxCQa1hADDHEaBRco7ScIPCBP5PlDqRzRSyu
 HiwRgQ5EOsEcA8/TQqNKQVL/s3UgOvpw2JRYq6a9uZR+k2skQDxYwmFFQorDbhDn0luR
 pT1x388j725TtHpnAR/r4u4y06ck1pvawMlBdayNgDJfz88okpAMpWMWd6PjqMyfCXRE Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucjrdr4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:49:23 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QDKJQY013322;
        Mon, 26 Sep 2022 15:49:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucjrdr45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:49:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QFbYVA032301;
        Mon, 26 Sep 2022 15:49:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3jssh91y62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:49:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QFnHNA3998348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 15:49:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBC51A405B;
        Mon, 26 Sep 2022 15:49:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E9E7A4054;
        Mon, 26 Sep 2022 15:49:17 +0000 (GMT)
Received: from [9.171.20.172] (unknown [9.171.20.172])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 15:49:17 +0000 (GMT)
Message-ID: <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
Date:   Mon, 26 Sep 2022 17:49:16 +0200
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
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5DtpxKxPO8IHNBcG607UyFF58T5jGATs
X-Proofpoint-ORIG-GUID: Jvxbn7w7La4_KTQpSuYLex2PibWJ-dfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260098
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 26.09.22 um 15:37 schrieb Peter Zijlstra:
> On Mon, Sep 26, 2022 at 03:23:10PM +0200, Christian Borntraeger wrote:
>> Am 26.09.22 um 14:55 schrieb Peter Zijlstra:
>>
>>> Could you please test with something like the below on? I can boot that
>>> with KVM, but obviously I didn't suffer any weirdness to begin with :/
>>>
>>> ---
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 4e6a6417211f..ef9ccfc3a8c0 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4051,6 +4051,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>>>    	unsigned long flags;
>>>    	int cpu, success = 0;
>>> +	WARN_ON_ONCE(state & TASK_FREEZABLE);
>>> +
>>>    	preempt_disable();
>>>    	if (p == current) {
>>>    		/*
>>
>> Does not seem to trigger.
> 
> Moo -- quite the puzzle this :/ I'll go stare at it more then.

Hmm,

#define ___wait_is_interruptible(state)                                         \
         (!__builtin_constant_p(state) ||                                        \
                 state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)          \

That would not trigger when state is also TASK_FREEZABLE, no?
