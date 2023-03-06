Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9B6ABFF4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCFMzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCFMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:55:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151627997;
        Mon,  6 Mar 2023 04:54:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3266Onw0005660;
        Mon, 6 Mar 2023 12:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ID1Aw0POcPiJYnmPMoPY5hNF8NWcGrTSf2bKzTdrMWw=;
 b=mxYHx62T9CpMVoHQaBGI648c78ETGA5T9Qw/DG5lo+4OqETi7NhFzEpLaT4XckrhiSgM
 nLv3kL2ZGVVfa9vMdkk44hd3Jmr3ilwuUv12Mrh1y/KbgMfs7U/ZYvUYVRAY6tgfwKBK
 rWZcTbkVBuDBGSmNBF7VWmn2Vk2FGGOKduAAi8D7nWVMnO4W47tvuoWFLLb/prQRX9HB
 GwLWcjYVyUWbRpmjTm9E+g1Mf0mboisD0y4v1Kln84ktSfxdCSj0tZk2sfn31PHhZRKS
 LzjAoTY8hvEQWHd8/y2rdmKxZqoAFirr5+7G6JsFYGB72BPWsk+w60XzYFJRtKZSHgoF WA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41javqcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 12:54:52 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326CspKq016306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 12:54:51 GMT
Received: from [10.204.79.110] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 04:54:50 -0800
Message-ID: <9f3a25be-723c-3be0-94bd-820707c80656@quicinc.com>
Date:   Mon, 6 Mar 2023 18:24:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] rcu: Fix rcu_torture_read ftrace event
Content-Language: en-US
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20230306122744.236790-1-douglas.raillard@arm.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230306122744.236790-1-douglas.raillard@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gSHaOnuuUK9-kf2zkUNPDWzC9dJDc5mp
X-Proofpoint-GUID: gSHaOnuuUK9-kf2zkUNPDWzC9dJDc5mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=820 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/2023 5:57 PM, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the rcutorturename field so that its size is correctly reported in
> the text format embedded in trace.dat files. As it stands, it is
> reported as being of size 1:
> 
>      field:char rcutorturename[8];   offset:8;       size:1; signed:0;
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>   include/trace/events/rcu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 90b2fb0292cb..012fa0d171b2 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -768,7 +768,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
>   	TP_ARGS(rcutorturename, rhp, secs, c_old, c),
>   
>   	TP_STRUCT__entry(
> -		__field(char, rcutorturename[RCUTORTURENAME_LEN])
> +		__array(char, rcutorturename, RCUTORTURENAME_LEN)

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   		__field(struct rcu_head *, rhp)
>   		__field(unsigned long, secs)
>   		__field(unsigned long, c_old)
