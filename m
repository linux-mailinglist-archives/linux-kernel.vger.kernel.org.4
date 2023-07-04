Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD474755E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGDPb4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGDPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:31:55 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3581B2;
        Tue,  4 Jul 2023 08:31:54 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 0FA9115360;
        Tue,  4 Jul 2023 16:31:52 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id B9EEA219FC1; Tue,  4 Jul 2023 16:31:51 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
References: <20230704140750.25799-1-mans@mansr.com>
        <20230704150310.GA385243@aspen.lan>
Date:   Tue, 04 Jul 2023 16:31:51 +0100
In-Reply-To: <20230704150310.GA385243@aspen.lan> (Daniel Thompson's message of
        "Tue, 4 Jul 2023 16:03:10 +0100")
Message-ID: <yw1xo7krzo9k.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Thompson <daniel.thompson@linaro.org> writes:

> On Tue, Jul 04, 2023 at 03:07:50PM +0100, Mans Rullgard wrote:
>> The condition for the initial power state based on the default
>> brightness value is reversed.  Fix it.
>>
>> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  drivers/video/backlight/led_bl.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
>> index 3259292fda76..28e83618a296 100644
>> --- a/drivers/video/backlight/led_bl.c
>> +++ b/drivers/video/backlight/led_bl.c
>> @@ -200,8 +200,8 @@ static int led_bl_probe(struct platform_device *pdev)
>>  	props.type = BACKLIGHT_RAW;
>>  	props.max_brightness = priv->max_brightness;
>>  	props.brightness = priv->default_brightness;
>> -	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
>> -		      FB_BLANK_UNBLANK;
>> +	props.power = (priv->default_brightness > 0) ? FB_BLANK_UNBLANK :
>> +		      FB_BLANK_POWERDOWN;
>
> The logic was wrong before but I think will still be wrong after the
> change too (e.g. the bogus logic is probably avoiding backlight flicker
> in some use cases).
>
> The logic here needs to be similar to what pwm_bl.c implements in
> pwm_backlight_initial_power_state(). Whilst it might be better
> to implement this in led_bl_get_leds() let me show what I mean
> in code that fits in the current line:
>
> 	/*
> 	 * Activate the backlight if the LEDs are already lit *or*
> 	 * there is no phandle link (meaning the backlight power
> 	 * state cannot be synced with the display state).
> 	 */
> 	props.power = (active_at_boot || !dev->node->phandle) ?
> 			FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>
> Note that active_at_boot is not the same as (priv->default_brightness > 0)
> since the value read by led_bl_get_leds() can be clobbered when we
> parse the properties.

Am I understanding correctly that the code should be using the
default_brightness value as set by led_bl_get_leds() to determine the
initial power state, not whatever default value the devicetree provides?

-- 
Måns Rullgård
