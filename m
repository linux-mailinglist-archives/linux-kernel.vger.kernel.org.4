Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E4692208
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjBJPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjBJPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:23:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400975F59;
        Fri, 10 Feb 2023 07:23:14 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AEeJDE009736;
        Fri, 10 Feb 2023 15:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SVsPGEtyQHE68QBQ00pydMfX0HSjV7Hx3EtuykeQ8Ok=;
 b=nst7GPrndJtlwM8G9q/4ytnIe0mDBjcZJXFlx25b6BJNGc4yc3HYq8jIsd9Af8ZbayoW
 GmDtfm0OqA/+L9+ViWY6syvFeP0oXG/bExOQ3Miz/o6JcimFSQPOKekzBuSUFF/rXsQZ
 catB/6OHXf6C3tmdBsZTgIUcUvmFEz30HaqX7Fl7b4UHn/4pQ3u7DJaEIW8DFVPB2CQD
 p5Loqa1we9IKpjX5g74FR2jbVG27hCrgUbJe2EgklvbXX28KagTFXVjX5uO/4Ey/Gxbj
 YyHYGdAZDzWwn1nistkzQJZNKNdY62SOBIyLm0CZ6ndBHhPfAGlCT2ZNAA7tY3XMyZTM 0g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nncxtshbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 15:23:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31AFN771007702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 15:23:07 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 10 Feb 2023 07:23:05 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <rostedt@goodmis.org>, <zhengyejian1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: Re: [PATCH] tracing/ring-buffer: Remove integrity check at end of iter read
Date:   Fri, 10 Feb 2023 20:52:36 +0530
Message-ID: <1676042556-737-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20230208090814.869242-1-zhengyejian1@huawei.com>
References: <20230208090814.869242-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rt8k2DVqn6vmtpmVku4xngE8WSNeX-K_
X-Proofpoint-GUID: Rt8k2DVqn6vmtpmVku4xngE8WSNeX-K_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_09,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=831
 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302100127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/9 06:36, Steven Rostedt wrote:
>> On Wed, 8 Feb 2023 17:08:14 +0800
>> Zheng Yejian <zhengyejian1@huawei.com> wrote:
>> 
>>> Concurrently closing "trace" file and writing into ring buffer [1] can
>>> cause WARNINGs [2]. It has been reported in
>>> Link: https://lore.kernel.org/all/20230203035608.2336906-1-zhengyejian1@huawei.com/
>>>
>>> It seems a data race between ring_buffer writing and integrity check.
>>> That is, RB_FLAG of head_page is been updating, while at same time RB_FLAG
>>> was cleared when doing integrity check:
>>>    rb_check_pages()            rb_handle_head_page():
>>>    --------                    --------
>>>    rb_head_page_deactivate()
>>>                                rb_head_page_set_normal()
>>>    rb_head_page_activate()
>>>
>> 
>> Good catch!
>
>Thanks!
>
>> 
>>> Integrity check at end of iter read was added since commit 659f451ff213
>>> ("ring-buffer: Add integrity check at end of iter read"). As it's commit
>>> message said:
>>>    > As reading via an iterator requires disabling the ring buffer, it
>>>    > is a perfect place to have it.
>>> However, since commit 1039221cc278 ("ring-buffer: Do not disable recording
>>> when there is an iterator"), ring buffer was not disabled at that place,
>>> so that integrity check should be removed.
>>>
>>> 1:
>>> ``` read_trace.sh
>>>    while true;
>>>    do
>>>      # the "trace" file is closed after read
>>>      head -1 /sys/kernel/tracing/trace > /dev/null
>>>    done
>>> ```
>>> ``` repro.sh
>>>    sysctl -w kernel.panic_on_warn=1
>>>    # function tracer will writing enough data into ring_buffer
>>>    echo function > /sys/kernel/tracing/current_tracer
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>>    ./read_trace.sh &
>>> ```
>>>
>> 
>> 
>>> Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there is an iterator")
>>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>>> ---
>>>   kernel/trace/ring_buffer.c | 11 -----------
>>>   1 file changed, 11 deletions(-)
>>>
>>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>>> index c366a0a9ddba..34e955bd1e59 100644
>>> --- a/kernel/trace/ring_buffer.c
>>> +++ b/kernel/trace/ring_buffer.c
>>> @@ -5203,17 +5203,6 @@ void
>>>   ring_buffer_read_finish(struct ring_buffer_iter *iter)
>>>   {
>>>   	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
>>> -	unsigned long flags;
>>> -
>>> -	/*
>>> -	 * Ring buffer is disabled from recording, here's a good place
>>> -	 * to check the integrity of the ring buffer.
>>> -	 * Must prevent readers from trying to read, as the check
>>> -	 * clears the HEAD page and readers require it.
>>> -	 */
>>> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>> -	rb_check_pages(cpu_buffer);
>>> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>> 
>> I would rather find a way to make this still work than just removing it.
>
>Yes, we can try to find the way.
>
>> 
>> Perhaps there's no reason to clear the flags, and change rb_check_pages()
>> to mask them out before testing. Something like:
>> 
>> static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>> {
>> 	struct list_head *head = cpu_buffer->pages;
>> 	struct buffer_page *bpage, *tmp;
>> 
>> 	if (RB_WARN_ON(cpu_buffer, rb_list_head(rb_list_head(head->next)->prev) != head))
>> 		return -1;
>> 	if (RB_WARN_ON(cpu_buffer, rb_list_head(rb_list_head(head->prev)->next) != head))
>> 		return -1;
>> 
>> 	if (rb_check_list(cpu_buffer, head))
>
>rb_check_list() expect to check a page with RB_FLAG being cleared,
>but in this solution, rb_head_page_deactivate() is not called before,
>so we may not call it directly? The same problem with below check for
>"bpage->list".

Correct.


>> 		return -1;
>> 
>> 	list_for_each_entry_safe(bpage, tmp, head, list) {
>
>I'd like to know if there is a case that "head" happens to be a
>"reader_page", and the ring buffer is not exactly being traversed?

In my issue, i see below callstack and it seem to be spinning inside rb_list_head_clear() as
cpu_buffer->pages has duplicate entry in the list.

-00 |rb_list_head_clear(inline)
-00 |rb_head_page_deactivate(inline)
-00 |rb_check_pages(cpu_buffer = 0xFFFFFF89E0C3B200)
-01 |atomic_try_cmpxchg_acquire(inline)
-01 |queued_spin_lock(inline)
-01 |do_raw_spin_lock_flags(inline)
-01 |__raw_spin_lock_irqsave(inline)
-01 |_raw_spin_lock_irqsave(inline)
-01 |ring_buffer_read_finish(iter = 0xFFFFFF8006FE3780)
-02 |cpumask_next(inline)
-02 |tracing_release(inode = ?, file = 0xFFFFFF8A53A63F00)
-03 |__fput(file = 0xFFFFFF8A53A63F00)
-04 |____fput(work = ?)
-05 |_raw_spin_unlock_irq(inline)
-05 |task_work_run()
-06 |tracehook_notify_resume(inline)
-06 |do_notify_resume(regs = 0xFFFFFFC06ADC8EB0, thread_flags = 67108868)
-07 |prepare_exit_to_user_mode(inline)
-07 |exit_to_user_mode(inline)
-07 |el0_svc(regs = 0xFFFFFFC06ADC8EB0)
-08 |el0t_64_sync_handler(regs = ?)
-09 |el0t_64_sync(asm)

...
..
ffffff80359eeb00 --> Duplicate entry 
ffffff80359ee300
ffffff80359ee180
ffffff80359eeec0
ffffff80359eec00
ffffff80359ee800 -- Tail page
ffffff80359eedc0 -- Head page
ffffff80359ee640
ffffff80359ee080
ffffff80359ee700
ffffff80359ee7c0
ffffff80359eed80
ffffff80359ee900
ffffff80359ee9c0
ffffff80359eea00
ffffff80359eea80
ffffff80359eec80
ffffff80359ee240
ffffff80359ee6c0
ffffff80359ee0c0
ffffff80359ee8c0
ffffff80359ee940
ffffff80359eee00
ffffff80359ee000
ffffff80359eeb00 ---> Duplicate entry 


-Mukesh

>
>> 		if (RB_WARN_ON(cpu_buffer,
>> 		     rb_list_head(rb_list_head(bpage->list.next)->prev) != &bpage->list))
>> 			return -1;
>> 		if (RB_WARN_ON(cpu_buffer,
>> 		     rb_list_head(rb_list_head(bpage->list.prev)->next) != &bpage->list))
>> 			return -1;
>> 		if (rb_check_list(cpu_buffer, &bpage->list))
>> 			return -1;
>> 	}
>> 
>> 	return 0;
>> }
>> 
>> I haven't tested the above.
>> 
>> ?
>> 
>> -- Steve
>> 
>> 
>>>   
>>>   	atomic_dec(&cpu_buffer->resize_disabled);
>>>   	kfree(iter->event);
