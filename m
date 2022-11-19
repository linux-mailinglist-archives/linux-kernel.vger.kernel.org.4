Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298F630EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKSM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiKSM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AEC9E94A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668862686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=att0kd8Ei9hnRQ7//eGic4U9uIgK4F47gd3Pen4Nml4=;
        b=gAQQJbgre9fJ5kyj0s4b+nrbwBVURPX5aS9Tag7mwhQ3dSRgaISx/8U900nkg7+Hviu2Zu
        CtY7xuwktXTFdEGidCr6DXJEqgtW0sDtUgs49p8aooMahhmSSajnkpn2mbATqU9C8nNiQz
        AO/iR9ouBAAUfJY5iFy5hFJHGu5uiLA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-vmLWCy7gM16H6suhbrLL9A-1; Sat, 19 Nov 2022 07:58:03 -0500
X-MC-Unique: vmLWCy7gM16H6suhbrLL9A-1
Received: by mail-ed1-f72.google.com with SMTP id b14-20020a056402278e00b004621a2642d7so4133422ede.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=att0kd8Ei9hnRQ7//eGic4U9uIgK4F47gd3Pen4Nml4=;
        b=IgHPPFXhtPK0QAtb+1x24yLp/vBI29TBUqo2C8EvqstnPslrfc8EvxPg9r8cRXT68P
         cgROtWjELw5DTDGmY1/vaLE4NzxG1XRhQrOgT/lAoPnwSV1yAVZ/ssqnWs9Sg4RanMH9
         T4GWQTRaumlfRLa0biLeDkFXsZRBjtqXNVlN5QJ2arWcArKKhCVfCASczW8VjzTnpw3j
         nhK18t8wmCoOFcPRARAqTLWqBvurK/v0b479GOaTYq9tSTdSijvg8bdezcavZVY1Osr3
         fcupgJRcQijF4yVbUmCqpt5tpEF555uL/7W8bvYpOfVSZ3TLRFjul6AJ1ntqDcyfF9XK
         9mBw==
X-Gm-Message-State: ANoB5plF1Jts25OjLMOIy7OUhwfp27fVI+4MSa2etTLXwmQ1+DiVelUy
        sdbNOkZbNVSEp206maFwP86UBsV/gt/2xtHkRA5k5RTlwem3TMz0fLwcLoomBEAKaNTDr4b6rOV
        efcNOu3Gw86Pl5pH9/Qm0lTR/
X-Received: by 2002:aa7:d1cc:0:b0:468:f964:372e with SMTP id g12-20020aa7d1cc000000b00468f964372emr7805874edp.326.1668862682555;
        Sat, 19 Nov 2022 04:58:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Ra+xt2V3m680hjIDqNisNFkDT6A55mp2gEd2PzLtjvyisa18iNaOjHiKcRdh6G30b8IU+oQ==
X-Received: by 2002:aa7:d1cc:0:b0:468:f964:372e with SMTP id g12-20020aa7d1cc000000b00468f964372emr7805862edp.326.1668862682337;
        Sat, 19 Nov 2022 04:58:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jt12-20020a170906ca0c00b007aec44edcfcsm2841094ejb.75.2022.11.19.04.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 04:58:01 -0800 (PST)
Message-ID: <1c8cee3a-41e1-d02a-d7cf-549d91ac0143@redhat.com>
Date:   Sat, 19 Nov 2022 13:58:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 529/606] power: supply: max17042_battery: Convert to i2c's
 .probe_new()
Content-Language: en-US, nl
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-530-uwe@kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221118224540.619276-530-uwe@kleine-koenig.org>
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

On 11/18/22 23:44, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/max17042_battery.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index ab031bbfbe78..89cabe8ed3b0 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1031,9 +1031,9 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
>  	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
>  };
>  
> -static int max17042_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int max17042_probe(struct i2c_client *client)
>  {
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct i2c_adapter *adapter = client->adapter;
>  	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
>  	struct power_supply_config psy_cfg = {};
> @@ -1220,7 +1220,7 @@ static struct i2c_driver max17042_i2c_driver = {
>  		.of_match_table = of_match_ptr(max17042_dt_match),
>  		.pm	= &max17042_pm_ops,
>  	},
> -	.probe		= max17042_probe,
> +	.probe_new	= max17042_probe,
>  	.id_table	= max17042_id,
>  };
>  module_i2c_driver(max17042_i2c_driver);

