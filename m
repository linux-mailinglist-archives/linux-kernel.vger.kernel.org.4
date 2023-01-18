Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36D67247E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjARRIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjARRIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781F54208
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674061671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBANv9H3NJKZ6sjNqm34M+TVsHXbeGsvXhw690AG2bM=;
        b=DLiaB+U+atgut1xhP5ZUlXwXDOLyl69+GcQWmcEhZfYU9/98iohoOf1nKQgpLTJX1ZHLQ+
        yEO3BMDbPt7MPV+LPW2kdgGJCI8EGtvX7RjLtygoLjUMREzc9RPbc6Drj4w/pVG9uA8qHv
        T8VIMTds5f6kN8jKzUov8uPbyb5Ft4c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-feDjGFwpNGCA-GBCj4V04g-1; Wed, 18 Jan 2023 12:07:49 -0500
X-MC-Unique: feDjGFwpNGCA-GBCj4V04g-1
Received: by mail-ed1-f70.google.com with SMTP id z2-20020a056402274200b0049e48d86760so1983063edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBANv9H3NJKZ6sjNqm34M+TVsHXbeGsvXhw690AG2bM=;
        b=ugOGH9jmtj0+ziu4RJ+AM3KMy92b53TQ4iA6jZYdEq9oK+0eHPb1WHn88ZBGiqP1gy
         R+8o0ITnTrSILorC5FP/3ir9CI6v8gNAUvSOOtMaqdNuCL9QtZYLCK56+zmdePTBmQBz
         XhjqlnNmgPJfSQHVZ5BRo0DTY+PJXkVpNwV4WM9NDvr0BM0ejWmwMtp+LRm0AvlMWxxY
         nOvkqxZM/P8LPUgozueqfmcq8Taa9EzKdRnT2tSxdRiJOgBnPmI6QYX9srabr0S4upaq
         Da03dNucNLe7828zzMq69Er08F09tr28l/UZbziSYrYdqzk42X338FGAX/uTh68SO2tl
         XWUA==
X-Gm-Message-State: AFqh2ko4EEL2DEgMvCTc8FAGxw48fzjzVPUpjxHyjtSrY/1niUYmpkSF
        mpy6KAZ9+in50oI2Ecs8ZzZz6uVjTgtDSrgIQB8O4XM0pc3ChfsFas0+LXD23PqYOn3QNGS410W
        JfMe22ZDYnZ/2oNMXDqJmZ5t7
X-Received: by 2002:a05:6402:3496:b0:48e:9c36:6c39 with SMTP id v22-20020a056402349600b0048e9c366c39mr10655816edc.0.1674061667348;
        Wed, 18 Jan 2023 09:07:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuM6N50uo34MhuDQ2myK4tmuRftD6RxUPFaD0W5wWJaH1S/YZtVCY64QmVFCMkp4Ewl6ol/wg==
X-Received: by 2002:a05:6402:3496:b0:48e:9c36:6c39 with SMTP id v22-20020a056402349600b0048e9c366c39mr10655801edc.0.1674061667188;
        Wed, 18 Jan 2023 09:07:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906538d00b0085a958808c6sm10297082ejo.7.2023.01.18.09.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:07:46 -0800 (PST)
Message-ID: <3d51f766-bd80-870d-c939-99660526c654@redhat.com>
Date:   Wed, 18 Jan 2023 18:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: light: cm32181: Fix PM support on system with 2
 I2C resources
Content-Language: en-US, nl
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118170422.339619-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230118170422.339619-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/23 18:04, Kai-Heng Feng wrote:
> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> with 2 I2C resources") creates a second client for the actual I2C
> address, but the "struct device" passed to PM ops is the first I2C
> client that can't talk to the sensor.
> 
> That means the I2C transfers in both suspend and resume routines can
> fail and blocking the whole suspend process.
> 
> Instead of using the first client for I2C transfer, use the I2C client
> stored in the cm32181 private struct so the PM ops can get the correct
> I2C client to really talk to the sensor device.
> 
> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> BugLink: https://bugs.launchpad.net/bugs/1988346
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Tested-by: Wahaj <wahajaved@protonmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2:
>  - Removed setting drvdata to the dummy client.
>  - Added bug links.
>  - Wording.
> 
>  drivers/iio/light/cm32181.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 001055d097509..b1674a5bfa368 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	i2c_set_clientdata(client, indio_dev);
> +
>  	/*
>  	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>  	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> @@ -460,8 +462,6 @@ static int cm32181_probe(struct i2c_client *client)
>  			return PTR_ERR(client);
>  	}
>  
> -	i2c_set_clientdata(client, indio_dev);
> -
>  	cm32181 = iio_priv(indio_dev);
>  	cm32181->client = client;
>  	cm32181->dev = dev;
> @@ -490,7 +490,8 @@ static int cm32181_probe(struct i2c_client *client)
>  
>  static int cm32181_suspend(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 CM32181_CMD_ALS_DISABLE);
> @@ -498,8 +499,8 @@ static int cm32181_suspend(struct device *dev)
>  
>  static int cm32181_resume(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);

