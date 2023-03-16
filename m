Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF96BD702
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCPR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA5D3096
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678987542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1serZQHzm601R2npYPPuVI8Z3zB+qqGYsuRD4toBV7c=;
        b=IAj34ILhICJ0mypLO7MsArRQAZeso7gI514tgZh/VL/XO04PwWw6TdbkIX4IQMaZJ5nWzg
        ujJJ9WMnGEXPmxM1JYViOk66Wc5WQiQlIx4TzhHNnEW8f0uuaPhpl8IC88KOFaIZxcjWgD
        5bVmXgQHus2fPgqN6kO2keyRXgbQ8n0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Mfi-WlrxMAq-COlUz9dgLw-1; Thu, 16 Mar 2023 13:25:41 -0400
X-MC-Unique: Mfi-WlrxMAq-COlUz9dgLw-1
Received: by mail-ed1-f71.google.com with SMTP id z14-20020a05640235ce00b004e07ddbc2f8so4019875edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1serZQHzm601R2npYPPuVI8Z3zB+qqGYsuRD4toBV7c=;
        b=pokF3TQwgLIzeyj1ncLd6uqjxFQY7NvhaPBaYELrkzJan5BSvdF+fI+GxGrcTZEFF5
         vLJFtay0DiyOhtcI+CER8JU6y4Iv/Nhj3pMl7t08kH009t4mLq4YUgVH2TxEJ0vrnKTE
         +qT4bB2SjLPxbaJksMIf4AC23CqpWqSvd5kJhEAxdDDCe4UwbPmCNZo6MAoAdYaJE2n1
         bDt0ULPCYD/z2ckE+2d4bZKbfGuWoqKTPQP+YsTn2U0J7c6dRO/bB928Z+agqGg5vx8j
         l8Q4yxuWRZDHdSSJduCXrIkTDOrnvZYOebYiREajnz2j7vHmhuVC4WCcXWW2Cg7jOYkD
         3Nsg==
X-Gm-Message-State: AO0yUKV7l8DYfUQf/CeBjxobeGXhweR1zRKfnUovo74f6S7m+7WxaF1b
        of5V9ckfAY3996g3zsj75DVT/XUyM8sDONv5pY0sst4XmPi1jApl27A5aOIJeb0wvzKcQtlaKJE
        0GFJlEsBdeVrGlVLzfVnai8IGZB4vtCBC
X-Received: by 2002:aa7:d78f:0:b0:4fa:e1fd:5a30 with SMTP id s15-20020aa7d78f000000b004fae1fd5a30mr356206edq.19.1678987539784;
        Thu, 16 Mar 2023 10:25:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set+DPBVzs9B4R9NeQUEfg4MMaN/dEUz7AT1ho1bCegNJiP+GT8Tv6Osf63YssfFBnnMY4aKT2w==
X-Received: by 2002:aa7:d78f:0:b0:4fa:e1fd:5a30 with SMTP id s15-20020aa7d78f000000b004fae1fd5a30mr356191edq.19.1678987539508;
        Thu, 16 Mar 2023 10:25:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b009222eec8097sm4065449ejb.75.2023.03.16.10.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:25:38 -0700 (PDT)
Message-ID: <5657267e-9d57-4d55-5b1e-d46fed90ff59@redhat.com>
Date:   Thu, 16 Mar 2023 18:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/2] input: touchscreen: goodix: Hold controller in
 reset during suspend
To:     Jan Jasper de Kroon <jajadekroon@gmail.com>
Cc:     dmitry.torokhov@gmail.com, hadess@hadess.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        megi@xff.cz
References: <20230310170026.415739-1-jajadekroon@gmail.com>
 <20230316152159.66922-1-jajadekroon@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230316152159.66922-1-jajadekroon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/16/23 16:22, Jan Jasper de Kroon wrote:
> From: Ondřej Jirman <megi@xff.cz>
> 
> The Goodix touchscreen controller used in PinePhone is not properly
> suspended during system sleep, leading to high power consumption. This
> commit modifies the driver to hold the controller in reset during
> system sleep, reducing power consumption by around 40mW.
> 
> The original patch also disabled the regulators during system sleep, but
> this could cause issues with other peripherals attached to the same power
> supplies. Hence, this commit only holds the controller in reset during
> system sleep and does not attempt to power it off.
> 
> A separate commit adds a new device tree property "goodix-hold-in-reset"
> to control the hold-in-reset behavior of the controller during system sleep.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jan Jasper de Kroon <jajadekroon@gmail.com>
> ---
> Changes from v3 to v4:
> - Renamed the hold-in-reset-in-suspend function to 
>   goodix-hold-in-reset to prevent potential naming conflicts with other 
>   functions in the codebase. No functional changes were made.
> 
> Changes from v2 to v3:
> - Some patch style cleaning up, to confirm to submission standard.
> 
> Changes from v1 to v2:
> - Rewrote the commit message and function name to better reflect it's 
>   behavior.
>  drivers/input/touchscreen/goodix.c | 23 +++++++++++++++++++++++
>  drivers/input/touchscreen/goodix.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index b348172f19c3..9f86bdfbfc73 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -1284,6 +1284,7 @@ static void goodix_disable_regulators(void *arg)
>  
>  static int goodix_ts_probe(struct i2c_client *client)
>  {
> +	struct device_node *np = client->dev.of_node;
>  	struct goodix_ts_data *ts;
>  	const char *cfg_name;
>  	int error;
> @@ -1303,6 +1304,7 @@ static int goodix_ts_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, ts);
>  	init_completion(&ts->firmware_loading_complete);
>  	ts->contact_size = GOODIX_CONTACT_SIZE;
> +	ts->goodix_hold_in_reset = of_property_read_bool(np, "goodix-hold-in-reset");

I only noticed this just now, sorry. Can you please use
"device_property_read_bool(&client-dev, "goodix-hold-in-reset");
instead, this way this will also work with non device-tree (aka OF)
platforms.

Also with devicetree properties if you prefix them by the vendor
name the vendor-prefix should end with a comma, so you get:

"goodix,hold-in-reset"

And I think this name is not very descriptive, this really should be something like:

"goodix,hold-in-reset-during-suspend"

to make what it does more clear.

I assume that this is going to get set inside a dts file, in that case this
new property should be documented in:

Documentation/devicetree/bindings/input/touchscree /goodix.yaml

and these devicetree-bindings changes must be in a separate patch
(and the dt-bindings maintainers should be Cc-ed on that patch).

Regards,

Hans




>  
>  	error = goodix_get_gpio_config(ts);
>  	if (error)
> @@ -1410,6 +1412,13 @@ static int goodix_suspend(struct device *dev)
>  	if (ts->load_cfg_from_disk)
>  		wait_for_completion(&ts->firmware_loading_complete);
>  
> +	if (ts->goodix_hold_in_reset) {
> +		goodix_free_irq(ts);
> +		goodix_irq_direction_output(ts, 0);
> +		gpiod_direction_output(ts->gpiod_rst, 0);
> +		return 0;
> +	}
> +
>  	/* We need gpio pins to suspend/resume */
>  	if (ts->irq_pin_access_method == IRQ_PIN_ACCESS_NONE) {
>  		disable_irq(client->irq);
> @@ -1455,6 +1464,20 @@ static int goodix_resume(struct device *dev)
>  	u8 config_ver;
>  	int error;
>  
> +	if (ts->goodix_hold_in_reset) {
> +		error = goodix_reset(ts);
> +		if (error) {
> +			dev_err(dev, "Controller reset failed.\n");
> +			return error;
> +		}
> +
> +		error = goodix_request_irq(ts);
> +		if (error)
> +			return error;
> +
> +		return 0;
> +	}
> +
>  	if (ts->irq_pin_access_method == IRQ_PIN_ACCESS_NONE) {
>  		enable_irq(client->irq);
>  		return 0;
> diff --git a/drivers/input/touchscreen/goodix.h b/drivers/input/touchscreen/goodix.h
> index 87797cc88b32..7be7eb1a8f27 100644
> --- a/drivers/input/touchscreen/goodix.h
> +++ b/drivers/input/touchscreen/goodix.h
> @@ -104,6 +104,7 @@ struct goodix_ts_data {
>  	u8 main_clk[GOODIX_MAIN_CLK_LEN];
>  	int bak_ref_len;
>  	u8 *bak_ref;
> +	bool goodix_hold_in_reset;
>  };
>  
>  int goodix_i2c_read(struct i2c_client *client, u16 reg, u8 *buf, int len);

