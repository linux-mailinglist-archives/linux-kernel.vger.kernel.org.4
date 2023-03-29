Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40636CF3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC2TuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC2TuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:50:21 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1E768B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:49:55 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c1so14341012vsk.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680119340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlsIZeod3ngvlE+hFIn17UzULS/26j1iAdWvld+qR9I=;
        b=Wf8asQeCEzFQyKJyP7NpPoV7w0C4BybXEk06i1di2v8jRMF962jql2i2Mkt9cOdebq
         D1P98+lYCVsWY2YGTgC7wJ+tFUVFwX6yJkDsXje1sCwgT9DGvWHD+UbpXl9JsJvpJzvN
         rYq0plz1aFgNQ2s/FSaRZRTlFFAXTtt0BPGh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlsIZeod3ngvlE+hFIn17UzULS/26j1iAdWvld+qR9I=;
        b=cFek97dFItI3AdzF7Jo6qNQoxCNTgpEY9jDoKZKlk3wKk4G2JogWCnMvQnc22zwfvv
         7FjvxE05RpvtP8mhnNode9J6sCTZx4zVWfe6+SZoLkYCFi2ZbL9a2xeI6d5COkHV6pxv
         WgOEf6GCMvGEfBEAGc6uk7xXdi9wGt+na0pNwH9YED97yzMrr2+sLVLZXl8H/1fU4Tm8
         hIf9nz7bs83JwnKwrDNbI8rw6FH0m2C0Bon5IlZ/pDTXWJXOM7Y7n73EnCZLTBq6coKE
         /NuPnhk2R4PJJhzse9FqFDA1LhoXXz4GPnNWMz4b6feC41E5/H1Kb7OzahAAYtRmuhjn
         sTaA==
X-Gm-Message-State: AAQBX9d4lH/V0FXt59E4Hx3VlY4AtYxVNQnCu5f1puhWO3FWI0DCVI84
        T9ktMFCaDM594bIzCkJmAT5Xy0EjkcN/Xb6Lbcw=
X-Google-Smtp-Source: AKy350Yh04CnCgO23DQlgwhxgFI7ltdGpLxTCpdq/BOmKQStRml2k2DOLoGGO9Y/ycJmKyu0PA3fGg==
X-Received: by 2002:a67:b30d:0:b0:426:c681:18e1 with SMTP id a13-20020a67b30d000000b00426c68118e1mr1253110vsm.28.1680119339820;
        Wed, 29 Mar 2023 12:48:59 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id w12-20020a9f2c8c000000b00764d172829asm2157222uaj.13.2023.03.29.12.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:48:58 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id h34so12219099uag.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:48:58 -0700 (PDT)
X-Received: by 2002:ab0:3d89:0:b0:755:9b3:fef8 with SMTP id
 l9-20020ab03d89000000b0075509b3fef8mr16171362uac.2.1680119338100; Wed, 29 Mar
 2023 12:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230329110222.RFC.1.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
In-Reply-To: <20230329110222.RFC.1.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Mar 2023 12:48:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGTZ0UpB2KKdhkuM6fPhMOJTRLzd+X77UcMCo247n6-A@mail.gmail.com>
Message-ID: <CAD=FV=UGTZ0UpB2KKdhkuM6fPhMOJTRLzd+X77UcMCo247n6-A@mail.gmail.com>
Subject: Re: [RFC PATCH] regulator: Avoid lockdep reports when resolving supplies
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 29, 2023 at 11:03=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> An automated bot told me that there was a potential lockdep problem
> with regulators. This was on the chromeos-5.15 kernel, but I see
> nothing that would be different downstream compared to upstream. The
> bot said:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   WARNING: possible recursive locking detected
>   5.15.104-lockdep-17461-gc1e499ed6604 #1 Not tainted
>   --------------------------------------------
>   kworker/u16:4/115 is trying to acquire lock:
>   ffffff8083110170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: create_reg=
ulator+0x398/0x7ec
>
>   but task is already holding lock:
>   ffffff808378e170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_t=
rylock+0x3c/0x7b8
>
>   other info that might help us debug this:
>    Possible unsafe locking scenario:
>
>          CPU0
>          ----
>     lock(regulator_ww_class_mutex);
>     lock(regulator_ww_class_mutex);
>
>    *** DEADLOCK ***
>
>    May be due to missing lock nesting notation
>
>   4 locks held by kworker/u16:4/115:
>    #0: ffffff808006a948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: =
process_one_work+0x520/0x1348
>    #1: ffffffc00e0a7cc0 ((work_completion)(&entry->work)){+.+.}-{0:0}, at=
: process_one_work+0x55c/0x1348
>    #2: ffffff80828a2260 (&dev->mutex){....}-{3:3}, at: __device_attach_as=
ync_helper+0xd0/0x2a4
>    #3: ffffff808378e170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: ww_mu=
tex_trylock+0x3c/0x7b8
>
>   stack backtrace:
>   CPU: 2 PID: 115 Comm: kworker/u16:4 Not tainted 5.15.104-lockdep-17461-=
gc1e499ed6604 #1 9292e52fa83c0e23762b2b3aa1bacf5787a4d5da
>   Hardware name: Google Quackingstick (rev0+) (DT)
>   Workqueue: events_unbound async_run_entry_fn
>   Call trace:
>    dump_backtrace+0x0/0x4ec
>    show_stack+0x34/0x50
>    dump_stack_lvl+0xdc/0x11c
>    dump_stack+0x1c/0x48
>    __lock_acquire+0x16d4/0x6c74
>    lock_acquire+0x208/0x750
>    __mutex_lock_common+0x11c/0x11f8
>    ww_mutex_lock+0xc0/0x440
>    create_regulator+0x398/0x7ec
>    regulator_resolve_supply+0x654/0x7c4
>    regulator_register_resolve_supply+0x30/0x120
>    class_for_each_device+0x1b8/0x230
>    regulator_register+0x17a4/0x1f40
>    devm_regulator_register+0x60/0xd0
>    reg_fixed_voltage_probe+0x728/0xaec
>    platform_probe+0x150/0x1c8
>    really_probe+0x274/0xa20
>    __driver_probe_device+0x1dc/0x3f4
>    driver_probe_device+0x78/0x1c0
>    __device_attach_driver+0x1ac/0x2c8
>    bus_for_each_drv+0x11c/0x190
>    __device_attach_async_helper+0x1e4/0x2a4
>    async_run_entry_fn+0xa0/0x3ac
>    process_one_work+0x638/0x1348
>    worker_thread+0x4a8/0x9c4
>    kthread+0x2e4/0x3a0
>    ret_from_fork+0x10/0x20
>
> The problem was first reported soon after we made many of the
> regulators probe asynchronously, though nothing I've seen implies that
> the problems couldn't have also happened even without that.
>
> I haven't personally been able to reproduce the lockdep issue, but the
> issue does look somewhat legitimate. Specifically, it looks like in
> regulator_resolve_supply() we are holding a "rdev" lock while calling
> set_supply() -> create_regulator() which grabs the lock of a
> _different_ "rdev" (the one for our supply). This is not necessarily
> safe from a lockdep perspective since there is no documented ordering
> between these two locks.
>
> In reality, we should always be locking a regulator before the
> supplying regulator, so I don't expect there to be any real deadlocks
> in practice. However, the regulator framework in general doesn't
> express this to lockdep.
>
> Let's fix the issue by simply grabbing the two locks involved in the
> same way we grab multiple locks elsewhere in the regulator framework:
> using the "wound/wait" mechanisms.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> My knowledge of lockdep is not as strong as it should be and my
> knowledge of wait-wound locks is not as strong as it should be. That,
> combined with the fact that I can't actually reproduce the issue, has
> led me to label this as RFC.
>
> I can at least confirm that my system still boots with this patch
> applied, but I can't say 100% for sure that this addresses the issue
> that the bot reported to me. Hopefully others can review and make sure
> that this seems sensible to them.
>
> If this looks reasonable, I can land it and see if that prevents the
> bot from hitting this again.
>
>  drivers/regulator/core.c | 89 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 1490eb40c973..822fec20d36a 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -207,6 +207,76 @@ static void regulator_unlock(struct regulator_dev *r=
dev)
>         mutex_unlock(&regulator_nesting_mutex);
>  }
>
> +/**
> + * regulator_lock_two - lock two regulators
> + * @rdev1:             first regulator
> + * @rdev2:             second regulator
> + * @ww_ctx:            w/w mutex acquire context
> + *
> + * Locks both rdevs using the regulator_ww_class.
> + */
> +static void regulator_lock_two(struct regulator_dev *rdev1,
> +                              struct regulator_dev *rdev2,
> +                              struct ww_acquire_ctx *ww_ctx)
> +{
> +       struct regulator_dev *tmp;
> +       int ret;
> +
> +       ww_acquire_init(ww_ctx, &regulator_ww_class);
> +
> +       /* Try to just grab both of them */
> +       ret =3D regulator_lock_nested(rdev1, ww_ctx);
> +       WARN_ON(ret);
> +       ret =3D regulator_lock_nested(rdev2, ww_ctx);
> +       if (ret !=3D -EDEADLOCK) {
> +               WARN_ON(ret);
> +               goto exit;
> +       }
> +
> +       while (true) {
> +               /*
> +                * Start of loop: rdev1 was locked and rdev2 was contende=
d.
> +                * Need to unlock rdev1, slowly lock rdev2, then try rdev=
1
> +                * again.
> +                */
> +               regulator_unlock(rdev1);
> +
> +               ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
> +               ret =3D regulator_lock_nested(rdev1, ww_ctx);

Doh. I did some more stress testing right after I sent this out and it
caught a bug where "ref_cnt" was underflowing. I'm fairly certain I
need a:

  rdev2->ref_cnt++;

...right after the ww_mutex_lock_slow(), since that doesn't increment
the ref_cnt. I suspect I also need:

  rdev->mutex_owner =3D current;

...though I'm confused because I think some other places don't do
that. In any case, I'll confirm and do some more stress testing and
then send out another patch shortly. Sorry for jumping the gun on
sending the first version.

-Doug
