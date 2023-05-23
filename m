Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E6E70D447
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjEWGsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjEWGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:48:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C84118
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:48:01 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N5GKUZ018328;
        Tue, 23 May 2023 06:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UkRwBX3upaQasInjTTtl7uZI18qP9LlN//DSxUObA8k=;
 b=V+cp9ccqRP4kE3cRwhWuuwTXlpMJ5kOstC5Ab1obEXRRf0HIRVgCtixMl0UMZ47ZD71F
 gnAHn30Q0xr/2lqzoLDP+Bhl7gEhXS/tY+djoCwR+cUwzDE5da0Q4cZiAiRC7bTPhyiv
 zWexqKYPKgqWijXOV/Oo1BbSczMx1cbh5u8aL+oOqd39ic0d8UGbVaCYxAKnHZfTQGUD
 4GMDj6QJuAyzkjnywQb16C9pv6OZd8sWKBUcqS/PBoZONBZni7yfwTQoSueoQP0b6VRa
 SBtMqmAfUjzrUcMKpbK5GBu6REE0t61Z1hRV10cSosozCSy6iA8q5vjRLxi5bO9F9F0A fw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrq56g5b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 06:47:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N6lfaZ003472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 06:47:41 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 23:47:38 -0700
Message-ID: <1d0de89c-db09-0689-2528-5b6d90ad7192@quicinc.com>
Date:   Tue, 23 May 2023 12:17:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] sched: hide unused sched_update_scaling()
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20230522195021.3456768-1-arnd@kernel.org>
 <20230522195021.3456768-2-arnd@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230522195021.3456768-2-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iTPmKFj4T7oQkERhZVYTPYKnlt0MLc6m
X-Proofpoint-ORIG-GUID: iTPmKFj4T7oQkERhZVYTPYKnlt0MLc6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_03,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230055
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 1:20 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function is only used when CONFIG_SMP is enabled, without that there
> is no caller and no prototype:
> 
> kernel/sched/fair.c:688:5: error: no previous prototype for 'sched_update_scaling' [-Werror=missing-prototypes
> 
> Hide the definition in the same #ifdef check as the declaration.
> 
> Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM, thanks.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-- Mukesh

> ---
>   kernel/sched/fair.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0ca13ac..2c1b345c3b8d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -684,7 +684,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
>   /**************************************************************
>    * Scheduling class statistics methods:
>    */
> -
> +#ifdef CONFIG_SMP
>   int sched_update_scaling(void)
>   {
>   	unsigned int factor = get_update_sysctl_factor();
> @@ -702,6 +702,7 @@ int sched_update_scaling(void)
>   	return 0;
>   }
>   #endif
> +#endif
>   
>   /*
>    * delta /= w
