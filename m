Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09DA6FE4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEJUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjEJUSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:18:38 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548302D66;
        Wed, 10 May 2023 13:18:35 -0700 (PDT)
Received: (Authenticated sender: jeanmichel.hautbois@yoseli.org)
        by mail.gandi.net (Postfix) with ESMTPSA id F027A40002;
        Wed, 10 May 2023 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
        t=1683749913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNEEyYKpfVOr28cZNeS8TXCo4aaHFV1TNLCNzOagDv0=;
        b=ELECcCHLGPcxNkrpYZYraLgOrjS5PDyS2mL3IFcfqH8hD8Y2tl5JxMtz1yJprviEWoXzKa
        n+pqsU6hefDA94kpbUvx0pl6qhcgOlt7uEc4TjJ6jN4enhcnPhMu/fsgMf7VDbZxL+5JoY
        2T911dXkh87toWnlLMrvqNux1rU6cH33Kt9ieYsAyEKIhRM5wn6gFOThuhxBT7F7kwRvxx
        9qSFu2yq9anRTQRVShjeGHJbm0Ew8yvOzaXJsNXLOJ5Pmc5rmMovr3MJOTSCCOd92gzu0w
        RyKMbCNF3ujSqMWbQBGNbIsWiq0Nhoj6/0PeThL9+M30w43J8wLCObcEJiJa+Q==
Message-ID: <32ecb9f3-1443-210c-0fc9-40891629e25a@yoseli.org>
Date:   Wed, 10 May 2023 22:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: pca953x issue when driving a DSI bridge
Content-Language: en-US
To:     andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
References: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
 <ZFvTi3tQGUq2OCHi@surfacebook>
From:   Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <ZFvTi3tQGUq2OCHi@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/05/2023 19:25, andy.shevchenko@gmail.com wrote:
> Wed, May 10, 2023 at 06:12:19PM +0200, Jean-Michel Hautbois kirjoitti:
>> Hello there !
>>
>> I have a custom board, based on a i.MX8mm SoC which has a MIPI-DSI to eDP
>> bridge (namely, a TI sn65dsi86). This bridge has a DSI enable pin, which is
>> basically its reset pin, connected to my PCA9539 GPIO expander.
>>
>> The issue is that this pin can't be sleeping, and it is tested in the
>> gpiod_set_value() function.
>>
>> Here is where it fails in my dmesg:
> 
> ...
> 
>> [   11.273968]  gpiod_set_value+0x5c/0xcc
>> [   11.277722]  ti_sn65dsi86_resume+0x4c/0x94 [ti_sn65dsi86]
> 
> Your problem even worse, i.e. ->resume() might sleep.

Indeed it is worse ;-).

> 
>> [   11.283131]  __rpm_callback+0x48/0x19c
>> [   11.286885]  rpm_callback+0x6c/0x80
>> [   11.290375]  rpm_resume+0x3b0/0x660
>> [   11.293864]  __pm_runtime_resume+0x4c/0x90
>> [   11.297960]  __device_attach+0x90/0x1e4
>> [   11.301797]  device_initial_probe+0x14/0x20
>> [   11.305980]  bus_probe_device+0x9c/0xa4
>> [   11.309817]  device_add+0x3d8/0x820
>> [   11.313308]  __auxiliary_device_add+0x40/0xa0
>> [   11.317668]  ti_sn65dsi86_add_aux_device.isra.0+0xb0/0xe0 [ti_sn65dsi86]
>> [   11.324381]  ti_sn65dsi86_probe+0x20c/0x2ec [ti_sn65dsi86]
>> [   11.329876]  i2c_device_probe+0x3b8/0x3f0
>> [   11.333889]  really_probe+0xc0/0x3dc
> 
> ...
> 
>> I suppose this is not a corner case and we may have other drivers and other
>> boards connecting a GPIO which can sleep in a context where it should not ?
>>
>> I would like to add one thing: on this board, the expander is routed in a
>> way that makes it impossible to "sleep" as the reset is forced pulled-up and
>> the power regulators are fixed and can't be stopped.
> 
> Can you elaborate why you think there is a problem?

I didn't know if it could be an issue or not, so I mentioned it but 
sounds like a nonsense :-).

> 
>> I don't know how to address this issue nicely and any thoughts is
>> appreciated !
> 
> As a workaround you can consider the code around i2c_in_atomic_xfer_mode()
> but since I have heard about i.MX8 so many negative remarks which makes me
> think that hardware is a train wreck and shouldn't be used at all.
>

Not sure to get the workaround proposal right...
I won't argue about i.MX8 ;-).

Thanks,
JM
