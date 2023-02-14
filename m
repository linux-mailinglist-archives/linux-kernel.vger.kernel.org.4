Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCEA6956BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBNCgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:36:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E312045;
        Mon, 13 Feb 2023 18:36:49 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMb7c1015784;
        Tue, 14 Feb 2023 02:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7/aakhHw6jmY23Ry7x9srwxzX1saJqqEf70DwHYKcOs=;
 b=bF8BS8VHyWbFs0T+AWP25OzB1/dsOmG0ON2l2WffnyHmabGWty9dwaw7/ShcdxkeGneu
 BjIxeAx2F4vT36UGKa3+JNP0yjH8oE7tdY5WD7tg5oLrVrEdIgrfZ65kkIFvqgoo1gba
 Ai5Gvn00C73Fo8qMGrZys3s+SGLjVF9h430//MaCCfU+M6QDHRxEfWt/RvxQ6Mo7tbDQ
 tYCWxKZGLHE03PHI/HhyngB6xWbrYXZELJHd0PEupvyRFW0j0eYF1lNJZSHtl7r2iqZT
 K1++R86alG4bUrXxbcuYF2wMo/6ZnAjjocuRgkSXxSKZHIfJqvdgntRzUHp/EfUdM6Jv HQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np3dewuk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 02:36:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E2aiKt019149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 02:36:44 GMT
Received: from [10.110.6.173] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 18:36:43 -0800
Message-ID: <2ad6c912-69fe-9c2e-146d-cdca9b8b1c7b@quicinc.com>
Date:   Mon, 13 Feb 2023 18:36:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/6] rpmsg: glink: smem: Wrap driver context
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
 <20230213155215.1237059-3-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230213155215.1237059-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OIPzMpvG_sorgmQnHBeZlMOQc7SP8nys
X-Proofpoint-ORIG-GUID: OIPzMpvG_sorgmQnHBeZlMOQc7SP8nys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_01,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140019
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2023 7:52 AM, Bjorn Andersson wrote:
> The Glink SMEM driver allocates a struct device and hangs two
> devres-allocated pipe objects thereon. To facilitate the move of
> interrupt and mailbox handling to the driver, introduce a wrapper object
> capturing the device, glink reference and remote processor id.
> 
> The type of the remoteproc reference is updated, as these are
> specifically targeting the SMEM implementation.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Revert back to use a local struct device * in register, to reduce size of
>    diff.
> - Reverse xmas tree of variables in register
> - Fix spelling of targeting in commit message.
> 
>   drivers/remoteproc/qcom_common.h |  3 ++-
>   drivers/rpmsg/qcom_glink_smem.c  | 43 ++++++++++++++++++++++++--------
>   include/linux/rpmsg/qcom_glink.h | 12 ++++-----
>   3 files changed, 40 insertions(+), 18 deletions(-)
> 

Thanks for the changes, LGTM.

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

> diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
> index c35adf730be0..2747c7d9ba44 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -6,6 +6,7 @@
>   #include "remoteproc_internal.h"
>   #include <linux/soc/qcom/qmi.h>
>   
> +struct qcom_glink_smem;
>   struct qcom_sysmon;
>   
>   struct qcom_rproc_glink {
> @@ -15,7 +16,7 @@ struct qcom_rproc_glink {
>   
>   	struct device *dev;
>   	struct device_node *node;
> -	struct qcom_glink *edge;
> +	struct qcom_glink_smem *edge;
>   };
>   
>   struct qcom_rproc_subdev {
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 579bc4443f6d..a9c477df4d68 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -33,6 +33,14 @@
>   #define SMEM_GLINK_NATIVE_XPRT_FIFO_0		479
>   #define SMEM_GLINK_NATIVE_XPRT_FIFO_1		480
>   
> +struct qcom_glink_smem {
> +	struct device dev;
> +
> +	struct qcom_glink *glink;
> +
> +	u32 remote_pid;
> +};
> +
>   struct glink_smem_pipe {
>   	struct qcom_glink_pipe native;
>   
> @@ -41,7 +49,7 @@ struct glink_smem_pipe {
>   
>   	void *fifo;
>   
> -	int remote_pid;
> +	struct qcom_glink_smem *smem;
>   };
>   
>   #define to_smem_pipe(p) container_of(p, struct glink_smem_pipe, native)
> @@ -49,13 +57,14 @@ struct glink_smem_pipe {
>   static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
>   {
>   	struct glink_smem_pipe *pipe = to_smem_pipe(np);
> +	struct qcom_glink_smem *smem = pipe->smem;
>   	size_t len;
>   	void *fifo;
>   	u32 head;
>   	u32 tail;
>   
>   	if (!pipe->fifo) {
> -		fifo = qcom_smem_get(pipe->remote_pid,
> +		fifo = qcom_smem_get(smem->remote_pid,
>   				     SMEM_GLINK_NATIVE_XPRT_FIFO_1, &len);
>   		if (IS_ERR(fifo)) {
>   			pr_err("failed to acquire RX fifo handle: %ld\n",
> @@ -179,14 +188,17 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
>   
>   static void qcom_glink_smem_release(struct device *dev)
>   {
> -	kfree(dev);
> +	struct qcom_glink_smem *smem = container_of(dev, struct qcom_glink_smem, dev);
> +
> +	kfree(smem);
>   }
>   
> -struct qcom_glink *qcom_glink_smem_register(struct device *parent,
> -					    struct device_node *node)
> +struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
> +						 struct device_node *node)
>   {
>   	struct glink_smem_pipe *rx_pipe;
>   	struct glink_smem_pipe *tx_pipe;
> +	struct qcom_glink_smem *smem;
>   	struct qcom_glink *glink;
>   	struct device *dev;
>   	u32 remote_pid;
> @@ -194,10 +206,12 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>   	size_t size;
>   	int ret;
>   
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -	if (!dev)
> +	smem = kzalloc(sizeof(*smem), GFP_KERNEL);
> +	if (!smem)
>   		return ERR_PTR(-ENOMEM);
>   
> +	dev = &smem->dev;
> +
>   	dev->parent = parent;
>   	dev->of_node = node;
>   	dev->release = qcom_glink_smem_release;
> @@ -216,6 +230,8 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>   		goto err_put_dev;
>   	}
>   
> +	smem->remote_pid = remote_pid;
> +
>   	rx_pipe = devm_kzalloc(dev, sizeof(*rx_pipe), GFP_KERNEL);
>   	tx_pipe = devm_kzalloc(dev, sizeof(*tx_pipe), GFP_KERNEL);
>   	if (!rx_pipe || !tx_pipe) {
> @@ -264,14 +280,14 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>   		goto err_put_dev;
>   	}
>   
> +	rx_pipe->smem = smem;
>   	rx_pipe->native.avail = glink_smem_rx_avail;
>   	rx_pipe->native.peak = glink_smem_rx_peak;
>   	rx_pipe->native.advance = glink_smem_rx_advance;
> -	rx_pipe->remote_pid = remote_pid;
>   
> +	tx_pipe->smem = smem;
>   	tx_pipe->native.avail = glink_smem_tx_avail;
>   	tx_pipe->native.write = glink_smem_tx_write;
> -	tx_pipe->remote_pid = remote_pid;
>   
>   	*rx_pipe->tail = 0;
>   	*tx_pipe->head = 0;
> @@ -285,7 +301,10 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>   		goto err_put_dev;
>   	}
>   
> -	return glink;
> +	smem->glink = glink;
> +
> +	return smem;
> +
>   
>   err_put_dev:
>   	device_unregister(dev);
> @@ -294,8 +313,10 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>   }
>   EXPORT_SYMBOL_GPL(qcom_glink_smem_register);
>   
> -void qcom_glink_smem_unregister(struct qcom_glink *glink)
> +void qcom_glink_smem_unregister(struct qcom_glink_smem *smem)
>   {
> +	struct qcom_glink *glink = smem->glink;
> +
>   	qcom_glink_native_remove(glink);
>   	qcom_glink_native_unregister(glink);
>   }
> diff --git a/include/linux/rpmsg/qcom_glink.h b/include/linux/rpmsg/qcom_glink.h
> index 22fc3a69b683..bfbd48f435fa 100644
> --- a/include/linux/rpmsg/qcom_glink.h
> +++ b/include/linux/rpmsg/qcom_glink.h
> @@ -5,7 +5,7 @@
>   
>   #include <linux/device.h>
>   
> -struct qcom_glink;
> +struct qcom_glink_smem;
>   
>   #if IS_ENABLED(CONFIG_RPMSG_QCOM_GLINK)
>   void qcom_glink_ssr_notify(const char *ssr_name);
> @@ -15,20 +15,20 @@ static inline void qcom_glink_ssr_notify(const char *ssr_name) {}
>   
>   #if IS_ENABLED(CONFIG_RPMSG_QCOM_GLINK_SMEM)
>   
> -struct qcom_glink *qcom_glink_smem_register(struct device *parent,
> -					    struct device_node *node);
> -void qcom_glink_smem_unregister(struct qcom_glink *glink);
> +struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
> +						 struct device_node *node);
> +void qcom_glink_smem_unregister(struct qcom_glink_smem *glink);
>   
>   #else
>   
> -static inline struct qcom_glink *
> +static inline struct qcom_glink_smem *
>   qcom_glink_smem_register(struct device *parent,
>   			 struct device_node *node)
>   {
>   	return NULL;
>   }
>   
> -static inline void qcom_glink_smem_unregister(struct qcom_glink *glink) {}
> +static inline void qcom_glink_smem_unregister(struct qcom_glink_smem *glink) {}
>   #endif
>   
>   #endif
