Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD372B623
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjFLDjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFLDje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:39:34 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2921114
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:39:30 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-783eef15004so1038246241.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686541170; x=1689133170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebvYpO0F+u/gYndYVszi7JYWZMT92l/StikrCYwVr/Q=;
        b=DfiHa7OMFW8jDMmQFzxjjDd/wHo4AhI4eN/xuXsi4TY0Z8GEbzZHIXZqhLuCMvjTmc
         GSwZ81WAgVIxQ2GAi5juHf5aCaQATRmHOwwl5HmtFqjyFCSr9ZTr0Ltou5iXw2UDqBG1
         QYV5HluDzZWe8c+/M4dzsuvYbkETa18qAIN/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686541170; x=1689133170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebvYpO0F+u/gYndYVszi7JYWZMT92l/StikrCYwVr/Q=;
        b=BSkIBpQEgvynyTUf0Ov+iUVyn5KcyUFFmH9WKyyvQBMFqTlNh+qKtP+OB2HAjaIl9M
         7tOtIDoSQhvKMsUZ4dvFq3Js9Q+zryiUQQlpE/oBuZTwEv3irY4eqlgYq0j6cB/i7uKe
         fjVcyAs/J4mtc46B5wQBPdN7deWtg+1r1EXUOsh7QCdWRMg0WrOiahXdf6/dcgsrs0wS
         AJJPLAB2naS2qnJ4gHwflSGM1eVGla0QSRDApVT49J84gugQRsB0B0DqKF9+W7eHFb79
         mh8jlAdtTgj+YKEmiUNOqa64OFl2O+aia3EnEo4GsSdtboyIGJNNR86ZuPLkYE4gsufU
         B4jw==
X-Gm-Message-State: AC+VfDw/W9M9NPmp2PaTJuT2V/X0795CxUUfF1plHLbOf1df6nRnlZjz
        qTRuSFY4ASj9eN39I3is5m+exaNoqFqSwpRAMC5Wzw==
X-Google-Smtp-Source: ACHHUZ47kwyUvVJowTEBOgc8w9/bLyQ8fdjTcVtYWb61OD85CsmXfvhz77UhIZ1asoftsYVkaV+sx2b+IROxk7T5gzo=
X-Received: by 2002:a05:6102:34f4:b0:430:1fa:87c5 with SMTP id
 bi20-20020a05610234f400b0043001fa87c5mr2280202vsb.32.1686541170026; Sun, 11
 Jun 2023 20:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230608075651.3214540-1-wenst@chromium.org> <ce04685b7c4840b683add0bdd4404da6@AcuMS.aculab.com>
In-Reply-To: <ce04685b7c4840b683add0bdd4404da6@AcuMS.aculab.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jun 2023 11:39:18 +0800
Message-ID: <CAGXv+5EtdhkMq916LLOfpz8ok_xump5tv+oeNBvPq-_3-93oqQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: Use bitfield values for range selectors
To:     David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 1:10=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Chen-Yu Tsai
> > Sent: 08 June 2023 08:57
> >
> > Right now the regulator helpers expect raw register values for the rang=
e
> > selectors. This is different from the voltage selectors, which are
> > normalized as bitfield values. This leads to a bit of confusion. Also,
> > raw values are harder to copy from datasheets or match up with them,
> > as datasheets will typically have bitfield values.
> >
> > Make the helpers expect bitfield values, and convert existing users.
> > Include bitops.h explicitly for ffs(), and reorder the header include
> > statements. While at it, also replace module.h with export.h, since the
> > only use is EXPORT_SYMBOL_GPL.
> >
> ...
> >  static const unsigned int atc260x_ldo_voltage_range_sel[] =3D {
> > -     0x0, 0x20,
> > +     0x0, 0x1,
> >  };
>
> Is there any way the change can be done so that un-edited
> modules fail to compile?
> Otherwise the whole thing is an accident waiting to happen.

I think we could change the field name in the regulator description?
But unsuspecting end users / developers might just edit the name and not
see that the scheme has changed.

Or we could add a sanity check at runtime that checks the values during
regulator registration. How does that sound?

Mark, is this something you'd like?


ChenYu
