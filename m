Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47461A1AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiKDT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:59:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A5419BC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:58:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A4JGkrx008395;
        Fri, 4 Nov 2022 19:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aMqQQWzE6QrDvHBLONghM7biH9mUG+hEgNcbo3baRH0=;
 b=fBZl4RsWIKF4L4YX4L4X6hFf0a0B9ZHUbBW/0Pi01v+EekFvenhXiaIuDW1oFieixuwQ
 NR/pUhXz+Pcz6WmzMaibrTxK7GTJbvNitfiLnra3N9BPc5FFiMy4TnUy7v5vvLtvQVn1
 5m0v4fXq6bYOHwlylpAqOcjCC5nQORXIun1Qb/VuVp8hrLiNRQZZYYwQgifJBh8hrbc+
 EiISz3pwS7b1NT5dja0Smdwaq+y81sCAtaRum0KLaRUhHDx8ItwyhB+TcqIylA8FC3jw
 eqZ73DOVe1bqdpYmcgMzPs7nt6TdqUHMU+ccvzYpGaxJYNU4AcMcqZP1XPevttByiM8z 9g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kn6je0bsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:58:43 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Ju20X031478;
        Fri, 4 Nov 2022 19:58:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3km9ttuwu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:58:42 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4JwTrE001663;
        Fri, 4 Nov 2022 19:58:41 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 2A4JwfFx001751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:58:41 +0000
Received: from [10.216.46.236] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 12:58:39 -0700
Message-ID: <fda57ad1-bc92-a7ae-53a0-47c2a8467c47@quicinc.com>
Date:   Sat, 5 Nov 2022 01:28:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] gcov: clang: fix the buffer overflow issue
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     <oberpar@linux.ibm.com>, <nathan@kernel.org>, <trix@redhat.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <1667568213-26227-1-git-send-email-quic_mojha@quicinc.com>
 <CAKwvOdkdeLEvtOmX423oYaWCami0kAFatWe25DdJq7gbmGb+5g@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAKwvOdkdeLEvtOmX423oYaWCami0kAFatWe25DdJq7gbmGb+5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SnZxO1DIp_SrsK0HY1J06e8qR-sthahK
X-Proofpoint-GUID: SnZxO1DIp_SrsK0HY1J06e8qR-sthahK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks for looking into this.

On 11/4/2022 11:18 PM, Nick Desaulniers wrote:
> On Fri, Nov 4, 2022 at 6:23 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> Currently, in clang version of gcov code when module is getting removed
>> gcov_info_add() incorrectly adds the sfn_ptr->counter to all the
>> dst->functions and it result in the kernel panic in below crash report.
>> Fix this by properly handling it.
>>
>> [    8.899094][  T599] Unable to handle kernel write to read-only memory at virtual address ffffff80461cc000
>> [    8.899100][  T599] Mem abort info:
>> [    8.899102][  T599]   ESR = 0x9600004f
>> [    8.899103][  T599]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    8.899105][  T599]   SET = 0, FnV = 0
>> [    8.899107][  T599]   EA = 0, S1PTW = 0
>> [    8.899108][  T599]   FSC = 0x0f: level 3 permission fault
>> [    8.899110][  T599] Data abort info:
>> [    8.899111][  T599]   ISV = 0, ISS = 0x0000004f
>> [    8.899113][  T599]   CM = 0, WnR = 1
>> [    8.899114][  T599] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000ab8de000
>> [    8.899116][  T599] [ffffff80461cc000] pgd=18000009ffcde003, p4d=18000009ffcde003, pud=18000009ffcde003, pmd=18000009ffcad003, pte=00600000c61cc787
>> [    8.899124][  T599] Internal error: Oops: 9600004f [#1] PREEMPT SMP
>> [    8.899265][  T599] Skip md ftrace buffer dump for: 0x1609e0
>> ....
>> ..,
>> [    8.899544][  T599] CPU: 7 PID: 599 Comm: modprobe Tainted: G S         OE     5.15.41-android13-8-g38e9b1af6bce #1
>> [    8.899547][  T599] Hardware name: XXX (DT)
>> [    8.899549][  T599] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
>> [    8.899551][  T599] pc : gcov_info_add+0x9c/0xb8
>> [    8.899557][  T599] lr : gcov_event+0x28c/0x6b8
>> [    8.899559][  T599] sp : ffffffc00e733b00
>> [    8.899560][  T599] x29: ffffffc00e733b00 x28: ffffffc00e733d30 x27: ffffffe8dc297470
>> [    8.899563][  T599] x26: ffffffe8dc297000 x25: ffffffe8dc297000 x24: ffffffe8dc297000
>> [    8.899566][  T599] x23: ffffffe8dc0a6200 x22: ffffff880f68bf20 x21: 0000000000000000
>> [    8.899569][  T599] x20: ffffff880f68bf00 x19: ffffff8801babc00 x18: ffffffc00d7f9058
>> [    8.899572][  T599] x17: 0000000000088793 x16: ffffff80461cbe00 x15: 9100052952800785
>> [    8.899575][  T599] x14: 0000000000000200 x13: 0000000000000041 x12: 9100052952800785
>> [    8.899577][  T599] x11: ffffffe8dc297000 x10: ffffffe8dc297000 x9 : ffffff80461cbc80
>> [    8.899580][  T599] x8 : ffffff8801babe80 x7 : ffffffe8dc2ec000 x6 : ffffffe8dc2ed000
>> [    8.899583][  T599] x5 : 000000008020001f x4 : fffffffe2006eae0 x3 : 000000008020001f
>> [    8.899586][  T599] x2 : ffffff8027c49200 x1 : ffffff8801babc20 x0 : ffffff80461cb3a0
>> [    8.899589][  T599] Call trace:
>> [    8.899590][  T599]  gcov_info_add+0x9c/0xb8
>> [    8.899592][  T599]  gcov_module_notifier+0xbc/0x120
>> [    8.899595][  T599]  blocking_notifier_call_chain+0xa0/0x11c
>> [    8.899598][  T599]  do_init_module+0x2a8/0x33c
>> [    8.899600][  T599]  load_module+0x23cc/0x261c
>> [    8.899602][  T599]  __arm64_sys_finit_module+0x158/0x194
>> [    8.899604][  T599]  invoke_syscall+0x94/0x2bc
>> [    8.899607][  T599]  el0_svc_common+0x1d8/0x34c
>> [    8.899609][  T599]  do_el0_svc+0x40/0x54
>> [    8.899611][  T599]  el0_svc+0x94/0x2f0
>> [    8.899613][  T599]  el0t_64_sync_handler+0x88/0xec
>> [    8.899615][  T599]  el0t_64_sync+0x1b4/0x1b8
>> [    8.899618][  T599] Code: f905f56c f86e69ec f86e6a0f 8b0c01ec (f82e6a0c)
>> [    8.899620][  T599] ---[ end trace ed5218e9e5b6e2e6 ]---
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   kernel/gcov/clang.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
>> index cbb0bed..0aabb9a 100644
>> --- a/kernel/gcov/clang.c
>> +++ b/kernel/gcov/clang.c
>> @@ -271,15 +271,20 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
>>    */
>>   void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
>>   {
>> -       struct gcov_fn_info *dfn_ptr;
>> -       struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
>> -                       struct gcov_fn_info, head);
> 
> Hi Mukesh,
> Thanks for the report and patch!
> 
> Looking closer at the existing implementation, it looks curious to me
> that we use list_first_entry_or_null() since that may return NULL,
> which we never check for.  I'm curious if that's safe to remove?
> Probably, since we haven't had any issues reported thus far.
> 
>> +       struct gcov_fn_info *sfn_ptr;
>> +       struct gcov_fn_info *dfn_ptr = list_first_entry_or_null(
>> +                       &dst->functions, struct gcov_fn_info, head);
>>
>> -       list_for_each_entry(dfn_ptr, &dst->functions, head) {
>> +       list_for_each_entry(sfn_ptr, &src->functions, head) {
> 
> This seems to be iterating BOTH src and dest, whereas previously we
> were only iterating dest AFAICT.  Is this correct?  Seems to be a
> change of behavior, at the least, which seems orthogonal to fixing the
> panic.

Can you just check the implementation here once ?

https://elixir.bootlin.com/linux/v6.1-rc3/source/kernel/gcov/gcc_4_7.c#L241

By looking at the above link clang version does not seem to doing right ?

> 
> Otherwise it sounds like we could just add NULL ptr checks against
> sfn_ptr outside the loop, and against dfn_ptr inside the loop.
> Something like this?
> ```
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index cbb0bed958ab..5d4cb801aa9c 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -275,10 +275,13 @@ void gcov_info_add(struct gcov_info *dst, struct
> gcov_info *src)
>          struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
>                          struct gcov_fn_info, head);
> 
> -       list_for_each_entry(dfn_ptr, &dst->functions, head) {
> -               u32 i;
> +       if (!sfn_ptr)
> +               return;
> 
> -               for (i = 0; i < sfn_ptr->num_counters; i++)
> +       list_for_each_entry(dfn_ptr, &dst->functions, head) {
> +               if (!dfn_ptr)
> +                       continue;
> +               for (u32 i = 0, e = sfn_ptr->num_counters; i != e; ++i)
>                          dfn_ptr->counters[i] += sfn_ptr->counters[i];
>          }
>   }
> ```
> Can you test the above hunk or comment on whether it addresses the issue?


BTW, it just handles NUL pointer issue and not the one which is 
mentioned here.

"Unable to handle kernel write to read-only memory at virtual address 
ffffff80461cc000"

-Mukesh

> 
>>                  u32 i;
>>
>> +               if (!dfn_ptr)
>> +                       return;
>> +
>>                  for (i = 0; i < sfn_ptr->num_counters; i++)
>>                          dfn_ptr->counters[i] += sfn_ptr->counters[i];
>> +
>> +               dfn_ptr = list_next_entry(dfn_ptr, head);
>>          }
>>   }
>>
>> --
>> 2.7.4
>>
> 
> 
