Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569936EB120
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjDURtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjDURsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:48:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990841738
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:48:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b8f557b241fso1050955276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682099309; x=1684691309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWqX2mo3dFEdJ7DitrYIS25Aemq6au0F4tIDpdUOsJw=;
        b=bfP6ECRJHhdI5t6m6waV6Qm4WcJC8DFhQCADYZFuc4ex288Vh8DWOzWAHUcjV1zhj+
         oAy+Tv7CtzOmdM+/cz2ddJoxmDwNAD1p2+RdAnmYh1zr2l5ATaM8N8pdDsjOggdF1RM+
         Z6v1SEuUrRPjusoKU0CtdgGIU8Qsuq0/awodvEN8pwdb0Kkk28brobkOOFtdq4gmPfSB
         lUWU51pzGRcvJEGmESaUaZ+SGaO5QHXeqEMwv+bBcwHSmQ66XF0I6o90axp1UVCrV6HU
         k8rgL9Lkds1KyFm8/Pmjk1wcXsGr7JXsV8XhBCrN0dIctyzqx8quROaQXrfAN4wqaKL9
         rdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682099309; x=1684691309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWqX2mo3dFEdJ7DitrYIS25Aemq6au0F4tIDpdUOsJw=;
        b=du42pZRZeRFlLFtUc/p1m3hSKwbPLT5yWy5GJqQEwtLRRuKzNPm5DW+nsqZbq7mEAy
         xBamuKyzfii9QMkb8grHmwWRt/7Ln291JRnSsDijAKaIWyAQPexnd5bNmEc5fVO15nvl
         R38Eka45AXCha2bgU9xpqUJHKAdm0suQRcIdZNQLW9NiEf167jNLGfGslrDgY2faQc2X
         4JhSoCw+jBBzn6l6JAqbzXP6+R2GYrQ+okLVehHeFyxKFCSX2QWbFSJYz1QlcN/bYeGa
         SIeYHcKmd1XWqbHzlvcAiPbZtBLqZfQbOXmBckViEVbzTTjgfDEGEfJi8gJFO6uTyrcH
         NgZQ==
X-Gm-Message-State: AAQBX9dtq1eAMltkC6YfXl5Yd60qU/sGNjG5Y60/d5U+CeqmMdqdZFnh
        VzDYTQGfgZEDOTRl7/VzFp4NJZbrt4HUGvQFfYO2CA==
X-Google-Smtp-Source: AKy350YkzVZKiayDZ4WmYVl9MOA0tVyi7CUMntD/rBvh18BIGAz1wcdLk9SMlfMn9GtwBc7uql6PxkcK5qJpUim6SRQ=
X-Received: by 2002:a0d:cc0d:0:b0:54e:e136:9f6b with SMTP id
 o13-20020a0dcc0d000000b0054ee1369f6bmr2554780ywd.46.1682099308692; Fri, 21
 Apr 2023 10:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com> <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation> <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
 <969a083998224016947f5e77218f4587@AcuMS.aculab.com> <20230421164838.52euobr5ohfyxxti@mobilestation>
 <CAOSNQF14TcJCU3BBvkL7PuokNXAczTyU=0mOisujBCYNNc2rZA@mail.gmail.com> <20230421171552.qvunrlxxpqusd5h3@mobilestation>
In-Reply-To: <20230421171552.qvunrlxxpqusd5h3@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Fri, 21 Apr 2023 23:18:16 +0530
Message-ID: <CAOSNQF2g9tNmgd62fne6qZaOXyDjux4D0oZy1DHbGDNh1DwmFw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "rohitner@google.com" <rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:45=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Fri, Apr 21, 2023 at 10:40:44PM +0530, Joy Chakraborty wrote:
> > On Fri, Apr 21, 2023 at 10:18=E2=80=AFPM Serge Semin <fancer.lancer@gma=
il.com> wrote:
> > >
> > > On Fri, Apr 21, 2023 at 04:39:30PM +0000, David Laight wrote:
> > > > From: Joy Chakraborty
> > > > > Sent: 21 April 2023 10:22
> > > > ...
> > > > > Sure, I can make the following change in the formatting and send =
the
> > > > > patch series:
> > > > >          dws->n_bytes =3D
> > > > >                  roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_p=
er_word,
> > > > >                                                  BITS_PER_BYTE));
> > > >
> > >
> > > > Won't checkpatch bleat about that?
> > >
> > > Why would it?
> >
> > I ran checkpatch on this and it seems to be fine with minor spacing cha=
nges.
>
> What spacing do you mean? No problem with the change as is:
> [fancer@mobilestation] kernel $ git show HEAD | grep -A1 -B2 roundup_pow_=
of_two
> -       dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_B=
YTE);
> +       dws->n_bytes =3D
> +               roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
> +                                               BITS_PER_BYTE));
> [fancer@mobilestation] kernel $ ./scripts/checkpatch.pl --git HEAD
> total: 0 errors, 0 warnings, 10 lines checked
>
> Commit e18b699257db ("spi: dw: Round of n_bytes to power of 2") has no ob=
vious style problems and is ready for submission.
>
> -Serge(y)
>

Sorry for my error, it looks like my email client does not show it correctl=
y.
What I was going to upload in V9 is the same as you mentioned.

Thanks
Joy
> >
> > >
> > > >
> > > > Is it ever actually valid for the caller to provide a
> > > > value that isn't 8, 16 or 32 ?
> > >
> > > Judging by this
> > > https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/spi/spi.c#L3=
630
> > > it is. SPI-controller also supports word lengths within the
> > > pre-synthesized range. So it's up to the SPI-peripherals and their
> > > protocols what word length to select.
> > >
> > > -Serge(y)
> > >
> > > >
> > > > I'm sure it looked as though some other lengths/counts
> > > > where likely to go badly wrong.
> > > >
> > > > I know there are times when it is useful to bit-bang 'odd'
> > > > numbers of bits - like command+address+delay for fast reads
> > > > but that is a sub-32bit transfer so (at least somewhere)
> > > > is 1 word but not all the bits.
> > > >
> > > >       David
> > > >
> > > > -
> > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keyne=
s, MK1 1PT, UK
> > > > Registration No: 1397386 (Wales)
