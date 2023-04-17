Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F876E46FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDQMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjDQL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:59:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF885275;
        Mon, 17 Apr 2023 04:59:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b620188aeso1247752b3a.0;
        Mon, 17 Apr 2023 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681732662; x=1684324662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByuvqnZ0whBYE58ALvTkPoZXFMoOo3weY1eli1YLs8M=;
        b=ezXmzlMEqu08ohTUCxyWeT1ghxYBInGOWizV/QuxcC3LNYxDh4JflmMdjRbuaKuFEF
         M3/peUNeBWEFoNGrCMbsDOZBj245P7/NUTnHjRz8dXI8bIdQiWYnK5KwVA7Eqfw2RG/y
         IMj15+g/R9545qoQEQLdBloLu5S8PqcAuaJA3lC97I6/m2AOugMZBuh0HbYjumTHQNpL
         ZALVclRThPcEz1Icfh4eP08TGGnFWk+EW52vi9FJR+hNPeiM4l4D/xaMz4GsJGAmmSKj
         OZ3qvulCfiClhw3EKAQiTh34xSpk3PvDKxCXWzG/BuQPk5qXzXboCa1KB7OeZP+/otqg
         nDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732662; x=1684324662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByuvqnZ0whBYE58ALvTkPoZXFMoOo3weY1eli1YLs8M=;
        b=TD1r/7eQ1j8ai4uIs7pg5XnBQe9Jw6SYAnV6meRbzVE47qi1zkd9C5KwT2gRbrf5uU
         s228ThKZO7kkWW7O2D/QKG5ILsfKt2VM62tgvRP5Za0skgxeF7zV3zZ6Mk/vXen05zqJ
         rSNwaTFvH36caPsmdXXtgmj9rI70UudedNCWDBoe7mt2Cdw5jqRCcQk39XOI0NOwbf17
         wp6zdwHEP7s6SCu1m7I/RPwnIJkZZEesRrEFigpH7cYPfGzFDzD+sJkNofiI/SEphgCR
         DWkJBbMOps035k4xJQWRTKBbIylztFfTY9ZVYcDloNWESwJj7JeoYUXFwdAPIUIYMM4n
         rx8Q==
X-Gm-Message-State: AAQBX9eUnvuiw/bXNSc9Qo45mmK7CvS8x/cjWr59edi1kIpms8xNsXWS
        XJgAUorcPwKW/nwH4Igj2GbDKPdHoVrtc6WY7sE=
X-Google-Smtp-Source: AKy350ZuQYL1FYypLxgVwEvW7yKVWERIY1UOZe2w4ZV8QVjHAvbbucDalib2gb7BSAcoKBVQ6I/LS6oIqFiXdpeTNM4=
X-Received: by 2002:a05:6a00:24c4:b0:63b:5496:7af9 with SMTP id
 d4-20020a056a0024c400b0063b54967af9mr6836463pfv.2.1681732661836; Mon, 17 Apr
 2023 04:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-5-aford173@gmail.com>
 <807aa6c6-bbea-abcc-172d-17e22d1a3988@denx.de>
In-Reply-To: <807aa6c6-bbea-abcc-172d-17e22d1a3988@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 17 Apr 2023 06:57:30 -0500
Message-ID: <CAHCN7x+NUnMtLbj_7A_uqxPsi5NXRXsPFwDnn=sf1bgm-Q-BsQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
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

On Sun, Apr 16, 2023 at 5:13=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/15/23 12:41, Adam Ford wrote:
> > The high-speed clock is hard-coded to the burst-clock
> > frequency specified in the device tree.  However, when
> > using devices like certain bridge chips without burst mode
> > and varying resolutions and refresh rates, it may be
> > necessary to set the high-speed clock dynamically based
> > on the desired pixel clock for the connected device.
>
> The link rate negotiation should happen internally between the nearest
> bridge and DSIM, so please add that to DRM core instead of hacking
> around it by tweaking the HS clock again.

I thought you tried to add something like this before and had some resistan=
ce.

The Pixel clock is set by the bridge already without any new code
added to the DRM core..  I am just reading that value that's there,
and setting the clock accordingly.  I don't see how this is a hack.

adam
