Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A935FD3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJME3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJME3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:29:08 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD2110B02
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:29:07 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so1019217fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYIIq0zO9axQJUK4FF0gEw5z0+wm+xs5xbHKpjK1nxE=;
        b=aeRtqd2Sh3gnMbaYcXg+1q+5/bEdCg3LbB9VVrDjLOskPXni1TjtP+R2a1fMZ0D2xQ
         5v+cLRSwJTv6bGpPDqXn72QFCQ1umXDphtFov4hsKy8L+fE2nsHpINSRlgB/7hP3M+WE
         51FqSr1Ing7WnFu+YdZQ/wAoKOQlQbPnlNJ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SYIIq0zO9axQJUK4FF0gEw5z0+wm+xs5xbHKpjK1nxE=;
        b=ohI1Z4cO/GHSa4Q2fx4cBvZuGMKtMSEMfCSr1B0ckoFoicEgeKk8yMmKnIC56kChuV
         HJvF/TFyRNDwBdlY1OjAKGvwWYyDyyrBM43OG1fNTiAFfGHtiG6cPtZkPiuhIVQy3XVO
         S4Zg6be6l51euV82zZ2FaZ7T2o1S5bAxIm90SfFV0jgxmyw6TY/iGcA8CuJuths0BItZ
         FkNm11fwF8KEDLCgLiP/pKWirqEo8CqlRmm2RxlkhLlrMxx6QUHtCyao4XYO1qAPrm9e
         1SLO9R5mz6aZcSa5Hua4AaC5lUI+/rlaUxb8Z2JHgyX5S5OBwd9DZ7oqQyw1hKYOUa7G
         cygw==
X-Gm-Message-State: ACrzQf2RmAoaBJdJ/yzLzAFhF/wd3zzug01ZLGP/c1A8Czt4ZupJkCnQ
        jr+Kro48MJ06i2Nkg6yvIgBBvyw/sPRF+w==
X-Google-Smtp-Source: AMsMyM5tQ1GyTxX06uD3t1+sqbC651364jK0uqQhGWVrM71qeTn5MmPhAZSAwzcCHj3V2k1YSnS5iQ==
X-Received: by 2002:a05:6870:390b:b0:132:9ca3:8dc1 with SMTP id b11-20020a056870390b00b001329ca38dc1mr4387539oap.106.1665635345900;
        Wed, 12 Oct 2022 21:29:05 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id em37-20020a0568705ba500b00127ba61535fsm2080100oab.15.2022.10.12.21.29.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 21:29:04 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id c187-20020a4a4fc4000000b004808e2f7affso560233oob.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:29:04 -0700 (PDT)
X-Received: by 2002:a4a:c11a:0:b0:480:6f49:51c8 with SMTP id
 s26-20020a4ac11a000000b004806f4951c8mr7835433oop.47.1665635343943; Wed, 12
 Oct 2022 21:29:03 -0700 (PDT)
Received: from 190990251477 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Oct 2022 21:29:03 -0700
MIME-Version: 1.0
In-Reply-To: <Y0Z++9QUAOOUAQrj@google.com>
References: <20221012040918.272582-1-dcallagh@chromium.org>
 <20221012040918.272582-2-dcallagh@chromium.org> <Y0Z++9QUAOOUAQrj@google.com>
From:   Dan Callaghan <dcallagh@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 12 Oct 2022 21:29:03 -0700
X-Gmail-Original-Message-ID: <CAL=kDigzLLfqxJyGCon3Tk6jHH0r=Zw9ZJDT0LL4Rcr8tmmppw@mail.gmail.com>
Message-ID: <CAL=kDigzLLfqxJyGCon3Tk6jHH0r=Zw9ZJDT0LL4Rcr8tmmppw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] platform/chrome: add a driver for HPS
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?U2FtaSBLecO2c3RpbMOk?= <skyostil@chromium.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Tzung-Bi Shih=E2=80=99s message of 2022-10-12 19:46:51 +1100:
> On Wed, Oct 12, 2022 at 03:09:18PM +1100, Dan Callaghan wrote:
> > ---
>
> It doesn't need a cover letter if the series only has 1 patch in general.
> Instead, it could put additional information (and changelogs) after "---"=
.

Understood, I'll omit the cover letter in future postings.

> > diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/=
chrome/cros_hps_i2c.c
> [...]
> > +static int hps_i2c_probe(struct i2c_client *client)
> > +{
> > +     struct hps_drvdata *hps;
> > +     int ret;
> > +
> > +     hps =3D devm_kzalloc(&client->dev, sizeof(*hps), GFP_KERNEL);
> > +     if (!hps)
> > +             return -ENOMEM;
> > +
> > +     memset(&hps->misc_device, 0, sizeof(hps->misc_device));
>
> The memset can be dropped.  `hps` is z-allocated.

I'll take this out.

> > +     hps->misc_device.parent =3D &client->dev;
> > +     hps->misc_device.minor =3D MISC_DYNAMIC_MINOR;
> > +     hps->misc_device.name =3D "cros-hps";
> > +     hps->misc_device.fops =3D &hps_fops;
> > +
> > +     i2c_set_clientdata(client, hps);
> > +     hps->client =3D client;
>
> To be neat, I would prefer to insert a blank line here.

Sure, will add one.

> > +     hps->enable_gpio =3D devm_gpiod_get(&client->dev, "enable", GPIOD=
_OUT_HIGH);
> > +     if (IS_ERR(hps->enable_gpio)) {
> > +             ret =3D PTR_ERR(hps->enable_gpio);
> > +             dev_err(&client->dev, "failed to get enable gpio: %d\n", =
ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D misc_register(&hps->misc_device);
> > +     if (ret) {
> > +             dev_err(&client->dev, "failed to initialize misc device: =
%d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     hps_set_power(hps, false);
>
> IIUC, the GPIO will raise to HIGH in the first place, and then fall
> to LOW until here.  Is it an expected behavior?  How about gpiod_get()
> with GPIOD_OUT_LOW?

It might seem a little unusual, but it is intentional. The enable line is
already high when we enter the kernel from firmware. Acquiring the GPIO
line with GPIOD_OUT_HIGH preserves its existing state (high) in case later
steps fail.

We power off the periphal only once the driver is successfully bound and ha=
s
taken control of its power state.

> > +static int hps_i2c_remove(struct i2c_client *client)
> > +{
> > +     struct hps_drvdata *hps =3D i2c_get_clientdata(client);
> > +
> > +     pm_runtime_disable(&client->dev);
> > +     misc_deregister(&hps->misc_device);
> > +     hps_set_power(hps, true);
>
> Why does it need to raise the GPIO again when removing the device?

Similar to the above, we want to preserve the default power state
(i.e. powered on) whenever the driver is not bound to the device.

This behaviour made sense to us mainly because we were originally controlli=
ng
the peripheral entirely from userspace, so it was always powered on by defa=
ult.

Do you think this behaviour is acceptable, or do we need to change it?

--=20
Dan Callaghan <dcallagh@chromium.org>
Software Engineer, Google
