Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE368CDE2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBGECg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjBGECZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:02:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDEE2D161;
        Mon,  6 Feb 2023 20:02:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so12926833pjp.0;
        Mon, 06 Feb 2023 20:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awV7awz8WzQB+8buNgTYNblRUM5yram/QyouWVFZwWQ=;
        b=Fzvdv2SBuZM8xyXZiNG6uHAAbVJRPHPUm+WXh8KDqEQjdCozwLy8aj8EW/ux9hWdN6
         L1fMvs+TaaOFwPTWMHRKTJodpZK8GSaTY2UGe5+YQJBgbXSLvsoBm4+eCCA25ROtufor
         uBTjYALsQ6gJKZB42gz9J6NOhh/+gFdyrrk8zx+B1aJHBbUzySOKKw71MfQe7WgnMyB7
         CUa+3f4rwVksxHSDyFxRxHt+UvFfuLKH7aSyUd7MOnxhlXB7JIoso924XKHAHMsxzGl4
         OzHBsUToPqhvqcGg5z6wEx3aF53UhJH7kd49UeX2VrHv5Ef0KHGxeWofhny8R0LGhLl8
         ErCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awV7awz8WzQB+8buNgTYNblRUM5yram/QyouWVFZwWQ=;
        b=xn7VaMaTqvU0kXhfOCtdc2oi/VtTw2hZyM7T79LRoa9jbY1pHKWXdLX6mEnFBl6JHM
         /JtZALrUvMr5ShC+WiChq97ky6YCliTpqzXlKTYhfbLMFvYjbu0QpJlJ9u4ctANEQ3aP
         ZrvOyfZEhobP1soMa07OQp14OkqWZb1nMMzm9EDHjtwSsvbAt6BbIeKsdDXfdJ4NuAIM
         izViZBB01coXF+dD+siRYIT3Ewnp52uLYHDVrZc5t8ZVY09BVZGyEzuSOkdnsSNgMuT/
         IWMvp3lbDEIwwN5a+BQfy+G5HNLT5gb2CqJKpOEWYKXyzhzWofRkgTD2Oe3X6Acr+Pbh
         5Mtw==
X-Gm-Message-State: AO0yUKUsC8pyjOdkJRV1VIXPaZcZVPA2T6WnJ8z32pee/Xl2tTVUmo0U
        cWoans2N28ns40yX11SzT0fR2YeVre8=
X-Google-Smtp-Source: AK7set8UKS/neLd3Q82bQ+D01FOCW8FROf4ZKbRms4B+zvMIGj4NSHBldyuQ40j3DHL5HnzTU3pCMw==
X-Received: by 2002:a17:903:230e:b0:196:49a3:d33d with SMTP id d14-20020a170903230e00b0019649a3d33dmr1553220plh.60.1675742535200;
        Mon, 06 Feb 2023 20:02:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c930:81ab:3aec:b9cb])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902b09800b001992181b5d5sm2067104plr.245.2023.02.06.20.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:02:14 -0800 (PST)
Date:   Mon, 6 Feb 2023 20:02:11 -0800
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
Subject: Re: [PATCH 6/7] HID: i2c-hid: goodix: Add mainboard-vddio-supply
Message-ID: <Y+HNQ/md9sUAqkU2@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.6.Ic234b931025d1f920ce9e06fff294643943a65ad@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206184744.6.Ic234b931025d1f920ce9e06fff294643943a65ad@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:15PM -0800, Douglas Anderson wrote:
> As talked about in the patch ("dt-bindings: HID: i2c-hid: goodix: Add
> mainboard-vddio-supply") we may need to power up a 1.8V rail on the
> host associated with touchscreen IO. Let's add support in the driver
> for it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Unfortunately, I haven't been able to actually test this on real
> hardware yet. However, the change is very simple, I believe it is
> correct, and it doesn't break other boards I've tested it on.
> 
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> index 584d833dc0aa..0060e3dcd775 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -26,6 +26,7 @@ struct i2c_hid_of_goodix {
>  	struct i2chid_ops ops;
>  
>  	struct regulator *vdd;
> +	struct regulator *vddio;
>  	struct gpio_desc *reset_gpio;
>  	const struct goodix_i2c_hid_timing_data *timings;
>  };
> @@ -40,6 +41,10 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
>  	if (ret)
>  		return ret;
>  
> +	ret = regulator_enable(ihid_goodix->vddio);
> +	if (ret)
> +		return ret;
> +
>  	if (ihid_goodix->timings->post_power_delay_ms)
>  		msleep(ihid_goodix->timings->post_power_delay_ms);
>  
> @@ -56,6 +61,7 @@ static void goodix_i2c_hid_power_down(struct i2chid_ops *ops)
>  		container_of(ops, struct i2c_hid_of_goodix, ops);
>  
>  	gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
> +	regulator_disable(ihid_goodix->vddio);
>  	regulator_disable(ihid_goodix->vdd);
>  }
>  
> @@ -81,6 +87,10 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client)
>  	if (IS_ERR(ihid_goodix->vdd))
>  		return PTR_ERR(ihid_goodix->vdd);
>  
> +	ihid_goodix->vddio = devm_regulator_get(&client->dev, "mainboard-vddio");
> +	if (IS_ERR(ihid_goodix->vddio))
> +		return PTR_ERR(ihid_goodix->vddio);
> +
>  	ihid_goodix->timings = device_get_match_data(&client->dev);
>  
>  	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 
Dmitry
