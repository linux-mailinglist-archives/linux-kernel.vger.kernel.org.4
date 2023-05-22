Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2066470BA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEVKsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEVKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:48:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DBB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:48:00 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MAhNcG023376;
        Mon, 22 May 2023 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DXN57oV8UgXLJ9q/agZR3Q3Q32XZ6QAeanngY1pHnDk=;
 b=lGY5OLj2gaN456/AKfaQ4CdqzPsMw0it/22Yt9tKZwDsR4Ok99nUgkotFQ+PFYYl5koK
 qvcUMsoHFbxCHrNfODujVU7hnNhx59CBjhSgnfzyVz91z/6LS6E7be76QtI28qhllpE2
 UWA8oZOb9ji3ZyhgS/QHWSmPesbd5qMCVOuEr3+s7BLoyB3Sbs1Yg54haVeiSWpbL3BC
 y/IqFg3JSOBPH5iQAfQvKFV+/VyypUR32pCpmw2ta4ApvIazUxGus+Qmn9NbksxONzXL
 dhTH2JsVRDNos9TKmK//mA4Xoxf2xSOmR1ep7D9XnKpZCecVru3WUdGEyfQlp6veK1na cQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppe9bdmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:47:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MAletX016263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:47:40 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 03:47:36 -0700
Message-ID: <b88e83c2-9712-d07d-b48a-5981169cff0f@quicinc.com>
Date:   Mon, 22 May 2023 16:17:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230522115605.1238227-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MqUK_9MMijGV1N9NnO9S-91ii1T2p49M
X-Proofpoint-ORIG-GUID: MqUK_9MMijGV1N9NnO9S-91ii1T2p49M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220091
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 5:26 PM, Miaohe Lin wrote:
> cpumask_weight_and() can be used to count of bits both in rd->span and
> cpu_active_mask. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/sched/deadline.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 166c3e6eae61..fe983ed7bb12 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -110,20 +110,11 @@ static inline struct dl_bw *dl_bw_of(int i)
>   static inline int dl_bw_cpus(int i)
>   {
>   	struct root_domain *rd = cpu_rq(i)->rd;
> -	int cpus;
>   
>   	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
>   			 "sched RCU must be held");
>   
> -	if (cpumask_subset(rd->span, cpu_active_mask))
> -		return cpumask_weight(rd->span);
> -
> -	cpus = 0;
> -
> -	for_each_cpu_and(i, rd->span, cpu_active_mask)
> -		cpus++;
> -
> -	return cpus;
> +	return cpumask_weight_and(rd->span, cpu_active_mask);
>   }


Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

>   
>   static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
