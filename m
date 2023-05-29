Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610927144E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjE2GcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjE2GcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:32:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D9180
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:31:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T5KVAt030065;
        Mon, 29 May 2023 06:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2WYVwDFOvX9QgIUW9lmzH94tMnnGYGKTR6xeVuTcQ34=;
 b=DaUFpLkCnmaVKQvaeIGYS69djXTfmnmqStXzehDr2xENttFBDbXyoizeGP+eMGfN5+Rs
 eRFh87nRC7ViXYLYMaMRMWeIXz1Vjonu2bc8shm8SKcJHneG4blPV9hrZAMdn6XGG3qY
 o0aUI7Z2SsIPgVaT1KmzGZNsc5pNCQLbA7O2eaPH5eXWoSY2mIcfZPJSS9v1D08feUOY
 Q2zP+Yx7op6BCpL9/zWQ+OYO9zYmGhCg494bPV0QBitQKNvBal9GCO+xVhqeioj4PGwB
 o1Ez2wf7Gkl+iXk1UKi9BOuAxvJXhqztYcXMBwPIjdgK8gsBG82dO0TdnxHCObgL3N6H fA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qub5djr8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 06:30:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34T6UEn0022762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 06:30:14 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 28 May
 2023 23:30:11 -0700
Message-ID: <a6db7f89-bc62-9627-0bd1-1c66b72fc7dd@quicinc.com>
Date:   Mon, 29 May 2023 11:59:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched: deadline: Simplify
 pick_earliest_pushable_dl_task()
To:     Li kunyu <kunyu@nfschina.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230530181145.2880-1-kunyu@nfschina.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230530181145.2880-1-kunyu@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fiqr8Pu1vtdBdBGEUgWvlNENrxUEOsNV
X-Proofpoint-GUID: Fiqr8Pu1vtdBdBGEUgWvlNENrxUEOsNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_04,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=978 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290054
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 11:41 PM, Li kunyu wrote:
> Using the while statement instead of the if and goto statements is more
> concise and efficient.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

LGTM, Thanks.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/sched/deadline.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d823e608c7f0..b94a498f8cd9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2112,15 +2112,13 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   
>   	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
>   
> -next_node:
> -	if (next_node) {
> +	while (next_node) {
>   		p = __node_2_pdl(next_node);
>   
>   		if (pick_dl_task(rq, p, cpu))
>   			return p;
>   
>   		next_node = rb_next(next_node);
> -		goto next_node;
>   	}
>   
>   	return NULL;
