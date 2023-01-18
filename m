Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8989D672463
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjARRER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:04:14 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4421C1716E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:04:13 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED6433F124
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674061450;
        bh=5SYtdRB0wOm4T2jCfMhlLtgKk9wbubyH9yWyonQFCeo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HegGUkjwxA1EbOcPrm0roQ/sUaAVTKtyjIgM3k5cNz1C9EFPdYt1zLgHsFkT0FZka
         DJ6bZipC6OcMOz22H4NvICYgsfbJiS4dabuUMEELlFRLF7ra31pxXjutPofGaF7CxM
         bwHxz616ko0Ixp4I0FqXcNwzc0NOSBYSIgf1lOmUE6DPs9fHuiKHJNAVRb3cz0TSkk
         wyiz0muh94Vyh6d2oLnpqDueQ4GQt7P3bitRoype45UQGxDc7cE6ddgr1K6Cc8QR0s
         bx9fBLcDIJDKAqNJTbIcbpCUNNWDpsrRSCSZj7XS+69JHgJDFfVz+jLm15MyWnZ+pX
         L8C/5bgtUFXRQ==
Received: by mail-pl1-f200.google.com with SMTP id i16-20020a17090332d000b00194a7b146b2so3562085plr.20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SYtdRB0wOm4T2jCfMhlLtgKk9wbubyH9yWyonQFCeo=;
        b=KvIyMzZgC6caodpSvetHm+ngj2NrIP3UfWpK5+yO5TMLyzObZE4txe6THaBKsEiHiU
         XjsgAQBQzmTEiSu6VZ7oEgXsAapgyWhMzL/Jwg9o+7TjOBqqGXYIJwjLX/yoTuGsFTkt
         CoaxOWWc4NNe1qRSAm2t0OTD4jp65oKVfff9dXHSCmshqeEkbzSQH446yMbRzucrMHZy
         TeqoBGVrlwVBRvjFLtsm4KxpYWCR4JVo1hReB/ofD1vwMAVCd9tkvG88Mi+VrtvlCDcU
         fJjjj4D3WBCUKgb9sP6tJnpRkUhUcX7m6dMf7po4D7DS6AEu+aVNxDSs/GkPm7MNUeFt
         dbJQ==
X-Gm-Message-State: AFqh2krN/5kdq/y45n6INerixeu/wjIxRgMsgv9gNDucppSwI4iMhqcz
        3AhVk334aoOa3dYu7TNxZv0/kZgWvnS2+NbwnSIkQR15Uwiq40LzfHPF0FmRVoE0bkGg5QeCprk
        pUKVFGV1ETeMOXdmD5Vo2i7emQBPOSY4GXsFp8FQLN/V2o5BPaBpiPYrZow==
X-Received: by 2002:a63:5303:0:b0:478:ac4b:bd6f with SMTP id h3-20020a635303000000b00478ac4bbd6fmr542410pgb.435.1674061449271;
        Wed, 18 Jan 2023 09:04:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtrcuIx8bawaThYbiDoMBBBOPRIMttzcMSs8VmThqWTbakfGUwSQOMEf/UWj3WSAs0YIONYFcA8sDM/WU8GNz4=
X-Received: by 2002:a63:5303:0:b0:478:ac4b:bd6f with SMTP id
 h3-20020a635303000000b00478ac4bbd6fmr542402pgb.435.1674061448883; Wed, 18 Jan
 2023 09:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20230117160951.282581-1-kai.heng.feng@canonical.com>
 <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com> <CAAd53p5DFUMjMNAyp6YVONwCpGs8rRVORj0=OSgj+Z0f3QpeCg@mail.gmail.com>
 <CAAd53p5XXCniBN7x4uhp4XW=qr2U72_UntgAR0BV2viRtd+8EA@mail.gmail.com> <a9db708f-59a6-586a-8728-81622a93ef3e@redhat.com>
In-Reply-To: <a9db708f-59a6-586a-8728-81622a93ef3e@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 19 Jan 2023 01:03:57 +0800
Message-ID: <CAAd53p76cC5P+5-8Dbego6XCkRcvBaQqzf_8SikYEND+_o7vSw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C resources
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de,
        Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Jan 18, 2023 at 6:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/18/23 06:15, Kai-Heng Feng wrote:
> > On Wed, Jan 18, 2023 at 11:29 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Hi Hans,
> >>
> >> On Wed, Jan 18, 2023 at 1:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 1/17/23 17:09, Kai-Heng Feng wrote:
> >>>> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> >>>> with 2 I2C resources") creates a second client for the actual I2C
> >>>> address, but the "struct device" passed to PM ops is the first client
> >>>> that can't talk to the sensor.
> >>>>
> >>>> That means the I2C transfers in both suspend and resume routines can
> >>>> fail and blocking the whole suspend process.
> >>>>
> >>>> Instead of using the first client for I2C transfer, store the cm32181
> >>>> private struct on both cases so the PM ops can get the correct I2C
> >>>> client to perfrom suspend and resume.
> >>>>
> >>>> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> >>>> Tested-by: Wahaj <wahajaved@protonmail.com>
> >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>
> >>> Thank you for this fix. I had looking into this on my todo list,
> >>> since I have been seeing some bug reports about this too.
> >>>
> >>> One remark inline:
> >>>
> >>>> ---
> >>>>  drivers/iio/light/cm32181.c | 11 +++++++----
> >>>>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> >>>> index 001055d097509..0f319c891353c 100644
> >>>> --- a/drivers/iio/light/cm32181.c
> >>>> +++ b/drivers/iio/light/cm32181.c
> >>>> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
> >>>>       if (!indio_dev)
> >>>>               return -ENOMEM;
> >>>>
> >>>> +     i2c_set_clientdata(client, indio_dev);
> >>>> +
> >>>
> >>> Why move this up, the suspend/resume callbacks cannot run until
> >>> probe() completes, so no need for this change.
> >>
> >> The intention is to save indio_dev as drvdata in the first (i.e.
> >> original) i2c_client's dev.
> >>
> >>>
> >>>>       /*
> >>>>        * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
> >>>>        * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> >>>> @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
> >>>>               client = i2c_acpi_new_device(dev, 1, &board_info);
> >>>>               if (IS_ERR(client))
> >>>>                       return PTR_ERR(client);
> >>>> -     }
> >>>>
> >>>> -     i2c_set_clientdata(client, indio_dev);
> >>>> +             i2c_set_clientdata(client, indio_dev);
> >>>> +     }
> >>>
> >>> And moving it inside the if block here (instead of just dropping it)
> >>> is also weird. I guess you meant to just delete it since you moved it up.
> >>
> >> Doesn't i2c_acpi_new_device() creates a new i2c_client (and its dev embedded)?
> >>
> >> So the intention is to save indio_dev for the second (ARA case) i2c_client too.
> >>
> >>>
> >>>>
> >>>>       cm32181 = iio_priv(indio_dev);
> >>>>       cm32181->client = client;
> >>>
> >>> Also note that the ->client used in suspend/resume now is not set until
> >>> here, so moving the i2c_set_clientdata() up really does not do anything.
> >>>
> >>> I beleive it would be best to just these 2 hunks from the patch and
> >>> only keep the changes to the suspend/resume callbacks.
> >>
> >> Yes, it seems like those 2 hunks are not necessary. Let me send a new patch.
> >
> >         if (ACPI_HANDLE(dev) && client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {
> >                 ...
> >                 client = i2c_acpi_new_device(dev, 1, &board_info);
> >                 ...
> >         }
> >         i2c_set_clientdata(client, indio_dev);
> >
> > It means the indio_dev is only assigned to the new i2c_client->dev's
> > drvdata, the original dev's drvdata remains NULL.
> > So we need to assign it before the original client gets replaced by
> > the new one, otherwise we can't get cm32181 in PM ops.
>
> You are right, my bad. The original code has a bug where it indeed was
> making the i2c_set_clientdata() call on the wrong client device.
>
> So the i2c_set_clientdata() call needs to be moved up.
>
> There is no need to also call i2c_set_clientdata() on the dummy
> i2c-client though. That one does not have a driver attached.

Sure, will update this in v2.

>
> The suspend/resume callbacks are made on the original client-dev,
> not on the one of the dummy-client (which is the one which we
> actually use to communicate).
>
> >> But I do wonder what happens for the removing case? Will the second
> >> i2c_client leak?
>
> Yes it does, good point. That should probably also be fixed, but
> that needs to be a different / second patch.

Agree, thanks for the input.

Kai-Heng

>
> Regards,
>
> Hans
>
>
>
> >>>> @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
> >>>>
> >>>>  static int cm32181_suspend(struct device *dev)
> >>>>  {
> >>>> -     struct i2c_client *client = to_i2c_client(dev);
> >>>> +     struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> >>>> +     struct i2c_client *client = cm32181->client;
> >>>>
> >>>>       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> >>>>                                        CM32181_CMD_ALS_DISABLE);
> >>>> @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
> >>>>
> >>>>  static int cm32181_resume(struct device *dev)
> >>>>  {
> >>>> -     struct i2c_client *client = to_i2c_client(dev);
> >>>>       struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> >>>> +     struct i2c_client *client = cm32181->client;
> >>>>
> >>>>       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> >>>>                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> >>>
> >
>
