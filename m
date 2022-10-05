Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E35F5437
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJEMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJEMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:11:21 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CC2BE3B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:11:17 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 496ED400F8;
        Wed,  5 Oct 2022 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :references:from:from:content-language:subject:subject
        :user-agent:mime-version:date:date:message-id:received:received
        :received:received; s=mta-01; t=1664971874; x=1666786275; bh=Yh1
        4YdeAHF7vpRcVXwa3NG7XiaY7uA/RQXn1y52glug=; b=llVbk7QF9CXGn3akBGB
        BJDj+UOcuGVMMEWSp/YZIRanRVJzsCmkIpdcNyLWRssZD/EvlVrTzlVefJ8Hm6TI
        hvwTfFPIhoKbwY0ugqD6TaLPpA8bbFhiXYHMQTLbbmrmJeG/Thwj+nfgQiy2snAd
        VeP/umMr4D3KYyUznx9f/wbw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EiKQp7DzEdgd; Wed,  5 Oct 2022 15:11:14 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C5E5841221;
        Wed,  5 Oct 2022 15:11:14 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 5 Oct 2022 15:11:14 +0300
Received: from [10.199.21.212] (10.199.21.212) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 5 Oct 2022
 15:11:13 +0300
Message-ID: <418b8bbb-84d0-7293-42cd-8c552e4357eb@yadro.com>
Date:   Wed, 5 Oct 2022 15:11:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] mailbox: Error out early if the mbox driver has
 failed to submit the message
Content-Language: en-US
From:   Evgeny Shatokhin <e.shatokhin@yadro.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Ilya Kuznetsov <ilya@yadro.com>,
        <linux@yadro.com>
References: <20220915164730.515767-1-e.shatokhin@yadro.com>
 <20220915164730.515767-3-e.shatokhin@yadro.com>
 <CABb+yY2Yg1J4WZeB5MKmOONKNsS8468rJmeGkG1TS0Uw71bwYw@mail.gmail.com>
 <8a378429-ab75-0ebc-a852-24c9d3bb9298@yadro.com>
In-Reply-To: <8a378429-ab75-0ebc-a852-24c9d3bb9298@yadro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.21.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.09.2022 19:32, Evgeny Shatokhin wrote:
> Thank you for a quick reply!
> 
> On 16.09.2022 20:04, Jassi Brar wrote:
>> On Thu, Sep 15, 2022 at 11:50 AM Evgenii Shatokhin
>> <e.shatokhin@yadro.com> wrote:
>>>
>>> mbox_send_message() places the pointer to the message to the queue
>>> (add_to_rbuf) then calls msg_submit(chan) to submit the first of the
>>> queued messaged to the mailbox. Some of mailbox drivers can return
>>> errors from their .send_data() callbacks, e.g., if the message is
>>> invalid or there is something wrong with the mailbox device.
>>>
>> The message can't be invalid because the client code is written for a
>> particular provider.
> 
> As of mainline kernel v6.0-rc5, there are mailbox controller drivers 
> which check if the messages are valid in their .send_data() callbacks. 
> Example:
> 
> drivers/mailbox/rockchip-mailbox.c, rockchip_mbox_send_data():
>      if (msg->rx_size > mb->buf_size) {
>          dev_err(mb->mbox.dev, "Transmit size over buf size(%d)\n",
>              mb->buf_size);
>          return -EINVAL;
>      }
> 
> Other examples are zynqmp_ipi_send_data() from 
> drivers/mailbox/zynqmp-ipi-mailbox.c, ti_msgmgr_send_data() from 
> drivers/mailbox/ti-msgmgr.c, etc.
> 
> If this is incorrect and the controller drivers should not do such 
> things, I'd suggest to clearly state it in the docs, because it is far 
> from obvious from Documentation/driver-api/mailbox.rst at the moment.
> 
> That is, one could state that checking if the messages to be transmitted 
> are valid is a responsibility of the callers of mailbox API rather than 
> of the controller driver.
> 
> I could prepare such patch for the docs. Objections?
> 
>>
>> Though it is possible for the mailbox controller to break down for
>> some reason. In that case, the blocking api will keep retrying until
>> successful. 
> 
> As far as I can see from the code, the behaviour seems to be different.
> 
> mbox_send_message() calls msg_submit() to send the message the first 
> time. If that fails, hrtimer is not armed, so there will be no attempts 
> to send the message again till tx_out ms pass:
> 
>      err = chan->mbox->ops->send_data(chan, data);
>      if (!err) {
>          chan->active_req = data;
>          chan->msg_count--;
>      }
> exit:
>      spin_unlock_irqrestore(&chan->lock, flags);
> 
>      if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>          /* kick start the timer immediately to avoid delays */
>          spin_lock_irqsave(&chan->mbox->poll_hrt_lock, flags);
>          hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
>          spin_unlock_irqrestore(&chan->mbox->poll_hrt_lock, flags);
>      }
> 
> This is from msg_submit(). Thus, the hrtimer will not fire, tx_tick() 
> will not be called until tx_out ms have passed, and no attempts to send 
> the message again will be made here.
> 
> In addition, complete(&chan->tx_complete) will not be called, so, 
> mbox_send_message() will have to needlessly wait whole tx_out ms.
> Only after that, it will call tx_tick(chan, -ETIME), which will, in 
> turn, call msg_submit() to try to send the message again. If the mbox 
> has not recovered, sending will fail again.
> 
> Then, mbox_send_message() will exit with -ETIME. The pointer to the 
> message will remain in chan->msg_data[], but the framework will not 
> attempt to send it again until the client calls mbox_send_message() for 
> another, possibly unrelated message.
> 
> In this case, to sum up, mbox_send_message():
> * needlessly waits for tx_out ms;
> * only tries to send the message twice rather than makes retries until 
> successful;
> * does not inform the client about the actual error happened, just 
> returns -ETIME;
> * keeps the pointer to the message in chan->msg_data[], which is too 
> easy to overlook on the client side. Too easy for the client to, say, 
> reuse the structure and cause trouble.
> 
> What I suggest is to leave it to the client (or some other 
> provider-specific code using the client) what to do with the failures.
> 
> If the error is reported by the controller driver, don't wait in 
> mbox_send_message(), just pass the error to the client and exit. If the 
> client decides to ignore the error - OK, its problem. Or - it may kick 
> the mbox device somehow in a provider-specific way to make it work, or - 
> reset the channel, or - do anything else to make things work again.
> 
> The behaviour of mbox_send_message() would then become more consistent: 
> either it has sent the message successfully or it failed and returned an 
> error, without side-effects (like the pointer to that message kept in 
> the internal buffer).
> 
> I do not think this change would break the existing controller drivers 
> and client drivers.
> 
> What do you think?
> 
>> But ideally the client, upon getting -ETIME, should free()
>> and request() the channel reset it (because controller drivers usually
>> don't contain the logic to automatically reset upon some error).
>>
>> thanks.

Any updates on this?
Looking forward to your comments.

Regards,
Evgenii
