Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE46C08EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCTCil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTCij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:38:39 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6E59EC;
        Sun, 19 Mar 2023 19:38:37 -0700 (PDT)
Received: from [172.16.12.33] (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id E84A1680467;
        Mon, 20 Mar 2023 10:38:34 +0800 (CST)
Message-ID: <867179bc-a21f-5479-f27f-2e17fc5a9a01@rock-chips.com>
Date:   Mon, 20 Mar 2023 10:38:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] usb: typec: tcpm: fix source caps may lost after soft
 reset
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-5-frank.wang@rock-chips.com>
 <f5650fa4-db16-b1e4-f5b4-917fbcabb415@roeck-us.net>
From:   Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <f5650fa4-db16-b1e4-f5b4-917fbcabb415@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxJGFYfGE8YHx9OGRkYShhVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRg6Qio*PT0PDxIqDA9OCAMd
        PhxPFEpVSlVKTUxCSUxCQkpOQ0pNVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTk1MNwY+
X-HM-Tid: 0a86fce2010b2eb5kusne84a1680467
X-HM-MType: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 2023/3/17 20:58, Guenter Roeck wrote:
> On 3/12/23 19:58, Frank Wang wrote:
>> Invoke set_pd_rx() may flush the RX FIFO of PD controller, so do
>> set_pd_rx() before sending Soft Reset in case Source caps may be flushed
>> at debounce time between SOFT_RESET_SEND and SNK_WAIT_CAPABILITIES 
>> state.
>>
>
> Isn't that a problem of the fusb302 driver that it flushes its buffers
> unconditionally when its set_pd_rx() callback is called ?
>
> Guenter
>

The story goes like this,  the fusb302 notified SOFT_RESET completion to 
TCPM and began to receive the Source Caps automatically,
TCPM got completion from fusb302 and changed state to 
SNK_WAIT_CAPABILITIES and invoked set_pd_rx() callback. However, the
fusb302 or TCPM's worker may be not scheduled in time, set_pd_rx() would 
be performed after the Source Caps packets had received
into fusb302's FIFO, even after the GoodCRC (Source Caps) had be replied.

So make forward set_pd_rx() process before PD_CTRL_SOFT_RESET sent at 
SOFT_RESET_SEND state can cleanup the context in our side
and ensure the right PD commucation. I am not sure whether it is sensible?

BR.
Frank

>> Without this patch, in PD charger stress test, the FUSB302 driver may
>> occur the following exceptions in power negotiation stage.
>>
>> [ ...]
>> [ 4.512252] fusb302_irq_intn
>> [ 4.512260] AMS SOFT_RESET_AMS finished
>> [ 4.512269] state change SOFT_RESET_SEND ->SNK_WAIT_CAPABILITIES 
>> [rev3 NONE_AMS]
>> [ 4.514511] pd := on
>> [ 4.514516] pending state change SNK_WAIT_CAPABILITIES 
>> ->HARD_RESET_SEND @ 310 ms [rev3 NONE_AMS]
>> [ 4.515428] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
>> [ 4.515431] IRQ: BC_LVL, handler pending
>> [ 4.515435] IRQ: PD sent good CRC
>> [ 4.516434] PD message header: 0
>> [ 4.516437] PD message len: 0
>> [ 4.516444] PD RX, header: 0x0 [1]
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c 
>> b/drivers/usb/typec/tcpm/tcpm.c
>> index 9e583060e64fc..ba6bf71838eed 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -4321,10 +4321,12 @@ static void run_state_machine(struct 
>> tcpm_port *port)
>>           tcpm_set_state(port, unattached_state(port), 0);
>>           break;
>>       case SNK_WAIT_CAPABILITIES:
>> -        ret = port->tcpc->set_pd_rx(port->tcpc, true);
>> -        if (ret < 0) {
>> -            tcpm_set_state(port, SNK_READY, 0);
>> -            break;
>> +        if (port->prev_state != SOFT_RESET_SEND) {
>> +            ret = port->tcpc->set_pd_rx(port->tcpc, true);
>> +            if (ret < 0) {
>> +                tcpm_set_state(port, SNK_READY, 0);
>> +                break;
>> +            }
>>           }
>>           /*
>>            * If VBUS has never been low, and we time out waiting
>> @@ -4603,6 +4605,7 @@ static void run_state_machine(struct tcpm_port 
>> *port)
>>       case SOFT_RESET_SEND:
>>           port->message_id = 0;
>>           port->rx_msgid = -1;
>> +        port->tcpc->set_pd_rx(port->tcpc, true);
>>           if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
>>               tcpm_set_state_cond(port, hard_reset_state(port), 0);
>>           else
>
