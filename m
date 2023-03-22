Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA406C5158
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCVQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCVQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:55:52 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB15257
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:55:51 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id c10so9615337vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679504150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN9XlJJdD0wdM8hHUTPISoSh6U/BkfuxtSdOC1SlQBc=;
        b=XSpbXcbNoEHM2+cv/MaUT4komgPFFkNAi2EA+3nRoq0Z+XKShmzQb1HYqkcxs4Ad84
         RklJw0OSvW4r6NWkkfyeq44he0XoTw865C+GSEXGwzBeUy8kMccju0O+trBfGBTTtEnK
         itr+ZmoeAqA/GG2RfPojV3VUXLiMqYU+9j0kAE2KZJHRIKN2T94I49bMAnuQpwDCgTPK
         RxQuTwveFomoQPAYSGVXAusTLBLF9+9KpQS/z9AE7ZfDKm7KVSOl/rrkYz9jGFmjBK6l
         pupEdS4thX8Imlfc01a24L7aKTqgUklRNcconXRJpA8UK41+jzhTINHYmRVoBD7i5EQ1
         PFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN9XlJJdD0wdM8hHUTPISoSh6U/BkfuxtSdOC1SlQBc=;
        b=DVRVJSydj5bk9e60xRtSj2AMINIb4+k2dqUi7+sJmRkeuZEoMuOeRUorJvCFwzGePu
         Jd7x0mzJ+sxDhZNcx1qfyTXS6mo0pZ8UpxffU9K6BHGSMjqFd4qT0yWim0uprzki2vB8
         xCsjBETEQX5xZt1u0bNoV721W3/4l5lg99BgeSiDEN2bbX6ByjhWrQWrRVz546YZWcwm
         iOUmxq4YSrPOWmBonCfzyfDScFL1hTdTeohid2/rdTSYwhTu9KryCTpTEq7s2Ee9mr1O
         OFgcvnNt78WrZUNcejV7NYLupI1a9DDw+RQEhtRIxKeMEnm5DkjYHalAzc97qIcNhSCo
         ETxQ==
X-Gm-Message-State: AO0yUKUlXmoroTLozB/fxsD1HjBcy8MF/33LeR0iNWC8zEa7DgCTqbea
        t4lBxqu/yyLo9G7wzWx57X8BCYprBvceso7oIKiPNLaeKa9jy6Fr
X-Google-Smtp-Source: AK7set/CqNKnacEs94tVobaB8uz0cm9h/EKIzrR4X439yPye+TCQAPYpoEjoElKKld5os7hFOVRUq5gFDLVBTTGwmBw=
X-Received: by 2002:a67:d605:0:b0:425:e5e6:d1d9 with SMTP id
 n5-20020a67d605000000b00425e5e6d1d9mr180575vsj.2.1679504150619; Wed, 22 Mar
 2023 09:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679323449.git.william.gray@linaro.org> <ZBh8hgdRq+kydPBw@smile.fi.intel.com>
In-Reply-To: <ZBh8hgdRq+kydPBw@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 22 Mar 2023 17:55:39 +0100
Message-ID: <CAMRc=MeDZVLmj9+sBQngbqr25HmX0O1BCEohOyij0SOhY_cwgg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Drop map from handle_mask_sync() parameters
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 4:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 20, 2023 at 10:50:14AM -0400, William Breathitt Gray wrote:
> > Changes in v3:
> >  - Inline dio48gpio->map usage in dio48e_handle_mask_sync() to avoid
> >    redefining map parameter
> >
> > Remove the map parameter from the struct regmap_irq_chip callback
> > handle_mask_sync() because it can be passed via the irq_drv_data
> > parameter instead. The gpio-104-dio-48e driver is the only consumer of
> > this callback and is thus updated accordingly.
> >
> > A couple pending patchsets also utilize handle_mask_sync() [0][1], so
> > it'll be useful to merge the changes in this series first to avoid
> > subsequent noise adjusting the dependent drivers.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I believe this should go to the immutable branch somewhere, so GPIO and r=
egmap
> subsystems can pull from.
>
> > [0] https://lore.kernel.org/r/cover.1677515341.git.william.gray@linaro.=
org/
> > [1] https://lore.kernel.org/r/cover.1678106722.git.william.gray@linaro.=
org/
> >
> > William Breathitt Gray (2):
> >   gpio: 104-dio-48e: Implement struct dio48e_gpio
> >   regmap-irq: Drop map from handle_mask_sync() parameters
> >
> >  drivers/base/regmap/regmap-irq.c |  5 ++---
> >  drivers/gpio/gpio-104-dio-48e.c  | 37 +++++++++++++++++++++-----------
> >  include/linux/regmap.h           |  3 +--
> >  3 files changed, 28 insertions(+), 17 deletions(-)
> >
> >
> > base-commit: 03810031c91dfe448cd116ee987d5dc4139006f4
> > --
> > 2.39.2
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Since patch 2/2 touches both GPIO and regmap, ideally I would get an
Ack from Mark and take it through GPIO tree and then possibly provide
Mark with a tag.

Bart
