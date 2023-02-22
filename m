Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34069F20E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjBVJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjBVJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:43:38 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB73C783;
        Wed, 22 Feb 2023 01:40:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f16so7073420ljq.10;
        Wed, 22 Feb 2023 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yleek0oaFc70WbJunAtXSm0MOQeAIy9beRoYkSDegxQ=;
        b=MaR6vviAZKVp1bFr4GsfVcqKsd/ROQreCiDNcS1+A/LFIMFtBOmT5Zq/0YH1dh8EzE
         19ijszOgiXRWeTRZBoYGTWSR2M1W+qaB1soNJp9vb1GMyvJMT0xubVIVIilmbu2LY5V9
         7wlKMhiN0GFK6f/SXB7U0zf5wqg5XHbAJ31HEgI4nnKcvwkZfPbargHwsz322Kt9vLUc
         bevPvHUwQbg0VgPcGWsBIjIkTW2ExcW5kWunrqhddlXx1/8P5e/3ByfAy5PNlz/FeNpp
         WX6GD+kGdOmSr9U0t380kEfCMXcQ8tknOgLjtCoiAWvNX12416KNGZ/uiIcKzjAfXGlb
         MHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yleek0oaFc70WbJunAtXSm0MOQeAIy9beRoYkSDegxQ=;
        b=gJZG+mm+/nhVQHTbsu4mHqUYgfnH+HMDkFu0GFofsCYD7jJgmlumsJEljFLOkRiQfQ
         fRsZjcet3xTApV+lEP26oKbNsZX6oWiC3Mt1uh95jWnQqyNQhAgEu/gmT7Ev00SVXlNd
         QTsJcsnI5Vvvk/PJ7XjZKCgxdtykqv/X6YnsdgMF+0C3+LTU91U9mW0Abc6dWe92LdGn
         RHUs5Zm3hnS4i+oz9KepNHpfWfYCzn9C8oowEBAm60M9YTi4K37xOTY9iOWMjzz4eWbp
         GeMkJroQqMVCkZjOBVK3u5YbJ6B4Ha75+TXZqbLatgV9VMkmkrE8dEr+lboB4y663Z/Y
         M4PQ==
X-Gm-Message-State: AO0yUKWgWr+q3x3gkfvikE6Z4S8twzos2+2mQWe+ir4Hf0/sBRzxXAeU
        0TI6FtIJhi+uf2s+DXtjiYc=
X-Google-Smtp-Source: AK7set/JBY1TYm0YPPO8CsPIN7FcVv0ivVO2LrB1rButFqoarh+nxqZLywS5l5PLR/ZvbWmGNiTH+w==
X-Received: by 2002:a2e:bc0d:0:b0:294:669b:8f97 with SMTP id b13-20020a2ebc0d000000b00294669b8f97mr4297154ljf.46.1677058801266;
        Wed, 22 Feb 2023 01:40:01 -0800 (PST)
Received: from [127.0.0.1] ([91.204.85.69])
        by smtp.gmail.com with ESMTPSA id o16-20020a2e9b50000000b002958bb2deacsm401396ljj.46.2023.02.22.01.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 01:40:00 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:39:59 +0200
From:   =?UTF-8?B?0KHQstGP0YLQvtGB0LvQsNCyINCg0LjQs9C10LvRjA==?= 
        <clamor95@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_09/10=5D_staging=3A_dsp=3A_a?= =?US-ASCII?Q?dd_support_for_Fortemedia_FM34NE_DSP?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y/Xefn/76JW1C03d@kroah.com>
References: <20230221183211.21964-1-clamor95@gmail.com> <20230221183211.21964-10-clamor95@gmail.com> <Y/UbMH5tXDgsvSbD@kroah.com> <CAPVz0n2-giCF9Z9fMimTFQnGk73HAdfU4SitGn58iZapLjeuTQ@mail.gmail.com> <Y/Xefn/76JW1C03d@kroah.com>
Message-ID: <C94BE033-EE34-40E4-96D4-1EB4C1B04A09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



22 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2023 =D1=80=2E 11:21:02 GMT+02:00,=
 Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Feb 22, 2023 at 10:19:47AM +0200, Svyatoslav Ryhel wrote:
>> =D0=B2=D1=82, 21 =D0=BB=D1=8E=D1=82=2E 2023 =D1=80=2E =D0=BE 21:27 Greg=
 Kroah-Hartman
>> <gregkh@linuxfoundation=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > On Tue, Feb 21, 2023 at 08:32:10PM +0200, Svyatoslav Ryhel wrote:
>> > > FM34NE is digital sound processing chip used for active
>> > > noise suppression mainly on ASUS Transformers=2E
>> > >
>> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > ---
>> > >  drivers/staging/Kconfig          |   2 +
>> > >  drivers/staging/Makefile         |   1 +
>> > >  drivers/staging/dsp/Kconfig      |   7 +
>> > >  drivers/staging/dsp/Makefile     |   2 +
>> > >  drivers/staging/dsp/dsp-fm34ne=2Ec | 364 +++++++++++++
>> > >  drivers/staging/dsp/dsp-fm34ne=2Eh | 845 +++++++++++++++++++++++++=
++++++
>> > >  6 files changed, 1221 insertions(+)
>> > >  create mode 100644 drivers/staging/dsp/Kconfig
>> > >  create mode 100644 drivers/staging/dsp/Makefile
>> > >  create mode 100644 drivers/staging/dsp/dsp-fm34ne=2Ec
>> > >  create mode 100644 drivers/staging/dsp/dsp-fm34ne=2Eh
>> >
>> >
>> > Sorry, but why is this going into drivers/staging/ at all?  What is
>> > needed to be done to get this out of staging?  Why not do that work
>> > right now?  At the least, we need a TODO file in the directory that
>> > lists what needs to be done and who is responsible for it=2E
>>=20
>> Because this driver sets up fm34 and switches it to bypass mode allowin=
g
>> sound to work on the device=2E There is no dsp framework in kernel whic=
h could
>> be called to operate dsp from the actual sound codec=2E (If there is, I
>> would be glad
>> if you show me)=2E Fm34 must be active only on DMIC use, all other case=
s require
>> it to be in bypass=2E
>
>That does not explain at all why this needs to go into drivers/staging/
>and not the normal portion of the kernel=2E  Why this specific location?
>What is wrong with it that requires it to go here?

It is not fully functional and does not perform its main function (noise c=
ancellation) because it has to be called only for DMIC=2E Same time it is e=
ssential to be set so that audio could work on device=2E

Once there is such a framework in kernel, which allows to control dsp from=
, I assume, asoc machine driver, this driver can be moved wherever it shoul=
d be=2E Currently I can not tell where it should be since I haven't seen ds=
p drivers like this in kernel=2E

>In other words, you need to document _WHY_ it must go here as it is not
>obvious at all=2E
>
>thanks,
>
>greg k-h
