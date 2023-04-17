Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF06E46E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjDQLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjDQLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:54:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398A65B5;
        Mon, 17 Apr 2023 04:53:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so25329347plg.4;
        Mon, 17 Apr 2023 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681732399; x=1684324399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W28jZlr43n4A+R8dw3oLWIHuParHAvf3EPiECCIvalU=;
        b=qhPUmExhRfifkoU+BUpekMd1gF/UVzqbLp7FIrS0RngjO+zVlU+4wtXqvS81HXxTCH
         wXRI5D9rv6NJs6cPzwkxyvUaOqdBDHWyYDFRhROC3ZUQLD1x7IHGLBg6qpYIwBNX6pi6
         CkzwtJfULWhZeiHSwtLINQKAJqCW2VVWpHYYusPnxo0O3FBnUABeM5DxYyslSkMplp79
         yFjDrQTb1F4ofmRWcjcKbA56LrHfFKDAtqGldGIq/aZBJGHNF6bqZ/WTSIRG7RYDTKZu
         /qxGVyyeADIj23M3ae8kc4bFZ8CVaxvsVMEqJfhYfai4YD6gJkShoqPFfBzbeE2DR3/S
         lERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732399; x=1684324399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W28jZlr43n4A+R8dw3oLWIHuParHAvf3EPiECCIvalU=;
        b=PPA5hbMEnfjpXH5IZj2nm1Qvf2SyC3p2RVuMHZaU8Y9kXSA+t5rP49XC73YE1QsxRX
         staNecrUErewwhBu1te8BiaMc85ljJ08ny4NCanS6Zfuy0dJ+c4KkRfsJ7rmP43mUTFA
         q3/jgf/dL5xz92zmqhqBV85yibY+tK10iZOnLiDHigWCkFU2tB+81uAv90lI6z+EsTzw
         AZp+pSpXZbBBrp3646SljwWGL4vsXX9IONXmAxT8VqTcfINymf0BkBhtzrHAXQWgNbW1
         Ho20CVUDGN0zL21qV2we3U7p3y025lpLyZI1ytKA4jDQEzcGLJVj9NKBBk1IF32xG6h8
         TDiA==
X-Gm-Message-State: AAQBX9c1mclfnJOe8RtaeFpyHyKz1cwH9h9nJJyPOrJCAlBVJuY8H1Qt
        ZjRciN4h9arJhIbYPDNCacyj/snMuzNBshC/Fhk=
X-Google-Smtp-Source: AKy350YurxFnXqjEiS/2z4uyi1r8p2MxvThm75LwFZcyBF9tDX0TFjTvQ5tjopuoyeXI+BEBVKAhjJ3Ze587uvT3574=
X-Received: by 2002:a17:902:f90b:b0:1a6:655f:9efe with SMTP id
 kw11-20020a170902f90b00b001a6655f9efemr3499134plb.3.1681732398572; Mon, 17
 Apr 2023 04:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-4-aford173@gmail.com>
 <8db7ad8da4805d7eb4471051676d179e193ee399.camel@pengutronix.de>
In-Reply-To: <8db7ad8da4805d7eb4471051676d179e193ee399.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 17 Apr 2023 06:53:07 -0500
Message-ID: <CAHCN7x+hFu15TM0w5DXzmWZRKEN6=MNNTVLNtpNxbirVGrapdg@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm: bridge: samsung-dsim: Dynamically configure DPHY timing
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Fabio Estevam <festevam@gmail.com>, m.szyprowski@samsung.com,
        marex@denx.de, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
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

On Mon, Apr 17, 2023 at 3:38=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Hi Adam,
>
> Am Samstag, dem 15.04.2023 um 05:41 -0500 schrieb Adam Ford:
> > NXP uses a lookup table to determine the various values for
> > the PHY Timing based on the clock rate in their downstream
> > kernel.  Since the input clock can be variable, the phy
> > settings need to be variable too.  Add an additional variable
> > to the driver data to enable this feature to prevent breaking
> > boards that don't support it.
> >
>
> I haven't checked if this generates values close to the ones in this
> table, but I guess it should be worth a try to use
> phy_mipi_dphy_get_default_config() instead.

I didn't know that was a thing.  I like that idea much better than the
table.  I just pulled what NXP had and tweaked it to fit the mainline.
I'll give it a try in the next few days, when I have some more time.

adam
>
> Regards,
> Lucas
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c |  85 +++++++--
> >  drivers/gpu/drm/bridge/samsung-dsim.h | 254 ++++++++++++++++++++++++++
> >  include/drm/bridge/samsung-dsim.h     |   1 +
> >  3 files changed, 326 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/gpu/drm/bridge/samsung-dsim.h
> >
<snip>
>
