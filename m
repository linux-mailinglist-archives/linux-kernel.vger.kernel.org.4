Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F974A5DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjGFVZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGFVZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:25:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C61BF3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:25:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so3271a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688678729; x=1691270729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jveyGfyZnU4QZ4Tv50nsm4vX0ehG0ZXutB/fMm4ATqA=;
        b=LG1FG2Z4dz0E3iCs/Ok5I4yExx1U51TTgBhCOrEXXmox8Grv+QkinP2ikrBk4CzEHj
         qbDie08YAe6SxefoxBJg66h/vM/DNhqAUxy4T5XpjH/O4n4hiWginTOPYTErrVSIJDHF
         Y/aS5/EhGJuMpcAhZH6EOZXFKH3VZ6frlPpepZEVqr45740HdjWfREWcbbOmmQlVqIx5
         9XtQSLEbIeHxHm2Sk+GmuK+DC280dRX+UZ3hcKfLvGgknsZCq4hgow/dL0FYPeAP/mJD
         UlmlR/D6/W/SQkJ0nV82EQ7LlLNHJHTWoEd1OSzJbDPkr/Tpc91lWseoZNgsqEmRA14S
         jIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688678729; x=1691270729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jveyGfyZnU4QZ4Tv50nsm4vX0ehG0ZXutB/fMm4ATqA=;
        b=gvk2oT5rYhUISljR765/vXokLxg/MCNjv8iKhag31rzauH3DfbOTdW56jrNAeB05qq
         cgjBA96ygOk6XNV4rtNBCrfC0bxstyBqE4RET+ScDIZKSNtCM0TUaVHiMkEijwrY8YJj
         fxRFfVJyR3g4br+ykfPAWvXtWfaMG5M/H2KJ7yG3+HnN/ZDELv2PPmNUG+EywnqeAmOb
         LtyUi6oQVlveMX6aMCMTLzGywi4JCohwAIexnHjbV++TncQzsV44O5DfuFA8nwzYZVcg
         EM4EOQ4FMwi3bIRm9BuFP5Nu49ZgTQHiKOGDqop9Wd+4umaGFNXggwhaaXGkfwEyAXb2
         rvFA==
X-Gm-Message-State: ABy/qLaliXHdubQ57QAsqHNydEgmvxHoZUY2UAqvVslqCg1ouXqcY4sp
        O9/HMkVtSoqdlIKPTr9UK2RIG6ibKgl6SeGK1rR+Hw==
X-Google-Smtp-Source: APBJJlHzbJ8ME0Uk9Q1RcdFhM+DvMx5GdQK1S9Q34hIjiYNqau+w5SO7xuMwn/G5bJWesXs2U4r9tBJgAHF+oXdHK60=
X-Received: by 2002:a50:c344:0:b0:506:90c4:b63b with SMTP id
 q4-20020a50c344000000b0050690c4b63bmr24265edb.4.1688678728980; Thu, 06 Jul
 2023 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
 <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com>
 <20230525093151.2338370-5-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=W_Vw=WTuap60PtzU8Jc58T1PsEhJfY96NmFFgmC1DB9w@mail.gmail.com> <CACRpkdZkNio99zS+ttEXncOtS1TcYbfunKSKddErRDV1gTY43w@mail.gmail.com>
In-Reply-To: <CACRpkdZkNio99zS+ttEXncOtS1TcYbfunKSKddErRDV1gTY43w@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 6 Jul 2023 14:25:16 -0700
Message-ID: <CAD=FV=Xx_Bf=Fr1aCmmcjXAv1CyMYwEFba7C6k_HRE1VPtTtHQ@mail.gmail.com>
Subject: Re: [v4 4/4] drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 4, 2023 at 12:47=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Thu, Jun 1, 2023 at 5:55=E2=80=AFPM Doug Anderson <dianders@google.com=
> wrote:
> > On Thu, May 25, 2023 at 2:32=E2=80=AFAM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > The Starry-ili9882 is a 10.51" WUXGA TFT panel. which fits in nicely =
with
> > > the existing panel-boe-tv101wum-nl6 driver. From the datasheet,MIPI n=
eed
> > > to keep the LP11 state before the lcm_reset pin is pulled high. So ad=
d
> > > lp11_before_reset flag.
> > >
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 371 ++++++++++++++++=
++
> > >  1 file changed, 371 insertions(+)
> >
> > Applied to drm-misc-next:
> >
> > 8716a6473e6c drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel
>
> Sorry for noticing too late and coming after the fact and complaining.
>
> We must stop using the panel-boe-tv101wum-nl6.c driver as a
> one-stop-shop for Chromium panels. The Starry panel in particular
> hardware-wise has nothing in common with the other panels in this
> driver and I'm suspicious about patch 3/4 as well.
>
> Please check my patch breaking it out to a separate driver, and
> if you could check internally if you have a datasheet for Ilitek
> ILI9882t or can use your vendor leverage to get one to improve
> on the driver (such as define the DCS commands...) that would
> be great.
>
> There are good reasons for grouping the panel drivers into
> respective display controller such as fixing bugs in one place
> and if we ever want to properly support things such as
> gamma correction it will provide the proper per-display-controller
> approach.

I mentioned in response to your patch #3 also [1], but closing the
loop here as well. The original reason several panels all ended up in
one driver was in response to Sam's feedback [2]. That was even
documented when the first of the "Chromium" panels landed in commit
93ee1a2c0f08 ("drm/panel: support for BOE and INX video mode panel").

In my mind it's really a tradeoff and I'm happy to go with whatever
consensus that others agree with. What I'm never super happy with,
though, is changing the bikeshed color too often, so I'd be really
curious to hear Sam's thoughts on the issue and whether he'd like to
see this driver broken out into a dozen drivers.

[1] https://lore.kernel.org/r/CAD=3DFV=3DXkr3Qpd8m_6Xta_2jL_ezbxsmMyarbKXTX=
L+UJLG9xNw@mail.gmail.com
[2] https://lore.kernel.org/all/YSPAseE6WD8dDRuz@ravnborg.org/
