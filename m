Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09087696341
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBNMOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjBNMOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:14:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64E211D;
        Tue, 14 Feb 2023 04:14:45 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E4Ls5H030528;
        Tue, 14 Feb 2023 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vN0frs54ZBYYfmOCBXdNKCUNlLLin+tNZYV8zh4bHZg=;
 b=OopLqgIK/1KXNtR6iJKsnKmJ67iQPbiX5tLsC8ukbcS9w2TbSYH85BNm1BBNgBuninPm
 y4IJ523SgdBL57NMrZHDTxy00xzpIfbrKAjrcBxTf05+UjQPjGeCjTlr/4mkzHnbwCDs
 6sHtbF3IzH4oeaWKW0abS+tjsMmX3UokGka6X6NqG6EroOfj3ti/R15V0eqXtia3BrIK
 O8IL8p4fPmW4wVaWV5N20oiH1HhsQgAkFR0frBMJNpshpQcH7q1nJyidJaLC7aedRVOo
 tFQ2AOgHLEIRCCYte6gNyNnpBvyUvLSOaP/Gmd3CYSRQeTSjt6YIHlOUihVfiCTJWf7O mA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygsdqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:14:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ECEbUN001922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 12:14:37 GMT
Received: from [10.216.50.155] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 04:14:34 -0800
Message-ID: <04ba3f0f-6ca8-b8ff-3fd8-2ccc63482e04@quicinc.com>
Date:   Tue, 14 Feb 2023 17:44:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tracing/ring-buffer: Remove integrity check at end of
 iter read
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <zhengyejian1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <wanghai38@huawei.com>
References: <20230208090814.869242-1-zhengyejian1@huawei.com>
 <1676042556-737-1-git-send-email-quic_mojha@quicinc.com>
 <20230211113700.40728a05@gandalf.local.home>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230211113700.40728a05@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hdtNgYMRu8hmneO8_G-VDvoIBOGjqTlu
X-Proofpoint-GUID: hdtNgYMRu8hmneO8_G-VDvoIBOGjqTlu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=703 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140106
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2023 10:07 PM, Steven Rostedt wrote:
> On Fri, 10 Feb 2023 20:52:36 +0530
> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> 
>>>> 		return -1;
>>>>
>>>> 	list_for_each_entry_safe(bpage, tmp, head, list) {
>>>
>>> I'd like to know if there is a case that "head" happens to be a
>>> "reader_page", and the ring buffer is not exactly being traversed?
> 
> No, the way it works is that the reader page is found by searching for the
> head pointer, and then it is set when swapped. Basically, the pseudo code
> is:
> 
>    reader->next = head_page | HEAD_FLAG
>    val = head_page->prev->next
>    val &= ~FLAGS
>    val |= HEAD_FLAG
>    cmpxchg(head_page->prev->next, val, reader)
> 
> The HEAD_FLAG is always on the pointer that points to the head page that
> gets swapped. This will never point to the reader page, as that would mean
> the writer has access to it.
> 
>>
>> In my issue, i see below callstack and it seem to be spinning inside rb_list_head_clear() as
>> cpu_buffer->pages has duplicate entry in the list.
>>
>> -00 |rb_list_head_clear(inline)
>> -00 |rb_head_page_deactivate(inline)
>> -00 |rb_check_pages(cpu_buffer = 0xFFFFFF89E0C3B200)
>> -01 |atomic_try_cmpxchg_acquire(inline)
>> -01 |queued_spin_lock(inline)
>> -01 |do_raw_spin_lock_flags(inline)
>> -01 |__raw_spin_lock_irqsave(inline)
>> -01 |_raw_spin_lock_irqsave(inline)
>> -01 |ring_buffer_read_finish(iter = 0xFFFFFF8006FE3780)
>> -02 |cpumask_next(inline)
>> -02 |tracing_release(inode = ?, file = 0xFFFFFF8A53A63F00)
>> -03 |__fput(file = 0xFFFFFF8A53A63F00)
>> -04 |____fput(work = ?)
>> -05 |_raw_spin_unlock_irq(inline)
>> -05 |task_work_run()
>> -06 |tracehook_notify_resume(inline)
>> -06 |do_notify_resume(regs = 0xFFFFFFC06ADC8EB0, thread_flags = 67108868)
>> -07 |prepare_exit_to_user_mode(inline)
>> -07 |exit_to_user_mode(inline)
>> -07 |el0_svc(regs = 0xFFFFFFC06ADC8EB0)
>> -08 |el0t_64_sync_handler(regs = ?)
>> -09 |el0t_64_sync(asm)
>>
>> ...
>> ..
>> ffffff80359eeb00 --> Duplicate entry
>> ffffff80359ee300
>> ffffff80359ee180
>> ffffff80359eeec0
>> ffffff80359eec00
>> ffffff80359ee800 -- Tail page
>> ffffff80359eedc0 -- Head page
>> ffffff80359ee640
>> ffffff80359ee080
>> ffffff80359ee700
>> ffffff80359ee7c0
>> ffffff80359eed80
>> ffffff80359ee900
>> ffffff80359ee9c0
>> ffffff80359eea00
>> ffffff80359eea80
>> ffffff80359eec80
>> ffffff80359ee240
>> ffffff80359ee6c0
>> ffffff80359ee0c0
>> ffffff80359ee8c0
>> ffffff80359ee940
>> ffffff80359eee00
>> ffffff80359ee000
>> ffffff80359eeb00 ---> Duplicate entry
> 
> So this is a separate issue where the ring buffer is corrupted?

It looks to be different issue and there also i see similar call stack 
of tracing_release() but in that issue it is looping forever in 
deactivate call due to list corruption.

I am not yet able to root cause a place of corruption as it is 
reproduced only once, will need to check more on this.

For this issue, i have posted at
https://lore.kernel.org/lkml/1676376403-16462-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh

> 
> -- Steve
