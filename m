Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4601E6E1917
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDNAg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDNAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:36:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F656B1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:36:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h198so23820966ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681432583; x=1684024583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay/CcEIvoPOo3V/jjcAmNDj7kSwO97+ln0Uh81qk+0Q=;
        b=d88SKQMELRGYX7aa74mjKWzryq0icaPMiwXmidmJpco6WiHrjMG/udcUIYVyH4cOxF
         hEovDe0Ybe4YSCta5S3LlEwgKw347CO+M0Aq2375Lq+kGi66Oi4SYqUb689ZeCa7/Np9
         PPW7/Qrq1woMEcBuRom3e89/RNFpujSJCUx3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681432583; x=1684024583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay/CcEIvoPOo3V/jjcAmNDj7kSwO97+ln0Uh81qk+0Q=;
        b=ASm5zrLIkC1WvMLBPaZ2L7ea7rjBgvJczSVUJdaUUT+TdfPkqYvBZdv8Tm8AnJwlJ8
         2RtCWPVgo/QbDajCbef2dLfVCWWd0be+pyT1C7G52P5+lfa5Zyi/UymhHpf77AjnhP8t
         ruNZcA4iFZS30ecGBM1HOJvR6+bSO5eKDIPL/SO0mjF7jyiIS0dAMS8hgzCjqAzUKxOS
         PFlyxx1dw7a/Ao1SFfd08CHhMe+3Qvy8qFnM+YnXlS3ZX2qvFO/8AtUMzjL/zyRHWSOy
         TuzyAb8n7B9wonFAoPUu8zeF6/3DKrXMmSf3VqGDmwPmwMLEyUUn6JSqDO/sUQxD2cr0
         fxnw==
X-Gm-Message-State: AAQBX9e7aadHM6VX6BRP4UfPcQTnk4hO8eV4MGidjlb8IBqG0Z1gC8Tg
        ZfEP9hM2Ux3AXyHtO1ClgG3BwgHLKlEXbQQYttA=
X-Google-Smtp-Source: AKy350b3b4F9XsGlaTFENMAQxEN9XhsS1sfztgjEBGSU/EfIvmWfYj+UF9usOFm5LQVtT0xCh1bmdQ==
X-Received: by 2002:a25:68cc:0:b0:b8e:ce44:3eb5 with SMTP id d195-20020a2568cc000000b00b8ece443eb5mr4931834ybc.19.1681432583370;
        Thu, 13 Apr 2023 17:36:23 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id d6-20020a258246000000b00b7d2204cd4bsm795970ybn.21.2023.04.13.17.36.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 17:36:22 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g10so463133ybu.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:36:22 -0700 (PDT)
X-Received: by 2002:a25:d24e:0:b0:b8b:eea7:525b with SMTP id
 j75-20020a25d24e000000b00b8beea7525bmr2566656ybg.7.1681432581986; Thu, 13 Apr
 2023 17:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
 <20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid> <CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com>
In-Reply-To: <CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Apr 2023 17:36:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wqu21ErJGwf24mkFcXTZx_vR1r++0cP68vr9FQDY8O-A@mail.gmail.com>
Message-ID: <CAD=FV=Wqu21ErJGwf24mkFcXTZx_vR1r++0cP68vr9FQDY8O-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] regulator: core: Avoid lockdep reports when
 resolving supplies
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
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

Hi,

On Fri, Apr 7, 2023 at 2:46=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> w=
rote:
>
> Quoting Douglas Anderson (2023-03-29 14:33:54)
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 9a13240f3084..08726bc0da9d 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -207,6 +207,78 @@ static void regulator_unlock(struct regulator_dev =
*rdev)
> >         mutex_unlock(&regulator_nesting_mutex);
> >  }
> >
> > +/**
> > + * regulator_lock_two - lock two regulators
> > + * @rdev1:             first regulator
> > + * @rdev2:             second regulator
> > + * @ww_ctx:            w/w mutex acquire context
> > + *
> > + * Locks both rdevs using the regulator_ww_class.
> > + */
> > +static void regulator_lock_two(struct regulator_dev *rdev1,
> > +                              struct regulator_dev *rdev2,
> > +                              struct ww_acquire_ctx *ww_ctx)
> > +{
> > +       struct regulator_dev *tmp;
> > +       int ret;
> > +
> > +       ww_acquire_init(ww_ctx, &regulator_ww_class);
> > +
> > +       /* Try to just grab both of them */
> > +       ret =3D regulator_lock_nested(rdev1, ww_ctx);
> > +       WARN_ON(ret);
> > +       ret =3D regulator_lock_nested(rdev2, ww_ctx);
> > +       if (ret !=3D -EDEADLOCK) {
> > +               WARN_ON(ret);
> > +               goto exit;
> > +       }
>
> I think this would be clearer if we had two local variable pointers
>
>         struct regulator_dev *held, *contended;
>
>         held =3D rdev1;
>         contended =3D rdev2;
>
> > +
> > +       while (true) {
> > +               /*
> > +                * Start of loop: rdev1 was locked and rdev2 was conten=
ded.
> > +                * Need to unlock rdev1, slowly lock rdev2, then try rd=
ev1
> > +                * again.
> > +                */
> > +               regulator_unlock(rdev1);
>
>                 regulator_unlock(held);
>
> > +
> > +               ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
> > +               rdev2->ref_cnt++;
> > +               rdev2->mutex_owner =3D current;
> > +               ret =3D regulator_lock_nested(rdev1, ww_ctx);
>
>                 ww_mutex_lock_slow(&contended->mutex, ww_ctx);
>                 contended->ref_cnt++;
>                 contended->mutex_owner =3D current;
>                 swap(held, contended);
>                 ret =3D regulator_lock_nested(contended, ww_ctx);
>                 if (ret !=3D -EDEADLOCK) {

Sure, I can do the rename to make it clearer. OK, sent out as
("regulator: core: Make regulator_lock_two() logic easier to follow")
[1]

[1] https://lore.kernel.org/r/20230413173359.1.I1ae92b25689bd6579952e6d458b=
79f5f8054a0c9@changeid


> > @@ -2190,7 +2263,9 @@ struct regulator *_regulator_get(struct device *d=
ev, const char *id,
> >                 return regulator;
> >         }
> >
> > +       regulator_lock(rdev);
> >         regulator =3D create_regulator(rdev, dev, id);
> > +       regulator_unlock(rdev);
>
> I'm sad that we're now locking the entire time create_regulator() is
> called. Can that be avoided? I see that create_regulator() publishes the
> consumer on the consumer_list, but otherwise I don't think it needs to
> hold the regulator lock. It goes on to call debugfs code after
> allocating memory. After this patch, we're going to be holding the lock
> for that regulator across debugfs APIs. I suspect that may lead to more
> problems later on because the time we hold the lock is extremely wide
> now.
>
> Of course, we were already holding the child regulator's lock for the
> supply, because that's what this patch is fixing in
> regulator_resolve_supply(). I'm just nervous that we're holding the lock
> for a much wider time now. Maybe we can have create_regulator() return
> the regulator and add a new function like add_regulator_consumer() that
> does the list modification? Then we can make create_regulator() do
> everything without holding a lock and have a very short time where the
> new function locks two regulator locks and does the linkage.

While we could try to come up with something fancier like this, I'm
not convinced it's worth the complexity. There are already cases where
we hold multiple regulator locks for quite long periods of time.
Specifically you can look at regulator_enable(). There, we'll grab the
lock for the regulator and the locks for all of the regulators parents
up the chain. Then we'll enable the regulator (and maybe the parents)
which might even include a long delay/sleep while holding the mutexes
for the whole chain.

Mark: do you have any opinion / intuition here? Is holding the rdev
lock for this larger scope a problem?

-Doug
