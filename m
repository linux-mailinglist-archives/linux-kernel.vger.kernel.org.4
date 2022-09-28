Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559105ED658
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiI1HiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiI1Hhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:37:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9E10E5F8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:36:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5tmnD010606;
        Wed, 28 Sep 2022 07:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PbqUuym9VLgWesm4aNmQ2+8panIpJAtDPBpsvUo2Irw=;
 b=eHJsmhkbOwvo54PKa9bxEL4N1JLeDtp01oNR745gru8kyPVlpkC7GYoCwojzPDCBeqfm
 qGfFOXVW3/ERBgURXGjN7T8HHCCm8W7mA81VGAsaAMy41R60FoZu6VTcnY5QuPbjqFfp
 ShQR2vN2tb2xW/R9M2ilAJDWPWCQPo3VfG7sYzKOF2FFFLuw5VIwUDQsWMRmyabP0/5l
 dnHyP4JKrgHwTPKyDFsdwNkWPA2uVRi4FgOKN0SmzAbrdnCpajmZ71dcLvOegJ38c4SS
 XOZpjsHY3rjOe6X3BoUbjhZouZZL1ZDuko4Sq3fXY6y52sIM0oSsMrqZy7TnaBA0ugYC Kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juvnnk5pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:36:03 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28S7a2ef022746;
        Wed, 28 Sep 2022 07:36:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jstykp1bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:36:02 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28S7a2lu022741;
        Wed, 28 Sep 2022 07:36:02 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 28S7a2RB022740
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 07:36:02 +0000
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 00:36:00 -0700
Message-ID: <9f0e7048-561d-92d9-0888-4d3fe581674d@quicinc.com>
Date:   Wed, 28 Sep 2022 15:35:57 +0800
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
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zyD2Gfoh_qFTeuYJP2FFrVywK5cq5cdK
X-Proofpoint-GUID: zyD2Gfoh_qFTeuYJP2FFrVywK5cq5cdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=867 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280045
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
> 
> Note, this code has __string() which does a strlen() which appears to be
> working fine.
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
> 
> -- Steve

hi，Steve:
	I simulate a what I supposed problem,  but it did not panic.
	I will use kasan to debug further. thanks for your review and suggest 
on this problem. abandon this patch now currently, if there is new 
proved problem, I will come again.


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 637d25c31374..d219d9f45529 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1389,6 +1389,7 @@ struct task_struct {
         ANDROID_KABI_RESERVE(7);
         ANDROID_KABI_RESERVE(8);

+       char comm1[32];
         /*
          * New fields for task_struct should be added above here, so that
          * they are included in the randomized portion of task_struct.
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index dd7d7c9efecd..da2426c7f99b 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -139,7 +139,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
                 __entry->dst_level = dst_cgrp->level;
                 __assign_str(dst_path, path);
                 __entry->pid = task->pid;
-               __assign_str(comm, task->comm);
+               __assign_str(comm, task->comm1);
         ),

         TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s 
pid=%d comm=%s",
diff --git a/kernel/fork.c b/kernel/fork.c
index 58409b7178c2..4e0c564852c6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1443,6 +1443,7 @@ static int copy_mm(unsigned long clone_flags, 
struct task_struct *tsk)
         tsk->last_switch_count = tsk->nvcsw + tsk->nivcsw;
         tsk->last_switch_time = 0;
  #endif
+        strlcpy(tsk->comm1, "012345678901234567890123456789", 30);

         tsk->mm = NULL;
         tsk->active_mm = NULL;




# cat /sys/kernel/tracing/trace_pipe
               sh-874     [007] d..2   142.097349: 
cgroup_notify_populated: root=1 id=49 level=1 path=/top-app val=1
               sh-874     [007] d..1   142.097405: cgroup_attach_task: 
dst_root=1 dst_id=49 dst_level=1 dst_path=/top-app pid=1 
comm=01234567890123456789012345678
