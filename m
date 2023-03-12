Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAE6B6A5F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCLS76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDFF23D80
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678647550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OrWn/zNauXSDODQQ5+F8Wu87rgqZHXj4j3GzkJ/rfM=;
        b=agOPqgbJkkiFXJR7sagM5IfpJe9481vmBzjfrJCgezYhYAimFsM5Cwe9osQpZZNUsF9tFM
        qg8zYM1vco+YwsVoAvxAhqR3MoQwOEtS1WIVOnilyR2Tu+4J41J18MEQftjVCCFSyQ153H
        1tQR8M932Si7uxKg3uD7UGPEUjFNgTc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-MPKiZmfGNiSkQzfdoIX7JA-1; Sun, 12 Mar 2023 14:59:06 -0400
X-MC-Unique: MPKiZmfGNiSkQzfdoIX7JA-1
Received: by mail-ed1-f70.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so13629666edc.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678647545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OrWn/zNauXSDODQQ5+F8Wu87rgqZHXj4j3GzkJ/rfM=;
        b=tVzZ4hVKmi7dliTLlqwUDu6gryVZVYIHrH8u8KS0M7NXuwnxu8N4wjOdM40hGCpyaJ
         nRnXRX29rOJWvFva0LwQrKnhghMUF9PSAWCpTOo8xbt33k2UvjCqzlIkkwl19ts/o0CK
         lD39VMIn7B6N8irEinoplbUyrmyOL82tUS7NnBZULpcVr71QKszlizZYP8Akdxnwbo8t
         mS6Z0A+JvY0nJKy1qpVRh83wrfaFb+0q11xSvPIcG7kYPa3xjEhreU7UiQOm2kawSxpB
         DsEGtu62vwuqi4CuAiaHbbOKDBnNwWj2tTr44qBxVcchICWkF+kslWb495f0M5VuTyMh
         BCaA==
X-Gm-Message-State: AO0yUKVpKzmKr9irsfN+kGsCcLLGg77P8i98z479PY7NtS9HxRfDdwPV
        YMsCFgERYpdVaE++e10ocyrqbzbjSKFTdzXdUzHByrwohjYTzT79qOsgtxsn3AcUurloAR2zDp6
        a8yhYi2Mnop8J6Iqzwt67uDuj
X-Received: by 2002:a17:907:7d8e:b0:87b:dac0:b23b with SMTP id oz14-20020a1709077d8e00b0087bdac0b23bmr40815524ejc.55.1678647545461;
        Sun, 12 Mar 2023 11:59:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set8PyEarzMVfFck6OBeI9PyCNkjXXCFlPlycQW0wphCuZ00hAS+fpgVvCtSMaPBzEHfQ59d37w==
X-Received: by 2002:a17:907:7d8e:b0:87b:dac0:b23b with SMTP id oz14-20020a1709077d8e00b0087bdac0b23bmr40815508ejc.55.1678647545107;
        Sun, 12 Mar 2023 11:59:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bg25-20020a170906a05900b00905a1abecbfsm2490702ejb.47.2023.03.12.11.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:59:04 -0700 (PDT)
Message-ID: <33b72957-1062-1b66-85eb-c37dc5ca259b@redhat.com>
Date:   Sun, 12 Mar 2023 19:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] input: touchscreen: goodix: Hold controller in
 reset during suspend
To:     Jan Jasper de Kroon <jajadekroon@gmail.com>
Cc:     linux-input@vger.kernel.org, megi@xff.cz, hadess@hadess.net,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
References: <20230311131534.484700-1-jajadekroon@gmail.com>
 <20230312184058.552305-1-jajadekroon@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230312184058.552305-1-jajadekroon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/23 19:40, Jan Jasper de Kroon wrote:
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
> Separate commit adds a new device tree property "hold-in-reset-in-suspend"
> to control the hold-in-reset behavior of the controller during system
> sleep.
> 
> Signed-off-by: Ondřej Jirman <megi@xff.cz>
> Signed-off-by: Jan Jasper de Kroon <jajadekroon@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> V1 -> V2: 
> - Rewrote the commit message and function name to better reflect it's 
>   behavior.
> v2 -> V3: Some patch style cleaning up, to confirm to submission standard.
> 
>  drivers/input/touchscreen/goodix.c | 23 +++++++++++++++++++++++
>  drivers/input/touchscreen/goodix.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index b348172f19c3..a35a203e04bf 100644
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
> +	ts->hold_in_reset_in_suspend = of_property_read_bool(np, "hold-in-reset-in-suspend");
>  
>  	error = goodix_get_gpio_config(ts);
>  	if (error)
> @@ -1410,6 +1412,13 @@ static int goodix_suspend(struct device *dev)
>  	if (ts->load_cfg_from_disk)
>  		wait_for_completion(&ts->firmware_loading_complete);
>  
> +	if (ts->hold_in_reset_in_suspend) {
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
> +	if (ts->hold_in_reset_in_suspend) {
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
> index 87797cc88b32..c515d03b742c 100644
> --- a/drivers/input/touchscreen/goodix.h
> +++ b/drivers/input/touchscreen/goodix.h
> @@ -104,6 +104,7 @@ struct goodix_ts_data {
>  	u8 main_clk[GOODIX_MAIN_CLK_LEN];
>  	int bak_ref_len;
>  	u8 *bak_ref;
> +	bool hold_in_reset_in_suspend;
>  };
>  
>  int goodix_i2c_read(struct i2c_client *client, u16 reg, u8 *buf, int len);

