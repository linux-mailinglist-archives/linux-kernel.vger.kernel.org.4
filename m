Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320A269F009
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBVIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBVIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:20:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC86AD08;
        Wed, 22 Feb 2023 00:19:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ck15so28263897edb.0;
        Wed, 22 Feb 2023 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJNOZOcvMnjGdeBFXws515SfQDHLUn4sM+kuakbttss=;
        b=h6W6n70b5qdFFU2oGmksYnw9ys1MLpPsMO/GuCv3dW0fVdRsdwKwESP+Udzw0ublfF
         vTEAFC8EzOkWBE6PcAs52WI1nIM5ctxJNwGnMQQGIdp/R+EWwVMMcS5qy93bHaAnfy1u
         PrK4TgYtXtha/5+uzf9IVqquy0ImeOLcz/Qn+Y/gX/bt3ev7+NN6T4LifsI/kP4CfmJr
         8sIMGkA3R+7jUSeFvUNjt0veZ3+Qjz1s19CDBp+eH2L2BeH/07zKNJZ/qA1vpcb1kvg7
         QLyOd1jcBeQZOH6re09TSfFpupJ2kH0AJ1EqQ5R+z/HIjXz4Fea29C5i7VCPAqlXhp6c
         MYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJNOZOcvMnjGdeBFXws515SfQDHLUn4sM+kuakbttss=;
        b=Dtb6Lu+92Sd1iX35Cv4phld1JqLPGt2x3M31H/yXDa064YM8abM8xqDuY8IeFsKP4I
         6ZSGui7lTVj5HTlGGFlqFOt+zWhJsNp+KRHliFZk3U3gizaISLjeq3ZQiz4pg8nQDWSG
         bzsix0HCRYBPScBGwdsVriBOs+HHVFx03SB9N6zH1MyakmkuZea89+0KuP/bKY1EDp2H
         6hNqiAksv+aabIJl+tDnpqfc6w36R2UQak4KtlkW9OWO8yUVWvDAHSpmBw6JW6vQijIk
         bP55G+vctmA6pF4TB9vt3zBpBL55b8ASm5Zsd6Pt6+n5ZubVXCq9B89qH2yPlX/tTtUt
         4XKw==
X-Gm-Message-State: AO0yUKXOQeKY2QlbOD8Y4DnSYqlkLCSzPh1Ws2cf2ZTTc2JCcokWJZlH
        Jh59aFa4mZbvEX2Cf8LzOGA8Paocbixt8xJSOKQ=
X-Google-Smtp-Source: AK7set/eD4OWazbd4WlNqGtkzE9MinhNaPt6ANWVDAub6zWcoT23wqA99bVdNLX5ZOspxYng6Z/FnKKs1niTz2q5K4E=
X-Received: by 2002:a17:906:5e5a:b0:877:747c:9745 with SMTP id
 b26-20020a1709065e5a00b00877747c9745mr7263091eju.8.1677053998298; Wed, 22 Feb
 2023 00:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20230221183211.21964-1-clamor95@gmail.com> <20230221183211.21964-10-clamor95@gmail.com>
 <Y/UbMH5tXDgsvSbD@kroah.com>
In-Reply-To: <Y/UbMH5tXDgsvSbD@kroah.com>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 22 Feb 2023 10:19:47 +0200
Message-ID: <CAPVz0n2-giCF9Z9fMimTFQnGk73HAdfU4SitGn58iZapLjeuTQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] staging: dsp: add support for Fortemedia FM34NE DSP
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 21 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 21:27 Greg Kroah-H=
artman
<gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 21, 2023 at 08:32:10PM +0200, Svyatoslav Ryhel wrote:
> > FM34NE is digital sound processing chip used for active
> > noise suppression mainly on ASUS Transformers.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/staging/Kconfig          |   2 +
> >  drivers/staging/Makefile         |   1 +
> >  drivers/staging/dsp/Kconfig      |   7 +
> >  drivers/staging/dsp/Makefile     |   2 +
> >  drivers/staging/dsp/dsp-fm34ne.c | 364 +++++++++++++
> >  drivers/staging/dsp/dsp-fm34ne.h | 845 +++++++++++++++++++++++++++++++
> >  6 files changed, 1221 insertions(+)
> >  create mode 100644 drivers/staging/dsp/Kconfig
> >  create mode 100644 drivers/staging/dsp/Makefile
> >  create mode 100644 drivers/staging/dsp/dsp-fm34ne.c
> >  create mode 100644 drivers/staging/dsp/dsp-fm34ne.h
>
>
> Sorry, but why is this going into drivers/staging/ at all?  What is
> needed to be done to get this out of staging?  Why not do that work
> right now?  At the least, we need a TODO file in the directory that
> lists what needs to be done and who is responsible for it.

Because this driver sets up fm34 and switches it to bypass mode allowing
sound to work on the device. There is no dsp framework in kernel which coul=
d
be called to operate dsp from the actual sound codec. (If there is, I
would be glad
if you show me). Fm34 must be active only on DMIC use, all other cases requ=
ire
it to be in bypass.

> But again, just do the work now, it's faster and simpler to do it before
> you submit it instead of waiting until after it is merged.
>
> Also, no need for a .h file when you only have one .c file.  Just put
> them all together into one file please.

I understand, but the header contains sets of configuration sequences.
Including those into .c will make it barely readable.

> thanks,
>
> greg k-h
