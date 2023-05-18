Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C837F708315
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjERNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjERNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:44:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0D19B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:44:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I8rk9i014292;
        Thu, 18 May 2023 13:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VhYcNWrgaXQdwDNyvgAZGGJyylEbwDyMuEB1xBXjJ/U=;
 b=gB5SuodaV+52on6WdehsDKdErG8WlnATBC0lQQGtZ18AbWC0hUhpoZqTyjba/1V+9i4s
 KCKG2FoB1oNkNUmFW8X5RqoktXWSEKAwlRtEK1ButA6gDQbjXg7PHlLFeFye1thMfzZg
 cka9mhO5qNKKlK3YaPFflEN/vwwbcb1zHXbT32fo8Qx8RIfK3syqsHjyKlg5KtZPvCyv
 5uf7ZuiwMVbCz19CuDEYlnPxinnNpiRx4W78uvFO+eYPlnfloNVZdw9c0X8kQQN4oF/s
 4M47m0qX0t/vb+QS7T9AzPe0RGutvAfNsC9vH+AzfbNibTvLNk03Efc+MdQuLcvAyQ55 dA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmxyp2us0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 13:44:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IDi8Tn009310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 13:44:08 GMT
Received: from [10.216.40.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 06:44:04 -0700
Message-ID: <69f2db7c-bc3d-b08c-c85d-66bb32c3766a@quicinc.com>
Date:   Thu, 18 May 2023 19:14:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched: core: Simplify cpuset_cpumask_can_shrink()
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230518203416.3323-1-zeming@nfschina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230518203416.3323-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lSAeEcDaj_Sg92QajV4T5IdzihdIX2p8
X-Proofpoint-GUID: lSAeEcDaj_Sg92QajV4T5IdzihdIX2p8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180109
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2023 2:04 AM, Li zeming wrote:
> Remove useless intermediate variable "ret" and its initialization.
> Directly return dl_cpuset_cpumask_can_shrink() result.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Acked-by : Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   kernel/sched/core.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a66960da3f5c..f3f2ece26291 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9273,14 +9273,10 @@ void __init init_idle(struct task_struct *idle, int cpu)
>   int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>   			      const struct cpumask *trial)
>   {
> -	int ret = 1;
> -
>   	if (cpumask_empty(cur))
> -		return ret;
> -
> -	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
> +		return 1;
>   
> -	return ret;
> +	return dl_cpuset_cpumask_can_shrink(cur, trial);
>   }
>   
>   int task_can_attach(struct task_struct *p,
