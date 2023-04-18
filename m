Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B76E6804
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDRPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjDRPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:24:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFCA12CB0;
        Tue, 18 Apr 2023 08:24:41 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6rQvW008403;
        Tue, 18 Apr 2023 15:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rNasdmeHm0asfhvPEs4XOdtG16/F5CT6ndRcY6Rz8wI=;
 b=lVh4biwWC2VfTHQ6S53pIMCAbifWv6nXO0MUyIgd7p5zIgqlAPi2/u8K1IUSWrtBk7Qt
 j2C2eSL0hGI1SyPahEBQnvS2LbeeeXxZ35ZjxGsumFKhWxdeoEWi2VZ72kvt55jwuAb9
 /u3NTt3NaK5rOBXW6/hi7t7dNCsvCqsd5SO85y8rhJ2sNdhEV+clv2hmxMWu1Plxxov7
 WYwGi4V3u2UONLDMg6R15mkpcsKI+l+HM+sAqrBSnW/UmwY+uEZWoWo9yz4zZS7Ajndz
 zCxjVuyOCSn/K7OrVgJCie3+oNldKT4pMs0my1XcsP1Xcaj3Pv1ZwnT2BNf0qlwzeU4V VQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q19kg2ncx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:24:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IFOQvZ002113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:24:26 GMT
Received: from [10.216.30.222] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 08:24:23 -0700
Message-ID: <b33d2762-6769-15d1-6f7f-ca24feb6aa1b@quicinc.com>
Date:   Tue, 18 Apr 2023 20:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/timer: Add missing hrtimer modes to
 decode_hrtimer_mode().
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230418143854.8vHWQKLM@linutronix.de>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230418143854.8vHWQKLM@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YMVAh5o6zWjxYE0pAtdWzRB6xpAWsDDy
X-Proofpoint-ORIG-GUID: YMVAh5o6zWjxYE0pAtdWzRB6xpAWsDDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=987
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180131
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/2023 8:08 PM, Sebastian Andrzej Siewior wrote:
> The trace output for the HRTIMER_MODE_.*_HARD modes is seen as a number
> since these modes are not decoded. The author was not aware of the fancy
> decoding function which makes the life easier.
> 
> Extend decode_hrtimer_mode() with the additional HRTIMER_MODE_.*_HARD
> modes.
> 
> Fixes: ae6683d815895 ("hrtimer: Introduce HARD expiry mode")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Good catch.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   include/trace/events/timer.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
> index 2e713a7d9aa3a..5d43751a766c6 100644
> --- a/include/trace/events/timer.h
> +++ b/include/trace/events/timer.h
> @@ -158,7 +158,11 @@ DEFINE_EVENT(timer_class, timer_cancel,
>   		{ HRTIMER_MODE_ABS_SOFT,	"ABS|SOFT"	},	\
>   		{ HRTIMER_MODE_REL_SOFT,	"REL|SOFT"	},	\
>   		{ HRTIMER_MODE_ABS_PINNED_SOFT,	"ABS|PINNED|SOFT" },	\
> -		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" })
> +		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" },	\
> +		{ HRTIMER_MODE_ABS_HARD,	"ABS|HARD" },		\
> +		{ HRTIMER_MODE_REL_HARD,	"REL|HARD" },		\
> +		{ HRTIMER_MODE_ABS_PINNED_HARD, "ABS|PINNED|HARD" },	\
> +		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
>   
>   /**
>    * hrtimer_init - called when the hrtimer is initialized
