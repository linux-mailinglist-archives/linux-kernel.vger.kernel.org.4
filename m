Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB96DB652
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjDGWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDGWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:10:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29487C67E;
        Fri,  7 Apr 2023 15:10:52 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337LEoTI009823;
        Fri, 7 Apr 2023 22:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cLrW7EfNX54pesm49DMsh4E0Rg6kSq/wi6Ow3PIrZCY=;
 b=l18zsD0cBVWdOhA9HDOO0bvFjCpbajMXXOrgZ8gpZ+696iWhK5m0XYSg/T9nh41iwo82
 fFjEagNbVU+6rGz2YxbX7kLG9vGSFMxRygLHryUJJVG50vFLx0E2pVshvs2jPlG5dqB8
 g+IQqdBwk9GKmNwphQ5z5uGowHtB71Uj6lu+N0RQ5VesrieTkiPvN8rFB+wQXdJf+nNt
 pmufYpqIrLgUdV+uX+SpmiMwH5B9I1bAd2xx4iIzhzVrVS2qury1T3ttKNvrDKN/P871
 sXHthCh5ru9mHOdD/T+DykktY6W6V1Zy0EzIe/N9E2xQE1nJwqv3MHUnsahsIp3smMEv Vw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psv4dmapk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 22:10:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337MAlb5027266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 22:10:47 GMT
Received: from [10.110.34.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 15:10:46 -0700
Message-ID: <e01c0579-5ce2-459b-0306-7351f8aca561@quicinc.com>
Date:   Fri, 7 Apr 2023 15:10:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230327144153.3133425-1-quic_bjorande@quicinc.com>
 <20230327144153.3133425-3-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230327144153.3133425-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M6XwqxmFN3Af0Y9mr2DPSwg0kncSZyZc
X-Proofpoint-ORIG-GUID: M6XwqxmFN3Af0Y9mr2DPSwg0kncSZyZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070200
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 7:41 AM, Bjorn Andersson wrote:
> Rather than duplicating most of the code for constructing the initial
> TX_DATA and subsequent TX_DATA_CONT packets, roll them into a single
> loop.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 46 +++++++++----------------------
>   1 file changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 62634d020d13..082cf7f4888e 100644
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
> +		if (chunk_size > SZ_8K && (wait || offset > 0))

offset > 0 seems to be a new condition compared to the previous logic.
Are we adding this as a cached check because we know if offset is set 
then fragmented sends are allowed?

I don't think wait would have changed during the loop, so I'm not sure 
if offset > 0 is adding any extra value to the check.

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
