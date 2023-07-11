Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE95874EF00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGKMeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGKMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:34:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654B170E;
        Tue, 11 Jul 2023 05:33:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAXh14011465;
        Tue, 11 Jul 2023 12:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZRBfs040BRdum9oeYUADEjrb3k2RsXmk2ekeVRNex5U=;
 b=fmaaLA/Y15vS3FmafkMEDMr2lhs30LxK7WthotSIKLC6hCE+X7HmgkvVGHkJ1FZVBMo8
 foIIuW1q3NeQJDP16Cos3yLjIqo0Xdo0qtrtcqBtJKb/HYgRHDZEJLcUDo3nDdVt3Asx
 KGvfgdXB+wRcyxtrVMSwVnOjX8jZYXnV354lI/keWUtOGDJb80Midobi8xV5uzXzXfp7
 QdyOHlel6+xfntYhj/dkjv9ZGwItxlXduHJ8o24Ro3ojj1svweHD/7bPGOvteau3f/14
 +XhTygvoojZAWx9fyN9BMEJY3NUI8qr/Wr1IDTpoBPfz7E6+9sVNpU/+/GMHUYZJZfHp 9g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs4qp09pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:21:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BCLDmM012255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:21:13 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 05:20:39 -0700
Message-ID: <91faf4d4-ff42-24cb-126c-cdb046d34c1e@quicinc.com>
Date:   Tue, 11 Jul 2023 17:50:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] rpmsg: glink: change rx work queue type
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
 <20230607121731.26958-2-quic_mmanikan@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230607121731.26958-2-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p1D8xkLtOkWWWmbhArSdaeiOmhH7dT6S
X-Proofpoint-GUID: p1D8xkLtOkWWWmbhArSdaeiOmhH7dT6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110111
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2023 5:47 PM, Manikanta Mylavarapu wrote:
> In case of heavy cpu load, rx worker thread
> not able to get cpu slot because it's bound
> to kernel global work queue.
> 
> Glink client drivers will return timeout
> error if they didn't receive response
> within stipulated duration. Changing rx
> work queue type to UNBOUND workqueue
> ensures rx worker thread will be executed
> as early as possible.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 1beb40a1d3df..6f9a439e5046 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -81,6 +81,7 @@ struct glink_core_rx_intent {
>    * @rx_pipe:	pipe object for receive FIFO
>    * @tx_pipe:	pipe object for transmit FIFO
>    * @rx_work:	worker for handling received control messages
> + * @rx_wq:	work queue of rx_work
>    * @rx_lock:	protects the @rx_queue
>    * @rx_queue:	queue of received control messages to be processed in @rx_work
>    * @tx_lock:	synchronizes operations on the tx fifo
> @@ -100,6 +101,7 @@ struct qcom_glink {
>   	struct qcom_glink_pipe *tx_pipe;
>   
>   	struct work_struct rx_work;
> +	struct workqueue_struct *rx_wq;
>   	spinlock_t rx_lock;
>   	struct list_head rx_queue;
>   
> @@ -822,7 +824,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
>   	list_add_tail(&dcmd->node, &glink->rx_queue);
>   	spin_unlock(&glink->rx_lock);
>   
> -	schedule_work(&glink->rx_work);
> +	queue_work(glink->rx_wq, &glink->rx_work);
>   	qcom_glink_rx_advance(glink, sizeof(dcmd->msg) + extra);
>   
>   	return 0;
> @@ -1665,6 +1667,8 @@ static void qcom_glink_cancel_rx_work(struct qcom_glink *glink)
>   	/* cancel any pending deferred rx_work */
>   	cancel_work_sync(&glink->rx_work);
>   
> +	destroy_workqueue(glink->rx_wq);
> +
>   	list_for_each_entry_safe(dcmd, tmp, &glink->rx_queue, node)
>   		kfree(dcmd);
>   }
> @@ -1750,6 +1754,10 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
>   	INIT_WORK(&glink->rx_work, qcom_glink_work);
>   	init_waitqueue_head(&glink->tx_avail_notify);
>   
> +	glink->rx_wq = alloc_workqueue("glink_rx_wq", WQ_UNBOUND, 1);
> +	if (!glink->rx_wq)
> +		return ERR_PTR(-ENOMEM);
> +
>   	spin_lock_init(&glink->idr_lock);
>   	idr_init(&glink->lcids);
>   	idr_init(&glink->rcids);


Gentle reminder for review!

Thanks,
Manikanta.
