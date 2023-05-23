Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9670D7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjEWIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjEWIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:48:44 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E30E0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:48:42 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-456f7ea8694so1548561e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684831721; x=1687423721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsCD0of1x6zAZe4E8ewHElcvWX4G+68HMU5ECsDupIE=;
        b=1MkyHwpRBLggLehbgS6eNfVckrrq+fSGe5Ml3QKm23i2ADWDBXeDmBN5mQpLixA1L7
         /STGoEzvvRpB9YR2lAH38LNK5EPoPYKR0USAiTHsMkH6PTlH/4pBmYOjfPYy2J/Y2FcC
         W0SzIJp0LCOnczI45DnIN/FEU25qCLA55krEq3uZR/TWW0lkWemQI6q2sZ56sLldQeO4
         d/eXHJjaLnm4UoLa2As4aYZOgyoAXDh3WFoT3NduC98nzH9ryrxihWhELLMp37MvEnu9
         wTZIKhJ5nO1lXo+qss4xvuc4vmH3GlFD9n7BGgxhyQbeV/BjRa2SUxLokggVFcHHaH+a
         DmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684831721; x=1687423721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsCD0of1x6zAZe4E8ewHElcvWX4G+68HMU5ECsDupIE=;
        b=A8JSxsw3keu9x1OzdJD1Nwz+usMCTbaJLHpJtOtAunvkwKcySeHcPY22OtQZSUaoBW
         SnVJZv6pSeWaK+fMIV6k2hlhvDBO/DWD0g5GJC3vhIhQOkulwe9KuuyffbHsVHSlifmc
         3JDAb4QEFnePFTckkADe/9LQ8XLGY1yxPK46Z7/pIPSQlRKl8Uaw9jGkO09sxd72SkQA
         fIymWb7mRBeLJxee712J/KU6od5i56kSqsmFE7+UOeYtZzm8R+fHnvQdd9Cyt71ZhaZY
         IWPUJoG/x7ZEjuQMfYon3S2or+5EpgY8qTrCM8NDTNOGnE8dhkTX8GTC6rGLTKkdwOw0
         pUPg==
X-Gm-Message-State: AC+VfDyoYy9Lsc8q1wQ8TyeN9mBOxr40C9XPunXzZJP/60QLBNwgoM0s
        z5MdiY2PnmKaPENaPBxsr8tIRQcZL+Z/e/Llv8ztKg==
X-Google-Smtp-Source: ACHHUZ4g3A8Ho/5ndNryXQpmLu1vYMnDo3U7OPTUNTtRkDJDs/TtPHk0tvFU6g2UWK2DN5PGxRYri4rRpoeNl2oXti8=
X-Received: by 2002:a1f:4113:0:b0:44f:d1f5:6bec with SMTP id
 o19-20020a1f4113000000b0044fd1f56becmr4252400vka.4.1684831721544; Tue, 23 May
 2023 01:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230427152055.18380-1-henning.schild@siemens.com>
 <20230427152055.18380-2-henning.schild@siemens.com> <ZEuBMCxeWAx9OilV@76cbfcf04d45>
 <759b2df004e2445e850a01b33e748972@siemens.com> <20230428113332.3a7b9a18@md1za8fc.ad001.siemens.net>
 <CAMRc=Mdfptr0ZXV=fzBE0T+=vTxhL1tOKxRy+ccFLOqinb0w1A@mail.gmail.com> <20230513115326.0a9f669e@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230513115326.0a9f669e@md1za8fc.ad001.siemens.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 May 2023 10:48:30 +0200
Message-ID: <CAMRc=MegFzyKSW6KAOUHfdMqnZGb3iAqhCbVrn2GFmyEqPTbcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on
 Nuvoton chip
To:     Henning Schild <henning.schild@siemens.com>
Cc:     "Wu, Xing Tong (DI FA CTR IPC CN PRC4)" <XingTong.Wu@siemens.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 11:53=E2=80=AFAM Henning Schild
<henning.schild@siemens.com> wrote:
>
> Am Thu, 11 May 2023 14:52:17 +0200
> schrieb Bartosz Golaszewski <brgl@bgdev.pl>:
>
> > On Fri, Apr 28, 2023 at 11:33=E2=80=AFAM Henning Schild
> > <henning.schild@siemens.com> wrote:
> > >
> > > Am Fri, 28 Apr 2023 10:26:18 +0200
> > > schrieb "Wu, Xing Tong (DI FA CTR IPC CN PRC4)"
> > > <XingTong.Wu@siemens.com>:
> > >
> > > > Hi all
> > > >
> > > > The chip id of NCT6116D is 0XD281, you can refer to
> > > > NCT6116D_Datasheet_V1_0.pdf, Page 291
> > >
> > > Thanks Xing Tong. I think we have come to agree that for now
> > > NCT6116D 0xD281 will not be supported in the kernel. Maybe until
> > > someone has access to that very chip and a use-case.
> > >
> > > But you managed to somehow get these datasheets, which are still not
> > > publicly available. Maybe you can use your contacts at Nuvoton to
> > > kindly ask them to publish those specs on their website for future
> > > reference. Some specs are there, but not all. That would help
> > > people to add more chips and avoid mistakes like they happened to
> > > me.
> > >
> > > Henning
> > >
> >
> > Henning, do you plan to respin this with the ID corrected?
>
> Bart, no this one fixes the name of the chip i have at hand, and fixes
> the size of its last bank. So it is valid on its own and should IMHO be
> merged as is.
>
> Since i do not have a NCT6116D (0xD281) i could basically just guess
> (not too hard) but not test. And i do not really feel like contributing
> untested code for which there is no known user/tester.
>
> Henning
>
> > Bart
>

Fair enough, applied.

Bart
