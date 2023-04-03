Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935166D4662
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjDCOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDCOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:02:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D977A8B;
        Mon,  3 Apr 2023 07:02:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333D0C9P024068;
        Mon, 3 Apr 2023 14:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JzG0/QcGKrxZjXJBUCmTMNvFnZhN0QYSpEfr1cyY06c=;
 b=dOWFQgCDJfDxJixp1y6RqX0o7jSo0GjXXvwHa7pHMSUQWALT5o2NTvtyg7hhujXwLV/F
 MlEWCj2G+8ru8OBfMENVescgZn06aPPQEf5OcCx+JjndRUuC+NDy1lyBER79H/NYtRjV
 gTckoI+yALSqaO0I8niwL8/l8sctjGZvyn2Q1132XhLHyvqvKE1xPxxbphaaDogHebgm
 16NMnnGHUp+Cxv05Lg2l1mGyTfkES7QURAN604jElum3RQmpbHCZfIHmIflanFCYhbC1
 tXfDU0GhdXMEtMk2nuRfuyTg6+O/HaEBEjSeHxGHCzgi+/6fIn9aaDqkpYc2E+gVZkPW oQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqy6204gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 14:02:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333E263l008799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 14:02:06 GMT
Received: from [10.216.35.203] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 07:02:00 -0700
Message-ID: <eaf6dd0c-3402-56bd-8b58-9275b5025032@quicinc.com>
Date:   Mon, 3 Apr 2023 19:31:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] rcu: Make sure new krcp free business is handled after
 the wanted rcu grace period.
Content-Language: en-US
To:     Ziwei Dai <ziwei.dai@unisoc.com>, <urezki@gmail.com>,
        <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <shuang.wang@unisoc.com>,
        <yifan.xin@unisoc.com>, <ke.wang@unisoc.com>,
        <xuewen.yan@unisoc.com>, <zhiguo.niu@unisoc.com>,
        <zhaoyang.huang@unisoc.com>
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3m8UW2SovsmKGTXlBuZr1zrc6pydPQb0
X-Proofpoint-ORIG-GUID: 3m8UW2SovsmKGTXlBuZr1zrc6pydPQb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_11,2023-04-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=610 phishscore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030103
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 6:12 PM, Ziwei Dai wrote:
> In kfree_rcu_monitor(), new free business at krcp is attached to any free
> channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
> business is handled after the rcu grace period. But if there is any none-free
> channel at krwp already, that means there is an on-going rcu work,
> which will cause the kvfree_call_rcu()-triggered free business is done
> before the wanted rcu grace period ends.
> 
> This commit ignore krwp which has non-free channel at kfree_rcu_monitor(),
> to fix the issue that kvfree_call_rcu() loses effectiveness.
> 
> Below is the css_set obj "from_cset" use-after-free case caused by
> kvfree_call_rcu() losing effectiveness.
> CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes,
> the task is schedule out.
> CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
> But "from_cset" is freed right after current gp end. "from_cset" is reallocated.
> CPU 0 's task arrives back, references "from_cset"'s member, which causes crash.
> 
> CPU 0					CPU 1
> count_memcg_event_mm()
> |rcu_read_lock()  <---
> |mem_cgroup_from_task()
>   |// css_set_ptr is the "from_cset" mentioned on CPU 1
>   |css_set_ptr = rcu_dereference((task)->cgroups)
>   |// Hard irq comes, current task is scheduled out.
> 
> 					cgroup_attach_task()
> 					|cgroup_migrate()
> 					|cgroup_migrate_execute()
> 					|css_set_move_task(task, from_cset, to_cset, true)
> 					|cgroup_move_task(task, to_cset)
> 					|rcu_assign_pointer(.., to_cset)
> 					|...
> 					|cgroup_migrate_finish()
> 					|put_css_set_locked(from_cset)
> 					|from_cset->refcount return 0
> 					|kfree_rcu(cset, rcu_head) // means to free from_cset after new gp
> 					|add_ptr_to_bulk_krc_lock()
> 					|schedule_delayed_work(&krcp->monitor_work, ..)
> 
> 					kfree_rcu_monitor()
> 					|krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
> 					|queue_rcu_work(system_wq, &krwp->rcu_work)
> 					|if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
> 					|call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request a new gp
> 
> 					// There is a perious call_rcu(.., rcu_work_rcufn)
> 					// gp end, rcu_work_rcufn() is called.
> 					rcu_work_rcufn()
> 					|__queue_work(.., rwork->wq, &rwork->work);
> 
> 					|kfree_rcu_work()
> 					|krwp->bulk_head_free[0] bulk is freed before new gp end!!!
> 					|The "from_cset" is freed before new gp end.
> 
> // the task is scheduled in after many ms.
>   |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.
> 

I too have observed this issue on 5.15, where i see below callstack.
And i see different view of memory and one is this callstack and the
other is,  i see proper value of memcg from the ramdump.

Looks to be different view of memory between rcu critical section.

119653.424434][T730913] binder: 30858:30913 ioctl c0306201 7633b56a78 
returned -14
[119653.426095][T730918] Unable to handle kernel paging request at 
virtual address 000000034088e7be

-000|mem_cgroup_disabled(inline)
-000|__count_memcg_events([X0] memcg = 0x000000034088D9AE, [X1] idx = 
PGFAULT = 0x11, [X2] count = 0x1)
     |  [X0] memcg = 0x000000034088D9AE
     |  [X1] idx = PGFAULT = 0x11
     |  [X2] count = 0x1
     |  [locdesc] __ptr = 0x0
-001|arch_local_irq_restore(inline)
     |  [X26] flags = 0x0
-001|count_memcg_events(inline)
     |  [X26] flags = 0x0
-001|count_memcg_event_mm(inline)
     |  [locdesc] idx = PGFAULT = 0x11
-001|do_handle_mm_fault([X24] vma = 0xFFFFFF89CC704870, [X20] address = 
0x000000763395AA78, [X22] flags =
     |  [X24] vma = 0xFFFFFF89CC704870
     |  [X20] address = 0x000000763395AA78
     |  [X22] flags = 0x0215
     |  [X23] seq = 0x0
     |  [X19] regs = 0xFFFFFFC05EA73AD0
     |  [locdesc] ret = 0x0
-002|handle_mm_fault(inline)
     |  [X22] address = 0x000000763395AA78
     |  [X24] flags = 0x0215
     |  [X21] regs = 0xFFFFFFC05EA73AD0
-002|__do_page_fault(inline)
     |  [X23] mm = 0xFFFFFF8812F65400
     |  [X22] addr = 0x000000763395AA78
     |  [X24] mm_flags = 0x0215
     |  [X27] vm_flags = 0x2
     |  [X21] regs = 0xFFFFFFC05EA73AD0
[119653.427011][T730918]  __count_memcg_events+0x2c/0x274
[119653.427014][T730918]  do_handle_mm_fault+0xe4/0x2c8
[119653.427017][T730918]  do_page_fault+0x4c0/0x688
[119653.427022][T730918]  do_translation_fault+0x48/0x64
[119653.427025][T730918]  do_mem_abort+0x68/0x148
[119653.427028][T730918]  el1_abort+0x40/0x64
[119653.427032][T730918]  el1h_64_sync_handler+0x60/0xa0
[119653.427035][T730918]  el1h_64_sync+0x7c/0x80
[119653.427037][T730918]  __arch_copy_to_user+0x60/0x224
[119653.427040][T730918]  binder_ioctl_write_read+0x28c/0x590
[119653.427046][T730918]  binder_ioctl+0x1b0/0xf00
[119653.427049][T730918]  __arm64_sys_ioctl+0x184/0x210
[119653.427052][T730918]  invoke_syscall+0x60/0x150
[119653.427055][T730918]  el0_svc_common+0x8c/0xf8
[119653.427057][T730918]  do_el0_svc+0x28/0xa0
[119653.427059][T730918]  el0_svc+0x24/0x84
[119653.427061][T730918]  el0t_64_sync_handler+0x88/0xec
[119653.427064][T730918]  el0t_64_sync+0x1b4/0x1b8
[119653.427067][T730918] Code: a9044ff4 d503201f 71016c3f 54000d42 
(f9470808)
[119653.427069][T730918] ---[ end trace a3882cb531ca3dd0 ]---


Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>

I will try to test this patch.

Thanks,
--Mukesh

> v2: Use helper function instead of inserted code block at kfree_rcu_monitor().
> 
> Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of kfree_rcu() work")
> Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> ---
>   kernel/rcu/tree.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e880c0..7b95ee9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3024,6 +3024,18 @@ static void kfree_rcu_work(struct work_struct *work)
>   	return !!READ_ONCE(krcp->head);
>   }
>   
> +static bool
> +need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
> +{
> +	int i;
> +
> +	for (i = 0; i < FREE_N_CHANNELS; i++)
> +		if (!list_empty(&krwp->bulk_head_free[i]))
> +			return true;
> +
> +	return !!krwp->head_free;
> +}
> +
>   static int krc_count(struct kfree_rcu_cpu *krcp)
>   {
>   	int sum = atomic_read(&krcp->head_count);
> @@ -3107,15 +3119,14 @@ static void kfree_rcu_monitor(struct work_struct *work)
>   	for (i = 0; i < KFREE_N_BATCHES; i++) {
>   		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
>   
> -		// Try to detach bulk_head or head and attach it over any
> -		// available corresponding free channel. It can be that
> -		// a previous RCU batch is in progress, it means that
> -		// immediately to queue another one is not possible so
> -		// in that case the monitor work is rearmed.
> -		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
> -			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
> -				(READ_ONCE(krcp->head) && !krwp->head_free)) {
> +		// Try to detach bulk_head or head and attach it, only when
> +		// all channels are free.  Any channel is not free means at krwp
> +		// there is on-going rcu work to handle krwp's free business.
> +		if (need_wait_for_krwp_work(krwp))
> +			continue;
>   
> +		// kvfree_rcu_drain_ready() might handle this krcp, if so give up.
> +		if (need_offload_krc(krcp)) {
>   			// Channel 1 corresponds to the SLAB-pointer bulk path.
>   			// Channel 2 corresponds to vmalloc-pointer bulk path.
>   			for (j = 0; j < FREE_N_CHANNELS; j++) {
