Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A4E6C9E50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjC0IlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjC0Ikh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:40:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBCF5BBF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:37:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so32596101edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679906236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alcgPkT70wWVcnAPv13WswAdsJvkYrPqqfWqcJe5IXA=;
        b=lSd7ukgeVlHRCzTfzLETp+jivNZUnMIBsvjrBRUW/ML6Sj/gzrK53xqMpcfOZbLYss
         Ah1Gyh0uu+DZzEeG3zI74NDdKClOW40FIMt0w1pwuiV6i4z1ht0Ig0hPNrh8gTesgIYt
         3ZWHZkXXjuvNzevYSplmkNR46OxWdSi7MlIWQ4XiLKWppKioq0cwBn9Q3C41O8iWZn1t
         OfBF35YrNz48jc6mgJyRIQp4vMbHK+cfSvYkoySgmqZLhcHl+UZwNUIsdazpZhFA1Y2Z
         TlWuhwHOOkTVPlKXP2QVu6GXMbDq7Ro3/81qzTxo3zxJjj6cufrW47dW/tT6ke2NOwoY
         9Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679906236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alcgPkT70wWVcnAPv13WswAdsJvkYrPqqfWqcJe5IXA=;
        b=VB11/u2yg8BAWp5gWzS8rAfRLmmYQBowpwEZrb14nH8w5j2X8fTBjzn8VMBm5RLp8t
         xdAsVbQ9ZXD6gzkc8aP91a3vQlAg1DGHvxtggNLQiusS8aQSDkikfC0pk6KmVsAKwXmL
         eezhP3PNDrZo4vcfuY3wauBjLJEjkeYnJ1DS49XrpqKM6Dvx+eysmloDPeFulVV0rf+K
         jTIks/mL6hW23RicvzTov8XlXbnsa/CK7qYSBMnwqgXo3FMwBgXXeRJqteNnI5B3X4hf
         2/ygiXcOX126bKOBph2cw7TYsoU4z+dKaK8Itpnqqs45yuoGr6R0yeYDMoWL9lD2Pd3h
         qQMQ==
X-Gm-Message-State: AAQBX9c6K8GGm9WXIaDxumnuorGdv8MrQcNy54tXu9lSO68fssyO/mEY
        nlKhjJ1AuvUnpylS3XENdWKpz8v2TtxrL+3nYB1mKP7x
X-Google-Smtp-Source: AKy350asEfigB4Hm1EKOSNKhMWyL5Vxg08Ww3GQgwCTEbPXRBhFzkdiSzYjjDBvFMUQf3xyqAp/uA+Z+oxo9OJD/Gn0=
X-Received: by 2002:a17:906:7051:b0:8db:b5c1:7203 with SMTP id
 r17-20020a170906705100b008dbb5c17203mr5368965ejj.11.1679906236204; Mon, 27
 Mar 2023 01:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230325083643.7575-1-clamor95@gmail.com> <20230325083643.7575-2-clamor95@gmail.com>
 <20230327083208.GQ68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230327083208.GQ68926@ediswmail.ad.cirrus.com>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Mon, 27 Mar 2023 11:37:05 +0300
Message-ID: <CAPVz0n1AaTzdwmfkxaUX5peAiQ2K73aoqKfLUy1jwEE6__uG2w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ASoC: wm8903: implement DMIC support
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 27 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 11:32 Char=
les Keepax <ckeepax@opensource.cirrus.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Mar 25, 2023 at 10:36:43AM +0200, Svyatoslav Ryhel wrote:
> > Add DMIC input and routing.
> >
> > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF300T
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  sound/soc/codecs/wm8903.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> > index 41346e5ec5ad..9c2f0aadcff3 100644
> > --- a/sound/soc/codecs/wm8903.c
> > +++ b/sound/soc/codecs/wm8903.c
> > @@ -9,7 +9,6 @@
> >   *
> >   * TODO:
> >   *  - TDM mode configuration.
> > - *  - Digital microphone support.
> >   */
> >
> >  #include <linux/module.h>
> > @@ -816,6 +815,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
> >  SND_SOC_DAPM_INPUT("IN2R"),
> >  SND_SOC_DAPM_INPUT("IN3L"),
> >  SND_SOC_DAPM_INPUT("IN3R"),
> > +SND_SOC_DAPM_INPUT("DMIC"),
> >  SND_SOC_DAPM_INPUT("DMICDAT"),
>
> There is already a datapath for the DMIC here, DMICDAT. Are you
> sure you don't just need to set the "Left/Right ADC Input" muxes
> correctly through the ALSA controls?
>

I will check once more, but so far I was not able to set the mic to
work with DMICDAT. Only with this patch.

Best regards,
Svyatoslav R.

> >
> >  SND_SOC_DAPM_OUTPUT("HPOUTL"),
> > @@ -996,6 +996,9 @@ static const struct snd_soc_dapm_route wm8903_inter=
con[] =3D {
> >       { "AIFTXL", NULL, "Left Capture Mux" },
> >       { "AIFTXR", NULL, "Right Capture Mux" },
> >
> > +     { "ADCL", NULL, "DMIC" },
> > +     { "ADCR", NULL, "DMIC" },
> > +
>
> And at any rate these should not be directly connected to the
> ADC you need some muxing to indicate whether the DMIC or AMICs
> are active. Which the DMICDAT path appears to already have.
>
> Thanks,
> Charles
