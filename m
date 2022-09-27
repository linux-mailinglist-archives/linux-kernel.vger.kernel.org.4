Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DA5EB6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiI0Bct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiI0Bcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:32:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4CEEE8D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:32:43 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R1V3ib031473;
        Tue, 27 Sep 2022 01:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/6zVVKupWX3BaFRhItTk3vWfPNA0w3Lu68D8j/WFCD4=;
 b=M31k33mUHsTDDsA0PpdDEZYzuoV8G0DZKSi/21AntEBto0RywwZPiQ/0IS2U3+gu+sFS
 NS+jJgjhaJAV0c/Oo4iPoSPxPpOzy31tJ82g1+7BcMp/ptEVa7eIfvTD5rFELA894ArA
 /+PjYIpn7ZaygOctr7MG+VTeleWXMMDV2UMgxpQmAwhL+qQSbQC1Cn2VJnJckrlSmNaN
 6k1PnZLjvNH9TmfhPRwjADNtLOSATAOY8rj/HIN+wGC9BdR6HZ2Bu4heAIT25uB2cvC/
 BM4OwcnHwxXY7tUvZTCKvQ8ivE7dP5hmPpeL6LlHtclBlgimP5XBMSALOxSbTDWIS8/B FQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jst9e4xpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 01:32:38 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28R1Wbs9008632;
        Tue, 27 Sep 2022 01:32:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3jstykrf31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 01:32:37 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R1WaTM008624;
        Tue, 27 Sep 2022 01:32:36 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 28R1WaXh008623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 01:32:36 +0000
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 18:32:35 -0700
Message-ID: <4da22546-219b-ec86-873d-f5b2ed4b5855@quicinc.com>
Date:   Tue, 27 Sep 2022 09:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2] cgroup: align the comm length with TASK_COMM_LEN
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <tj@kernel.org>,
        <william.kucharski@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20220923075105.28251-1-quic_yingangl@quicinc.com>
 <20220926100933.4532f987@gandalf.local.home>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <20220926100933.4532f987@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YQqHVVhj-1Urc6TtLvCHtgpYkv0AtIEO
X-Proofpoint-GUID: YQqHVVhj-1Urc6TtLvCHtgpYkv0AtIEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=568 adultscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209270007
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2022 10:09 PM, Steven Rostedt wrote:
> On Fri, 23 Sep 2022 15:51:05 +0800
> Kassey Li <quic_yingangl@quicinc.com> wrote:
> 
>> __string could get a dst string with length less than
>> TASK_COMM_LEN.
>>
>> A task->comm may change that can cause out of bounds access
>> for the dst string buffer, e.g in the call trace of below:
>>
>> Call trace:
>>
>>      dump_backtrace.cfi_jt+0x0/0x4
>>      show_stack+0x14/0x1c
>>      dump_stack+0xa0/0xd8
>>      die_callback+0x248/0x24c
>>      notify_die+0x7c/0xf8
>>      die+0xac/0x290
>>      die_kernel_fault+0x88/0x98
>>      die_kernel_fault+0x0/0x98
>>      do_page_fault+0xa0/0x544
>>      do_mem_abort+0x60/0x10c
>>      el1_da+0x1c/0xc4
> 
>>      trace_event_raw_event_cgroup_migrate+0x124/0x170
> 
> You're sure the above is on the strcpy()?
set PC to 0xffffffda401c47d4
and this reflect to the strcpy asm code of aarch64. (lib/string.c)

                          120|
   NSX:0000::FFFFFFDA401C47B8|B946C268 
                       ldr     w8,[x19,#0x6C0]   ; w8,[task,#1728]
   NSX:0000::FFFFFFDA401C47BC|79403809 
                       ldrh    w9,[x0,#0x1C]    ; w9,[entry,#28]
   NSX:0000::FFFFFFDA401C47C0|F10002FF 
                       cmp     x23,#0x0         ; x23,#0
   NSX:0000::FFFFFFDA401C47C4|B9001408 
                       str     w8,[x0,#0x14]    ; w8,[entry,#20]
   NSX:0000::FFFFFFDA401C47C8|8B090008 
                       add     x8,x0,x9         ; x8,entry,x9
   NSX:0000::FFFFFFDA401C47CC|9A970349 
                       csel    x9,x26,x23,eq
                             |
                             |
                           93|
   NSX:0000::FFFFFFDA401C47D0|3840152A 
                       ldrb    w10,[x9],#0x1    ; w10,[src],#1
 
NSX:0000::FFFFFFDA401C47D4|3800150A_________________________________________________________strb____w10,[x8],#0x1____;_w10,[dest],#1
__NSX:0000::FFFFFFDA401C47D8|35FFFFCA_________________________________________________________cbnz____w10,0xFFFFFFDA401C47D0
                             |
                             |
                             |
                             |
                             |
                             |
                          120|
   NSX:0000::FFFFFFDA401C47DC|910023E0 
                       add     x0,sp,#0x8       ; entry,sp,#8
   NSX:0000::FFFFFFDA401C47E0|AA1503E1 
                       mov     x1,x21
   NSX:0000::FFFFFFDA401C47E4|9400E4ED 
                       bl      0xFFFFFFDA401FDB98   ; 
trace_event_buffer_commit
   NSX:0000::FFFFFFDA401C47E8|F00134C9 
                       adrp    x9,0xFFFFFFDA4285F000
   NSX:0000::FFFFFFDA401C47EC|F85F83A8 
                       ldur    x8,[x29,#-0x8]   ; x8,[x29,#-8]
   NSX:0000::FFFFFFDA401C47F0|F9420929 
                       ldr     x9,[x9,#0x410]   ; x9,[x9,#1040]
   NSX:0000::FFFFFFDA401C47F4|EB08013F 
                       cmp     x9,x8
   NSX:0000::FFFFFFDA401C47F8|54000121 
                       b.ne    0xFFFFFFDA401C481C
   NSX:0000::FFFFFFDA401C47FC|A9494FF4 
                       ldp     x20,x19,[sp,#0x90]   ; 
xdst_cgrp,xtask,[sp,#144]
   NSX:0000::FFFFFFDA401C4800|A94857F6 
                       ldp     x22,x21,[sp,#0x80]   ; x__data,x21,[sp,#128]
   NSX:0000::FFFFFFDA401C4804|A9475FF8 
                       ldp     x24,x23,[sp,#0x70]   ; x24,x23,[sp,#112]
   NSX:0000::FFFFFFDA401C4808|A94667FA 
                       ldp     x26,x25,[sp,#0x60]   ; x26,x25,[sp,#96]
   NSX:0000::FFFFFFDA401C480C|A9456FFC 
                       ldp     x28,x27,[sp,#0x50]   ; x28,x27,[sp,#80]
   NSX:0000::FFFFFFDA401C4810|A9447BFD 
                       ldp     x29,x30,[sp,#0x40]   ; x29,x30,[sp,#64]
   NSX:0000::FFFFFFDA401C4814|910283FF 
                       add     sp,sp,#0xA0      ; sp,sp,#160
   NSX:0000::FFFFFFDA401C4818|D65F03C0 
                       ret
   NSX:0000::FFFFFFDA401C481C|97FC50DC 
                       bl      0xFFFFFFDA400D8B8C   ; __stack_chk_fail

> 
> Note, this code has __string() which does a strlen() which appears to be
> working fine.

  I did see this as well.

  500 #define __string(item, src) __dynamic_array(char, item,         \
  501             strlen((src) ? (const char *)(src) : "(null)") + 1)



My tester reported they could change the task->comm.
for example from "123456789abcde" to "test"
I wonder if we prepare the buffer as "test" 5bytes with __string
then  __assign_str  with "123456789abcde" new task->comm.

but this is very hard race condition.

this is not easy to reproduced, we got 2 instances of this problem.

I read others using the task->comm as trace event with memcpy as this 
patch I initialized.



> 
>>      cgroup_attach_task+0x2e8/0x41c
>>      __cgroup1_procs_write+0x114/0x1ec
>>      cgroup1_tasks_write+0x10/0x18
>>      cgroup_file_write+0xa4/0x208
>>      kernfs_fop_write+0x1f0/0x2f4
>>      __vfs_write+0x5c/0x200
>>      vfs_write+0xe0/0x1a0
>>      ksys_write+0x74/0xdc
>>      __arm64_sys_write+0x18/0x20
>>      el0_svc_common+0xc0/0x1a4
>>      el0_svc_compat_handler+0x18/0x20
>>      el0_svc_compat+0x8/0x2c
> 
> Can you give the full debug report, that includes the register content and
> everything else.

here is the crash stack of cpu regs.
you can ref the asm code above.


pc : [0xffffffda401c47d4] trace_event_raw_event_cgroup_migrate+0x124/0x170
lr : [0xffffffda401c4774] trace_event_raw_event_cgroup_migrate+0xc4/0x170
sp : ffffffc01f8e9aa0
x29: ffffffc01f8e9ae0 x28: 000000000000000b
x27: 0000000000000009 x26: ffffffda41f1e515
x25: 0000000000000008 x24: ffffffda42c72a7d
x23: ffffffbd1b6c59d0 x22: ffffffbbf383bec8
x21: 0000000000000034 x20: ffffffbd621cd000
x19: ffffffbd1b6c5140 x18: 0000000000000008
x17: ffffffbd66b96010 x16: ffffffbd621cd000
x15: ffffffbc11583860 x14: ffffffbd1b6c5ba8
x13: 0000000000000000 x12: 0000000000200000
x11: 0000000000000001 x10: 0000000000000000
x9 : ffffffbd1b6c59e0 x8 : ffffffbcf7450000
x7 : 6a716e76225c435a x6 : 0000800000008080
x5 : 0000000000000001 x4 : 0000000000000080
x3 : 0000000000000034 x2 : 0000000000000098
x1 : 0000000000000034 x0 : ffffffbcf744ffc8



> 
> -- Steve
