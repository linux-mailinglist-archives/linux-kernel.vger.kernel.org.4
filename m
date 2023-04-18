Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F46E6DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjDRVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjDRVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:07:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BCA253;
        Tue, 18 Apr 2023 14:07:40 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IKuoov001291;
        Tue, 18 Apr 2023 21:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2XAxNl4hzVW/qth3lmjEC9szXVLjhO+e60yVfkNNEfw=;
 b=DX5c4YQOXvTke4GSbXaZK47NiYxw1oew0B//qKtS0h8dBDEe9iH7CptofRN9yR2X6zaK
 paFfuuPn1QMUrLh6tiXFNxzOXbK5UjU85iIXC3Vz4W0hOuPdLcWGa9x4IYyrukruIDt3
 gfZAw1hfvIh49qd2McdtOYOmLnbnZpjKQCJe2bOhxTq1dmgRcTrpZrh1dV/DRp+cSLTd
 bIxheBAldmoTjiVy5g6lfR8LEnELRc2erJRt5fVWvKvCmHXWf+83kXOmLfXHUJ0/26fA
 NVdpm01q83Z6brAI7BBWnGvXnNFkVBpGxCp/ETxAEc0/VGo0yIpF5PC4UkhHDG+WfnYw mg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1v2ah9va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 21:07:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IL7V9v012444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 21:07:31 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 14:07:30 -0700
Subject: Re: [PATCH v2 2/2] rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230418163018.785524-1-quic_bjorande@quicinc.com>
 <20230418163018.785524-3-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <7ab6ad8b-2403-abba-08b5-028ecc18f12c@quicinc.com>
Date:   Tue, 18 Apr 2023 14:07:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230418163018.785524-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nKQhWyWGqcBeUO8-DpRlcBb2vazc1o1z
X-Proofpoint-ORIG-GUID: nKQhWyWGqcBeUO8-DpRlcBb2vazc1o1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180175
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/2023 9:30 AM, Bjorn Andersson wrote:
> Rather than duplicating most of the code for constructing the initial
> TX_DATA and subsequent TX_DATA_CONT packets, roll them into a single
> loop.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Reduced unnecessary complexity in the chunking condition
>

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>   drivers/rpmsg/qcom_glink_native.c | 46 +++++++++----------------------
>   1 file changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 62634d020d13..7e6fad4e02f8 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1309,7 +1309,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
>   	int ret;
>   	unsigned long flags;
>   	int chunk_size = len;
> -	int left_size = 0;
> +	size_t offset = 0;
>   
>   	if (!glink->intentless) {
>   		while (!intent) {
> @@ -1343,49 +1343,29 @@ static int __qcom_glink_send(struct glink_channel *channel,
>   		iid = intent->id;
>   	}
>   
> -	if (wait && chunk_size > SZ_8K) {
> -		chunk_size = SZ_8K;
> -		left_size = len - chunk_size;
> -	}
> -	req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
> -	req.msg.param1 = cpu_to_le16(channel->lcid);
> -	req.msg.param2 = cpu_to_le32(iid);
> -	req.chunk_size = cpu_to_le32(chunk_size);
> -	req.left_size = cpu_to_le32(left_size);
> -
> -	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
> -
> -	/* Mark intent available if we failed */
> -	if (ret) {
> -		if (intent)
> -			intent->in_use = false;
> -		return ret;
> -	}
> -
> -	while (left_size > 0) {
> -		data = (void *)((char *)data + chunk_size);
> -		chunk_size = left_size;
> -		if (chunk_size > SZ_8K)
> +	while (offset < len) {
> +		chunk_size = len - offset;
> +		if (chunk_size > SZ_8K && wait)
>   			chunk_size = SZ_8K;
> -		left_size -= chunk_size;
>   
> -		req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA_CONT);
> +		req.msg.cmd = cpu_to_le16(offset == 0 ? GLINK_CMD_TX_DATA : GLINK_CMD_TX_DATA_CONT);
>   		req.msg.param1 = cpu_to_le16(channel->lcid);
>   		req.msg.param2 = cpu_to_le32(iid);
>   		req.chunk_size = cpu_to_le32(chunk_size);
> -		req.left_size = cpu_to_le32(left_size);
> +		req.left_size = cpu_to_le32(len - offset - chunk_size);
>   
> -		ret = qcom_glink_tx(glink, &req, sizeof(req), data,
> -				    chunk_size, wait);
> -
> -		/* Mark intent available if we failed */
> +		ret = qcom_glink_tx(glink, &req, sizeof(req), data + offset, chunk_size, wait);
>   		if (ret) {
> +			/* Mark intent available if we failed */
>   			if (intent)
>   				intent->in_use = false;
> -			break;
> +			return ret;
>   		}
> +
> +		offset += chunk_size;
>   	}
> -	return ret;
> +
> +	return 0;
>   }
>   
>   static int qcom_glink_send(struct rpmsg_endpoint *ept, void *data, int len)
> 
