Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0760DB05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiJZGOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiJZGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:14:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B3B8788;
        Tue, 25 Oct 2022 23:14:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29Q6Dfh1112657;
        Wed, 26 Oct 2022 01:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666764821;
        bh=muYLAl87MpFKBWjWXoppAR+Krltf1/A+GYyPpKJuEPI=;
        h=Date:To:CC:References:From:Subject:In-Reply-To;
        b=yZf6aXD4PMrSIYbkCUNao3VAYgkm4djFF8S8b7pioJeBr/Z9HY33Il5FjcnrzC4PF
         0qdFFKBxxtF3kvkRUs85DJJUQmginvMgIDSU7qwhCLp3Y2XpXOYOrrXWinJd5ZvzlU
         o5weyH5bKtdC+36B3mmA+XyHXzmYsunRGPneXx0E=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29Q6Dfah031498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Oct 2022 01:13:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 26
 Oct 2022 01:13:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 26 Oct 2022 01:13:41 -0500
Received: from [10.250.234.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29Q6DaRi009046;
        Wed, 26 Oct 2022 01:13:37 -0500
Message-ID: <93932c6b-4be1-3c3c-2cef-e97fe9415745@ti.com>
Date:   Wed, 26 Oct 2022 11:43:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        <linux-omap@vger.kernel.org>
References: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com>
 <ea90b0ba-61bf-e56e-5120-9771122838cf@linux.intel.com>
 <Y00bmec4hvWxtnB5@linutronix.de>
 <c91216ec-c7e7-df7b-463-ec17c76b7bc2@linux.intel.com>
 <Y1YigD1lEWRbT8eH@atomide.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250_omap: remove wait loop from Errata i202
 workaround
In-Reply-To: <Y1YigD1lEWRbT8eH@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/22 10:58 am, Tony Lindgren wrote:
> Hi,
> 
> Adding Nishanth to Cc also.
> 
> * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221017 12:06]:
>> On Mon, 17 Oct 2022, Sebastian Andrzej Siewior wrote:
>>
>>> On 2022-10-17 11:12:41 [+0300], Ilpo Järvinen wrote:
>>>> On Thu, 13 Oct 2022, Matthias Schiffer wrote:
>>>>
>>>>> We were occasionally seeing the "Errata i202: timedout" on an AM335x
>>>>> board when repeatedly opening and closing a UART connected to an active
>>>>> sender. As new input may arrive at any time, it is possible to miss the
>>>>> "RX FIFO empty" condition, forcing the loop to wait until it times out.
>>>>
>>>> I can see this problem could occur and why your patch fixes it.
>>>>
>>>>> Nothing in the i202 Advisory states that such a wait is even necessary;
>>>>> other FIFO clear functions like serial8250_clear_fifos() do not wait
>>>>> either. For this reason, it seems safe to remove the wait, fixing the
>>>>> mentioned issue.
>>>>
>>>> Checking the commit that added this driver and the loop along with it, 
>>>> there was no information why it would be needed there either.
>>>
>>> I don't remember all the details but I do remember that I never hit it.
>>> The idea back then was to document what appears the problem and then
>>> once there is a reproducer address it _or_ when there is another problem
>>> check if it aligns with the output here (so that _this_ problem's origin
>>> could be this). This was part of address all known chip erratas and
>>> copied from omap-serial at the time so that the 8250 does not miss
>>> anything.
>>> Looking closer, this is still part of the omap-serial driver and it was
>>> introduced in commit
>>>    0003450964357 ("omap2/3/4: serial: errata i202: fix for MDR1 access")
>>
>> I found that one too but it doesn't give any explanation for it either.
>> In fact, the wait for empty is mysteriously missing from the itemized
>> description of the workaround in the commit message.
>>
>>> If someone found a way to trigger this output which is unrelated to the
>>> expected cause then this is clearly not helping nor intended.
>>>
>>> I would prefer to keep the loop and replace the disturbing output with a
>>> comment describing _why_ the FIFO might remain non-empty after a flush.
>>>
>>> In worst cases that loop causes a delay of less than 0.5ms while setting
>>> a baud rate so I doubt that this is causing a real problem.
> 
> This sounds like a safe solution for me if it's needed.
> 
>>> Either way I would like to see Tony's ACK before this is getting removed
>>> as suggested in this patch.
>>
>> Thanks for chimming in.
>>
>> I went to do some lore searching and came across this thread (it should 
>> be added with Link: tag the patch regardless of its final form):
>>   https://lore.kernel.org/linux-omap/4BBF61FE.3060807@ti.com/
> 
> Nishanth, do you have any more info on checking for fifo empty here?
> 

At least TRMs of newer SoCs such as AM654 [0] have following note:

NOTE : Bits UART_FCR[2] TX_FIFO_CLEAR and UART_FCR[1] RX_FIFO_CLEAR are

automatically cleared by hardware after 4 × UARTi_ICLK + 5 × UARTi_FCLK
clock cycles.

This delay is needed to finish the resetting of the corresponding FIFO
and DMA control
 registers.

I guess we can drop FIFO empty check and instead add above delay
required for FIFOs to be reset.

[0] https://www.ti.com/lit/pdf/spruid7e 12.1.5.4.6 UART FIFO Management


Regards
Vignesh
