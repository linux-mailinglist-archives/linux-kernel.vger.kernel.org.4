Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901946393FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiKZFUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiKZFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:20:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F721F60B;
        Fri, 25 Nov 2022 21:20:28 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ5GVlT005875;
        Sat, 26 Nov 2022 05:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i5V6pAuncwvgyudnVxg16U0ks0E+4Nu+5DZ35eeYYDE=;
 b=e6Zj0Vir+0oj2T1qIjc1HLMivLMVM86ln6E2Dx3cqvJXpQbvXJdxgGUhjAoyohhFgB0s
 fwlqC+ROt6GJReod937WL66pya47z/fswk1v8r1YR6sXdSUYI6qZt+O5a/8LwrRDCLru
 alr4Es4wfug1xl+7F2zYdepRdqDLZcW4VWOWc1yXJZJAg47jYJiCO1Q5v2Eb/TcRtK4N
 sYhV2Pa5a6+petx1eu47JBWfCuyir/YRYFUyOGqnbdZriciJWpaTNmL9Tfbmn6E4jI7I
 6U3UARKkyIe0ZOd2G/fv/XeALie0TG8m7RDQeLXivId7svjgutALTq5ZWT/31pqX1Vge Lw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3a4t86vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Nov 2022 05:20:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AQ5KFdV023119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Nov 2022 05:20:15 GMT
Received: from [10.50.56.30] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 25 Nov
 2022 21:20:12 -0800
Message-ID: <cf3fad42-0ab5-dae7-7954-8d7af80d20ac@quicinc.com>
Date:   Sat, 26 Nov 2022 10:49:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
To:     Zqiang <qiang1.zhang@intel.com>, <paulmck@kernel.org>,
        <frederic@kernel.org>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
Content-Language: en-US
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20221125155427.1381933-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bCWqU_oNO9aPN7TZNdZRNb2Hq09O9jRR
X-Proofpoint-ORIG-GUID: bCWqU_oNO9aPN7TZNdZRNb2Hq09O9jRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_04,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

On 11/25/2022 9:24 PM, Zqiang wrote:
> Currently, for the case of num_online_cpus() <= 1, return directly,
> indicates the end of current grace period and then release old data.
> it's not accurate, for SMP system, when num_online_cpus() is equal
> one, maybe another cpu that in offline process(after invoke
> __cpu_disable()) is still in the rude RCU-Tasks critical section
> holding the old data, this lead to memory corruption.
> 

Was this race seen in your testing? For the outgoing CPU, once that
CPU marks itself offline (and decrements __num_online_cpus), do we
have tracing active on that CPU, and synchronize_rcu_tasks_rude()
not waiting for it could potentially lead to memory corruption?

As per my understanding, given that outgoing/incoming CPU 
decrements/increments the __num_online_cpus value, and num_online_cpus()
is a plain read, problem could happen when the incoming CPU updates the
__num_online_cpus  value, however, rcu_tasks_rude_wait_gp()'s 
num_online_cpus() call didn't observe the increment. So, 
cpus_read_lock/unlock() seems to be required to handle this case.



Thanks
Neeraj

> Therefore, this commit add cpus_read_lock/unlock() before executing
> num_online_cpus().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>   kernel/rcu/tasks.h | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4a991311be9b..08e72c6462d8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
>   {
>   }
>   
> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> +
>   // Wait for one rude RCU-tasks grace period.
>   static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>   {
> +	int cpu;
> +	struct work_struct *work;
> +
> +	cpus_read_lock();
>   	if (num_online_cpus() <= 1)
> -		return;	// Fastpath for only one CPU.
> +		goto end;// Fastpath for only one CPU.
>   
>   	rtp->n_ipis += cpumask_weight(cpu_online_mask) > -	schedule_on_each_cpu(rcu_tasks_be_rude);
> +	for_each_online_cpu(cpu) {
> +		work = per_cpu_ptr(&rude_work, cpu);
> +		INIT_WORK(work, rcu_tasks_be_rude);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(&rude_work, cpu));
> +
> +end:
> +	cpus_read_unlock();
>   }
>   
>   void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
