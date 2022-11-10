Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA5E623F55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKJKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKJKEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:04:13 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4376AECA;
        Thu, 10 Nov 2022 02:04:12 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id z17so774468qki.11;
        Thu, 10 Nov 2022 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XV85RM2D5cPjJ+hWNkLRIR1G9UoikIDXt1LLlRhD8A=;
        b=qwwP6pmhD2bq2AH8IBA0Rh1N4i9O/412YKIKLExn+zHrY9YTlyQ//cUDeOa7bjPHms
         +L1q0CGTs3b/kyHb3g66t3mRyI49Wob8/nZF59DMBZbsgmzVUh8TFZTWN4Kpqt6+fD1h
         V3UmjGtJDArMDjkrwQFtOgf3BSObX904yIe8Bs0B4JVQbs1Tko5/cq1yQO/Hd5LvzuG3
         Xs31Uc41I0GCXlhGg42qUHe+w7n/LxEkGpkztdmPjg8vWRINNpRfsSvq/WZlGrqJKOmz
         p5OdRwWsjqHlcgF9Vbbxsl29vcgwA5TAdIcfZ6zaTJPpk8Ktnz6TogamhZLEfHkBXZc0
         C0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XV85RM2D5cPjJ+hWNkLRIR1G9UoikIDXt1LLlRhD8A=;
        b=6Cg5nKkLOYq6GyGUJX2xs4trfrU4ijIP1DRQPnTUTuJ0mNs5o84ZOviyKumpZ53pMh
         9uumbUBu5/JfSoVJsBngiiofj+pARstuQ52LhshjYi9f5kXBrZDJt+52p6tR1gY/zMni
         4EW6AQ4Dv/DdhrPf40zPrcjF4joQqB60/ffUxN2r3aN0gH5TWpr8O6B/ckRh6XMefDq6
         FOA9xElh9jIL+6S8T/mXvwOKT9VSBVgt9MAux7mGEYi/UxTu1IuKeJTnUoIKTGc3zkvI
         00w5KqPoOYSXHpS+K4luNp4VKkEwzZq/w8PiMG0Va6rTCjbKQaYfBl5i+MdRbyLapsjC
         TKSw==
X-Gm-Message-State: ANoB5pn1BlVQYA473hZO8GP/hfUGqzDkm52TptrqbO14STLUtgTjHup8
        CBRclg3yww/lq1YTFMNoLVOGfoRHUDtgko4t5h5VDj3A870bpPM4
X-Google-Smtp-Source: AA0mqf4zHFh5SBbSfQrtRwY9yFVtZhCvvTx6CtptTUQguahvGhZiglgxtVq1RGQe3ciWfcFRPPydbqdMTqbrOAXLDaI=
X-Received: by 2002:a37:8784:0:b0:6fb:25ba:3d32 with SMTP id
 j126-20020a378784000000b006fb25ba3d32mr547170qkd.504.1668074651427; Thu, 10
 Nov 2022 02:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-7-andriy.shevchenko@linux.intel.com> <20221110074456.hgmu7d5mn5kndc66@pengutronix.de>
In-Reply-To: <20221110074456.hgmu7d5mn5kndc66@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Nov 2022 12:03:35 +0200
Message-ID: <CAHp75Vcky+1jcjAtQ+RwcnK6TjWrsK8UMSa7hO3wmDL0Eb6beQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pinctrl: intel: Enumerate PWM device when
 community has a capabilitty
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 9:45 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 08, 2022 at 04:22:26PM +0200, Andy Shevchenko wrote:
> > Some of the Communities may have PWM capability. In such cases,
> > enumerate PWM device via respective driver. User is still responsible
> > for setting correct pin muxing for the line that needs to output the
> > signal.

...

> > +     pwm =3D pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info)=
;
> > +     if (IS_ERR(pwm) && PTR_ERR(pwm) !=3D -ENODEV)
> > +             return PTR_ERR(pwm);
>
> Linus and Andy already agreed that this patch is ugly. I wonder if this
> here would be a bit less ugly if you do:
>
>         if (IS_REACHABLE(...)) {
>                 pwm =3D pwm_lpss_probe(...);
>                 ...
>
>
>         }
>
> and drop the check PTR_ERR(pwm) !=3D -ENODEV (which might have a differen=
t
> semantic than "the pwm driver isn't available").

I will think about it (in such case the comment against the previous
patch makes more sense to me).

Thank you for the review!

--=20
With Best Regards,
Andy Shevchenko
