Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3657746B75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGDIGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGDIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:06:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27D10E4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:05:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso4987644a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688457958; x=1691049958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVWPGfFaZM7RIjrMZBy1U4ap/sNPrOgYsjGHVnmKQSk=;
        b=b2Q098KQfFtpS7gTPdbmgBLG6y6WnS0W4y9w15Mk6VXLKw1YWBD+7g/Z+VmdPH+PFz
         3RwrbMdE1TcSlKbe6kOsVFP6L5hMYedQEPgAyv2qwi59D6ErYxrSAXczjgxk42JyUsGN
         OH8OCWfJoTTLzDjWMHKGs7LZY384TmGEUV8rVE+9vnK3fWFQz/4D2IojDuU8v/TmbF0D
         L0UgKj0lwWON50ppAOvCvY/hKOHZur9fxXgK78td25ykVYgtgewaB0iX7rmLmOsDVCiA
         yI2zx+Hsn9r8i2GgKggPNsc4ThKwcz0CrfNMLXhYsjqqfJcxI1UoidEFs9zQIcqvF/lD
         t+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457958; x=1691049958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVWPGfFaZM7RIjrMZBy1U4ap/sNPrOgYsjGHVnmKQSk=;
        b=J4nhB36auTYnhsthJjwun62nOlmsnN1+ZiygzRptpNtGxwPGcKpqllCg/rAcoE/gb8
         LZ1niUpUy8OtbbTDsuf/5u2slrCaqBajnEAf2KwT11Edbcz6s0fh07sWrd4HwnF9NPwW
         WTvOJEQifMK0qXs9FKHBDkCPgq/K44CuzsNk/lDLcrr/hl2o9q5xV7pLevsgz157yM57
         krXcketzNrcVxp9Ss5ZsIyMQ2RCgdXBHI+jFCrlWoatPbWHMWfCEJNAa+r5RilRaLGoJ
         683jxvNqd+W4pUGcchMHLNIIm2g1uOxpvHfsrQcs7Vw2MOshFB37nX0fIblDWBwDbUYd
         pYNQ==
X-Gm-Message-State: ABy/qLbR+SiRp5xanjXiHnSQvFVS4w3oijzNwN+oEHKa3qc2GXUXadMb
        /6LPEmgl3HpJ8aYBO5oGjcvZrIOaw0eEMyfCrUGPa00vZ8A9tw==
X-Google-Smtp-Source: APBJJlFvdD4JojFZIfYCBIl8X+D9YLlLXiIOYn4I/eCNYZMtwhyTmPAnUPUixcI/mqslOeYez4T8nXjkJA+VMLhcPc4=
X-Received: by 2002:a05:6402:4496:b0:51d:d41b:26a5 with SMTP id
 er22-20020a056402449600b0051dd41b26a5mr9120655edb.14.1688457957804; Tue, 04
 Jul 2023 01:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230703150859.6176-1-ubizjak@gmail.com> <87o7ks16gh.fsf@intel.com>
In-Reply-To: <87o7ks16gh.fsf@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 4 Jul 2023 10:05:46 +0200
Message-ID: <CAFULd4YDHqUud94Q1mbKyKqGHh==Gv7+FpNhgm5s1p=0ZwcAXg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/pmu: Use local64_try_cmpxchg in i915_pmu_event_read
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 9:28=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
.com> wrote:
>
> On Mon, 03 Jul 2023, Uros Bizjak <ubizjak@gmail.com> wrote:
> > Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) =3D=
=3D old
> > in i915_pmu_event_read.  x86 CMPXCHG instruction returns success in ZF =
flag,
> > so this change saves a compare after cmpxchg (and related move instruct=
ion
> > in front of cmpxchg).
> >
> > Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxc=
hg
> > fails. There is no need to re-read the value in the loop.
> >
> > No functional change intended.
> >
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/i915_pmu.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i91=
5_pmu.c
> > index d35973b41186..108b675088ba 100644
> > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > @@ -696,12 +696,11 @@ static void i915_pmu_event_read(struct perf_event=
 *event)
> >               event->hw.state =3D PERF_HES_STOPPED;
> >               return;
> >       }
> > -again:
> > -     prev =3D local64_read(&hwc->prev_count);
> > -     new =3D __i915_pmu_event_read(event);
> >
> > -     if (local64_cmpxchg(&hwc->prev_count, prev, new) !=3D prev)
> > -             goto again;
> > +     prev =3D local64_read(&hwc->prev_count);
> > +     do {
> > +             new =3D __i915_pmu_event_read(event);
> > +     } while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
>
> You could save everyone a lot of time by actually documenting what these
> functions do. Assume you don't know what local64_try_cmpxchg() does, and
> see how many calls you have to go through to figure it out.

These functions are documented in Documentation/atomic_t.txt (under
"RMW ops:" section), and the difference is explained in a separate
section "CMPXCHG vs TRY_CMPXCGS" in the same file.

Uros.

> Because the next time I encounter this code or a patch like this, I'm
> probably going to have to do that again.
>
> To me, the old one was more readable. The optimization is meaningless to
> me if it's not quantified but reduces readability.
>
>
> BR,
> Jani.
>
>
> >
> >       local64_add(new - prev, &event->count);
> >  }
>
> --
> Jani Nikula, Intel Open Source Graphics Center
