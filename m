Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8A694446
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjBMLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjBMLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D51A48C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676287036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+r5vx7IWGfAUW6kMiX9+DAbfp5oEB9HB/LjP4Uymy1U=;
        b=O4mkMZNj9WuzmXNyIF1Nx0xoEQ+G0u+NvZlann/Lq+2L17g8LZx/kK9f8j5sOvNQpNlyWD
        qJRnrmsa+DLHmfhXIr77M7FO7obIc93txdvIM/hpLqG6N+g9AcxchM1/rEjftiQkvMuAPp
        D4/lZYw+2FdgGZjy00TQo2k91/RJ7JE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-M2MOdexjPMicDFeUv5vacg-1; Mon, 13 Feb 2023 06:17:15 -0500
X-MC-Unique: M2MOdexjPMicDFeUv5vacg-1
Received: by mail-ed1-f69.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso7358773edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+r5vx7IWGfAUW6kMiX9+DAbfp5oEB9HB/LjP4Uymy1U=;
        b=s8ppY1EM2rIA+Fv6lMaV8R7dAofGSd0OmaaEn35qHXF7wlq7ZmeQYJJy1pOtM7chsc
         cmxhHvQPk0AUV5A0VlRlbgzUuGE1Zbwo/m7Nvay7QgHJbGVslwPYPfeMyPyDVDiWdC3Z
         oDf0ZlWI/gRwTrHJ+TuEyvAthvp+NOV75QPfL4oV0TXL9JkNMg8qd1r+Xn5I7TXdqyOh
         ixHINrux9QV/ohEo4NfpX5jlQUAcff76Rxt7FnPI7TlImiI1IPHuvn/Sdk5AtbAC36O/
         6TSDMJzfHtLgVXlrgZzzMhdN3DHaJHTfOQwAAf75cOEgjz6xADmWtWUHf33ysQFsy6zu
         Xprg==
X-Gm-Message-State: AO0yUKUtOiWzotoMoNmJQbtRMJkNwK6j1U7V/IJvRH21asqRrrvRFFJJ
        /5shfmpGjS8S+IuJu98CwFRTUgCgTGRnRDQYFlLPuri8O6rVp0wP3gsnumr0Pm0ui+7rcyjH14B
        yosScujPRsynC7h6qUos648FQgS+GqQ==
X-Received: by 2002:a17:906:5295:b0:8ae:f18f:f2b5 with SMTP id c21-20020a170906529500b008aef18ff2b5mr20931286ejm.16.1676287034156;
        Mon, 13 Feb 2023 03:17:14 -0800 (PST)
X-Google-Smtp-Source: AK7set9XzK5zx6EohmjepBAaDv4Jg0lMKK5ZVkOPqXFHM8xYU+j4c8CYsCuEEnayZgmvokl+HPFLeg==
X-Received: by 2002:a17:906:5295:b0:8ae:f18f:f2b5 with SMTP id c21-20020a170906529500b008aef18ff2b5mr20931277ejm.16.1676287033949;
        Mon, 13 Feb 2023 03:17:13 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709065e0800b0087fa83790d8sm6732127eju.13.2023.02.13.03.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:17:13 -0800 (PST)
Message-ID: <7685a109-99fd-8b41-6911-5eba8924c0d6@redhat.com>
Date:   Mon, 13 Feb 2023 12:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] iio: light: cm32181: Unregister second I2C client if
 present
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208072141.1103738-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230208072141.1103738-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for working on this, some remarks inline.

On 2/8/23 08:21, Kai-Heng Feng wrote:
> If a second client that talks to the actual I2C address was created in
> probe(), there should be a corresponding cleanup in remove() to avoid
> leakage.
> 
> So if the "client" is not the same one used by I2C core, unregister it
> accordingly.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Use devm_add_action_or_reset() instead of remove() callback to avoid
>    race.
> 
>  drivers/iio/light/cm32181.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b1674a5bfa368..a3e5f56101c9f 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -429,6 +429,16 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +static void cm32181_disable(void *data)
> +{
> +	struct i2c_client *client = data;
> +	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
> +
> +	/* Unregister the dummy client */
> +	if (cm32181->client != client)
> +		i2c_unregister_device(cm32181->client);
> +}
> +
>  static int cm32181_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -479,6 +489,12 @@ static int cm32181_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, cm32181_disable, client);
> +	if (ret) {
> +		dev_err(dev, "%s: add devres action failed\n", __func__);
> +		return ret;
> +	}
> +

This is too late, we will still exit without unregistering the client if
the cm32181_reg_init() call fails.

It would be best to do this directly after the i2c_acpi_new_device()
call, so inside the "if (ACPI_HANDLE(dev) && client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {"
block.

This way you can also remove the "if (cm32181->client != client)"
check from cm32181_disable() since it now only runs when the client
was registered in the first place.

Also please rename cm32181_disable() to cm32181_unregister_dummy_client()
so that the name actually matches what it does.

Regards,

Hans





>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		dev_err(dev, "%s: regist device failed\n", __func__);

