Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8021A615100
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKARpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKARpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:45:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC261CB04;
        Tue,  1 Nov 2022 10:45:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A1HWEEo001851;
        Tue, 1 Nov 2022 17:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yRmx4djPcDbd4WB9oKDdIBwYg0RTQ87iKdGWmMMWJSg=;
 b=gqTnat0FqBxzZFAbgvEFGf1i3VhPBWqTTwjfKKW02D3e/CfgnY9oFygWK7jXMbeqQXTE
 TRefiIzjTOrJtxI/9jUoNebOir3IQ6CdukMvPgqCPBfiUXKXFw+7veTsFfKfG4bELyBl
 F0M2Q16PmGlxSZhP/pgFUirHltaPgvEXBC43EsTVkfSmzZMFdzudgvzN3xf1qW1wRHPl
 sDgqCHvhLThnqEWrFmzK1uavRzLR+5yFcXgH6+7TOUdafj4nEGhKRTavxfQwLSGwFB5Q
 4E9WZSR8j257VvhmSVf0WlcJqDnKpp6fZHe/9NZuYgEfsotNAi2G3WUnIsEBIWaJq/8B zg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7xp819s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 17:45:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A1Hj1xl013060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Nov 2022 17:45:01 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 10:45:00 -0700
Message-ID: <cc9f6d43-0655-482e-384d-e75230e951cf@quicinc.com>
Date:   Tue, 1 Nov 2022 10:44:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 09/21] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-10-quic_eberman@quicinc.com>
 <20221027135510.GA29032@hu-pkondeti-hyd.qualcomm.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20221027135510.GA29032@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EHivaGWcRaFEzMH7s9WypfDwZzoI3CQe
X-Proofpoint-ORIG-GUID: EHivaGWcRaFEzMH7s9WypfDwZzoI3CQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_08,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=555
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/2022 6:55 AM, Pavan Kondeti wrote:
> Hi Elliot,
> 
> On Wed, Oct 26, 2022 at 11:58:34AM -0700, Elliot Berman wrote:
>> Gunyah message queues are a unidirectional inter-VM pipe for messages up
>> to 1024 bytes. This driver supports pairing a receiver message queue and
>> a transmitter message queue to expose a single mailbox channel.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> <snip>
> 
>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>> +{
>> +	struct gh_msgq *msgq = data;
>> +
>> +	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void gh_msgq_txdone_tasklet(unsigned long data)
>> +{
>> +	struct gh_msgq *msgq = (struct gh_msgq *)data;
>> +
>> +	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_status);
>> +}
>> +
>> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +	struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
>> +	struct gh_msgq_tx_data *msgq_data = data;
>> +	u64 tx_flags = 0;
>> +	unsigned long ret;
>> +	bool ready;
>> +
>> +	if (msgq_data->push)
>> +		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
>> +
>> +	ret = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length,
>> +					(uintptr_t)msgq_data->data, tx_flags, &ready);
>> +
>> +	/**
>> +	 * unlikely because Linux tracks state of msgq and should not try to
>> +	 * send message when msgq is full.
>> +	 */
>> +	if (unlikely(ret == GH_ERROR_MSGQUEUE_FULL))
>> +		return -EAGAIN;
>> +
>> +	/**
>> +	 * Propagate all other errors to client. If we return error to mailbox
>> +	 * framework, then no other messages can be sent and nobody will know
>> +	 * to retry this message.
>> +	 */
>> +	msgq->last_status = gh_remap_error(ret);
>> +
>> +	/**
>> +	 * This message was successfully sent, but message queue isn't ready to
>> +	 * receive more messages because it's now full. Mailbox framework
>> +	 * requires that we only report that message was transmitted only when
>> +	 * we're ready to transmit another message. We'll get that in the form
>> +	 * of tx IRQ once the other side starts to drain the msgq.
>> +	 */
>> +	if (ret == GH_ERROR_OK && !ready)
>> +		return 0;
>> +
>> +	/**
>> +	 * We can send more messages. Mailbox framework requires that tx done
>> +	 * happens asynchronously to sending the message. Gunyah message queues
>> +	 * tell us right away on the hypercall return whether we can send more
>> +	 * messages. To work around this, defer the txdone to a tasklet.
>> +	 */
>> +	tasklet_schedule(&msgq->txdone_tasklet);
>> +
> 
> Nice comments.
> 
> irq_work would be a better choice.
> 
>> +	return 0;
>> +}
>> +
>> +struct mbox_chan_ops gh_msgq_ops = {
>> +	.send_data = gh_msgq_send_data,
>> +};
>> +
>> +/**
>> + * gh_msgq_init() - Initialize a Gunyah message queue with an mbox_client
>> + * @parent: optional, device parent used for the mailbox controller
>> + * @msgq: Pointer to the gh_msgq to initialize
>> + * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
>> + * @tx_ghrsc: optional, the transmission side of the message queue
>> + * @rx_ghrsc: optional, the receiving side of the message queue
>> + *
>> + * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most message queue use cases come with
>> + * a pair of message queues to facilitiate bidirectional communication. When tx_ghrsc is set,
>> + * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
>> + * is set, the mbox_client should register an .rx_callback() and the message queue driver will
>> + * push all available messages upon receiving the RX ready interrupt. The messages should be
>> + * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
>> + * after the callback.
>> + *
>> + * Returns - 0 on success, negative otherwise
>> + */
>> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
>> +		     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc)
>> +{
>> +	int ret;
>> +
>> +	/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
>> +	if ((!tx_ghrsc && !rx_ghrsc) ||
>> +	    (tx_ghrsc && tx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_TX) ||
>> +	    (rx_ghrsc && rx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_RX))
>> +		return -EINVAL;
>> +
>> +	msgq->tx_ghrsc = tx_ghrsc;
>> +	msgq->rx_ghrsc = rx_ghrsc;
>> +
>> +	msgq->mbox.dev = parent;
>> +	msgq->mbox.ops = &gh_msgq_ops;
>> +	msgq->mbox.chans = kcalloc(1, sizeof(*msgq->mbox.chans), GFP_KERNEL);
> 
> Error handling missing.
> 
> minor nit pick:
> 
> If you initialize num_chans to 1 before, then you can use that as the first
> argument to kcalloc() which makes it more readable since you opted for kcalloc()
> instead of kzalloc() there.
> 
>> +	msgq->mbox.num_chans = 1;
>> +	msgq->mbox.txdone_irq = true;
>> +
>> +	if (gh_msgq_has_tx(msgq)) {
>> +		ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
>> +				msgq);
>> +		if (ret)
>> +			goto err_chans;
>> +	}
>> +
>> +	if (gh_msgq_has_rx(msgq)) {
>> +		ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, gh_msgq_rx_irq_handler,
>> +						IRQF_ONESHOT, "gh_msgq_rx", msgq);
>> +		if (ret)
>> +			goto err_tx_irq;
>> +	}
>> +
>> +	tasklet_init(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet, (unsigned long)msgq);
> 
> If you wish to use tasklets, use tasklet_setup().
> 
>> +
>> +	ret = mbox_controller_register(&msgq->mbox);
>> +	if (ret)
>> +		goto err_rx_irq;
>> +
>> +	ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
>> +	if (ret)
>> +		goto err_mbox;
>> +
>> +	return 0;
>> +err_mbox:
>> +	mbox_controller_unregister(&msgq->mbox);
>> +err_rx_irq:
>> +	if (gh_msgq_has_rx(msgq))
>> +		free_irq(msgq->rx_ghrsc->irq, msgq);
>> +err_tx_irq:
>> +	if (gh_msgq_has_tx(msgq))
>> +		free_irq(msgq->tx_ghrsc->irq, msgq);
>> +err_chans:
>> +	kfree(msgq->mbox.chans);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_msgq_init);
>> +
>> +void gh_msgq_remove(struct gh_msgq *msgq)
>> +{
>> +	if (gh_msgq_has_rx(msgq))
>> +		free_irq(msgq->rx_ghrsc->irq, msgq);
>> +
>> +	if (gh_msgq_has_tx(msgq))
>> +		free_irq(msgq->tx_ghrsc->irq, msgq);
>> +
>> +	kfree(msgq->mbox.chans);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_msgq_remove);
>> +
> 
> Is gh_msgq_remove() supposed to undo every thing done in gh_msgq_init()?
> ex: mbox controller and channel are not unregistered.
> 

Ah thanks for catching, updated this as well as rest of your comments.
