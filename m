Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718CC74EEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGKMam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjGKMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:30:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370C10F2;
        Tue, 11 Jul 2023 05:29:59 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAsvv4022341;
        Tue, 11 Jul 2023 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=emn48To5pQ5Ek7KHLwCYOmyk4sO8oXyn8or5/pFjdk0=;
 b=VjBdkBwJT7m1SRGxXL8YOEoR3HXAu8rQrjA1+LZOdUM8zmRyRJc/U9Y1u6uDIHgd/HI6
 kOIQFpYCpwlVs0uBrLgalkadPwhFveeAmjoCyYt37K3+4nju33buRsQ/UPA47SugTVBW
 BVYm4HfvcjwlYmkIndsfWGTFZ8+B9+BkGUB7OHLdtsR4tvkEiQulcoFn7bGuYaS50oAw
 XPpqARGWJpDfZYWg3ehm4Lq89UfgSgPEqK3pto6+Y4xRzzi+D986mTsW1tK9IjrqJ4cb
 S2G0RcA2phHmBNDJk6etPTqMgMbp/j4Eij/gwEWLyeA8CqiW53GEEdV9ROoi78brVn13 +g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs5rd86kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:28:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BCSBTC014881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:28:11 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 05:28:07 -0700
Message-ID: <9e8fc471-5ca7-bacb-92c4-ae46e74c3e7c@quicinc.com>
Date:   Tue, 11 Jul 2023 17:58:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/2] rpmsg: glink: change intent work queue type
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
 <20230607121731.26958-3-quic_mmanikan@quicinc.com>
In-Reply-To: <20230607121731.26958-3-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rY8DPGTq42ZjigbldVKQmbFnc9MD-9q_
X-Proofpoint-ORIG-GUID: rY8DPGTq42ZjigbldVKQmbFnc9MD-9q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110112
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
> QDSP6 will clear heap memory once it's received
> RX_DONE event from APPS. Under heavy cpu load
> intent worker thread not able to get cpu slot
> because it's bound to kernel global work queue.
> Due to this QDSP6 firmware faces OOM and it leads
> to Q6 crash. Changing intent work queue type to
> UNBOUND workqueue ensures intent worker thread
> will be executed as early as possible.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 6f9a439e5046..c3e076bb863f 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -140,6 +140,7 @@ enum {
>    * @liids:	idr of all local intents
>    * @riids:	idr of all remote intents
>    * @intent_work: worker responsible for transmitting rx_done packets
> + * @intent_wq:	work queue of intent_work
>    * @done_intents: list of intents that needs to be announced rx_done
>    * @buf:	receive buffer, for gathering fragments
>    * @buf_offset:	write offset in @buf
> @@ -169,6 +170,7 @@ struct glink_channel {
>   	struct idr liids;
>   	struct idr riids;
>   	struct work_struct intent_work;
> +	struct workqueue_struct *intent_wq;
>   	struct list_head done_intents;
>   
>   	struct glink_core_rx_intent *buf;
> @@ -231,6 +233,14 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
>   	INIT_LIST_HEAD(&channel->done_intents);
>   	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
>   
> +	channel->intent_wq = alloc_workqueue("intent_wq", WQ_UNBOUND, 1);
> +	if (!channel->intent_wq) {
> +		pr_err("failed to create %s channel intent work queue\n",
> +		       channel->name);
> +		kfree(channel);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>   	idr_init(&channel->liids);
>   	idr_init(&channel->riids);
>   	kref_init(&channel->refcount);
> @@ -270,6 +280,7 @@ static void qcom_glink_channel_release(struct kref *ref)
>   	idr_destroy(&channel->riids);
>   	spin_unlock_irqrestore(&channel->intent_lock, flags);
>   
> +	destroy_workqueue(channel->intent_wq);
>   	kfree(channel->name);
>   	kfree(channel);
>   }
> @@ -573,7 +584,7 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
>   	list_add_tail(&intent->node, &channel->done_intents);
>   	spin_unlock(&channel->intent_lock);
>   
> -	schedule_work(&channel->intent_work);
> +	queue_work(channel->intent_wq, &channel->intent_work);
>   }
>   
>   /**

Gentle reminder for review!

Thanks,
Manikanta.
