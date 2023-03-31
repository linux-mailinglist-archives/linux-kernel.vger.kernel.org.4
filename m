Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6523A6D1AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCaIsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:48:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBF5BAD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFE5EB82D5A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92128C433A0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680252520;
        bh=uOPIzovJQaN2uF3uCRFfcTfMui228WfnHJ8oPe20zeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZCTbpWPMhYqpd++CTJoOKG+UybwN/OuqSGHgGJgjGO/4eJ1Cy4ofOmSB1IjLXjIm1
         oxTAid3k44j4vdfVOw22nT4C3SI7a4WtOwNgmHOpDho/mzdFPdQGfxBIfEndtSQSIg
         xFnhT6PZpCHV0U6lrY4uBcoYqsq3+WutRhNyl7QXfBLoprcjEzT/0dvBC61ugS5fP2
         vF+a8xUxC+yU5hCk4VFC8Kgct7635ohqqbbwOvobnYhPa907srZs3WzzUhwsxMmduP
         LVv1fX9FBc8u7E8YyVbPLNTO9JmtHXHqZKmdUe/MACGtGaVIkCTWG4Bt1elvVKLKeO
         lSyqVmpl8Jo7g==
Received: by mail-pg1-f182.google.com with SMTP id d8so12986650pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:48:40 -0700 (PDT)
X-Gm-Message-State: AAQBX9fRzp9IfzLtpfJngwnC9BgJPm7SZOudRLt5hJ/8zKNFuCBckkci
        tleSJ+0TW0QLtuiU2SMqDdmmbmqGe8Th8+OvsVZdFg==
X-Google-Smtp-Source: AKy350Y/MWkqiH7ijwIPbG8OO//iuA04N3BGZZ2M7G62QG2A4MpVvHeBi7S5bOepo2n+hR49zH/MKBuCzZcODRujn6Q=
X-Received: by 2002:a63:dd0f:0:b0:4fc:a80e:e6ec with SMTP id
 t15-20020a63dd0f000000b004fca80ee6ecmr7342372pgg.5.1680252520141; Fri, 31 Mar
 2023 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230331030204.1179524-1-treapking@chromium.org>
In-Reply-To: <20230331030204.1179524-1-treapking@chromium.org>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 31 Mar 2023 10:48:29 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4i+3H4-e7wCGTrpR+RCZy4OfgErn3bFmOWtWRkZy_whg@mail.gmail.com>
Message-ID: <CAN6tsi4i+3H4-e7wCGTrpR+RCZy4OfgErn3bFmOWtWRkZy_whg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Use constant sleep time for polling hpd
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 5:02=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> The default hpd_wait_us in panel_edp.c is 2 seconds. This makes the
> sleep time in the polling of _ps8640_wait_hpd_asserted become 200ms.
> Change it to a constant 20ms to speed up the function.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index b823e55650b1..c3eb45179405 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -184,7 +184,7 @@ static int _ps8640_wait_hpd_asserted(struct ps8640 *p=
s_bridge, unsigned long wai
>          * actually connected to GPIO9).
>          */
>         ret =3D regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> -                                      status & PS_GPIO9, wait_us / 10, w=
ait_us);
> +                                      status & PS_GPIO9, 20000, wait_us)=
;
>
>         /*
>          * The first time we see HPD go high after a reset we delay an ex=
tra
> --
> 2.40.0.348.gf938b09366-goog
>

Snoozing for a few days before applying.

Reviewed-by: Robert Foss <rfoss@kernel.org>
