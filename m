Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302B3739C82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFVJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjFVJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:19:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1B358E;
        Thu, 22 Jun 2023 02:10:39 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D0B8660706C;
        Thu, 22 Jun 2023 10:10:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687425038;
        bh=5uxh5lKnVnM46Q8SEQodnpqC2oAD7Fjq5YEoHjE5Sx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KPUAgmSdKBe8F1sbK0PJohKxD/iIlloBxRbdx2mXToR6bT0FdS/9cnpdpHyDyWPiV
         9LYisjtoi9lQjkY6At9xAj4YncbpeIshMKIzGUJIMWyOqj3QittZD7V+6FnIquTZnH
         kyANnfNm+j8bI8c/535TwPqRf62LvcR+18KpLAlQcC1hEy8GqAeUwjX2JbLeasux8I
         JMqpyRqAtZuGljolnyporGOo6z6ZzqXm//GGQROy/CNoq5PYvnLri1W+ItKNrAnqxa
         9CVUOFrfDlfafgmh31726rulYjimvN7Q790qDQmFLPxCVksLehwVx3/BZVXkSSbYjN
         y7zmKhrAZTPiw==
Message-ID: <99adec72-da7b-ce46-27be-b823a208a39e@collabora.com>
Date:   Thu, 22 Jun 2023 11:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 8/8] leds: leds-mt6323: Add support for WLEDs and
 MT6332
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     pavel@ucw.cz, lee@kernel.org, sean.wang@mediatek.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, llvm@lists.linux.dev
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-9-angelogioacchino.delregno@collabora.com>
 <20230621213124.GA2689001@dev-arch.thelio-3990X>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230621213124.GA2689001@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/06/23 23:31, Nathan Chancellor ha scritto:
> Hi Angelo,
> 
> On Thu, Jun 01, 2023 at 01:08:13PM +0200, AngeloGioacchino Del Regno wrote:
>> Add basic code to turn on and off WLEDs and wire up MT6332 support
>> to take advantage of it.
>> This is a simple approach due to the aforementioned PMIC supporting
>> only on/off status so, at the time of writing, it is impossible for me
>> to validate more advanced functionality due to lack of hardware.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> After this patch as commit 9bb0a9e0626c ("leds: leds-mt6323: Add support
> for WLEDs and MT6332") in -next, I see the following warnings from
> clang, which are basically flagging potential kernel Control Flow
> Integrity [1] violations that will be visible at runtime (this warning
> is not enabled for the kernel yet but we would like it to be):
> 
>    drivers/leds/leds-mt6323.c:598:49: error: incompatible function pointer types assigning to 'int (*)(struct led_classdev *, enum led_brightness)' from 'int (struct led_classdev *, unsigned int)' [-Werror,-Wincompatible-function-pointer-types-strict]
>      598 |                         leds->led[reg]->cdev.brightness_set_blocking =
>          |                                                                      ^
>      599 |                                                 mt6323_wled_set_brightness;
>          |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/leds/leds-mt6323.c:600:40: error: incompatible function pointer types assigning to 'enum led_brightness (*)(struct led_classdev *)' from 'unsigned int (struct led_classdev *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>      600 |                         leds->led[reg]->cdev.brightness_get =
>          |                                                             ^
>      601 |                                                 mt6323_get_wled_brightness;
>          |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
>    2 errors generated.
> 
>  From what I can tell/understand, 'enum led_brightness' is obsolete and
> the value that is passed via ->brightness_set_blocking() is an 'unsigned
> int' as well but it seems 'enum led_brightness' is used as the parameter
> in a lot of different callback implementations, so the prototype cannot
> be easily updated without a lot of extra work. Is there any reason not
> to just do something like this to avoid this issue?
> 

I don't think that this would bring any issue to the table.

The rework will possibly be done globally, for all drivers, when time comes... so
feel free to send the proposed patch.

Thanks,
Angelo

> [1]: https://lwn.net/Articles/898040/
> 
> Cheers,
> Nathan
> 
> diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
> index e8fecfc2e90a..24f35bdb55fb 100644
> --- a/drivers/leds/leds-mt6323.c
> +++ b/drivers/leds/leds-mt6323.c
> @@ -76,7 +76,7 @@ struct mt6323_led {
>   	int			id;
>   	struct mt6323_leds	*parent;
>   	struct led_classdev	cdev;
> -	unsigned int		current_brightness;
> +	enum led_brightness	current_brightness;
>   };
>   
>   /**
> @@ -451,7 +451,7 @@ static int mtk_wled_hw_off(struct led_classdev *cdev)
>   	return 0;
>   }
>   
> -static unsigned int mt6323_get_wled_brightness(struct led_classdev *cdev)
> +static enum led_brightness mt6323_get_wled_brightness(struct led_classdev *cdev)
>   {
>   	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
>   	struct mt6323_leds *leds = led->parent;
> @@ -471,7 +471,7 @@ static unsigned int mt6323_get_wled_brightness(struct led_classdev *cdev)
>   }
>   
>   static int mt6323_wled_set_brightness(struct led_classdev *cdev,
> -				      unsigned int brightness)
> +				      enum led_brightness brightness)
>   {
>   	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
>   	struct mt6323_leds *leds = led->parent;


