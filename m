Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BFB5F3EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiJDI7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiJDI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:59:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C252830
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:59:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so27428477eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fIJl4IiOeRHaHh1QoEObM4QlmMAVfHee9nuHBfhnVzU=;
        b=ZQ+T6F0KeYd1rXAGaq4pxLHWYpf52ZDDnEygNdrbIpL4s8YBrdQcO7AfkSEGUv0rgs
         PFX0nZ/YZZ/5vJRhcUQ+KCgKq9FzByTKnxWsqzqYCUpn5HPGNhy5wX6BHW/FjjLL2QCy
         HwA1c1OlDZEfrap4fJFg2E2Mw0PCrw0R/BLqEOwvYia3xo6QivtKrEUBbwlHEdoXV8du
         UcZnicgvZAEOIVbuJuUzwSBnx5SdiDi8i1HODdcZWVQztvfcWGdGi2SUkfTPAqwcU7sL
         7lzBpIBghaemabuGvzCLQLHwmMYibGDsJfrB+EmoBaLd94CkVF+boO890RDD1EwpvN7q
         5m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fIJl4IiOeRHaHh1QoEObM4QlmMAVfHee9nuHBfhnVzU=;
        b=sisM/C9EdEygYcZRw9Dzfdl54zs4Qy776TIHN/DJ8hhM6rmvaRcSQ5bqcMmnteUdRd
         RsvtXdpwtgG0ta703z8AH3GTsCxi0rdJemxc9vEGasud5v96yI+AnyapYRgPhdCCtc/L
         YeWe3KXQNoE24Yhgh1T5pJtCMZQFSXu9D9grsydHhad67+DT5lrd7O46f/JCMKyfgbWt
         vvMDgL8iyDH7xDA5y2rT0dd2eqtn6POarSQersOwLkPNsLn2XAdr7ERFeZJgyi2hcVve
         Oz49wVhBV/pkfiHkG+w1cfS2qMgRGlOiNQd1UMUpjtEoJKoXooOL6AGR1MMd1Ln7kDo9
         J1Gg==
X-Gm-Message-State: ACrzQf3ZMobmpK77yroVdf9fVrou/CX21YiAkmJO086P7hUvVpAkuEac
        6ovG+t8I/gGuopgOJf4LwomQyWyx5QaxWEc2gpruGg==
X-Google-Smtp-Source: AMsMyM50R+yprH9k7KbiVmostQiMsE/qB5tlByDLHsJ+zV6rySTLqnkxwD56v0PwMao+NlnRa0NGkBqpPXx5ZKsHAAI=
X-Received: by 2002:a17:907:7805:b0:780:24fd:c4e8 with SMTP id
 la5-20020a170907780500b0078024fdc4e8mr18694277ejc.78.1664873944675; Tue, 04
 Oct 2022 01:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221004044943.2407781-1-treapking@chromium.org>
In-Reply-To: <20221004044943.2407781-1-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Oct 2022 10:58:53 +0200
Message-ID: <CAG3jFytkKjuW0frBUf1-MEKgzTnfdZEHcdxTTFoeXmvRJz7Y3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] drm/bridge: it6505: Power management fixes for
 it6505 bridge
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 06:49, Pin-yen Lin <treapking@chromium.org> wrote:
>
> This series contains 2 fixes related to it6505 power management.
>
> Changes in v3:
> - Handle the error from extcon_get_state
> - Collect review tag
>
> Changes in v2:
> - Handle the error from pm_runtime_get_sync in it6505_extcon_work
>
> Pin-yen Lin (2):
>   drm/bridge: it6505: Adapt runtime power management framework
>   drm/bridge: it6505: Add pre_enable/post_disable callback
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 58 ++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 10 deletions(-)
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

Applied to drm-misc-next.
