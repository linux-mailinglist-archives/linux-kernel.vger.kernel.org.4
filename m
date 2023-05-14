Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C53701CEF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjENLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjENLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:01:22 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE61FE4;
        Sun, 14 May 2023 04:01:17 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Sun, 14 May 2023 13:01:10 +0200
MIME-Version: 1.0
Date:   Sun, 14 May 2023 13:01:10 +0200
From:   m.brock@vanmierlo.com
To:     "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>, manion05gk@gmail.com
Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
In-Reply-To: <DM4PR12MB61098014775DE9950A0E2E588C779@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <6b72c56e79a44fec348de26d14d9dce0@vanmierlo.com>
 <DM4PR12MB61098014775DE9950A0E2E588C779@DM4PR12MB6109.namprd12.prod.outlook.com>
Message-ID: <309c98bbe25b8493ac35c8da97f9bff1@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guntupalli, Manikanta schreef op 2023-05-10 18:26:
> Hi Maarten,
> 
>> -----Original Message-----
>> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
>> Sent: Thursday, May 4, 2023 5:52 PM
>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
>> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com; linux-
>> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; jirislaby@kernel.org; linux-arm-
>> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; git
>> (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
>> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
>> manion05gk@gmail.com
>> Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
>> 
>> Manikanta Guntupalli wrote 2023-04-26 14:29:
>> > Add optional gpio property to uartps node to support rs485 Add rs485
>> > support to uartps driver
>> >
>> > Manikanta Guntupalli (2):
>> >   dt-bindings: Add optional gpio property to uartps node to support
>> >     rs485
>> >   tty: serial: uartps: Add rs485 support to uartps driver
>> >
>> >  .../devicetree/bindings/serial/cdns,uart.yaml |  5 +
>> >  drivers/tty/serial/xilinx_uartps.c            | 96 ++++++++++++++++++-
>> >  2 files changed, 100 insertions(+), 1 deletion(-)
>> 
>> Why would you want to use a GPIO and not RTS for choosing the 
>> direction as
>> is more common in this case?
> In ZynqMp platform Cadence UART Controller RTS signal routed to
> external through the PL(Programmable Logic) design not through
> Multiplexed IO.

Then why not route RXD & TXD to the PL as well and connect the module to 
a
PMOD connector connected to the PL? But I admit that a GPIO always works 
as
well.

>> And have you thought about configuring the polarity?
> GPIO polarity configured through device tree property.
> 
> &uart0 {
>         ...
>         txrx-gpios = <&gpio 72 GPIO_ACTIVE_LOW>;
>         linux,rs485-enabled-at-boot-time;
> };

Useable, but not honoring 
SER_RS485_RTS_ON_SEND/SER_RS485_RTS_AFTER_SEND.

>> How long will the signal be active before the real transmission begins 
>> so the
>> driver can settle?
> Default is RE(GPIO LOW) and while sending we drive the pin to HIGH. We
> wait for transmission completion, for that we check Transmitter state
> machine active status to ZERO and TX FIFO EMPTY.

How does that take delay_rts_before_send/delay_rts_after_send into 
account?
Not every driver switches direction as fast as you would like.

> Thanks,
> Manikanta.

Greetings,
Maarten

