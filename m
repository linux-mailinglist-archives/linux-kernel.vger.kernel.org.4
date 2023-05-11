Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC56FF6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjEKQHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbjEKQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:07:40 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88059E4C;
        Thu, 11 May 2023 09:07:37 -0700 (PDT)
Received: (Authenticated sender: jeanmichel.hautbois@yoseli.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 509D96000B;
        Thu, 11 May 2023 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
        t=1683821256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWHlcsTh2DfuTFpi5+twMvyJp529YJ2ZyhT7Dvw4VIY=;
        b=l85rPEYwBOLeXkxSjf0bZVw7iYJpKqu8drno00eASVCBN4Z13Eq4I3dUYXIzR3r/5uJl3W
        v4ME6EBiRsLqneB3mD+IXvRgl5iLi/TQ1YwRdJdOkoU8xnKuAT9CRC/syuFz4K//7zOkGF
        BWSuJqJCZx1Xbcw3e3sLhEueOcSNyLf33zTR1Slfhnj/klg+1B/4bd4Xu57LtBFEM0ic+Z
        Zqi2y7zL3A3Tu7Q8Mv03dBzAQNtUo5wEQEMmt7xmxt/vY2spdIoKOl6zX3U8eKqminExTK
        gBdlZ/KOBnrIwWvFuPkhxclv+BUd+fD+hVSHwOJJ7kNfetyRjjRn3/mUUoxncA==
Message-ID: <1ab280c2-2536-f507-8e12-2e4d3f3eb37e@yoseli.org>
Date:   Thu, 11 May 2023 18:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: pca953x issue when driving a DSI bridge
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
References: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
 <ZFvTi3tQGUq2OCHi@surfacebook>
 <32ecb9f3-1443-210c-0fc9-40891629e25a@yoseli.org>
 <CAHp75Vcsieiab8ks7yLwJvhjHTPv2qeCBJYjMOVYBJXmNhbTYQ@mail.gmail.com>
Content-Language: en-US
From:   Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <CAHp75Vcsieiab8ks7yLwJvhjHTPv2qeCBJYjMOVYBJXmNhbTYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 11/05/2023 09:49, Andy Shevchenko wrote:
> On Wed, May 10, 2023 at 11:18 PM Jean-Michel Hautbois
> <jeanmichel.hautbois@yoseli.org> wrote:
>> On 10/05/2023 19:25, andy.shevchenko@gmail.com wrote:
>>> Wed, May 10, 2023 at 06:12:19PM +0200, Jean-Michel Hautbois kirjoitti:
> 
> ...
> 
>>>> [   11.273968]  gpiod_set_value+0x5c/0xcc
>>>> [   11.277722]  ti_sn65dsi86_resume+0x4c/0x94 [ti_sn65dsi86]
>>>
>>> Your problem even worse, i.e. ->resume() might sleep.
>>
>> Indeed it is worse ;-).
>>
>>>> [   11.283131]  __rpm_callback+0x48/0x19c
>>>> [   11.286885]  rpm_callback+0x6c/0x80
>>>> [   11.290375]  rpm_resume+0x3b0/0x660
>>>> [   11.293864]  __pm_runtime_resume+0x4c/0x90
>>>> [   11.297960]  __device_attach+0x90/0x1e4
>>>> [   11.301797]  device_initial_probe+0x14/0x20
>>>> [   11.305980]  bus_probe_device+0x9c/0xa4
>>>> [   11.309817]  device_add+0x3d8/0x820
>>>> [   11.313308]  __auxiliary_device_add+0x40/0xa0
>>>> [   11.317668]  ti_sn65dsi86_add_aux_device.isra.0+0xb0/0xe0 [ti_sn65dsi86]
>>>> [   11.324381]  ti_sn65dsi86_probe+0x20c/0x2ec [ti_sn65dsi86]
>>>> [   11.329876]  i2c_device_probe+0x3b8/0x3f0
>>>> [   11.333889]  really_probe+0xc0/0x3dc
> 
> ...
> 
>>>> I suppose this is not a corner case and we may have other drivers and other
>>>> boards connecting a GPIO which can sleep in a context where it should not ?
>>>>
>>>> I would like to add one thing: on this board, the expander is routed in a
>>>> way that makes it impossible to "sleep" as the reset is forced pulled-up and
>>>> the power regulators are fixed and can't be stopped.
>>>
>>> Can you elaborate why you think there is a problem?
>>
>> I didn't know if it could be an issue or not, so I mentioned it but
>> sounds like a nonsense :-).
> 
> Maybe not. I don't know that hardware, schematics and more information
> is needed to understand. But I leave it to you.
> 
>>>> I don't know how to address this issue nicely and any thoughts is
>>>> appreciated !
>>>
>>> As a workaround you can consider the code around i2c_in_atomic_xfer_mode()
>>> but since I have heard about i.MX8 so many negative remarks which makes me
>>> think that hardware is a train wreck and shouldn't be used at all.
> 
>> Not sure to get the workaround proposal right...
> 
> There are possibilities to have atomic I2C transfers, but as comment
> says (on top of the above mentioned function) that is only for PMIC
> communications at the system shutdown.
> 
> In your case I would try the easiest way (taking into account that
> hardware connection is not preventing us from sleeping context), i.e.
> check if the function that has GPIO call may sleep on its own and
> simply replace gpiod_set_value() by gpiod_set_value_cansleep().
> 

And I found a patch, which is merged in v6.4-rc1 which does exactly this !
https://lore.kernel.org/all/20230405135127.769665-1-alexander.stein@ew.tq-group.com/

Thanks as it is your advice which made me find it :-p

JM
