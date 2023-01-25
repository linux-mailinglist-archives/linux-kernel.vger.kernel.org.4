Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D467AA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjAYGgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:36:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3843F2B0;
        Tue, 24 Jan 2023 22:36:05 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P6SxQR006588;
        Wed, 25 Jan 2023 06:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ueo7qGmLs52stwbaqTQ+/XirgW99VlTZgfpNSgfGkwQ=;
 b=l04yBiwfH4gCN6aOq8yiZqvn9LJCaQKGUcbBsLSYyovw83Tt0JIXpt+3Ll89LwQpRLfW
 pPOJBgJHcubWXJVgUATpOTVFITws6a2nYWc41Ck4yz1NxzpEeBRW24uqyljszVwI9lgr
 oNeRWBiD8q7zqyAbtxd78KRJQgfzEUNAZX9+md4qQT4O8UNkRrN3GP8xvKOQlw2z5iV9
 A9Ig92R+fCLt+X/EPN/AX1eKmMv1K+h0CpD0gJBPFOjCTGvCSEDuj1gtvF8aeqExbEl/
 0Dzx47/zJpZVHs9D/W/m6b1DIQpPr6WUdS8IuXCmSE76azTFJFFZGpCHfaAYV9HXLmda kQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nar2n8jkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 06:35:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P6ZuB5028532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 06:35:56 GMT
Received: from [10.110.119.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 22:35:38 -0800
Message-ID: <89a1721a-d364-6ad9-a817-91ac654fd1cc@quicinc.com>
Date:   Tue, 24 Jan 2023 22:34:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/6] rpmsg: glink: Extract tx kick operation
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-2-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230109224001.1706516-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CQOjNoN7lj-cl7N5njBwrzAUmN2EvVLw
X-Proofpoint-GUID: CQOjNoN7lj-cl7N5njBwrzAUmN2EvVLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_02,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250059
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:39 PM, Bjorn Andersson wrote:
> Refactor out the tx kick operations to its own function, in preparation
> for pushing the details to the individual transports.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>   drivers/rpmsg/qcom_glink_native.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 115c0a1eddb1..5fd8b70271b7 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -303,6 +303,12 @@ static void qcom_glink_tx_write(struct qcom_glink *glink,
>   	glink->tx_pipe->write(glink->tx_pipe, hdr, hlen, data, dlen);
>   }
>   
> +static void qcom_glink_tx_kick(struct qcom_glink *glink)
> +{
> +	mbox_send_message(glink->mbox_chan, NULL);
> +	mbox_client_txdone(glink->mbox_chan, 0);
> +}
> +
>   static void qcom_glink_send_read_notify(struct qcom_glink *glink)
>   {
>   	struct glink_msg msg;
> @@ -313,8 +319,7 @@ static void qcom_glink_send_read_notify(struct qcom_glink *glink)
>   
>   	qcom_glink_tx_write(glink, &msg, sizeof(msg), NULL, 0);
>   
> -	mbox_send_message(glink->mbox_chan, NULL);
> -	mbox_client_txdone(glink->mbox_chan, 0);
> +	qcom_glink_tx_kick(glink);
>   }
>   
>   static int qcom_glink_tx(struct qcom_glink *glink,
> @@ -355,9 +360,7 @@ static int qcom_glink_tx(struct qcom_glink *glink,
>   	}
>   
>   	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
> -
> -	mbox_send_message(glink->mbox_chan, NULL);
> -	mbox_client_txdone(glink->mbox_chan, 0);
> +	qcom_glink_tx_kick(glink);
>   
>   out:
>   	spin_unlock_irqrestore(&glink->tx_lock, flags);
> @@ -1046,9 +1049,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>   			break;
>   		case RPM_CMD_READ_NOTIF:
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> -
> -			mbox_send_message(glink->mbox_chan, NULL);
> -			mbox_client_txdone(glink->mbox_chan, 0);
> +			qcom_glink_tx_kick(glink);
>   			break;
>   		case RPM_CMD_INTENT:
>   			qcom_glink_handle_intent(glink, param1, param2, avail);
