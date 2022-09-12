Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20545B5694
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiILIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiILIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:48:42 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAB62AE29
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:48:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p15-20020a056830130f00b006544f5228e3so5395486otq.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oIPlj77S7TL3EFKkzdGb3gdQ5LXHDMLWke3cCptq+uM=;
        b=Phx26Sw0C0/q7KiFz7tbZrU15U/bIg1itlUhlajdilKJCe+ZEn0BY9dMFemw/JaFlM
         D32lZi4+ywqgMBRKDKiKOxWMMgY9qXMhepZ296QYJeLrrPDBY6I/JBRtqcXRk46omA2l
         dZQdUMgmJyDFxq4HLMQK3/dJzOtxq0jT+RSlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oIPlj77S7TL3EFKkzdGb3gdQ5LXHDMLWke3cCptq+uM=;
        b=OGiPZNYRre7f7pT7KpHUpVBZrU+GUz6baE+iqd3whX/l47IHeXWJ4XR65su9cEXGo4
         PmvB6ZIqe89OavetHVI2iAEQQqppYUuhIi4Hv6tmrORWEfUIFfDQebbsX7A3sIUXYL2d
         iW29PGD2EmptmheITh0Radk0XiZfiFckjGcKEc3DmTv0NvGC9f9fxSUiySrmWG79pmEf
         ZH9LbAZDFCB2iozNQuqqIFv9pFwZI2kFe7l0D5H7dsIml5U0yQoEanRBHYSyDGBwVxiE
         59WfdJjr98Duy6f0UZ1vsdN/XBPW74R06KRIDl59hjLXj0x6zvUs0rjQurDX/OT7ud82
         E8OA==
X-Gm-Message-State: ACgBeo2dQp3pLomEkjU2KUKDIpj/D/nhbYeipJWAUKYFA3UphMseZMaV
        t3x4S9RwS5uio9I5m9iYpX2ZUsDWvxZqUZkT4OPr7JuwjR4=
X-Google-Smtp-Source: AA6agR5F+gCZuv+oh+Q6WUp78QErI7l6b0//NlbqS+axSsTAl9dE1LnsxdC4rhb30WDsYV4IXdBdq1EaHGjxO0jgTmM=
X-Received: by 2002:a9d:51cc:0:b0:655:de5c:f2f3 with SMTP id
 d12-20020a9d51cc000000b00655de5cf2f3mr1987188oth.237.1662972519102; Mon, 12
 Sep 2022 01:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220912072945.760949-1-yunjunlee@chromium.org> <87pmg1hvw7.wl-tiwai@suse.de>
In-Reply-To: <87pmg1hvw7.wl-tiwai@suse.de>
From:   YJ Lee <yunjunlee@chromium.org>
Date:   Mon, 12 Sep 2022 16:48:27 +0800
Message-ID: <CAPm_npbzeq8twNavfWfrAi-v8eky1QNivS7PKOocgxax+T4X3Q@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: dummy: Add customizable volume min/max.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        yuhsuan@chromium.org, whalechang@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 3:52 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 12 Sep 2022 09:29:45 +0200,
> YJ Lee wrote:
> >
> > Add module parameters to support customized min/max volume leveling,
> > which will be useful to test devices with different volume granularity.
> >
> > Signed-off-by: YJ Lee <yunjunlee@chromium.org>
> > ---
> >  sound/drivers/dummy.c | 34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
> > index 2a7fc49c1a7c5..64fb2778f1e9a 100644
> > --- a/sound/drivers/dummy.c
> > +++ b/sound/drivers/dummy.c
> > @@ -42,6 +42,8 @@ MODULE_LICENSE("GPL");
> >  #define USE_CHANNELS_MAX     2
> >  #define USE_PERIODS_MIN      1
> >  #define USE_PERIODS_MAX      1024
> > +#define USE_MIXER_VOLUME_LEVEL_MIN   -50
> > +#define USE_MIXER_VOLUME_LEVEL_MAX   100
> >
> >  static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;   /* Index 0-MAX */
> >  static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;    /* ID for this card */
> > @@ -50,6 +52,8 @@ static char *model[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = NULL};
> >  static int pcm_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
> >  static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};
> >  //static int midi_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
> > +static int mixer_volume_level_min = USE_MIXER_VOLUME_LEVEL_MIN;
> > +static int mixer_volume_level_max = USE_MIXER_VOLUME_LEVEL_MAX;
> >  #ifdef CONFIG_HIGH_RES_TIMERS
> >  static bool hrtimer = 1;
> >  #endif
> > @@ -69,6 +73,10 @@ module_param_array(pcm_substreams, int, NULL, 0444);
> >  MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-128) for dummy driver.");
> >  //module_param_array(midi_devs, int, NULL, 0444);
> >  //MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for dummy driver.");
> > +module_param(mixer_volume_level_min, int, 0444);
>
> I can imagine that the permission could be 0644, so that the
> parameters can be changed dynamically via sysfs, too.  But it may skip
> the sanity check at probe, hence more code would be needed, OTOH.
>
> So I applied the patch as is now.
>
>
> thanks,
>
> Takashi

Thanks for the insight! Learned a lot from your kind explanation and
constant help.

Appreciated,
YJ
