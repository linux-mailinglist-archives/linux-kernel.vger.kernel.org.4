Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FC6DB5DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDGVq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:46:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0005AC178
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:46:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e9so29347663ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680903981;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZgziCzrlnZ1KMQngzHso1b66A2bwnxe6r27PGoDf30=;
        b=M1ElGxSdslOWrChiUFsekSQMA8P7KQRV0fcTWd/bFeNsaSyG23XXQH+saSYXouolNo
         F1xvqZNMgC+qKsKO1kmV7pbZHeBmlWY1owLhjmw7XmxFyOEDeuM+U0KtmmOzXrfTn57k
         jeT7WMiLF9O8hKv9v2lvPBh1VX5cliB48mI7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903981;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZgziCzrlnZ1KMQngzHso1b66A2bwnxe6r27PGoDf30=;
        b=rs4cDkuZxm6gNBgPm8QuJUjOoMoLQqZxxyeklDqW/gQmYArmE1MjTKMli1iB2dPaQQ
         I9Cy5pTDu9iDLWOIiDVRh3+XmBXK6Hxi0lkvaiFJqstbryTA6Q/D/hmw4ks9JaO6uEpd
         nFx+uY/5TiL+p9D0XM6Sou1yfIFZirTxW/l1gm5efjIEWt7kXAC2xF/ZyjMqm5bBpuJO
         gSuXLrs4/x/RfWkoFzRmroALLz7vH1Nzd+8vSRHnQZ4LmbxOT2UtURGaNAG4BEfBizsi
         v71EWF07mrtI+nJiYtpx9XpzDrfdG3ThNdZZejUXh1ztaNOD6ozACbkIzpFpflUkkFs3
         BhZA==
X-Gm-Message-State: AAQBX9ccAnFunJ9BP8zpO6wqHZHXjMRsIJtz1BevggakWe4QLw2vHz/s
        6ZBXqRe7VbatUiC89xaOSZvy3gd64x6u6VTRhJg4JA==
X-Google-Smtp-Source: AKy350aqpjHi+SDJccBKfvG/HJ3MWImHDy3IF4CAPi73MJzymMzb0Ph0h2JD0VQkHHuADHARS5N4fBsPp1edjxNJTxA=
X-Received: by 2002:a2e:8006:0:b0:2a6:de0:79af with SMTP id
 j6-20020a2e8006000000b002a60de079afmr929528ljg.10.1680903981221; Fri, 07 Apr
 2023 14:46:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Apr 2023 14:46:20 -0700
MIME-Version: 1.0
In-Reply-To: <20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
References: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
 <20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 7 Apr 2023 14:46:20 -0700
Message-ID: <CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] regulator: core: Avoid lockdep reports when
 resolving supplies
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-03-29 14:33:54)
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 9a13240f3084..08726bc0da9d 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -207,6 +207,78 @@ static void regulator_unlock(struct regulator_dev *rdev)
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
> +       ret = regulator_lock_nested(rdev1, ww_ctx);
> +       WARN_ON(ret);
> +       ret = regulator_lock_nested(rdev2, ww_ctx);
> +       if (ret != -EDEADLOCK) {
> +               WARN_ON(ret);
> +               goto exit;
> +       }

I think this would be clearer if we had two local variable pointers

	struct regulator_dev *held, *contended;

	held = rdev1;
	contended = rdev2;

> +
> +       while (true) {
> +               /*
> +                * Start of loop: rdev1 was locked and rdev2 was contended.
> +                * Need to unlock rdev1, slowly lock rdev2, then try rdev1
> +                * again.
> +                */
> +               regulator_unlock(rdev1);

		regulator_unlock(held);

> +
> +               ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
> +               rdev2->ref_cnt++;
> +               rdev2->mutex_owner = current;
> +               ret = regulator_lock_nested(rdev1, ww_ctx);

		ww_mutex_lock_slow(&contended->mutex, ww_ctx);
		contended->ref_cnt++;
		contended->mutex_owner = current;
		swap(held, contended);
		ret = regulator_lock_nested(contended, ww_ctx);
		if (ret != -EDEADLOCK) {

> +                       WARN_ON(ret);
> +                       break;
> +               }
> +       }
> +
> +exit:
> +       ww_acquire_done(ww_ctx);
> +}
> +
> @@ -1627,8 +1699,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
>
>  /**
>   * set_supply - set regulator supply regulator
> - * @rdev: regulator name

It certainly wasn't the name :)

> - * @supply_rdev: supply regulator name
> + * @rdev: regulator (locked)
> + * @supply_rdev: supply regulator (locked))
>   *
>   * Called by platform initialisation code to set the supply regulator for this
>   * regulator. This ensures that a regulators supply will also be enabled by the
[...]
> @@ -2190,7 +2263,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
>                 return regulator;
>         }
>
> +       regulator_lock(rdev);
>         regulator = create_regulator(rdev, dev, id);
> +       regulator_unlock(rdev);

I'm sad that we're now locking the entire time create_regulator() is
called. Can that be avoided? I see that create_regulator() publishes the
consumer on the consumer_list, but otherwise I don't think it needs to
hold the regulator lock. It goes on to call debugfs code after
allocating memory. After this patch, we're going to be holding the lock
for that regulator across debugfs APIs. I suspect that may lead to more
problems later on because the time we hold the lock is extremely wide
now.

Of course, we were already holding the child regulator's lock for the
supply, because that's what this patch is fixing in
regulator_resolve_supply(). I'm just nervous that we're holding the lock
for a much wider time now. Maybe we can have create_regulator() return
the regulator and add a new function like add_regulator_consumer() that
does the list modification? Then we can make create_regulator() do
everything without holding a lock and have a very short time where the
new function locks two regulator locks and does the linkage.
