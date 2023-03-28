Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A536CCDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjC1WzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC1WzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:55:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1452100;
        Tue, 28 Mar 2023 15:55:22 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SMf6hZ028467;
        Tue, 28 Mar 2023 22:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zD6tIgThhRSFsnYd5P+4y30mqU1VvCsggBrYEeNNsMQ=;
 b=MSmpX/FmMcqVVOcOIfZm2dQ5LX42PM8NAAG8Vyad1NXrKFvANiEaKplJ2jJShi93e0BA
 GAHr8QFeQo35zsUyTdHpr6AyecChFaG8LlKtnH0U5odfBS4jzG1iI0bh7d5ZDZpMOOa8
 hChUMXGlFq+Zpk5V+4E2AJfE4zMrsGyXdkqC+nHyD+jZzvG+k8hCoeOzgoLGsvfkAKF/
 AHszaIR2qMURp/15f9PvTaJWsWGh5bJB+GMtVFl2biSz7Z12ia/IlzNmCrJMF1pMs2kA
 jFvvAW8kBb/tqQj18TU56rN87yvycPLyGHYQFm866mpAL0sFedtY0I9R1phL0CeepPpY wQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkbmyvg5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 22:55:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32SMtIkF020043
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 22:55:18 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 15:55:18 -0700
Subject: Re: [PATCH 1/2] rpmsg: glink: Propagate TX failures in intentless
 mode as well
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230327144153.3133425-1-quic_bjorande@quicinc.com>
 <20230327144153.3133425-2-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <026912e3-4479-415e-96db-abbb2f533599@quicinc.com>
Date:   Tue, 28 Mar 2023 15:55:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230327144153.3133425-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l6vWVoHXxDvFoxA5DIhySnmzoKxsZ2QQ
X-Proofpoint-GUID: l6vWVoHXxDvFoxA5DIhySnmzoKxsZ2QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280178
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 7:41 AM, Bjorn Andersson wrote:
> As support for splitting transmision over several messages using
> TX_DATA_CONT was introduced it does not immediately return the return
> value of qcom_glink_tx().
> 
> The result is that in the intentless case (i.e. intent == NULL), the
> code will continue to send all additional chunks. This is wasteful, and
> it's possible that the send operation could incorrectly indicate
> success, if the last chunk fits in the TX fifo.
> 
> Fix the condition.
> 
> Fixes: 8956927faed3 ("rpmsg: glink: Add TX_DATA_CONT command while sending")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

s/transmision/transmission

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>   drivers/rpmsg/qcom_glink_native.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 01d2805fe30f..62634d020d13 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1356,8 +1356,9 @@ static int __qcom_glink_send(struct glink_channel *channel,
>   	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
>   
>   	/* Mark intent available if we failed */
> -	if (ret && intent) {
> -		intent->in_use = false;
> +	if (ret) {
> +		if (intent)
> +			intent->in_use = false;
>   		return ret;
>   	}
>   
> @@ -1378,8 +1379,9 @@ static int __qcom_glink_send(struct glink_channel *channel,
>   				    chunk_size, wait);
>   
>   		/* Mark intent available if we failed */
> -		if (ret && intent) {
> -			intent->in_use = false;
> +		if (ret) {
> +			if (intent)
> +				intent->in_use = false;
>   			break;
>   		}
>   	}
> 
