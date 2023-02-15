Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12E5698027
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBOQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBOQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:06:48 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADD38E9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:06:47 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-52ee632329dso207780687b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwtALRclslgWS2dlyCLe75cs/v561ydtVZ9l57rIn+M=;
        b=Ow1l7YZwZohk6KuEdt7CKOyYdx8dcaWpGlLoAG/MpA58G1laiQ4i3OB8raR5tf+TVN
         fZqasQzK9KyLswwHSQD+juqoxt952jOeawoYhPdC0DDJf0rzng3ON5xxK68EpNm9fLt3
         n1uV/TltqNwrfc7QzHQlBDHWbg6ZX7dw59I3NLROiWUF+rPeRDta3oUcJ2Sslk/y8184
         hrTGW185Qx5KrdvxuaDl7dbTwx46p/R9rCdopWV5yHUgEC64vYLbsU6vjazm8DDYa5Ds
         OynWZo6uS8K9xd+rV+5KrzMTzlaRasAhFZYbX8g6UDhZcVPP+j7JHQLoswdWtIKjUrxI
         ebhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwtALRclslgWS2dlyCLe75cs/v561ydtVZ9l57rIn+M=;
        b=09M23X8BNMP025vdP9Z6iD4TkwXNaLolZyXkLqHQwVTD/OhjzK7JvOuJzFVn0tKWOx
         qmRSB8kvSSzdByeYn6gaR5R9Q5s05fAc1+fuyb8TZrCzlQuzwawnekwT7v23zK/EkZmk
         riDfmGMSFwPcjL/ji/J2uvqdp2zH0qBWZPKJylX54X5nwDpxhDkhvVqOADJ244IZgmiC
         HPzQgNxeSGuwPhuZuZVPvtOJwywTfCw4llIxy5bdnFtQ4p7g2uvnIHOrSdqcPa7JyGxM
         91WCcXWFpAOMHTf8tQXR6W9FKsqoldu30eibYyRLTU+gvyD6Fv25sLMM1Z07lF7sTjWr
         0ovQ==
X-Gm-Message-State: AO0yUKX9SeF60c9TslOhHzrvi87T92YpPvlxy2gUrXOwA4lfY8fbFL0Y
        WF8b+XeCXM44XSE3wJ2WW5lJbzoF2I9E6mXeGHcyXw==
X-Google-Smtp-Source: AK7set+ZcW8D0YTnm90AxxZ2cuveg7b77FT+FPISTiLtiFSpGb77ZxPi9t/h4IiUQFaPQJtpIEhXNiZlZqzNscsTrk8=
X-Received: by 2002:a25:d652:0:b0:8f6:c6a2:f894 with SMTP id
 n79-20020a25d652000000b008f6c6a2f894mr368661ybg.576.1676477206414; Wed, 15
 Feb 2023 08:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20230215101045.21456-1-David.Rau.opensource@dm.renesas.com> <Y+zZwKFX1gMC5/ac@sirena.org.uk>
In-Reply-To: <Y+zZwKFX1gMC5/ac@sirena.org.uk>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Feb 2023 08:06:35 -0800
Message-ID: <CABXOdTdv=+n8+UCgWUvyrZ6R0uAu48bODa3TA_2nUuMbUT7MUg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: da7219: Improve the IRQ process to increase the stability
To:     Mark Brown <broonie@kernel.org>
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 5:10 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 15, 2023 at 10:10:45AM +0000, David Rau wrote:
> > Remove the sleep control in IRQ thread
> > and create an individual task to handel it for Jack plug in event.

handle

> >
> > This commit improves the control of ground switches in the AAD IRQ.
>
> Copying in Guenter given the issues he raised with this, not
> deleting context for his benefit.  It looks like this should
> avoid the issues with the interrupt appearing locked up.
>

It should since it limits the delay to cases where jack_inserted is
false, but on the other side it hides the delay in an odd way.

Sequence for an insertion interrupt:

- da7219_aad_pre_irq_thread() schedules the worker, which presumably
starts to run immediately and goes to sleep
- da7219_aad_irq_thread() calls cancel_work_sync() and thus
effectively waits until the worker wakes up and sets the ground switch

On top of that, it now reads the interrupt status before calling
cancel_work_sync(), meaning additional interrupts received while
waiting for the thread to wake up are not handled by the first
interrupt.

Effectively this seems to be quite similar to moving the conditional
sleep to the place where cancel_work_sync() is called. I would assume
that will fix the problem (after all, the msleep() is no longer called
unconditionally), but I don't see the benefit of introducing a worker
to do that. Also, since there is no guarantee that the worker actually
started by the time cancel_work_sync() is called, I would suspect that
it may result in unexpected behavior if the worker has not started by
that time, which I would assume can happen if the system is heavily
loaded. It also makes the use of the ground switch (i.e., when to set
and when to drop it) even more of a mystery than it is right now.

Having said that, I don't really know or understand the code, so maybe
this all makes sense and my feedback should be ignored.

Guenter

> > Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
> > ---
> >  sound/soc/codecs/da7219-aad.c | 41 +++++++++++++++++++++++++++++------
> >  sound/soc/codecs/da7219-aad.h |  4 ++++
> >  2 files changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
> > index c55b033d89da..4a4f09f924bc 100644
> > --- a/sound/soc/codecs/da7219-aad.c
> > +++ b/sound/soc/codecs/da7219-aad.c
> > @@ -339,11 +339,39 @@ static void da7219_aad_hptest_work(struct work_struct *work)
> >                                   SND_JACK_HEADSET | SND_JACK_LINEOUT);
> >  }
> >
> > +static void da7219_aad_jack_det_work(struct work_struct *work)
> > +{
> > +     struct da7219_aad_priv *da7219_aad =
> > +             container_of(work, struct da7219_aad_priv, jack_det_work);
> > +     struct snd_soc_component *component = da7219_aad->component;
> > +     u8 srm_st;
> > +
> > +     mutex_lock(&da7219_aad->jack_det_mutex);
> > +
> > +     srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
> > +     msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 4);
> > +     /* Enable ground switch */
> > +     snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > +
> > +     mutex_unlock(&da7219_aad->jack_det_mutex);
>
> This mutex is only held by this work function - is it needed?
>
> > +}
> > +
> >
> >  /*
> >   * IRQ
> >   */
> >
> > +static irqreturn_t da7219_aad_pre_irq_thread(int irq, void *data)
> > +{
> > +
> > +     struct da7219_aad_priv *da7219_aad = data;
> > +
> > +     if (!da7219_aad->jack_inserted)
> > +             schedule_work(&da7219_aad->jack_det_work);
> > +
> > +     return IRQ_WAKE_THREAD;
> > +}
> > +
> >  static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
> >  {
> >       struct da7219_aad_priv *da7219_aad = data;
> > @@ -351,14 +379,9 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
> >       struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> >       struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
> >       u8 events[DA7219_AAD_IRQ_REG_MAX];
> > -     u8 statusa, srm_st;
> > +     u8 statusa;
> >       int i, report = 0, mask = 0;
> >
> > -     srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
> > -     msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 4);
> > -     /* Enable ground switch */
> > -     snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > -
> >       /* Read current IRQ events */
> >       regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
> >                        events, DA7219_AAD_IRQ_REG_MAX);
> > @@ -377,6 +400,9 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
> >               events[DA7219_AAD_IRQ_REG_A], events[DA7219_AAD_IRQ_REG_B],
> >               statusa);
> >
> > +     if (!da7219_aad->jack_inserted)
> > +             cancel_work_sync(&da7219_aad->jack_det_work);
> > +
> >       if (statusa & DA7219_JACK_INSERTION_STS_MASK) {
> >               /* Jack Insertion */
> >               if (events[DA7219_AAD_IRQ_REG_A] &
> > @@ -940,8 +966,9 @@ int da7219_aad_init(struct snd_soc_component *component)
> >
> >       INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
> >       INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
> > +     INIT_WORK(&da7219_aad->jack_det_work, da7219_aad_jack_det_work);
> >
> > -     ret = request_threaded_irq(da7219_aad->irq, NULL,
> > +     ret = request_threaded_irq(da7219_aad->irq, da7219_aad_pre_irq_thread,
> >                                  da7219_aad_irq_thread,
> >                                  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >                                  "da7219-aad", da7219_aad);
> > diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
> > index 21fdf53095cc..be87ee47edde 100644
> > --- a/sound/soc/codecs/da7219-aad.h
> > +++ b/sound/soc/codecs/da7219-aad.h
> > @@ -11,6 +11,7 @@
> >  #define __DA7219_AAD_H
> >
> >  #include <linux/timer.h>
> > +#include <linux/mutex.h>
> >  #include <sound/soc.h>
> >  #include <sound/jack.h>
> >  #include <sound/da7219-aad.h>
> > @@ -196,6 +197,9 @@ struct da7219_aad_priv {
> >
> >       struct work_struct btn_det_work;
> >       struct work_struct hptest_work;
> > +     struct work_struct jack_det_work;
> > +
> > +     struct mutex  jack_det_mutex;
> >
> >       struct snd_soc_jack *jack;
> >       bool micbias_resume_enable;
> > --
> > 2.17.1
> >
