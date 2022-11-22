Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916ED633FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiKVPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKVPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:13:24 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE11B791;
        Tue, 22 Nov 2022 07:13:23 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 7so17621586ybp.13;
        Tue, 22 Nov 2022 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTPGbQKklg3WPb4L2pCSqb2WzLeJedtyuqo1q379m1A=;
        b=ialhRJddDMj4ibZs8gQX1Ey4rorGR/1j+F+b6ETvqWOvKsNlGXPDg2T3IMYJwGy3lu
         uFdbVef2YndOpg5qrZ0hZQgfjPcZmHd4QSi81HLyJ4jhHhVhBMpq8VeMNgmtYcLbmI+q
         i9Xf8wP+bzvAdxNsGx7jxXXcx0JOHrkXCoKUA0KPyWnIgEcGs8jSGozgvIoCpTajCHTy
         zBhh4OZB1Q2hPQLb6FpaLvWaViEkR84hVjgjhqQbMOFQrZs5eIJ0GcCDO2ZZ+qK0Rxs9
         g7juESUZ2hOWmZmPp1oejsX6rtA/to54sJSpwyjXB0nHk394qgpNmCcToEhMJLL3WyC1
         atFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTPGbQKklg3WPb4L2pCSqb2WzLeJedtyuqo1q379m1A=;
        b=X2aHGElRWKUAfopCOJ6tRYzS5M8ep43h4ODnu0YXfXOMzufX6fRjz6Kk5reVhmBPuf
         YiANCwqs1afKd0PZfoEFT0YqkuVqIa8L9Pb5JWMuAIZgh5HOyBfMhj8RqoAn8NzIBPpg
         5jDmAjptqqaYdOM50fN1O+86RPp7TiT8Gzvma+FLziCBK847zP56fusopzF92jD8QhVd
         BS6dbtSVU4Xx5fmxkrMp6yHTWOJTrS/1yr5nbPIpYzmwzdh+wLgZX0ENEbYgI0+T3ApV
         ZCsce8AhXF+FFRw06L3l5gLae8I3EUMlr5GP4rY+FnvnLEQOPrXEhDvF/KO2lfvYFQ1I
         3NEw==
X-Gm-Message-State: ANoB5pm8mKPG2lCn+F7okPGus6FdjpbK7A734021Tqce5E535GKShAte
        /XOdzo7pqrIypur5yq5t1FyZ56gvVu1c4zwpDDQ4D8Ik
X-Google-Smtp-Source: AA0mqf5oWk8PwJBLc+tM5kalC/Q5zxw8k9YnsAMKTlWyb9fASLv+GLqH9r8CYg4au+EZPFkcy499KqY7Jfwga29nI80=
X-Received: by 2002:a25:5cb:0:b0:6e7:868:405d with SMTP id 194-20020a2505cb000000b006e70868405dmr10725845ybf.389.1669130002937;
 Tue, 22 Nov 2022 07:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20221122141434.30498-1-lukas.bulwahn@gmail.com> <0O6RLR.G9QGB8EGFCT01@crapouillou.net>
In-Reply-To: <0O6RLR.G9QGB8EGFCT01@crapouillou.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 22 Nov 2022 16:13:12 +0100
Message-ID: <CAKXUXMywmFc4TVBu8iDkoesMnGhStmGNPc5EqT0dFT_CKvr+3w@mail.gmail.com>
Subject: Re: [PATCH] clocksource: ingenic-ost: define pm functions properly in
 platform_driver struct
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 22, 2022 at 3:24 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Lukas,
>
> Le mar. 22 nov. 2022 =C3=A0 15:14:34 +0100, Lukas Bulwahn
> <lukas.bulwahn@gmail.com> a =C3=A9crit :
> > Commit ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx
> > OST")
> > adds the struct platform_driver ingenic_ost_driver, with the
> > definition of
> > pm functions under the non-existing config PM_SUSPEND, which means the
> > intended pm functions were never actually included in any build.
> >
> > Since commit 7a82e97a11b9 ("PM: core: introduce pm_ptr() macro"), the
> > default pattern for platform_driver definitions is to use pm_ptr().
> > Assuming CONFIG_PM_SUSPEND really intended to mean CONFIG_PM (and not
> > CONFIG_PM_SLEEP), use pm_ptr() just as most other drivers do.
>
> It actually was supposed to be CONFIG_PM_SLEEP, yes. You can see that
> because the only callbacks are .suspend_noirq and .resume_noirq.
> Therefore you can use pm_sleep_ptr() instead of pm_ptr().
>
> By the way, once you use this macro then the __maybe_unused tags on the
> dev_pm_ops structure and its callbacks are not needed anymore, so you
> can remove these as well.
>
> > Fixes: ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx
> > OST")
>
> That Fixes: tag won't work since the pm_ptr() macro did not exist back
> then (besides, you didn't Cc linux-stable).
>
> I'd advocate to remove the Fixes: tag, since it is not really a bug
> fix, more like an improvement.
>

Thanks for the quick feedback. I will send a patch v2 incorporating that.

Lukas

> Cheers,
> -Paul
>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  drivers/clocksource/ingenic-ost.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/clocksource/ingenic-ost.c
> > b/drivers/clocksource/ingenic-ost.c
> > index 06d25754e606..6b64731df15c 100644
> > --- a/drivers/clocksource/ingenic-ost.c
> > +++ b/drivers/clocksource/ingenic-ost.c
> > @@ -181,9 +181,7 @@ static const struct of_device_id
> > ingenic_ost_of_match[] =3D {
> >  static struct platform_driver ingenic_ost_driver =3D {
> >       .driver =3D {
> >               .name =3D "ingenic-ost",
> > -#ifdef CONFIG_PM_SUSPEND
> > -             .pm =3D &ingenic_ost_pm_ops,
> > -#endif
> > +             .pm =3D pm_ptr(&ingenic_ost_pm_ops),
> >               .of_match_table =3D ingenic_ost_of_match,
> >       },
> >  };
> > --
> > 2.17.1
> >
>
>
