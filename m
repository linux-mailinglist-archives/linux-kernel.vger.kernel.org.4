Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A915B67AAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjAYHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:05:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103D46092;
        Tue, 24 Jan 2023 23:05:02 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P6OlXq028830;
        Wed, 25 Jan 2023 07:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kuf3CPpk1ne0jnopE0CpQlsAJhT3rVTGJ4IBpQwqZTI=;
 b=Rwu1KTo0ayDsx2fUHWbTWrO8QTNfqxdtdu581gRdOdcqeJ7zx1pEvqZHH5qrmN+B5hyT
 GRdSgtNmaBV2hjerIy28izM2oe4BA3vgnMzLSQYCx0QUq8SrDqvr8j6zJ03JWDEGJuPs
 z7yBkbtxcv0UO75lyk6/+6puzCpoPohKUv2k71iLAnMgPnzZxJio1tbGSItneieo39vV
 64hH0tvxJ1IsC7J9FccCELi+XFHg0OEKXP1oMpVrdZOnKKmg633cLjiMJeutywLmE4qr
 wrOhf/L7h2UG863YxhTowDNyMeTwP2Gs6/nW+MGj02mTcd21SrIh8n51k8utlz/AHoOd KA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nar2n8kuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:04:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P74wws015670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:04:58 GMT
Received: from [10.110.119.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 23:04:57 -0800
Message-ID: <1b5887bd-93e3-8653-2771-9cdc0539f534@quicinc.com>
Date:   Tue, 24 Jan 2023 23:04:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5/6] rpmsg: glink: Fail qcom_glink_tx() once remove has
 been initiated
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-6-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230109224001.1706516-6-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kXv61LVy4cQL42N18sk49mJxcKMnku-c
X-Proofpoint-GUID: kXv61LVy4cQL42N18sk49mJxcKMnku-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_03,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=873
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250063
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:40 PM, Bjorn Andersson wrote:
> Upon removing the glink edge communication is at best one-way. This

glink edge, communication

> means that the very common scenario of glink requesting intents will not
> be possible to serve.
> 
> Typically a successful transmission results in the client waiting for a
> response, with some timeout and a mechanism for aborting that timeout.
> 
> Because of this, once the glink edge is defunct once removal is
> commenced it's better to fail transmissions fast.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

>   drivers/rpmsg/qcom_glink_native.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index db5d946d5901..d81d0729493e 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -90,6 +90,7 @@ struct glink_core_rx_intent {
>    * @intentless:	flag to indicate that there is no intent
>    * @tx_avail_notify: Waitqueue for pending tx tasks
>    * @sent_read_notify: flag to check cmd sent or not
> + * @abort_tx:	flag indicating that all tx attempts should fail
>    */
>   struct qcom_glink {
>   	struct device *dev;
> @@ -111,6 +112,8 @@ struct qcom_glink {
>   	bool intentless;
>   	wait_queue_head_t tx_avail_notify;
>   	bool sent_read_notify;
> +
> +	bool abort_tx;
>   };
>   
>   enum {
> @@ -326,12 +329,22 @@ static int qcom_glink_tx(struct qcom_glink *glink,
>   
>   	spin_lock_irqsave(&glink->tx_lock, flags);
>   
> +	if (glink->abort_tx) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
>   	while (qcom_glink_tx_avail(glink) < tlen) {
>   		if (!wait) {
>   			ret = -EAGAIN;
>   			goto out;
>   		}
>   
> +		if (glink->abort_tx) {
> +			ret = -EIO;
> +			goto out;
> +		}
> +
>   		if (!glink->sent_read_notify) {
>   			glink->sent_read_notify = true;
>   			qcom_glink_send_read_notify(glink);
> @@ -1763,11 +1776,18 @@ static int qcom_glink_remove_device(struct device *dev, void *data)
>   void qcom_glink_native_remove(struct qcom_glink *glink)
>   {
>   	struct glink_channel *channel;
> +	unsigned long flags;
>   	int cid;
>   	int ret;
>   
>   	qcom_glink_cancel_rx_work(glink);
>   
> +	/* Fail all attempts at sending messages */
> +	spin_lock_irqsave(&glink->tx_lock, flags);
> +	glink->abort_tx = true;
> +	wake_up_all(&glink->tx_avail_notify);
> +	spin_unlock_irqrestore(&glink->tx_lock, flags);
> +
>   	ret = device_for_each_child(glink->dev, NULL, qcom_glink_remove_device);
>   	if (ret)
>   		dev_warn(glink->dev, "Can't remove GLINK devices: %d\n", ret);
