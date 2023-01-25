Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF667AAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjAYHHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:07:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6C46092;
        Tue, 24 Jan 2023 23:07:33 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P6t9S9023927;
        Wed, 25 Jan 2023 07:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nhrukkMf0X8WUV4MEoDuF9s5/hsGlhq0RAEK34e1E+g=;
 b=TZ+BwGVzEqxaCP3fSE23vqN4RWHW+/1XExVScwUoC9oKNhRmQ4wizgHyOYwaGcov7XLA
 IZhlXk9uiwJWSAVmnJLvX/6jA2Efp61FsL8axs/7xU+2qq6JfDYQlY2OXTMBKr28l2hQ
 cElEqCqJY2tzaxMy+5G4i5cxLbMZwksgh1MOdGaILTxF6ahrDIZsmSucINMO2ISNFZ/+
 qnIDbdK8G7ug9hGywYBox9WODIxBP1g8vHpVjCb0p2gyrCkh/Wuapwm8+w+qtlc41EQp
 d21PF+hLRFsnUAKXhLfKBK4qthS9XibQu2Rx9KD6brLOsEQm+GLOsb2Lj4KR+u32Q4CP IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nanb68v98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:07:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P77SBa029577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:07:28 GMT
Received: from [10.110.119.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 23:07:28 -0800
Message-ID: <7bff3a2c-b5c4-782b-9134-def135c40f21@quicinc.com>
Date:   Tue, 24 Jan 2023 23:07:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 6/6] rpmsg: glink: Cancel pending intent requests at
 removal
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-7-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230109224001.1706516-7-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QWANaEpKRdT39rMV1ocnzNXREfm8JehP
X-Proofpoint-GUID: QWANaEpKRdT39rMV1ocnzNXREfm8JehP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_03,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=806 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250064
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:40 PM, Bjorn Andersson wrote:
> During removal of the glink edge interrupts are disabled and no more
> incoming messages are being serviced. In addition to the remote endpoint
> being defunct that means that any outstanding requests for intents will
> not be serviced, and qcom_glink_request_intent() will blindly wait for
> up to 10 seconds.
> 
> Mark the intent request as not granted and complete the intent request
> completion to fail the waiting client immediately.
> 
> Once the current intent request is failed, any potential clients waiting
> for the intent request mutex will not enter the same wait, as the
> qcom_glink_tx() call will fail fast.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>   drivers/rpmsg/qcom_glink_native.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index d81d0729493e..bb14e7edeadc 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -423,6 +423,12 @@ static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
>   	complete(&channel->intent_req_comp);
>   }
>   
> +static void qcom_glink_intent_req_abort(struct glink_channel *channel)
> +{
> +	channel->intent_req_result = 0;
> +	complete(&channel->intent_req_comp);
> +}
> +
>   /**
>    * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
>    * @glink: Ptr to the glink edge
> @@ -1788,6 +1794,12 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
>   	wake_up_all(&glink->tx_avail_notify);
>   	spin_unlock_irqrestore(&glink->tx_lock, flags);
>   
> +	/* Abort any senders waiting for intent requests */
> +	spin_lock_irqsave(&glink->idr_lock, flags);
> +	idr_for_each_entry(&glink->lcids, channel, cid)
> +		qcom_glink_intent_req_abort(channel);
> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
> +
>   	ret = device_for_each_child(glink->dev, NULL, qcom_glink_remove_device);
>   	if (ret)
>   		dev_warn(glink->dev, "Can't remove GLINK devices: %d\n", ret);
