Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C937080B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjERMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjERMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:06:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46A011B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:05:58 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-561b7729a12so22852177b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684411558; x=1687003558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL3eiATgzSA2ovHT7vBhqzczz2ZnSH9amS5jJrBLHWw=;
        b=IGrqT235/B5ITqxKVojXRk9kSChAVqH2uUb7sfsjkPT2wuWgmXGw40QavnZOBwL1O7
         KWcre8/GceW+jEZfbM1GhQNVRLi71ioS6qOMlvCZ6BmO/u8KdoZYl7X+yTWw/XhDTykP
         wxxSM6JkfhigJnNxVp2cDecSBvxGGnIaGf2dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411558; x=1687003558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL3eiATgzSA2ovHT7vBhqzczz2ZnSH9amS5jJrBLHWw=;
        b=Xv7Gzm04A4SALbjFAVAbiz8M4uZbAbbNomebMpcIsr2kSVZhGx7/fqp0rpnXjinNly
         2jwJWWA80fwvl28FWPB2ZqnEtgALqyClHiR0WieRecAiy7zfk9kKPBuo6oxH/o+9Gf84
         5i6RwVVR8hlN8jOWPOysVUtzunSmFYDfpXX8Ejsoi6PsZGCPZGcKPuts0L9dY9jCr/Gv
         16HgfAg3H1lx5JnfrnDXXhna2US3nsMyhu2zeYAb51uB39GNS4Jr48KHyMzUb6wIRk6g
         clU9NyGYTjC7u0QucHiFNEZ2QFPPhUqi9T0vFOtOYiqbyDLJuq8dPr2mHhR7RMERzUwH
         fk5Q==
X-Gm-Message-State: AC+VfDw+pImmUhBw7vN37yXjjn6ALyR7O7TDqXa9GgyVBVf6NbFKE3MF
        bduIxLaI1CXdQrlXr43wzHFObFBxyjbJjaXhBk48Jw==
X-Google-Smtp-Source: ACHHUZ4VtqU+ct+qgqlQijOJr0lmAT4qilj39KRzvbV5+c/1QbK+kt0FxIk7sCik+on6KMT+DuvSXC3nlzNjgVWuXIQ=
X-Received: by 2002:a05:690c:102:b0:55f:5d6a:97fb with SMTP id
 bd2-20020a05690c010200b0055f5d6a97fbmr1477843ywb.9.1684411557812; Thu, 18 May
 2023 05:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-6-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-6-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 May 2023 17:35:46 +0530
Message-ID: <CAMty3ZBXO-S_X7H8erzLHmV0ePwq=DXJzmytsg2Vye1rgTk84Q@mail.gmail.com>
Subject: Re: [PATCH V6 5/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The DPHY timings are currently hard coded. Since the input
> clock can be variable, the phy timings need to be variable
> too.  To facilitate this, we need to cache the hs_clock
> based on what is generated from the PLL.
>
> The phy_mipi_dphy_get_default_config_for_hsclk function
> configures the DPHY timings in pico-seconds, and a small macro
> converts those timings into clock cycles based on the hs_clk.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Michael Walle <michael@walle.cc>
> ---

Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
