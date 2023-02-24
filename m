Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7C6A23FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBXV5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBXV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:57:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F86DDA9;
        Fri, 24 Feb 2023 13:57:20 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OLJ1AF016297;
        Fri, 24 Feb 2023 21:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YUw/L9gsrEr5RcEvUFQnRKftnsC+eLWLBE1DlB1Htv4=;
 b=moCcAUi2P86wvsHNvRfaUS5nzGZ3eNS8bEpoVIxkV9+eBwHPzFcb3PXh0O7e0lUXcG9j
 VRojRlfAbK6DmmwBEIbxjf1oCX22aRHLOb+eo2Fu8e/IJZx5DKYi/ILi7pDYQK8/H+Vo
 obC/WufvO8UfJRP4S1SE/zskfyZxrDBaYWVaYCaAeMnuLQ2Joip+kwccZPOpStM01YuY
 VmEt4HdS8LI6yCgDXlylkg4QCNQdEEqu8pKTVrlt1v9xOM4RbAnIgoPJyZTyJcbLtyML
 e1GjDSpFFu7VwBS+aSzwiTfkubNxGZncfIaCW7njCpb4UE/silke7qP3tkN9irlFkDtm 8g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxw3d9n3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:57:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OLv4wT003203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 21:57:04 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 13:57:02 -0800
Message-ID: <a75480bf-4710-d833-8f3a-708f0cd6706e@quicinc.com>
Date:   Fri, 24 Feb 2023 13:57:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212316.3309053-1-quic_eberman@quicinc.com>
 <10343ac1-8350-5fc0-b358-8a1b7280afcc@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <10343ac1-8350-5fc0-b358-8a1b7280afcc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qxgLbwKr4Mxp9UJY3uso8wRyxXbh5eXc
X-Proofpoint-ORIG-GUID: qxgLbwKr4Mxp9UJY3uso8wRyxXbh5eXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=616 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240175
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 1:11 PM, Alex Elder wrote:
> On 2/14/23 3:23 PM, Elliot Berman wrote:
>> Gunyah message queues are a unidirectional inter-VM pipe for messages up
>> to 1024 bytes. This driver supports pairing a receiver message queue and
>> a transmitter message queue to expose a single mailbox channel.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/virt/gunyah/message-queue.rst |   8 +
>>   drivers/mailbox/Makefile                    |   2 +
>>   drivers/mailbox/gunyah-msgq.c               | 214 ++++++++++++++++++++
>>   include/linux/gunyah.h                      |  56 +++++
>>   4 files changed, 280 insertions(+)
>>   create mode 100644 drivers/mailbox/gunyah-msgq.c
>>
>> diff --git a/Documentation/virt/gunyah/message-queue.rst 
>> b/Documentation/virt/gunyah/message-queue.rst
>> index 0667b3eb1ff9..082085e981e0 100644
>> --- a/Documentation/virt/gunyah/message-queue.rst
>> +++ b/Documentation/virt/gunyah/message-queue.rst
>> @@ -59,3 +59,11 @@ vIRQ: two TX message queues will have two vIRQs 
>> (and two capability IDs).
>>         |               |         |                 |         
>> |               |
>>         |               |         |                 |         
>> |               |
>>         +---------------+         +-----------------+         
>> +---------------+
>> +
>> +Gunyah message queues are exposed as mailboxes. To create the 
>> mailbox, create
>> +a mbox_client and call `gh_msgq_init`. On receipt of the RX_READY 
>> interrupt,
>> +all messages in the RX message queue are read and pushed via the 
>> `rx_callback`
>> +of the registered mbox_client.
>> +
>> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
>> +   :identifiers: gh_msgq_init
>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>> index fc9376117111..5f929bb55e9a 100644
>> --- a/drivers/mailbox/Makefile
>> +++ b/drivers/mailbox/Makefile
>> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)    += mtk-cmdq-mailbox.o
>>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)    += zynqmp-ipi-mailbox.o
>> +obj-$(CONFIG_GUNYAH)        += gunyah-msgq.o
>> +
>>   obj-$(CONFIG_SUN6I_MSGBOX)    += sun6i-msgbox.o
>>   obj-$(CONFIG_SPRD_MBOX)        += sprd-mailbox.o
>> diff --git a/drivers/mailbox/gunyah-msgq.c 
>> b/drivers/mailbox/gunyah-msgq.c
>> new file mode 100644
>> index 000000000000..03ffaa30ce9b
>> --- /dev/null
>> +++ b/drivers/mailbox/gunyah-msgq.c
> 
> You use a dash in this source file name, but an underscore
> everywhere else.  Unless there's a good reason to do this,
> please be consistent (use "gunyah_msgq.c").
> 
>> @@ -0,0 +1,214 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/gunyah.h>
>> +#include <linux/printk.h>
>> +#include <linux/init.h>
>> +#include <linux/slab.h>
>> +#include <linux/wait.h>
>> +
>> +#define mbox_chan_to_msgq(chan) (container_of(chan->mbox, struct 
>> gh_msgq, mbox))
>> +
>> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
>> +{
>> +    struct gh_msgq *msgq = data;
>> +    struct gh_msgq_rx_data rx_data;
>> +    enum gh_error err;
>> +    bool ready = true;
>> +
>> +    while (ready) {
>> +        err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
>> +                (uintptr_t)&rx_data.data, sizeof(rx_data.data),
>> +                &rx_data.length, &ready);
>> +        if (err != GH_ERROR_OK) {
>> +            if (err != GH_ERROR_MSGQUEUE_EMPTY)
> 
> Srini mentioned something about this too.  In many
> (all?) cases, there is a device pointer available,
> so you should use dev_*() functions rather than pr_*().
> 
> In this particular case, I'm not sure why/when the
> mbox.dev pointer would be null.  Also, dev_*() handles
> the case of a null device pointer, and it reports the
> device name (just as you do here).
> 
>> +                pr_warn("Failed to receive data from msgq for %s: %d\n",
>> +                    msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", 
>> err);
>> +            break;
>> +        }
>> +        mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
>> +    }
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +/* Fired when message queue transitions from "full" to "space 
>> available" to send messages */
>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>> +{
>> +    struct gh_msgq *msgq = data;
>> +
>> +    mbox_chan_txdone(gh_msgq_chan(msgq), 0);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +/* Fired after sending message and hypercall told us there was more 
>> space available. */
>> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
>> +{
>> +    struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, 
>> txdone_tasklet);
>> +
>> +    mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
>> +}
>> +
>> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +    struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
>> +    struct gh_msgq_tx_data *msgq_data = data;
>> +    u64 tx_flags = 0;
>> +    enum gh_error gh_error;
> 
> Above you named the variable "err".  It helps readability
> if you use a very consistent naming convention for variables
> of a certain type when they are used a lot.
> 
>> +    bool ready;
>> +
>> +    if (msgq_data->push)
>> +        tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
>> +
>> +    gh_error = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, 
>> msgq_data->length,
>> +                    (uintptr_t)msgq_data->data, tx_flags, &ready);
>> +
>> +    /**
>> +     * unlikely because Linux tracks state of msgq and should not try to
>> +     * send message when msgq is full.
>> +     */
>> +    if (unlikely(gh_error == GH_ERROR_MSGQUEUE_FULL))
>> +        return -EAGAIN;
>> +
>> +    /**
>> +     * Propagate all other errors to client. If we return error to 
>> mailbox
>> +     * framework, then no other messages can be sent and nobody will 
>> know
>> +     * to retry this message.
>> +     */
>> +    msgq->last_ret = gh_remap_error(gh_error);
>> +
>> +    /**
>> +     * This message was successfully sent, but message queue isn't 
>> ready to
>> +     * receive more messages because it's now full. Mailbox framework
> 
> Maybe:  s/receive/accept/
> 
>> +     * requires that we only report that message was transmitted when
>> +     * we're ready to transmit another message. We'll get that in the 
>> form
>> +     * of tx IRQ once the other side starts to drain the msgq.
>> +     */
>> +    if (gh_error == GH_ERROR_OK && !ready)
>> +        return 0;
>> +
>> +    /**
>> +     * We can send more messages. Mailbox framework requires that tx 
>> done
>> +     * happens asynchronously to sending the message. Gunyah message 
>> queues
>> +     * tell us right away on the hypercall return whether we can send 
>> more
>> +     * messages. To work around this, defer the txdone to a tasklet.
>> +     */
>> +    tasklet_schedule(&msgq->txdone_tasklet);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct mbox_chan_ops gh_msgq_ops = {
>> +    .send_data = gh_msgq_send_data,
>> +};
>> +
>> +/**
>> + * gh_msgq_init() - Initialize a Gunyah message queue with an 
>> mbox_client
>> + * @parent: optional, device parent used for the mailbox controller
>> + * @msgq: Pointer to the gh_msgq to initialize
>> + * @cl: A mailbox client to bind to the mailbox channel that the 
>> message queue creates
>> + * @tx_ghrsc: optional, the transmission side of the message queue
>> + * @rx_ghrsc: optional, the receiving side of the message queue
>> + *
>> + * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most 
>> message queue use cases come with
> 
> s/should be/must be/
> 
>> + * a pair of message queues to facilitate bidirectional 
>> communication. When tx_ghrsc is set,
>> + * the client can send messages with 
>> mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
>> + * is set, the mbox_client should register an .rx_callback() and the 
>> message queue driver will
> 
> s/should register/must register/
> 
> A general comment on this code is that you sort of half define
> a Gunyah message queue API.  You define an initialization
> function and an exit function, but you also expose the fact
> that you use the mailbox framework in implementation.  This
> despite avoiding defining it as an mbox in the DTS file.
> 
> It might be hard to avoid that I guess.  But to me it would be
> nice if there were a more distinct Gunyah message queue API,
> which would provide a send_message() function, for example.
> And in that case, perhaps you would pass in the tx_done and/or
> rx_data callbacks to this function (since they're required).

I can write a wrapper for send_message, but I think it limits the code 
re-use of mailbox framework.

> 
> All that said, this is (currently?) only used by the resource
> manager, so making a beautiful API might not be that important.
> Do you envision this being used to communicate with other VMs
> in the future?
> 
>> + * push all available messages upon receiving the RX ready interrupt. 
>> The messages should be
> 
> Maybe: s/push/deliver/
> 
>> + * consumed or copied by the client right away as the gh_msgq_rx_data 
>> will be replaced/destroyed
>> + * after the callback.
>> + *
>> + * Returns - 0 on success, negative otherwise
>> + */
>> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct 
>> mbox_client *cl,
>> +             struct gunyah_resource *tx_ghrsc, struct gunyah_resource 
>> *rx_ghrsc)
>> +{
>> +    int ret;
>> +
>> +    /* Must have at least a tx_ghrsc or rx_ghrsc and that they are 
>> the right device types */
>> +    if ((!tx_ghrsc && !rx_ghrsc) ||
>> +        (tx_ghrsc && tx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_TX) ||
>> +        (rx_ghrsc && rx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_RX))
>> +        return -EINVAL;
>> +
>> +    if (gh_api_version() != GUNYAH_API_V1) {
>> +        pr_err("Unrecognized gunyah version: %u. Currently supported: 
>> %d\n",
>> +            gh_api_version(), GUNYAH_API_V1);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (!gh_api_has_feature(GH_API_FEATURE_MSGQUEUE))
>> +        return -EOPNOTSUPP;
> 
> Can Gunyah even function if it doesn't have the MSGQUEUE feature?
> Will there ever be a Gunyah implementation that does not support
> it?  Perhaps this test could be done in gunyah_init() instead.

I don't think we will ever have a Gunyah implementation that doesn't 
support message queues. Perhaps some long distant Gunyah will use IPC 
mechanism X instead of message queues and the message queue support is 
dropped.

> 
> For that matter, you could verify the result of gh_api_version()
> at that time also.
> 

Moved the gh_api_version() check to gunyah_init()

>> +
>> +    msgq->tx_ghrsc = tx_ghrsc;
>> +    msgq->rx_ghrsc = rx_ghrsc;
>> +
>> +    msgq->mbox.dev = parent;
>> +    msgq->mbox.ops = &gh_msgq_ops;
>> +    msgq->mbox.num_chans = 1;
>> +    msgq->mbox.txdone_irq = true;
>> +    msgq->mbox.chans = kcalloc(msgq->mbox.num_chans, 
>> sizeof(*msgq->mbox.chans), GFP_KERNEL);
> 
>  From what I can tell, you will always use exactly one mailbox channel.
> So you could just do kzalloc(sizeof()...).
> 

If it's all the same, I'd like to keep it as kcalloc because chans is 
expected to be an array with num_chans size. It seems more correct to 
use kcalloc.

>> +    if (!msgq->mbox.chans)
>> +        return -ENOMEM;
>> +
>> +    if (msgq->tx_ghrsc) {
> 
>      if (tx_ghrsc) {
> 
> The irq field is assumed to be valid.  Are there any
> sanity checks you could perform?  Again this is only
> used for the resource manager right now, so maybe
> it's OK.
> 

We should safely assume irq field is valid. If we need to be skeptical 
of irq, we'd also need to be skeptical of capid and there's not validity 
check to perform there. struct gunyah_resource's are either filled from 
DT (in this case) or would be created by resource manager which does 
validity checks.

>> +        ret = request_irq(msgq->tx_ghrsc->irq, 
>> gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
> 
>          ret = request_irq(tx_ghrsc->irq, ...
> 
> 
>> +                msgq);
>> +        if (ret)
>> +            goto err_chans;
>> +    }
>> +
>> +    if (msgq->rx_ghrsc) {
>> +        ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, 
>> gh_msgq_rx_irq_handler,
>> +                        IRQF_ONESHOT, "gh_msgq_rx", msgq);
>> +        if (ret)
>> +            goto err_tx_irq;
>> +    }
>> +
>> +    tasklet_setup(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet);
>> +
>> +    ret = mbox_controller_register(&msgq->mbox);
>> +    if (ret)
>> +        goto err_rx_irq;
>> +
>> +    ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
> 
> 
>> +    if (ret)
>> +        goto err_mbox;
>> +
>> +    return 0;
>> +err_mbox:
>> +    mbox_controller_unregister(&msgq->mbox);
>> +err_rx_irq:
>> +    if (msgq->rx_ghrsc)
>> +        free_irq(msgq->rx_ghrsc->irq, msgq);
>> +err_tx_irq:
>> +    if (msgq->tx_ghrsc)
>> +        free_irq(msgq->tx_ghrsc->irq, msgq);
>> +err_chans:
>> +    kfree(msgq->mbox.chans);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gh_msgq_init);
>> +
>> +void gh_msgq_remove(struct gh_msgq *msgq)
>> +{
> 
> Is there any need to un-bind the client?
> 

I was leaving un-binding the client to the client (RM).

>> +    mbox_controller_unregister(&msgq->mbox);
>> +
>> +    if (msgq->rx_ghrsc)
>> +        free_irq(msgq->rx_ghrsc->irq, msgq);
>> +
>> +    if (msgq->tx_ghrsc)
>> +        free_irq(msgq->tx_ghrsc->irq, msgq);
>> +
>> +    kfree(msgq->mbox.chans);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_msgq_remove);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Message Queue Driver");
>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>> index cb6df4eec5c2..2e13669c6363 100644
>> --- a/include/linux/gunyah.h
>> +++ b/include/linux/gunyah.h
>> @@ -8,11 +8,67 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/errno.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/limits.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/types.h>
>> +/* Follows resource manager's resource types for VM_GET_HYP_RESOURCES */
>> +enum gunyah_resource_type {
>> +    GUNYAH_RESOURCE_TYPE_BELL_TX    = 0,
>> +    GUNYAH_RESOURCE_TYPE_BELL_RX    = 1,
>> +    GUNYAH_RESOURCE_TYPE_MSGQ_TX    = 2,
>> +    GUNYAH_RESOURCE_TYPE_MSGQ_RX    = 3,
>> +    GUNYAH_RESOURCE_TYPE_VCPU    = 4,
> 
> The maximum value here must fit in 8 bits.  I guess
> there's no risk right now of using that up, but you
> use negative values in some cases elsewhere.
> 
>> +};
>> +
>> +struct gunyah_resource {
>> +    enum gunyah_resource_type type;
>> +    u64 capid;
>> +    int irq;
> 
> request_irq() defines the IRQ value to be an unsigned int.
> 

Done.

>> +};
>> +
>> +/**
>> + * Gunyah Message Queues
>> + */
>> +
>> +#define GH_MSGQ_MAX_MSG_SIZE    240
>> +
>> +struct gh_msgq_tx_data {
>> +    size_t length;
>> +    bool push;
>> +    char data[];
>> +};
>> +
>> +struct gh_msgq_rx_data {
>> +    size_t length;
>> +    char data[GH_MSGQ_MAX_MSG_SIZE];
>> +};
>> +
>> +struct gh_msgq {
>> +    struct gunyah_resource *tx_ghrsc;
>> +    struct gunyah_resource *rx_ghrsc;
>> +
>> +    /* msgq private */
>> +    int last_ret; /* Linux error, not GH_STATUS_* */
>> +    struct mbox_controller mbox;
>> +    struct tasklet_struct txdone_tasklet;
> 
> Can the msgq_client be embedded here too?  (I don't really
> know whether msgq and msgq_client are one-to one.)
> 

They are one-to-one. I can embed the struct in the struct gh_msgq and 
drop the kcalloc.

Thanks,
Elliot

>> +};
>> +
>> +
>> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct 
>> mbox_client *cl,
>> +             struct gunyah_resource *tx_ghrsc, struct gunyah_resource 
>> *rx_ghrsc);
>> +void gh_msgq_remove(struct gh_msgq *msgq);
> 
> I suggested:
> 
> int gh_msgq_send(struct gh_msgq, struct gh_msgq_tx_data *data);
> 
>                      -Alex
> 
>> +
>> +static inline struct mbox_chan *gh_msgq_chan(struct gh_msgq *msgq)
>> +{
>> +    return &msgq->mbox.chans[0];
>> +}
>> +
>>   
>> /******************************************************************************/
>>   /* Common arch-independent definitions for Gunyah 
>> hypercalls                  */
>> +
>>   #define GH_CAPID_INVAL    U64_MAX
>>   #define GH_VMID_ROOT_VM    0xff
> 
