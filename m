Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E46711F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjARD3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjARD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:29:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D6F5087C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:29:43 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0AE1342218
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674012581;
        bh=feJKHenVKLzvev+T8z7P650W/iTpSN+ayNZKXPAdc74=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eMifTxHl8pDX6pZZcYoNrJzpq48I5yW7cGtMEc5hW/xt+7PuedWur323HH+uNIZv6
         UUTi4Ix3+narMujN0lOhUUgCJrd5zcgd+dHo2+j/Ielvew9l9m+vuMTXnIRSCfp+6f
         QVFLAuxH10krGg+UcdpXHpdr4W9FdR7GREz8bNJJUmhaSV0efAZHjhagPGuh0VtYKb
         KMFTxSxpa9VqvNB+Pe87UpYp7B1QWzumSpyMECZRBpM7bxinpAvQ7GIQwQLNuocFTE
         elY29cnhmecmjtJeNSCVhh6spQ8hmA4mf+AG/OV9gX+EtqvDkQRl9fdfTrQvwlfV3N
         PdnUiA5szpyxg==
Received: by mail-pl1-f199.google.com with SMTP id l15-20020a170902f68f00b001948ddc7cddso5438164plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 19:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feJKHenVKLzvev+T8z7P650W/iTpSN+ayNZKXPAdc74=;
        b=lYdsIHo85B8t02J1TNZqr2HqKzTjP0GKwI5drZ1soGCs8lKGIcmJJOQxhkBlMrPS8p
         dI6Sw4x6MuOkQ+1JE5Yvgvgcn8ajhnqMb+7fPl03aW4sR9wlG9phxZuc5EnhX6D1xSn9
         b2r9fOdy4cnaHfJ8TcngVR/sKgfEHZb68cHOe6f84uS6A3mDRo0SC5jBd55XfqU8cuqc
         9gi/hspAlnR+mDSLrsBhYqJEIH5K1jnvpnfPGD1vO2tPMidD1AmQOMYtCj5qSUxL6tGZ
         WfGpX0CLhKeFNU1rp3u7eEbgP0haTpjLdYBgxhutSCMV5lF2XdoOr+fyeH8mJW2Gez/+
         cvgw==
X-Gm-Message-State: AFqh2kptOqv7BuWEgHmNa+KaNlTKwxZTYf5VWasmdcIcTBvRd0wxCKaI
        5Go7Kvvi32WQiVLG+VTW81el8VnkCMcpH3TsATJrH9MoZpi8URQOrE+C9NATVNczPRlCDYD94Ul
        Os1Vq5S6Vu5qVptVG3b4KNAM8tgXIHmjw9eXUdOG6At+yrLctO9+Hoyr2vg==
X-Received: by 2002:a17:90a:8a0d:b0:229:2799:f149 with SMTP id w13-20020a17090a8a0d00b002292799f149mr493607pjn.110.1674012579649;
        Tue, 17 Jan 2023 19:29:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuiufXDZvjsIdQAJnH5w1Sl2NhHYIvgso/aIW7r1aWR2lDegNcwb1PKmoOGqqzW0KJamEVmJXdrlAYKdTZdsi8=
X-Received: by 2002:a17:90a:8a0d:b0:229:2799:f149 with SMTP id
 w13-20020a17090a8a0d00b002292799f149mr493600pjn.110.1674012579225; Tue, 17
 Jan 2023 19:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20230117160951.282581-1-kai.heng.feng@canonical.com> <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
In-Reply-To: <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 18 Jan 2023 11:29:27 +0800
Message-ID: <CAAd53p5DFUMjMNAyp6YVONwCpGs8rRVORj0=OSgj+Z0f3QpeCg@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 1:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/17/23 17:09, Kai-Heng Feng wrote:
> > Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> > with 2 I2C resources") creates a second client for the actual I2C
> > address, but the "struct device" passed to PM ops is the first client
> > that can't talk to the sensor.
> >
> > That means the I2C transfers in both suspend and resume routines can
> > fail and blocking the whole suspend process.
> >
> > Instead of using the first client for I2C transfer, store the cm32181
> > private struct on both cases so the PM ops can get the correct I2C
> > client to perfrom suspend and resume.
> >
> > Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> > Tested-by: Wahaj <wahajaved@protonmail.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Thank you for this fix. I had looking into this on my todo list,
> since I have been seeing some bug reports about this too.
>
> One remark inline:
>
> > ---
> >  drivers/iio/light/cm32181.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > index 001055d097509..0f319c891353c 100644
> > --- a/drivers/iio/light/cm32181.c
> > +++ b/drivers/iio/light/cm32181.c
> > @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
> >       if (!indio_dev)
> >               return -ENOMEM;
> >
> > +     i2c_set_clientdata(client, indio_dev);
> > +
>
> Why move this up, the suspend/resume callbacks cannot run until
> probe() completes, so no need for this change.

The intention is to save indio_dev as drvdata in the first (i.e.
original) i2c_client's dev.

>
> >       /*
> >        * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
> >        * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> > @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
> >               client = i2c_acpi_new_device(dev, 1, &board_info);
> >               if (IS_ERR(client))
> >                       return PTR_ERR(client);
> > -     }
> >
> > -     i2c_set_clientdata(client, indio_dev);
> > +             i2c_set_clientdata(client, indio_dev);
> > +     }
>
> And moving it inside the if block here (instead of just dropping it)
> is also weird. I guess you meant to just delete it since you moved it up.

Doesn't i2c_acpi_new_device() creates a new i2c_client (and its dev embedded)?

So the intention is to save indio_dev for the second (ARA case) i2c_client too.

>
> >
> >       cm32181 = iio_priv(indio_dev);
> >       cm32181->client = client;
>
> Also note that the ->client used in suspend/resume now is not set until
> here, so moving the i2c_set_clientdata() up really does not do anything.
>
> I beleive it would be best to just these 2 hunks from the patch and
> only keep the changes to the suspend/resume callbacks.

Yes, it seems like those 2 hunks are not necessary. Let me send a new patch.

But I do wonder what happens for the removing case? Will the second
i2c_client leak?

Kai-Heng

>
> Regards,
>
> Hans
>
>
> > @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
> >
> >  static int cm32181_suspend(struct device *dev)
> >  {
> > -     struct i2c_client *client = to_i2c_client(dev);
> > +     struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > +     struct i2c_client *client = cm32181->client;
> >
> >       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> >                                        CM32181_CMD_ALS_DISABLE);
> > @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
> >
> >  static int cm32181_resume(struct device *dev)
> >  {
> > -     struct i2c_client *client = to_i2c_client(dev);
> >       struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > +     struct i2c_client *client = cm32181->client;
> >
> >       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> >                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
>
