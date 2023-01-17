Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6532766E4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjAQRVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjAQRU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AEF1EFDF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673975963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewfumNS1FYmWl7FUU1gFFTcCMXASO4AeNvtcvaqR0WA=;
        b=QxPO6vvNAjwf9CpHCm18jQaoPGa+QcX+HETd5pzBnXKu/FsbO/MEXXVaPFGgUC6yJQiqu+
        eeKK6rkZRxb5WYMLCwsbEak1FgIHe7KILqAKYdCQWYiwAhF3twEs7iqLUBLomQ78CPddbd
        QA8L58e8ZqfzXi52Q/3Fn3b9qKyHIXQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-287--r8ogUmyOp6BOlXERnyMiA-1; Tue, 17 Jan 2023 12:19:21 -0500
X-MC-Unique: -r8ogUmyOp6BOlXERnyMiA-1
Received: by mail-ed1-f71.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so22016538edz.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewfumNS1FYmWl7FUU1gFFTcCMXASO4AeNvtcvaqR0WA=;
        b=viv0PwcJfmxL2x4DoLyyUTLKfRdzRbBqQ0fFiw6DD9NNwCSOB8eOXtdmLtjq0a+L4Y
         /n1ESAyLfOF4qo1m42iqifByqLHIGJRT8e1PTg8VFbTc0AVUWN30Y18HGF24ZvwfTXQ/
         qcMb5YR2fGgjfVgM1PvbGyzwl0/veleobpHAG+NYtZOoGVdKe/OcpFtMyLfTbkxKX68o
         zjvrHdsgg84kTyO6pu/+ACuzFZ5l7mZYph/zo3BZCbK3GpF+yXzBqr0qgiKquNw07JqC
         3SmHsm7gYMjr1WkhAQZ1GedkXogRzv3EPIIyVDi0pz9L2aEYJ6RPyRGvK7fCjs4pptvL
         SBFw==
X-Gm-Message-State: AFqh2kpkn7k3SzcSCXobVnFVodjXPjft3Ev94pYF860TQScpX28FbC6/
        YJORvjQyUztV2ZNATySZpZe8VEmXIokwvuDgJIxvwL6+dgCxhjxA8d9PmY7+G8ibuBpiRq1Rfmb
        kyttroEn1wli/xpZOheEJ/c4Q
X-Received: by 2002:a17:906:4684:b0:86f:b99c:ac8d with SMTP id a4-20020a170906468400b0086fb99cac8dmr3783656ejr.44.1673975960612;
        Tue, 17 Jan 2023 09:19:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtAZJ8m8Lta0dHgrvmfc7q8aPjIVicIKus68iWmBIaT/AmiMxP7pYPNDX7CjgN5HodtbJTYdg==
X-Received: by 2002:a17:906:4684:b0:86f:b99c:ac8d with SMTP id a4-20020a170906468400b0086fb99cac8dmr3783645ejr.44.1673975960446;
        Tue, 17 Jan 2023 09:19:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c4b87a69csm13425121ejc.153.2023.01.17.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:19:19 -0800 (PST)
Message-ID: <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
Date:   Tue, 17 Jan 2023 18:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C
 resources
Content-Language: en-US, nl
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117160951.282581-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230117160951.282581-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/17/23 17:09, Kai-Heng Feng wrote:
> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> with 2 I2C resources") creates a second client for the actual I2C
> address, but the "struct device" passed to PM ops is the first client
> that can't talk to the sensor.
> 
> That means the I2C transfers in both suspend and resume routines can
> fail and blocking the whole suspend process.
> 
> Instead of using the first client for I2C transfer, store the cm32181
> private struct on both cases so the PM ops can get the correct I2C
> client to perfrom suspend and resume.
> 
> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> Tested-by: Wahaj <wahajaved@protonmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thank you for this fix. I had looking into this on my todo list,
since I have been seeing some bug reports about this too.

One remark inline:

> ---
>  drivers/iio/light/cm32181.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 001055d097509..0f319c891353c 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	i2c_set_clientdata(client, indio_dev);
> +

Why move this up, the suspend/resume callbacks cannot run until
probe() completes, so no need for this change.

>  	/*
>  	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>  	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
>  		client = i2c_acpi_new_device(dev, 1, &board_info);
>  		if (IS_ERR(client))
>  			return PTR_ERR(client);
> -	}
>  
> -	i2c_set_clientdata(client, indio_dev);
> +		i2c_set_clientdata(client, indio_dev);
> +	}

And moving it inside the if block here (instead of just dropping it)
is also weird. I guess you meant to just delete it since you moved it up.

>  
>  	cm32181 = iio_priv(indio_dev);
>  	cm32181->client = client;

Also note that the ->client used in suspend/resume now is not set until
here, so moving the i2c_set_clientdata() up really does not do anything.

I beleive it would be best to just these 2 hunks from the patch and
only keep the changes to the suspend/resume callbacks.

Regards,

Hans


> @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
>  
>  static int cm32181_suspend(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 CM32181_CMD_ALS_DISABLE);
> @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
>  
>  static int cm32181_resume(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);

