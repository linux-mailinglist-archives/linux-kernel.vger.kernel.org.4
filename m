Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812DF5FE550
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJMWdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJMWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:32:54 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF3118DA8C;
        Thu, 13 Oct 2022 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665700372; x=1697236372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RTXxWrdpwELUsNpFPvvKmLA3EGeoXnl65V4asrrMENg=;
  b=WS/+Bb7/5vCqjyFN2SmWjoLDcijA9FWqKTNj9mh9Ovf4x9eSMMTLowxm
   flQpejBLasBqGR7+IfgaYrIzaV2XUJ6hWibzhaKZ/8gLBhMfKzCLFS0Fl
   ImalCyWM+b9iv+qhVZg97pdSnpXFf9PkQ78sFNnaRir9ElxdERlDO4D4w
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Oct 2022 15:32:51 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 15:32:50 -0700
Received: from [10.110.38.147] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 15:32:49 -0700
Message-ID: <c6c32b15-e32e-4362-00fc-e6710dca2546@quicinc.com>
Date:   Thu, 13 Oct 2022 15:32:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 09/13] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
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
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-10-quic_eberman@quicinc.com>
 <38a62751-799d-67ff-68d8-2946f2308e59@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <38a62751-799d-67ff-68d8-2946f2308e59@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2022 2:47 PM, Dmitry Baryshkov wrote:
> On 11/10/2022 03:08, Elliot Berman wrote:
>> +
>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>> +{
>> +    struct gunyah_msgq *msgq = data;
>> +
>> +    mbox_chan_txdone(gunyah_msgq_chan(msgq), 0);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static void gh_msgq_txdone_tasklet(unsigned long data)
>> +{
>> +    struct gunyah_msgq *msgq = (struct gunyah_msgq *)data;
>> +
>> +    mbox_chan_txdone(gunyah_msgq_chan(msgq), msgq->last_status);
> 
> I don't quite get this. Why do you need both an IRQ and a tasklet?
> 

I've now tweaked the code comments now as well to explain a bit better.

Gunyah tells us in the hypercall itself whether the message queue is 
full. Once the the message queue is full, Gunyah will let us know when 
reader starts draining the queue and we can start adding more messages 
via the tx_irq.

One point to note: the last message to be sent into the message queue 
that makes the queue full can be detected. The hypercall reports that 
the message was sent (GH_ERROR_OK) and the "ready" return value is 
false. In its current form, the msgq mailbox driver should never make a 
send hypercall and get GH_ERROR_MSGQUEUE_FULL because the driver 
properly track when the message queue is full.

When mailbox driver reports txdone, the implication is that more 
messages can be sent (not just that the message was transmitted). In 
typical operation, the msgq mailbox driver can immediately report that 
the message was sent and no tx_irq happens because the hypercall returns 
GH_ERROR_OK and ready=true. The mailbox framework doesn't allow txdone 
directly from the send_data callback. To work around that, Jassi 
recommended we use tasklet [1]. In the "atypical" case where message 
queue becomes full, we get GH_ERROR_OK and ready=false. In that case, we 
don't report txdone right away with the tasklet and instead wait for the 
tx_irq to know when more messages can be sent.

[1]: Tasklet works because send_data is called from mailbox framework 
with interrupts disabled. Once interrupts are re-enabled, the txdone is 
allowed to happen which is also when tasklet runs.

>> +
>> +    /**
>> +     * EAGAIN: message didn't send.
>> +     * ret = 1: message sent, but now the message queue is full and 
>> we can't send any more msgs.
>> +     * Either way, don't report that this message is done.
>> +     */
>> +    if (ret == -EAGAIN || ret == 1)
>> +        return ret;
> 
> '1' doesn't seem to be a valid return code for _send_data.
> 
> Also it would be logical to return any error here, not just -EAGAIN.
> 


If I return error to mailbox framework, then the message is stuck: 
clients don't know that there was some underlying transport failure. It 
would be retried if the client sends another message, but there is no 
guarantee that either retrying later would work (what would have 
changed?) nor that client would send another message to trigger retry. 
If the message is malformed or message queue not correctly set up, 
client would never know. Client should be told that the message wasn't sent.


>> +int gunyah_msgq_init(struct device *parent, struct gunyah_msgq *msgq, 
>> struct mbox_client *cl,
>> +             struct gunyah_resource *tx_ghrsc, struct gunyah_resource 
>> *rx_ghrsc)
> 
> Are the message queues allocated/created dynamically or statically? If 
> the later is true, please use devm_request(_threaded)_irq and devm_kzalloc.
> 

With the exception of resource manager, message queues are created 
dynamically.

P.S. Thanks for all the other suggestions in this and the other patches, 
I've applied them.

Thanks,
Elliot
