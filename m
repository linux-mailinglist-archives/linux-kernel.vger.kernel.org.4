Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A588B6A139B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBWXPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:15:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B58E30192;
        Thu, 23 Feb 2023 15:15:43 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NB48uY028287;
        Thu, 23 Feb 2023 23:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YFpzNH2DWYuvlrJNGKab5CeLAQNnqBmpWX5xvsyjYN4=;
 b=F/+jA20ag0QaU1Au9LUXGtexqxxSyfnZg96uPQIoZlaQMcqUpCQyEbqRZuw3axpbOXJV
 YlO+Y1c1O40/uz+2gnWpCc6CL42cYpGMKQYwqL0j5tkD/sShN6IgdRaDXqN7XET3t4lj
 cnEhvu9ye1GtcB72qjBj5Ht2mlpT20LKBGfNEQE0ELK6lqf8GcnfLEVENMUzHa4eHqnI
 r9KsvS88BL31Uo6J8An4bdz//hxJiz2I3G+mmcPNhVv5Ni3YbTVFz2WbhwWjYpVyOP1S
 3KjYHMIQps/DomsLS4J727EH2P8G1164yu3e55bWjKJxLqkHRmDZRA/PCSMZJXRjD6WY 8Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwymxauyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 23:15:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NNFTCN011459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 23:15:29 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 15:15:28 -0800
Message-ID: <d42cba3e-db22-5241-0ae2-ccec3b811a5a@quicinc.com>
Date:   Thu, 23 Feb 2023 15:15:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
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
 <576aed85-a566-3645-559e-06b2135cf57f@quicinc.com>
 <7e3170e4-c530-0b5b-903f-e5ea6d8268dc@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <7e3170e4-c530-0b5b-903f-e5ea6d8268dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XIMuETsQmJGwm2Lm-JK9jxuW4pWrkFK6
X-Proofpoint-GUID: XIMuETsQmJGwm2Lm-JK9jxuW4pWrkFK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230193
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 2:25 AM, Srinivas Kandagatla wrote:
> 
> 
> On 23/02/2023 00:15, Elliot Berman wrote:
>>
>>
>> On 2/20/2023 5:59 AM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 14/02/2023 21:23, Elliot Berman wrote:
>>>> Gunyah message queues are a unidirectional inter-VM pipe for 
>>>> messages up
>>>> to 1024 bytes. This driver supports pairing a receiver message queue 
>>>> and
>>>> a transmitter message queue to expose a single mailbox channel.
>>>>
>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>> ---
>>>>   Documentation/virt/gunyah/message-queue.rst |   8 +
>>>>   drivers/mailbox/Makefile                   |   2 +
>>>>   drivers/mailbox/gunyah-msgq.c               | 214 
>>>> ++++++++++++++++++++
>>>>   include/linux/gunyah.h                      |  56 +++++
>>>>   4 files changed, 280 insertions(+)
>>>>   create mode 100644 drivers/mailbox/gunyah-msgq.c
>>>>
>>>> diff --git a/Documentation/virt/gunyah/message-queue.rst 
>>>> b/Documentation/virt/gunyah/message-queue.rst
>>>> index 0667b3eb1ff9..082085e981e0 100644
>>>> --- a/Documentation/virt/gunyah/message-queue.rst
>>>> +++ b/Documentation/virt/gunyah/message-queue.rst
>>>> @@ -59,3 +59,11 @@ vIRQ: two TX message queues will have two vIRQs 
>>>> (and two capability IDs).
>>>>         |               |         |                 | |               |
>>>>         |               |         |                 | |               |
>>>>         +---------------+         +-----------------+ +---------------+
>>>> +
>>>> +Gunyah message queues are exposed as mailboxes. To create the 
>>>> mailbox, create
>>>> +a mbox_client and call `gh_msgq_init`. On receipt of the RX_READY 
>>>> interrupt,
>>>> +all messages in the RX message queue are read and pushed via the 
>>>> `rx_callback`
>>>> +of the registered mbox_client.
>>>> +
>>>> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
>>>> +   :identifiers: gh_msgq_init
>>>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>>>> index fc9376117111..5f929bb55e9a 100644
>>>> --- a/drivers/mailbox/Makefile
>>>> +++ b/drivers/mailbox/Makefile
>>>> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)    += mtk-cmdq-mailbox.o
>>>>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)    += zynqmp-ipi-mailbox.o
>>>> +obj-$(CONFIG_GUNYAH)        += gunyah-msgq.o
>>>
>>> Why are we reusing CONFIG_GUNYAH Kconfig symbol for mailbox, why not 
>>> CONFIG_GUNYAH_MBOX?
>>>
>>
>> There was some previous discussion about this:
>>
>> https://lore.kernel.org/all/2a7bb5f2-1286-b661-659a-a5037150eae8@quicinc.com/
>>
>>>> +
>>>>   obj-$(CONFIG_SUN6I_MSGBOX)    += sun6i-msgbox.o
>>>>   obj-$(CONFIG_SPRD_MBOX)       += sprd-mailbox.o
>>>> diff --git a/drivers/mailbox/gunyah-msgq.c 
>>>> b/drivers/mailbox/gunyah-msgq.c
>>>> new file mode 100644
>>>> index 000000000000..03ffaa30ce9b
>>>> --- /dev/null
>>>> +++ b/drivers/mailbox/gunyah-msgq.c
>>>> @@ -0,0 +1,214 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>> rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/mailbox_controller.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/gunyah.h>
>>>> +#include <linux/printk.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/wait.h>
>>>
>>> ...
>>>
>>>> +/* Fired when message queue transitions from "full" to "space 
>>>> available" to send messages */
>>>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>>>> +{
>>>> +    struct gh_msgq *msgq = data;
>>>> +
>>>> +    mbox_chan_txdone(gh_msgq_chan(msgq), 0);
>>>> +
>>>> +    return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +/* Fired after sending message and hypercall told us there was more 
>>>> space available. */
>>>> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
>>>
>>> Tasklets have been long deprecated, consider using workqueues in this 
>>> particular case.
>>>
>>
>> Workqueues have higher latency and tasklets came as recommendation 
>> from Jassi. drivers/mailbox/imx-mailbox.c uses tasklets in the same way.
>>
>> I did some quick unscientific measurements of ~1000x samples. The 
>> median latency for resource manager went from 25.5 us (tasklet) to 26 
>> us (workqueue) (2% slower). The mean went from 28.7 us to 32.5 us (13% 
>> slower). Obviously, the outliers for workqueues were much more extreme.
> 
> TBH, this is expected because we are only testing resource manager, Note 
>   the advantage that you will see shifting from tasket to workqueues is 
> on overall system latencies and some drivers performance that need to 
> react to events.
> 
> please take some time to read this nice article about this 
> https://lwn.net/Articles/830964/
> 

Hmm, this article is from 2020 and there was another effort in 2007. 
Neither seems to have succeeded. I'd like to stick to same mechanisms as 
other mailbox controllers.

Jassi, do you have any preferences?

Thanks,
Elliot


