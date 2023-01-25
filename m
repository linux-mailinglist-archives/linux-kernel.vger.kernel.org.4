Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445BB67AA92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjAYGz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYGzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:55:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F04609D;
        Tue, 24 Jan 2023 22:55:53 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P5eaoj027353;
        Wed, 25 Jan 2023 06:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BlajH/By5AN6a5Qpr7SOhUwX3WePB9Bgys1yvLE1vxU=;
 b=DjuLzsYNoqldxD8c/kUdeDdqDMfUdrjnplnrAmcoTVWYaFCDEBrYFqlA+XOhq/AtMWbf
 EBQ+4tZDXcUPGHPVPleGsBMVeQ+Pa2L4L7bGiysxBfttULQB+VdGudOQ19AjoqfLl7Eq
 UwddSyYKFxfdhu58JFmIozrHoY//zX0RmY7PIA85938hvV5E6wxS0FlyWopaygE7bvVN
 5qO5vAKRpqdY/1+9qMkGtEFO7I4eoYgJHXMVzdT+CJrEtVdSgeU5se0hPoCa8w4MMrnp
 ZIBuCMG3YzdE4nQrgM0+eyLzZdnVx9dNEB9tQ6tDni3lB75Ezf6YKUD2gi9F/16YZg1f bA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nar2n8kcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 06:55:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P6tmbx004150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 06:55:48 GMT
Received: from [10.110.119.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 22:55:48 -0800
Message-ID: <4d9606ef-8b5c-4116-f2fe-bdd0d846ac3b@quicinc.com>
Date:   Tue, 24 Jan 2023 22:55:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/6] rpmsg: glink: Move irq and mbox handling to
 transports
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
 <20230109224001.1706516-5-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230109224001.1706516-5-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bFRO7falH5mpRl1f3yPqoFMfah9n9s5B
X-Proofpoint-GUID: bFRO7falH5mpRl1f3yPqoFMfah9n9s5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_02,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250061
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 2:39 PM, Bjorn Andersson wrote:
> Not all GLINK transports uses an interrupt and a mailbox instance. The
> interrupt for RPM needs to be IRQF_NOSUSPEND, while it seems reasonable
> for the SMEM interrupt to use irq_set_wake. The glink struct device is
> constructed in the SMEM and RPM drivers but torn down in the core
> driver.
> 
> Move the interrupt and kick handling into the SMEM and RPM driver, to
> improve this and facilitate further improvements.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 48 ++------------------------
>   drivers/rpmsg/qcom_glink_native.h |  3 +-
>   drivers/rpmsg/qcom_glink_rpm.c    | 50 ++++++++++++++++++++++++++-
>   drivers/rpmsg/qcom_glink_smem.c   | 56 +++++++++++++++++++++++++++++--
>   4 files changed, 108 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 5fd8b70271b7..db5d946d5901 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -11,7 +11,6 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> -#include <linux/of_irq.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/rpmsg.h>
> @@ -78,11 +77,8 @@ struct glink_core_rx_intent {
>   /**
>    * struct qcom_glink - driver context, relates to one remote subsystem
>    * @dev:	reference to the associated struct device
> - * @mbox_client: mailbox client
> - * @mbox_chan:  mailbox channel
>    * @rx_pipe:	pipe object for receive FIFO
>    * @tx_pipe:	pipe object for transmit FIFO
> - * @irq:	IRQ for signaling incoming events
>    * @rx_work:	worker for handling received control messages
>    * @rx_lock:	protects the @rx_queue
>    * @rx_queue:	queue of received control messages to be processed in @rx_work
> @@ -98,14 +94,9 @@ struct glink_core_rx_intent {
>   struct qcom_glink {
>   	struct device *dev;
>   
> -	struct mbox_client mbox_client;
> -	struct mbox_chan *mbox_chan;
> -
>   	struct qcom_glink_pipe *rx_pipe;
>   	struct qcom_glink_pipe *tx_pipe;
>   
> -	int irq;
> -
>   	struct work_struct rx_work;
>   	spinlock_t rx_lock;
>   	struct list_head rx_queue;
> @@ -305,8 +296,7 @@ static void qcom_glink_tx_write(struct qcom_glink *glink,
>   
>   static void qcom_glink_tx_kick(struct qcom_glink *glink)
>   {
> -	mbox_send_message(glink->mbox_chan, NULL);
> -	mbox_client_txdone(glink->mbox_chan, 0);
> +	glink->tx_pipe->kick(glink->tx_pipe);

I think that we need to check that tx_pipe is not null or validate that 
tx_pipe is not null in the native register probe.

>   }
>   
>   static void qcom_glink_send_read_notify(struct qcom_glink *glink)
> @@ -1004,9 +994,8 @@ static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>   	return 0;
>   }
>   
> -static irqreturn_t qcom_glink_native_intr(int irq, void *data)
> +void qcom_glink_native_intr(struct qcom_glink *glink)
>   {
> -	struct qcom_glink *glink = data;
>   	struct glink_msg msg;
>   	unsigned int param1;
>   	unsigned int param2;
> @@ -1075,9 +1064,8 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>   		if (ret)
>   			break;
>   	}
> -
> -	return IRQ_HANDLED;
>   }
> +EXPORT_SYMBOL(qcom_glink_native_intr);
>   
>   /* Locally initiated rpmsg_create_ept */
>   static struct glink_channel *qcom_glink_create_local(struct qcom_glink *glink,
> @@ -1723,7 +1711,6 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
>   					   struct qcom_glink_pipe *tx,
>   					   bool intentless)
>   {
> -	int irq;
>   	int ret;
>   	struct qcom_glink *glink;
>   
> @@ -1754,27 +1741,6 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
>   	if (ret)
>   		dev_err(dev, "failed to add groups\n");
>   
> -	glink->mbox_client.dev = dev;
> -	glink->mbox_client.knows_txdone = true;
> -	glink->mbox_chan = mbox_request_channel(&glink->mbox_client, 0);
> -	if (IS_ERR(glink->mbox_chan)) {
> -		if (PTR_ERR(glink->mbox_chan) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to acquire IPC channel\n");
> -		return ERR_CAST(glink->mbox_chan);
> -	}
> -
> -	irq = of_irq_get(dev->of_node, 0);
> -	ret = devm_request_irq(dev, irq,
> -			       qcom_glink_native_intr,
> -			       IRQF_NO_SUSPEND | IRQF_SHARED,
> -			       "glink-native", glink);
> -	if (ret) {
> -		dev_err(dev, "failed to request IRQ\n");
> -		return ERR_PTR(ret);
> -	}
> -
> -	glink->irq = irq;
> -
>   	ret = qcom_glink_send_version(glink);
>   	if (ret)
>   		return ERR_PTR(ret);
> @@ -1800,7 +1766,6 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
>   	int cid;
>   	int ret;
>   
> -	disable_irq(glink->irq);
>   	qcom_glink_cancel_rx_work(glink);
>   
>   	ret = device_for_each_child(glink->dev, NULL, qcom_glink_remove_device);
> @@ -1817,15 +1782,8 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
>   
>   	idr_destroy(&glink->lcids);
>   	idr_destroy(&glink->rcids);
> -	mbox_free_channel(glink->mbox_chan);
>   }
>   EXPORT_SYMBOL_GPL(qcom_glink_native_remove);
>   
> -void qcom_glink_native_unregister(struct qcom_glink *glink)
> -{
> -	device_unregister(glink->dev);
> -}
> -EXPORT_SYMBOL_GPL(qcom_glink_native_unregister);
> -
>   MODULE_DESCRIPTION("Qualcomm GLINK driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/rpmsg/qcom_glink_native.h b/drivers/rpmsg/qcom_glink_native.h
> index e9a8671616c7..0129fe1b2b6c 100644
> --- a/drivers/rpmsg/qcom_glink_native.h
> +++ b/drivers/rpmsg/qcom_glink_native.h
> @@ -24,6 +24,7 @@ struct qcom_glink_pipe {
>   	void (*write)(struct qcom_glink_pipe *glink_pipe,
>   		      const void *hdr, size_t hlen,
>   		      const void *data, size_t dlen);
> +	void (*kick)(struct qcom_glink_pipe *glink_pipe);
>   };
>   
>   struct device;
> @@ -35,6 +36,6 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
>   					   struct qcom_glink_pipe *tx,
>   					   bool intentless);
>   void qcom_glink_native_remove(struct qcom_glink *glink);
> +void qcom_glink_native_intr(struct qcom_glink *glink);
>

We could rename this away from qcom_glink_native_intr to something like 
qcom_glink_native_rx. Seeing this in the header, the purpose sounds a 
bit obscure.

> -void qcom_glink_native_unregister(struct qcom_glink *glink);
>   #endif
> diff --git a/drivers/rpmsg/qcom_glink_rpm.c b/drivers/rpmsg/qcom_glink_rpm.c
> index 6443843df6ca..9136645d6251 100644
> --- a/drivers/rpmsg/qcom_glink_rpm.c
> +++ b/drivers/rpmsg/qcom_glink_rpm.c
> @@ -11,6 +11,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/rpmsg.h>
> @@ -56,6 +57,11 @@ struct glink_rpm_pipe {
>   struct glink_rpm {
>   	struct qcom_glink *glink;
>   
> +	int irq;
> +
> +	struct mbox_client mbox_client;
> +	struct mbox_chan *mbox_chan;
> +
>   	struct glink_rpm_pipe rx_pipe;
>   	struct glink_rpm_pipe tx_pipe;
>   };
> @@ -186,6 +192,24 @@ static void glink_rpm_tx_write(struct qcom_glink_pipe *glink_pipe,
>   	writel(head, pipe->head);
>   }
>   
> +static void glink_rpm_tx_kick(struct qcom_glink_pipe *glink_pipe)
> +{
> +	struct glink_rpm_pipe *pipe = to_rpm_pipe(glink_pipe);
> +	struct glink_rpm *rpm = container_of(pipe, struct glink_rpm, tx_pipe);
> +
> +	mbox_send_message(rpm->mbox_chan, NULL);
> +	mbox_client_txdone(rpm->mbox_chan, 0);
> +}
> +
> +static irqreturn_t qcom_glink_rpm_intr(int irq, void *data)
> +{
> +	struct glink_rpm *rpm = data;
> +
> +	qcom_glink_native_intr(rpm->glink);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int glink_rpm_parse_toc(struct device *dev,
>   			       void __iomem *msg_ram,
>   			       size_t msg_ram_size,
> @@ -292,12 +316,28 @@ static int glink_rpm_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	rpm->irq = of_irq_get(dev->of_node, 0);
> +	ret = devm_request_irq(dev, rpm->irq, qcom_glink_rpm_intr,
> +			       IRQF_NO_SUSPEND | IRQF_NO_AUTOEN,
> +			       "glink-rpm", rpm);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	rpm->mbox_client.dev = dev;
> +	rpm->mbox_client.knows_txdone = true;
> +	rpm->mbox_chan = mbox_request_channel(&rpm->mbox_client, 0);
> +	if (IS_ERR(rpm->mbox_chan))
> +		return dev_err_probe(dev, PTR_ERR(rpm->mbox_chan), "failed to acquire IPC channel\n");
> +
>   	/* Pipe specific accessors */
>   	rpm->rx_pipe.native.avail = glink_rpm_rx_avail;
>   	rpm->rx_pipe.native.peak = glink_rpm_rx_peak;
>   	rpm->rx_pipe.native.advance = glink_rpm_rx_advance;
>   	rpm->tx_pipe.native.avail = glink_rpm_tx_avail;
>   	rpm->tx_pipe.native.write = glink_rpm_tx_write;
> +	rpm->tx_pipe.native.kick = glink_rpm_tx_kick;
>   
>   	writel(0, rpm->tx_pipe.head);
>   	writel(0, rpm->rx_pipe.tail);
> @@ -307,13 +347,17 @@ static int glink_rpm_probe(struct platform_device *pdev)
>   					&rpm->rx_pipe.native,
>   					&rpm->tx_pipe.native,
>   					true);
> -	if (IS_ERR(glink))
> +	if (IS_ERR(glink)) {
> +		mbox_free_channel(rpm->mbox_chan);
>   		return PTR_ERR(glink);
> +	}
>   
>   	rpm->glink = glink;
>   
>   	platform_set_drvdata(pdev, rpm);
>   
> +	enable_irq(rpm->irq);
> +
>   	return 0;
>   }
>   
> @@ -322,8 +366,12 @@ static int glink_rpm_remove(struct platform_device *pdev)
>   	struct glink_rpm *rpm = platform_get_drvdata(pdev);
>   	struct qcom_glink *glink = rpm->glink;
>   
> +	disable_irq(rpm->irq);
> +
>   	qcom_glink_native_remove(glink);
>   
> +	mbox_free_channel(rpm->mbox_chan);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 703e63fa5a86..eec47ae98d67 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -7,8 +7,10 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/interrupt.h>
>   #include <linux/platform_device.h>
> +#include <linux/mailbox_client.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/slab.h>
>   #include <linux/rpmsg.h>
> @@ -36,8 +38,12 @@
>   struct qcom_glink_smem {
>   	struct device dev;
>   
> +	int irq;
>   	struct qcom_glink *glink;
>   
> +	struct mbox_client mbox_client;
> +	struct mbox_chan *mbox_chan;
> +
>   	u32 remote_pid;
>   };
>   
> @@ -186,6 +192,24 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
>   	*pipe->head = cpu_to_le32(head);
>   }
>   
> +static void glink_smem_tx_kick(struct qcom_glink_pipe *glink_pipe)
> +{
> +	struct glink_smem_pipe *pipe = to_smem_pipe(glink_pipe);
> +	struct qcom_glink_smem *smem = pipe->smem;
> +
> +	mbox_send_message(smem->mbox_chan, NULL);
> +	mbox_client_txdone(smem->mbox_chan, 0);
> +}
> +
> +static irqreturn_t qcom_glink_smem_intr(int irq, void *data)
> +{
> +	struct qcom_glink_smem *smem = data;
> +
> +	qcom_glink_native_intr(smem->glink);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static void qcom_glink_smem_release(struct device *dev)
>   {
>   	struct qcom_glink_smem *smem = container_of(dev, struct qcom_glink_smem, dev);
> @@ -277,6 +301,24 @@ struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
>   		goto err_put_dev;
>   	}
>   
> +	smem->irq = of_irq_get(smem->dev.of_node, 0);
> +	ret = devm_request_irq(&smem->dev, smem->irq, qcom_glink_smem_intr,
> +			       IRQF_NO_SUSPEND | IRQF_NO_AUTOEN,
> +			       "glink-smem", smem);

Are we adding dropping IRQF_NO_SUSPEND and adding enable irq wake for 
smem in follow up change?

> +	if (ret) {
> +		dev_err(&smem->dev, "failed to request IRQ\n");
> +		goto err_put_dev;
> +	}
> +
> +	smem->mbox_client.dev = &smem->dev;
> +	smem->mbox_client.knows_txdone = true;
> +	smem->mbox_chan = mbox_request_channel(&smem->mbox_client, 0);
> +	if (IS_ERR(smem->mbox_chan)) {
> +		ret = dev_err_probe(&smem->dev, PTR_ERR(smem->mbox_chan),
> +				    "failed to acquire IPC channel\n");
> +		goto err_put_dev;
> +	}
> +
>   	rx_pipe->smem = smem;
>   	rx_pipe->native.avail = glink_smem_rx_avail;
>   	rx_pipe->native.peak = glink_smem_rx_peak;
> @@ -285,6 +327,7 @@ struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
>   	tx_pipe->smem = smem;
>   	tx_pipe->native.avail = glink_smem_tx_avail;
>   	tx_pipe->native.write = glink_smem_tx_write;
> +	tx_pipe->native.kick = glink_smem_tx_kick;
>   
>   	*rx_pipe->tail = 0;
>   	*tx_pipe->head = 0;
> @@ -295,13 +338,17 @@ struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
>   					false);
>   	if (IS_ERR(glink)) {
>   		ret = PTR_ERR(glink);
> -		goto err_put_dev;
> +		goto err_free_mbox;
>   	}
>   
>   	smem->glink = glink;
>   
> +	enable_irq(smem->irq);
> +
>   	return smem;
>   
> +err_free_mbox:
> +	mbox_free_channel(smem->mbox_chan);
>   
>   err_put_dev:
>   	device_unregister(&smem->dev);
> @@ -314,8 +361,13 @@ void qcom_glink_smem_unregister(struct qcom_glink_smem *smem)
>   {
>   	struct qcom_glink *glink = smem->glink;
>   
> +	disable_irq(smem->irq);
> +
>   	qcom_glink_native_remove(glink);
> -	qcom_glink_native_unregister(glink);
> +
> +	device_unregister(&smem->dev);
> +
> +	mbox_free_channel(smem->mbox_chan);

This might need to be moved above device_unregister. I think the release 
function frees the smem structure.

>   }
>   EXPORT_SYMBOL_GPL(qcom_glink_smem_unregister);
>   
