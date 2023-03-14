Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868E76B9BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCNQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCNQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:38:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E6B3728
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:37:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd5so30586445edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678811852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/za17hscILXMYDNEFJAfU0x+/d+UxB9pPnmfHSM0Yo=;
        b=RvXo81auGFsdaYyzozWvFDu53E6OZGPj1/IIcyLb9eDD2kQscDMlZPgfal94OhR66M
         yArZe2qhbbGGcwBprgCkfBhtvKo7I0eRm5EKjYmihneboZeh1K9y/fuyPlaqWWMy0biA
         PjdRJBrSlX0MvFaWYVIFVb+uSaMVNpahfCN5GWOjVENEMGtAhUJVQ3OpH9IwKATwdMJm
         GVIaWUFVGNlDe65q0JM2AO/x86+G9z68XXMoOQ57O0dIWPmJpDNCF9HmABZJdKWSM3Ei
         IjZYU6JMbM/mMyUlbeUzm8F+Lzuo7+jef+EYd4nBSuKaOlWk70csCubqyMZqsePdhnZY
         /R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/za17hscILXMYDNEFJAfU0x+/d+UxB9pPnmfHSM0Yo=;
        b=l4ufHdY31H60UzerJfJJXBs8f9O0goSEr7KDaUCxur20vOaBoG36mU4IF8RKU3ElyV
         bNlyACQUVeqm+xCLxEhxwIcWzqR4gww03bqnEqYvBpUhIovekhoOAva93XeS3NXOQ+QO
         RphHmmLpo7UnYABJmm5v664l/e+wNq8Pzw5sriZ9MPsQaWnKf+GLOzPkhS7FjkC06Igd
         AAPO7+hMOINVgzVr49T8bN+MeIBtTq+Ui2YsObOOwlj/Y22uKzn5MmbCdcxO2Mbv88R9
         utEKMYpWEdSsZRcLIwGFJ874RzvYSlzcaRGskZkHFy7SW+ywMQTO1ZCvOH83MjcoDTSt
         EO5A==
X-Gm-Message-State: AO0yUKWX0VZhqSXKMjRtZ5qQMaEYyB/hElBwe4eiZhBgCbWm1+6NK8qz
        7B68tlL2T8HxJD10353yfvHlNKv8pNj+jMu/cfU=
X-Google-Smtp-Source: AK7set9qHO+MH9xAROxLYOE4p043LeWqXnPRsevKXosllot95F0KIdU/0MxvEzFV4Xs2KqeuIq+REdqIbhJF91WRAFI=
X-Received: by 2002:a50:f68a:0:b0:4fa:ff23:a87a with SMTP id
 d10-20020a50f68a000000b004faff23a87amr5365843edn.5.1678811852580; Tue, 14 Mar
 2023 09:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230314153409.1805280-1-daniel.baluta@oss.nxp.com> <6d9d09aa-d83e-e811-1d43-34780ea05d4d@linux.intel.com>
In-Reply-To: <6d9d09aa-d83e-e811-1d43-34780ea05d4d@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 14 Mar 2023 18:37:20 +0200
Message-ID: <CAEnQRZAj-FW-fCWsyupUDAH4Z2kTf0RL1acivyDHszMuU-75pg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-compress: Inherit atomicity from DAI link for
 Compress FE
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com
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

On Tue, Mar 14, 2023 at 6:14=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 3/14/23 10:34, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
> > that of the FE") BE and FE atomicity must match.
> >
> > In the case of Compress PCM there is a mismatch in atomicity between FE
> > and BE and we get errors like this:
> >
> > [   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
> > is nonatomic, invalid configuration
>
> Not clear on the 'FE is atomic' in the case of a compressed stream,
> which has to be handled with some sort of IPC, i.e. be nonatomic.
>

'FE is atomic' in this message is printed because this is the default value
of nonatomic field when PCM struct associated for a Compress PCM
struct is allocated.

No one changes 'nonatomic' field for Compress FE until my current patch.

> Also not sure why the FE is not set as nonatomic by the SOF parts?
> If it's needed for PCM, why wouldn't it be needed for compressed data?

FE is not touched for SOF parts. Only BE is set to nonatomic by SOF.

See: sound/soc/topology.c

=C2=BB       /* Set nonatomic property for FE dai links as their trigger
action involves IPC's */
=C2=BB       if (!link->no_pcm) {
=C2=BB       =C2=BB       link->nonatomic =3D true;
=C2=BB       =C2=BB       return 0;
=C2=BB       }

FE for PCM is modified by sound/soc/soc-pcm.c

int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
=C2=BB       pcm->nonatomic =3D rtd->dai_link->nonatomic;

So, I guess people assumed that is enough to use RTD dai link to set
pcm->noatomic field
and didn't look at it in SOF.

When FE for Compress PCM is created, we don't use soc_new_pcm but instead
we use snd_pcm_new_internal which doesn't inherit the nonatomic field
of the rtd->dai_link
as Normal PCM does inside soc_pcm_new.

So, my patch makes sure we inherit the nonatomic field from
rtd->dai_link also for Compress PCM
similar with what already happens for Normal PCM.

tl;dr: when creating a Normal PCM pcm->nonatomic is inherited from RTD
DAI link. when creating a
Compress PCM pcm->nonatomic field is not set. This patch makes sure
that for Compres PCM
we also inherit nonatomic from RTD DAI link.


thanks,
Daniel.
