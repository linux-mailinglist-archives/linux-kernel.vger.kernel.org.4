Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F378669FFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjBWAPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWAPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:15:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0030934C34;
        Wed, 22 Feb 2023 16:15:35 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MLUZPe015607;
        Thu, 23 Feb 2023 00:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HCL+ctSWpGnB2xaBRX9FLVk33q+txzOX1BjEyAyM2K0=;
 b=Y6V03bqm8Ox+5JXvn6CCmdL61OJKZwt7q48MV7231XVhUB2fTcgUCPLPmB99q3XKp78q
 rZTLKNk8qJQgW9D4suC3OrX4NuSCKR2vVErbh6obdwoCeRwG5D8MqP7eNGpErbFwh5UK
 ttU2z4A/MA5Ceig5hr2GVRc7QT9fap1xpem2HbPNGGeydazceldLvceYGzC9VM4EEb+2
 WLhhvhkqAvPP4UAsrFL2dTVSChNAxCsgQu/tUd4qnEt/esA5M3Y5ORyb3A4xLbvYjtPj
 z4S4jE0yogBQCgGEbNJvTfjJ5yk8EQdPMlLzJzI9rsiCvj6uFmDw3OSUJUe3aHgIBCfm 7A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwn389afs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 00:15:16 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N0FFLA010669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 00:15:15 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 16:15:15 -0800
Message-ID: <576aed85-a566-3645-559e-06b2135cf57f@quicinc.com>
Date:   Wed, 22 Feb 2023 16:15:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
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
 <c8161a4c-fa45-cb9e-7211-5486ece1fc2d@linaro.org>
Content-Language: en-US
In-Reply-To: <c8161a4c-fa45-cb9e-7211-5486ece1fc2d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K53N7I3HpO79FCEwWKk2fCSWW6GikGMq
X-Proofpoint-ORIG-GUID: K53N7I3HpO79FCEwWKk2fCSWW6GikGMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_11,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=883 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230000
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2023 5:59 AM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/2023 21:23, Elliot Berman wrote:
>> Gunyah message queues are a unidirectional inter-VM pipe for messages up
>> to 1024 bytes. This driver supports pairing a receiver message queue and
>> a transmitter message queue to expose a single mailbox channel.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/virt/gunyah/message-queue.rst |   8 +
>>   drivers/mailbox/Makefile                   |   2 +
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
> 
> Why are we reusing CONFIG_GUNYAH Kconfig symbol for mailbox, why not 
> CONFIG_GUNYAH_MBOX?
> 

There was some previous discussion about this:

https://lore.kernel.org/all/2a7bb5f2-1286-b661-659a-a5037150eae8@quicinc.com/

>> +
>>   obj-$(CONFIG_SUN6I_MSGBOX)    += sun6i-msgbox.o
>>   obj-$(CONFIG_SPRD_MBOX)       += sprd-mailbox.o
>> diff --git a/drivers/mailbox/gunyah-msgq.c 
>> b/drivers/mailbox/gunyah-msgq.c
>> new file mode 100644
>> index 000000000000..03ffaa30ce9b
>> --- /dev/null
>> +++ b/drivers/mailbox/gunyah-msgq.c
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
> 
> ...
> 
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
> 
> Tasklets have been long deprecated, consider using workqueues in this 
> particular case.
> 

Workqueues have higher latency and tasklets came as recommendation from 
Jassi. drivers/mailbox/imx-mailbox.c uses tasklets in the same way.

I did some quick unscientific measurements of ~1000x samples. The median 
latency for resource manager went from 25.5 us (tasklet) to 26 us 
(workqueue) (2% slower). The mean went from 28.7 us to 32.5 us (13% 
slower). Obviously, the outliers for workqueues were much more extreme.

> 
>> +{
>> +    struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, 
>> txdone_tasklet);
>> +
>> +    mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
>> +}
>> +
>> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
>> +{
> ..
> 
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
>> +        pr_err("Unrecognized gunyah version: %u. Currently supported: 
>> %d\n",
> dev_err(parent
> 
> would make this more useful
> 

Done.

- Elliot
