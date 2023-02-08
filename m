Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2368F908
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjBHUq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjBHUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:46:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D805E18B24;
        Wed,  8 Feb 2023 12:46:53 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KGhOx026102;
        Wed, 8 Feb 2023 20:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gtevRq5R05dpq27eDHQy4nXcSPGzivauM0owH2HF9Hk=;
 b=YVzbuEMR1qGIgwBVTIhiSD3pviS/Adm7Zr4a/yCwziskysT2fzBTn3XcPdVyxjkSha8w
 42e5+emoxpkl5bcjtiiwndcQNbK20BnYG1Du2H1GpYgP7Iqx6zwrWzDPRS4CcBWvw1+Z
 dCG+Vvbnwl3MnC5Ccbs+ILmurUPT6p8ljUsmDYvM4BZ9TdwTgEhQ3uRQBT24X5I1tDIc
 PyDkXv5JEonXzf7Kk/CtGyTJgqevV+FovioTR6TB/aFwBV7AafarTlVaeVf8UFNQ7QLP
 a4qnf5pu3drrecdZZI1GBe3N9PmZl+lD7k5ZxZSW1fmQEiQkVffhVHtDBuRHMQsqcFbO Kg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmjm681qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:46:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 318KkasL019453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 20:46:36 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 12:46:36 -0800
Message-ID: <bc274d7c-4c69-25a8-7463-de3c36e36ac8@quicinc.com>
Date:   Wed, 8 Feb 2023 12:46:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v9 08/27] mailbox: Add Gunyah message queue mailbox
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-9-quic_eberman@quicinc.com>
 <e5acd00c-7a53-a789-8dab-a69cffda34f5@linaro.org>
Content-Language: en-US
In-Reply-To: <e5acd00c-7a53-a789-8dab-a69cffda34f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EfdVe_XgxIDegBwspnwssRlNrUzPHiGW
X-Proofpoint-ORIG-GUID: EfdVe_XgxIDegBwspnwssRlNrUzPHiGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=635 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080176
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2023 1:59 AM, Srinivas Kandagatla wrote:
> 
> 
> On 20/01/2023 22:46, Elliot Berman wrote:
>> Gunyah message queues are a unidirectional inter-VM pipe for messages up
>> to 1024 bytes. This driver supports pairing a receiver message queue and
>> a transmitter message queue to expose a single mailbox channel.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---

[snip]

>> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
>> +{
>> +    struct gh_msgq *msgq = data;
>> +    struct gh_msgq_rx_data rx_data;
>> +    unsigned long gh_err;
>> +    bool ready = true;
>> +
>> +    while (ready) {
>> +        gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
>> +                (uintptr_t)&rx_data.data, sizeof(rx_data.data),
> you should proabably use  GH_MSGQ_MAX_MSG_SIZE instead of calling sizeof 
> for every loop.
> 
>> +                &rx_data.length, &ready);
>> +        if (gh_err == GH_ERROR_OK) {
>> +            mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
>> +        } else if (gh_err == GH_ERROR_MSGQUEUE_EMPTY) {
>> +            break;
>> +        } else {
>> +            pr_warn("Failed to receive data from msgq for %s: %zd\n",
>> +                msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", gh_err);
>> +            break;
>> +        }
>> +    }
>> +
>> +    return IRQ_HANDLED;
>> +}
> How about making this more readable.
> also use of gh_ in local variables is not really adding any value.
> > while (ready) {
>      err = gh_hypercall_msgq_recv(...);
>      if (err) {
>          if (err != GH_ERROR_MSGQUEUE_EMPTY)
>                      dev_warn(msgq->mbox.dev, "Failedto receive data 
> %zd\n", err);
>                  break;
> 
>                 }
>      mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
> }
> 
> 

Done

>> +
>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>> +{
>> +    struct gh_msgq *msgq = data;
>> +
>> +    mbox_chan_txdone(gh_msgq_chan(msgq), 0);
> What is this irq for? Is it for tx done ack?
> 

This IRQ is asserted when the message queue transitions from "full" to 
"space available". For mailbox framework, it is tx done ack.

>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
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
>> +    unsigned long ret;
>> +    bool ready;
>> +
>> +    if (msgq_data->push)
>> +        tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
>> +
>> +    ret = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, 
>> msgq_data->length,
>> +                    (uintptr_t)msgq_data->data, tx_flags, &ready);
>> +
>> +    /**
>> +     * unlikely because Linux tracks state of msgq and should not try to
>> +     * send message when msgq is full.
>> +     */
>> +    if (unlikely(ret == GH_ERROR_MSGQUEUE_FULL))
>> +        return -EAGAIN;
>> +
>> +    /**
>> +     * Propagate all other errors to client. If we return error to 
>> mailbox
>> +     * framework, then no other messages can be sent and nobody will 
>> know
>> +     * to retry this message.
>> +     */
>> +    msgq->last_ret = gh_remap_error(ret);
>> +
>> +    /**
>> +     * This message was successfully sent, but message queue isn't 
>> ready to
>> +     * receive more messages because it's now full.Mailbox framework
>> +     * requires that we only report that message was transmitted when
>> +     * we're ready to transmit another message. We'll get that in the 
>> form
>> +     * of tx IRQ once the other side starts to drain the msgq.
>> +     */
>> +    if (ret == GH_ERROR_OK && !ready)
>> +        return 0;
>> +
>> +    /**
>> +     * We can send more messages. Mailbox frameworkrequires that tx 
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
>> + * a pair of message queues to facilitate bidirectional 
>> communication. When tx_ghrsc is set,
>> + * the client can send messages with 
>> mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
>> + * is set, the mbox_client should register an .rx_callback() and the 
>> message queue driver will
>> + * push all available messages upon receiving the RX ready interrupt. 
>> The messages should be
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
>> +        pr_warn("Unrecognized gunyahversion: %u. Currently 
>> supported: %d\n",
>> +            gh_api_version(), GUNYAH_API_V1);
> how about using dev_err here?
> 
>> +        return -ENODEV;
> 
> -EOPNOTSUPP?
> 

Done.

>> +    }
>> +
>> +    if (!gh_api_has_feature(GH_API_FEATURE_MSGQUEUE))
>> +        return -EOPNOTSUPP;
>> +
>> +    msgq->tx_ghrsc = tx_ghrsc;
>> +    msgq->rx_ghrsc = rx_ghrsc;
>> +
>> +    msgq->mbox.dev = parent;
>> +    msgq->mbox.ops = &gh_msgq_ops;
>> +    msgq->mbox.num_chans = 1;
>> +    msgq->mbox.chans = kcalloc(msgq->mbox.num_chans, 
>> sizeof(*msgq->mbox.chans), GFP_KERNEL);
>> +    if (!msgq->mbox.chans)
>> +        return -ENOMEM;
> 
> new line here would be nice.
>> +    msgq->mbox.txdone_irq = true;
>> +
>> +    if (msgq->tx_ghrsc) {
>> +        ret = request_irq(msgq->tx_ghrsc->irq, 
>> gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
>> +                msgq);
>> +        if (ret)
>> +            gotoerr_chans;
>> +    }
>> +
>> +    if (msgq->rx_ghrsc) {
>> +        ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, 
>> gh_msgq_rx_irq_handler,
>> +                        IRQF_ONESHOT, "gh_msgq_rx", msgq);
>> +        if (ret)
>> +            gotoerr_tx_irq;
>> +    }
>> +
>> +    tasklet_setup(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet);
> 
> AFAIU, this looks like duplicating what core already has with 
> TXDONE_BY_POLL.
> 
> can we not use
> txdone_poll = true
> and implement last_tx_done callback to use hrtimer from the core to tick 
> tx.
> 

The TXDONE_BY_POLL suits when message queue is immediately ready to 
receive more data. In the other case, we have an interrupt to indicate 
when it can receive more data and the poll doesn't make sense. IMO, the 
IRQ handler should immediately tick the mailbox controller and I don't 
know a way to do that if using TXDONE_BY_POLL -- there isn't an 
interface to reset the timer and mbox_chan_done() only works with 
TXDONE_BY_IRQ.

Thanks,
Elliot
