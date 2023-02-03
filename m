Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DB689900
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBCMqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:46:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988719AFEA;
        Fri,  3 Feb 2023 04:46:35 -0800 (PST)
Received: from [94.107.229.70] (helo=[192.168.31.91]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pNvSb-000198-Uh; Fri, 03 Feb 2023 13:46:33 +0100
Message-ID: <1d2c42f7-5cc9-17a6-dbe6-1c599428831b@leemhuis.info>
Date:   Fri, 3 Feb 2023 13:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Content-Language: en-US, de-DE
To:     Paul Cercueil <paul@crapouillou.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675428395;a4564287;
X-HE-SMSGID: 1pNvSb-000198-Uh
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 01.02.23 14:32, Paul Cercueil wrote:
> Hi Sascha, Greg,
> 
> I have a breakage in 6.2-rc* that I eventually bisected to this commit,
> on a Ingenic SoC (using the jz4740 musb driver) with ECM or RNDIS
> configured through gadgetfs.
> 
> When plugging the board to my PC, the USB network interface is
> recognized, but 'ip link' sees it as 'NO-CARRIER'. With this commit
> reverted on v6.2-rc5, everything works fine.

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 321b59870f850
#regzbot title usb: gadget: USB network interface is recognized, but 'ip
link' sees it as 'NO-CARRIER'
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.	

> Le vendredi 04 novembre 2022 à 14:10 +0100, Sascha Hauer a écrit :
>> The UDC is not a suitable parent of the net device as the UDC can
>> change or vanish during the lifecycle of the ethernet gadget. This
>> can be illustrated with the following:
>>
>> mkdir -p /sys/kernel/config/usb_gadget/mygadget
>> cd /sys/kernel/config/usb_gadget/mygadget
>> mkdir -p configs/c.1/strings/0x409
>> echo "C1:Composite Device" > configs/c.1/strings/0x409/configuration
>> mkdir -p functions/ecm.usb0
>> ln -s functions/ecm.usb0 configs/c.1/
>> echo "dummy_udc.0" > UDC
>> rmmod dummy_hcd
>>
>> The 'rmmod' removes the UDC from the just created gadget, leaving
>> the still existing net device with a no longer existing parent.
>>
>> Accessing the ethernet device with commands like:
>>
>> ip --details link show usb0
>>
>> will result in a KASAN splat:
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in if_nlmsg_size+0x3e8/0x528
>> Read of size 4 at addr c5c84754 by task ip/357
>>
>> CPU: 3 PID: 357 Comm: ip Not tainted 6.1.0-rc3-00013-gd14953726b24-
>> dirty #324
>> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>>  unwind_backtrace from show_stack+0x10/0x14
>>  show_stack from dump_stack_lvl+0x58/0x70
>>  dump_stack_lvl from print_report+0x134/0x4d4
>>  print_report from kasan_report+0x78/0x10c
>>  kasan_report from if_nlmsg_size+0x3e8/0x528
>>  if_nlmsg_size from rtnl_getlink+0x2b4/0x4d0
>>  rtnl_getlink from rtnetlink_rcv_msg+0x1f4/0x674
>>  rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x1f8
>>  netlink_rcv_skb from netlink_unicast+0x294/0x478
>>  netlink_unicast from netlink_sendmsg+0x328/0x640
>>  netlink_sendmsg from ____sys_sendmsg+0x2a4/0x3b4
>>  ____sys_sendmsg from ___sys_sendmsg+0xc8/0x12c
>>  ___sys_sendmsg from sys_sendmsg+0xa0/0x120
>>  sys_sendmsg from ret_fast_syscall+0x0/0x1c
>>
>> Solve this by not setting the parent of the ethernet device.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  drivers/usb/gadget/function/u_ether.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_ether.c
>> b/drivers/usb/gadget/function/u_ether.c
>> index e06022873df16..8f12f3f8f6eeb 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -798,7 +798,6 @@ struct eth_dev *gether_setup_name(struct
>> usb_gadget *g,
>>         net->max_mtu = GETHER_MAX_MTU_SIZE;
>>  
>>         dev->gadget = g;
>> -       SET_NETDEV_DEV(net, &g->dev);
>>         SET_NETDEV_DEVTYPE(net, &gadget_type);
>>  
>>         status = register_netdev(net);
>> @@ -873,8 +872,6 @@ int gether_register_netdev(struct net_device
>> *net)
>>         struct usb_gadget *g;
>>         int status;
>>  
>> -       if (!net->dev.parent)
>> -               return -EINVAL;
>>         dev = netdev_priv(net);
>>         g = dev->gadget;
>>  
>> @@ -905,7 +902,6 @@ void gether_set_gadget(struct net_device *net,
>> struct usb_gadget *g)
>>  
>>         dev = netdev_priv(net);
>>         dev->gadget = g;
>> -       SET_NETDEV_DEV(net, &g->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(gether_set_gadget);
>>  
> 
