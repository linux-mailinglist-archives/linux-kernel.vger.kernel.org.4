Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7267110D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjEYQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbjEYQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:21:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66C19A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:21:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae51b07338so12486645ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685031673; x=1687623673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR6J9TvXn9/or5O3pdTkH60kcb1mT4LDvcJAYgDiz7s=;
        b=EM8TsBT/Zo04L+jH4EotMG3q1FMcUAGke00LNbj15w+MQ1qxm1+wr+s23oa9kd6JpB
         n0no0x/vhQC3o9sy3qz0Rmh3FtUX75T+28Uw0tauPGtBr1ac/C3b8MYuFQjC5e75KXRZ
         syeygCV0L9z6E1t3OUjvIZtWxh4B7OZjJVpphSNey3cQ6ZCbG0c4Px9no7PLNw38mZfO
         1sd6XkijpqiAoCgEg74OdGtbL+bf9SBvv8nn5B0APoPa6OV4ysW+j7IjxRub9MtG0FvZ
         EfqcQQJ5KcJPY0lKRuiGalhTmiNqf7ZTfWGfuoq4xqtx3/WAqu3k/nXZLLczhPmHNYzn
         d07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031673; x=1687623673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR6J9TvXn9/or5O3pdTkH60kcb1mT4LDvcJAYgDiz7s=;
        b=V5w05TYkve34HYiYJPlAgfNZBBrpmsW7Nm8e76Ea7vJnGfIJ0iGTAg2zphZve5Tehf
         MNQl0vT9/7KERo8oGxfThnK7qKiCgASMCHUFn8AIiGgSDMKYbMRd0CdEw9ExumIs6TTJ
         +Nb7tR3qEtCKs2fEcbrOkqswReOBEpa7zJ9QTCZVsNYJdVklYjT2FCGMu5naxZGu+VPC
         PrP6isaYXMpK1Jh/m16GhjVbu0IdOnzeJaFzGN6qX3IHCt+i9oSUO+3O/jhvIvXnbDDf
         PK8k4b+Cg1GYDDwhG58oRbXojyzdoh22qWrUmvtQVYSKI8Ljzyn95QS74U0eRR3nrYhu
         kYmA==
X-Gm-Message-State: AC+VfDzRaa1AG0Wh4k+ZHHOHgld+g/vuhTXBBel7oNgMs6XlHZO0o4Ul
        ApCy5TZL0nMoFIBw6xWjK0S7IDVR3JZaIA7JSL0=
X-Google-Smtp-Source: ACHHUZ4sgGwtWXBApTubMwD+ctsYBM3Rn5DjVAsxU05U0oi7GjJiQCcZNhl02V8PRjoOsaFPMMNCTnRJPwl4AvYVdmI=
X-Received: by 2002:a17:902:e892:b0:1ae:1237:874d with SMTP id
 w18-20020a170902e89200b001ae1237874dmr2152497plg.69.1685031672857; Thu, 25
 May 2023 09:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
 <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
 <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
 <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com>
 <8c65c5c3-0415-78c0-4585-df94a532a04e@linaro.org> <CAHCN7xJBf+8KyXbqxVSUUXbKqomX+i-13Ed23QFeF0SM8nQpzw@mail.gmail.com>
 <8f50dc2c-4d74-6c0f-87bc-b96bbf1373a9@linaro.org> <bef20993-b831-b692-237e-b1e89ac4f34b@linaro.org>
In-Reply-To: <bef20993-b831-b692-237e-b1e89ac4f34b@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 25 May 2023 11:21:01 -0500
Message-ID: <CAHCN7xLDoftN9kP7tdkyd0RQ+X2T3oha0tgfXamm-eonXmYnBg@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     neil.armstrong@linaro.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        dri-devel@lists.freedesktop.org, Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:19=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 25/05/2023 18:15, neil.armstrong@linaro.org wrote:
> > On 25/05/2023 17:57, Adam Ford wrote:
> >> On Thu, May 25, 2023 at 10:39=E2=80=AFAM Neil Armstrong
> >> <neil.armstrong@linaro.org> wrote:
> >>>
> >>> On 24/05/2023 14:49, Adam Ford wrote:
> >>>> On Wed, May 24, 2023 at 7:45=E2=80=AFAM Fabio Estevam <festevam@gmai=
l.com> wrote:
> >>>>>
> >>>>> Hi Adam,
> >>>>>
> >>>>> On Tue, May 23, 2023 at 8:49=E2=80=AFPM Adam Ford <aford173@gmail.c=
om> wrote:
> >>>>>
> >>>>>> Inki,
> >>>>>>
> >>>>>> I haven't heard back from you on whether or not you want the bindi=
ngs
> >>>>>> patch to be included with me resending the series as V7 or if you'=
re
> >>>>>> OK with a single, stand-alone patch.
> >>>>>> Will you let me know?  I have the patch standing by waiting for
> >>>>>> instructions.  If you're not the right person to ask, please let m=
e
> >>>>>> know who the right person is.
> >>>>>
> >>>>> Neil has also been collecting samsung-dsim patches. Maybe he can cl=
arify.
> >>>>
> >>>> If it matters, my preference all along was to do the bindings as a
> >>>> separate thing once the driver updates were merged into the tree.
> >>>> Since the bindings can be done in different ways, I was hoping to ha=
ve
> >>>> a separate discussion on the right way to do the bindings. If they
> >>>> need to be part of the series, I can do that.
> >>>
> >>> If you don't introduce compatibles, no need to send bindings, it can
> >>> be send separately.
> >>
> >> This series doesn't change any compatibility.
> >>
> >>>
> >>> Can I apply this serie and 20230503163313.2640898-2-frieder@fris.de ?=
 seems all has been reviewed.
> >>
> >> Looking at the driver, it looks like linux-next has some newer
> >> features added into the driver since I started, so this series might
> >> need a re-base.  If that's the case, let me know, and I'll do the
> >> re-base.
> >
> > Ok I'll pull the other bits and let you know if this one needs a rebase=
.
>
> Indeed, starting at patch 3 it fails to apply, a rebase on drm-misc-next =
is welcome!

I'll do it when I get home tonight and have the next rev.

adam
>
> Neil
>
> >
> > Neil
> >
> >>
> >> adam
> >>
> >>>
> >>> Neil
> >>>
> >>>>
> >>>> adam
> >>>
> >
>
