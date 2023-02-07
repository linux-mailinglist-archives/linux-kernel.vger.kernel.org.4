Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55968CDD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBGD7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGD67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:58:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C52112;
        Mon,  6 Feb 2023 19:58:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso687975pju.0;
        Mon, 06 Feb 2023 19:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzdKrRTnNU4SNJhekPfo9Qc/JklaeK1jZvFoAgwmSyw=;
        b=nxNW61od7TObEeYM+rZzIcCpm0Vr7fDKMRryXVZphUtnq+7XXv7CSIAF4pPBBuvOcE
         SVcK/PsDizf9cky6XKlMImUNx3WGJ7CiKXGn2fu6fUVzTM2ONnsfFUQTACjgYkSqJ/BV
         Q+CFc2K6ygaUg7H4KHQXjs/Zupl1UuhHp+PW/iAOfmNtdvWdFaF+VRWSGTsSTpONkFvE
         R24GBUgas3enBmHQdb14Wwe6ZRQtPMckmOmTGcyXf/0MC203eJxJS+d+lP2WS5vhKDZv
         G8fvN4GS3pqnE7Ogr8cYFBBq7os8XqJX4I5D0xvIrj9PXKfOF+j3eq5/vsx9F85TGrUV
         Wlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzdKrRTnNU4SNJhekPfo9Qc/JklaeK1jZvFoAgwmSyw=;
        b=5zSqJLhFTT+RcMxus3tNGKVh8Az5rHcfF+9sU2C2gW3q6fnILSxAZC7rPnHmABk843
         fnP9tV4ZduXFWUOwlQvI5y0HNA8mcdiRyuxjAZQvZXNQ9nUPJ97P1csNsB/sIN+cIMQI
         58PiE3CqXwpgzwkLwhM2IuSb+Pm0OJVYFMnlv7douted1gpyuWscKDC4w2z4abNUteJS
         Dmd00QGQ3X8ZNVHUt2qHrkGwYr5CnT7DWVztCAHhXJAD3SNgf2SDokOyRbP1PQaICoG/
         8023oBFnBLPrVsBfLD9nZyJiTAHDqteiQ1aFmx76FOyTreCew+np/KnCooLw9kLjd8fU
         /zOw==
X-Gm-Message-State: AO0yUKVtBnF4V+uuKlHWtN95a4Xg0iUCO7DmWVlJJ6fzUrH3pkayQXwp
        rhp3Sv5ftuCAM/E8hPMGz44=
X-Google-Smtp-Source: AK7set+T5I3WubDIAVOtvbG+iIU955Ksz70LvL8tVZ8nPldrwWzfEePxeLZojtODBw3Gyd0rTfuonw==
X-Received: by 2002:a17:902:e411:b0:199:10b1:68f2 with SMTP id m17-20020a170902e41100b0019910b168f2mr980400ple.66.1675742334747;
        Mon, 06 Feb 2023 19:58:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c930:81ab:3aec:b9cb])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902b69700b0019141c79b1dsm7675911pls.254.2023.02.06.19.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:58:53 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:58:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] HID: i2c-hid: goodix: Stop tying the reset line to
 the regulator
Message-ID: <Y+HMejpI7DoKwWYm@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.4.I085b32b6140c7d1ac4e7e97b712bff9dd5962b62@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206184744.4.I085b32b6140c7d1ac4e7e97b712bff9dd5962b62@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:13PM -0800, Douglas Anderson wrote:
> In commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to
> true state of the regulator"), we started tying the reset line of
> Goodix touchscreens to the regulator.
> 
> The primary motivation for that patch was some pre-production hardware
> (specifically sc7180-trogdor-homestar) where it was proposed to hook
> the touchscreen's main 3.3V power rail to an always-on supply. In such
> a case, when we turned "off" the touchscreen in Linux it was bad to
> assert the "reset" GPIO because that was causing a power drain. The
> patch accomplished that goal and did it in a general sort of way that
> didn't require special properties to be added in the device tree for
> homestar.
> 
> It turns out that the design of using an always-on power rail for the
> touchscreen was rejected soon after the patch was written and long
> before sc7180-trogdor-homestar went into production. The final design
> of homestar actually fully separates the rail for the touchscreen and
> the display panel and both can be powered off and on. That means that
> the original motivation for the feature is gone.
> 
> There are 3 other users of the goodix i2c-hid driver in mainline.
> 
> I'll first talk about 2 of the other users in mainline: coachz and
> mrbland. On both coachz and mrbland the touchscreen power and panel
> power _are_ shared. That means that the patch to tie the reset line to
> the true state of the regulator _is_ doing something on those
> boards. Specifically, the patch reduced power consumption by tens of
> mA in the case where we turned the touchscreen off but left the panel
> on. Other than saving a small bit of power, the patch wasn't truly
> necessary. That being said, even though a small bit of power was saved
> in the state of "panel on + touchscreen off", that's not actually a
> state we ever expect to be in, except perhaps for very short periods
> of time at boot or during suspend/resume. Thus, the patch is truly not
> necessary. It should be further noted that, as documented in the
> original patch, the current code still didn't optimize power for every
> corner case of the "shared rail" situation.
> 
> The last user in mainline was very recently added: evoker. Evoker is
> actually the motivation for me removing this bit of code. It turns out
> that for evoker we need to manage a second power rail for IO to the
> touchscreen. Trying to fit the management of this IO rail into the
> regulator notifiers turns out to be extremely hard. To avoid lockdep
> splats you shouldn't enable/disable other regulators in regulator
> notifiers and trying to find a way around this was going to be fairly
> difficult.
> 
> Given the lack of any true motivation to tie the reset line to the
> regulator, lets go back to the simpler days and remove the code. This
> is, effectively, a revert of commit bdbc65eb77ee ("HID: i2c-hid:
> goodix: Fix a lockdep splat"), commit 25ddd7cfc582 ("HID: i2c-hid:
> goodix: Use the devm variant of regulator_register_notifier()"), and
> commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to true
> state of the regulator").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> 
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 88 ++++---------------------
>  1 file changed, 13 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> index 29c6cb174032..584d833dc0aa 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -26,28 +26,28 @@ struct i2c_hid_of_goodix {
>  	struct i2chid_ops ops;
>  
>  	struct regulator *vdd;
> -	struct notifier_block nb;
>  	struct gpio_desc *reset_gpio;
>  	const struct goodix_i2c_hid_timing_data *timings;
>  };
>  
> -static void goodix_i2c_hid_deassert_reset(struct i2c_hid_of_goodix *ihid_goodix,
> -					  bool regulator_just_turned_on)
> +static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
>  {
> -	if (regulator_just_turned_on && ihid_goodix->timings->post_power_delay_ms)
> +	struct i2c_hid_of_goodix *ihid_goodix =
> +		container_of(ops, struct i2c_hid_of_goodix, ops);
> +	int ret;
> +
> +	ret = regulator_enable(ihid_goodix->vdd);
> +	if (ret)
> +		return ret;
> +
> +	if (ihid_goodix->timings->post_power_delay_ms)
>  		msleep(ihid_goodix->timings->post_power_delay_ms);
>  
>  	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 0);
>  	if (ihid_goodix->timings->post_gpio_reset_delay_ms)
>  		msleep(ihid_goodix->timings->post_gpio_reset_delay_ms);
> -}
> -
> -static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
> -{
> -	struct i2c_hid_of_goodix *ihid_goodix =
> -		container_of(ops, struct i2c_hid_of_goodix, ops);
>  
> -	return regulator_enable(ihid_goodix->vdd);
> +	return 0;
>  }
>  
>  static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
> @@ -55,42 +55,14 @@ static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
>  	struct i2c_hid_of_goodix *ihid_goodix =
>  		container_of(ops, struct i2c_hid_of_goodix, ops);
>  
> +	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
>  	regulator_disable(ihid_goodix->vdd);
>  }
>  
> -static int ihid_goodix_vdd_notify(struct notifier_block *nb,
> -				    unsigned long event,
> -				    void *ignored)
> -{
> -	struct i2c_hid_of_goodix *ihid_goodix =
> -		container_of(nb, struct i2c_hid_of_goodix, nb);
> -	int ret = NOTIFY_OK;
> -
> -	switch (event) {
> -	case REGULATOR_EVENT_PRE_DISABLE:
> -		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> -		break;
> -
> -	case REGULATOR_EVENT_ENABLE:
> -		goodix_i2c_hid_deassert_reset(ihid_goodix, true);
> -		break;
> -
> -	case REGULATOR_EVENT_ABORT_DISABLE:
> -		goodix_i2c_hid_deassert_reset(ihid_goodix, false);
> -		break;
> -
> -	default:
> -		ret = NOTIFY_DONE;
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
>  static int i2c_hid_of_goodix_probe(struct i2c_client *client)
>  {
>  	struct i2c_hid_of_goodix *ihid_goodix;
> -	int ret;
> +
>  	ihid_goodix = devm_kzalloc(&client->dev, sizeof(*ihid_goodix),
>  				   GFP_KERNEL);
>  	if (!ihid_goodix)
> @@ -111,40 +83,6 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client)
>  
>  	ihid_goodix->timings = device_get_match_data(&client->dev);
>  
> -	/*
> -	 * We need to control the "reset" line in lockstep with the regulator
> -	 * actually turning on an off instead of just when we make the request.
> -	 * This matters if the regulator is shared with another consumer.
> -	 * - If the regulator is off then we must assert reset. The reset
> -	 *   line is active low and on some boards it could cause a current
> -	 *   leak if left high.
> -	 * - If the regulator is on then we don't want reset asserted for very
> -	 *   long. Holding the controller in reset apparently draws extra
> -	 *   power.
> -	 */
> -	ihid_goodix->nb.notifier_call = ihid_goodix_vdd_notify;
> -	ret = devm_regulator_register_notifier(ihid_goodix->vdd, &ihid_goodix->nb);
> -	if (ret)
> -		return dev_err_probe(&client->dev, ret,
> -			"regulator notifier request failed\n");
> -
> -	/*
> -	 * If someone else is holding the regulator on (or the regulator is
> -	 * an always-on one) we might never be told to deassert reset. Do it
> -	 * now... and temporarily bump the regulator reference count just to
> -	 * make sure it is impossible for this to race with our own notifier!
> -	 * We also assume that someone else might have _just barely_ turned
> -	 * the regulator on so we'll do the full "post_power_delay" just in
> -	 * case.
> -	 */
> -	if (ihid_goodix->reset_gpio && regulator_is_enabled(ihid_goodix->vdd)) {
> -		ret = regulator_enable(ihid_goodix->vdd);
> -		if (ret)
> -			return ret;
> -		goodix_i2c_hid_deassert_reset(ihid_goodix, true);
> -		regulator_disable(ihid_goodix->vdd);
> -	}
> -
>  	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
>  }
>  
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 
Dmitry
