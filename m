Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB8726141
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbjFGN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjFGN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:27:51 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88851732;
        Wed,  7 Jun 2023 06:27:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a50fcc719so4979069b6e.2;
        Wed, 07 Jun 2023 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144469; x=1688736469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96K7mim4wjsUFSyoNjyPRj89jwQvp4OefH01N5hbH5I=;
        b=kKmqUbHhKvKv4wuODjZBcxBIOinIDVcbAF01ceisdhnKQA79OBhnjwwfC4LUDuxvvL
         QRHcLkUnUsnkt8lWRCZGxshGXRe5rC7MKUSiTyh0m/h9+IHeveHim1dVe+eRE6UybS62
         s4R7VX4U8/vdCKXJKXOY8Xlmw3nCm15dI4vQlOnvwvCreBCJSqZwFjkhPS3LAdXALnLm
         rHT1EUk5JgDKaYdTe5RD44EIqnmnZd57XEdqdy5ApO94SoIs7Y8jWgf863APYPgwmukn
         RNZS5y4DuvLMYB7oEXcYxyIUc6TFbL02K9yeRQ65k7v7AfwsY13sb7ad3R+cnIfz8IGy
         0L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144469; x=1688736469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96K7mim4wjsUFSyoNjyPRj89jwQvp4OefH01N5hbH5I=;
        b=NsFeCI1xaycoXmyGGnDUrBLHoID/ukUNHBWmbcAxdkjv0xhFB8TUml4Sr9CpF2y0fW
         zYSJWfffoyU66WVOMT9lxRLkieKRRs8/w9WpdSWBInzg1NWPN8i0wYv1N76lsv1PAYSl
         0IULA0lF995mFJFxgmkBd7cyL/wF2hHp89elztcpQF6eW9tWY0/6Je/tDUxLyFXse8XR
         3+HMDIVPEhZm/RfyDsyc2z+JcgZRItyeq2Wa+A0fpJRWMmMoVuFTRziAYGrGKChsXZ57
         04JRxdwyNxjPbMzzlN7vk915G6DBH1UfyH9lSCTUW1mUKO9aU86jsTcSKDItsxEK2eZL
         rV8w==
X-Gm-Message-State: AC+VfDxVGG+7MMkNtaK6+Nnt3P/oObnx4Qz7KIBvid4dgUmMdGcaSHd+
        PkxV+etlzdyQhZCQODacsWfuxAbesfkrOxEQRmo=
X-Google-Smtp-Source: ACHHUZ6nSlvk3rp1yOaaZ/dN8Pp/HWKYF5lyf8nRfNvUy82Jp6PBg92F5M4gACAMFvaoRdZYSavnkuamFvvPRm1b+yI=
X-Received: by 2002:aca:210d:0:b0:398:6008:f460 with SMTP id
 13-20020aca210d000000b003986008f460mr5491140oiz.28.1686144468671; Wed, 07 Jun
 2023 06:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230526030559.326566-1-aford173@gmail.com> <e1379d94-66a5-8538-abdf-de7770befb7d@prevas.dk>
In-Reply-To: <e1379d94-66a5-8538-abdf-de7770befb7d@prevas.dk>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 7 Jun 2023 08:27:37 -0500
Message-ID: <CAHCN7xK9RaLRSK_jSbbuGBUf14-FOHsrawi2J8G29iHSOj2Nyw@mail.gmail.com>
Subject: Re: [PATCH V8 0/7] drm: bridge: samsung-dsim: Support variable clocking
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 7, 2023 at 8:15=E2=80=AFAM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 26/05/2023 05.05, Adam Ford wrote:
> > This series fixes the blanking pack size and the PMS calculation.  It t=
hen
> > adds support to allows the DSIM to dynamically DPHY clocks, and support
> > non-burst mode while allowing the removal of the hard-coded clock value=
s
> > for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> > burst-clock device tree entry when burst-mode isn't supported by connec=
ted
> > devices like an HDMI brige.  In that event, the HS clock is set to the
> > value requested by the bridge chip.
> >
> > This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should
> > work on i.MX8M Mini as well. Marek Szyprowski has tested it on various
> > Exynos boards.
>
> Hi all
>
> We're testing this on top of v6.4-rc4 on our imx8mp board, which has a
> ti-sn65dsi86 DSI -> DisplayPort bridge. We do get an image at
> 1920x1200, but the monitor says it's only at 58Hz, and measuring on the
> DSI signals does seem to confirm that the update frequency is about 57.7
> or 57.8Hz (it's pretty hard to get a good measurement). It looks like
> it's the lines that are too long, by a time that corresponds to about 80
> pixels. But all the frontporch/backporch/hsync values look sane and
> completely standard for that resolution.
>
> Setting samsung,burst-clock-frequency explicitly to something large
> enough or letting it be derived from the 154MHz pixel clock makes no
> difference.
>
> Any ideas?

What refresh rate are you trying to achieve?  It seems like 57.7 or
57.8 is really close to the 58 the Monitor states.  I would expect the
refresh to be driven by whatever the monitor states it can handle.

Have you tried using modetest to see what refresh rates are available?
 When I was doing this driver work, I would use modetest to determine
the connector ID, then use modetest -s
<connector-id>:<resolution>-<refresh> to display various resolutions
and refresh rates.

The 8MP shares the video-pll clock with both disp1 and disp2 clocks,
and the imx-lcdif driver, which sends the display signals to the DSI,
uses the disp clock, so the video-pll needs to be an exact multiple of
the pixel clock or the output won't sink.  Modetest should also show
you the desired pixel clock for a given resolution and refresh.
My displays didn't show 19200x1200 as an option, so I wasn't able to
test that configuration.

adam
>
> Thanks,
> Rasmus
>
