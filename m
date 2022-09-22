Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1E5E6AED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiIVSaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiIVS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:29:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4510B597
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:27:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f23so9576470plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TBgCkH3JkIc+IniQbGJXoodAUuhOgxlJRYBUPHsWxrI=;
        b=HPMAzRpCXEpObfn/F63fTuscb+vLxR36rz8hUk97RWQnfpREP1bquwZIrUmttoBnot
         fGHtp1cvokVQjHv9zBLi5zT4154UtPQseIPvE9Tq0z+BCMKIkgyKMhCE02OfrMsyoT2n
         /i+vE/a0M0lzPIXgS3xawXCGdPlyTh8Cp0T3W3WNCAGeHg4iR9pZGqLIGVI/3x6Eclhm
         sUHPBDIWchRu1NaNexKsymA46SS1Ko55YLZsxo8LuyCMhthFG4RoQJTZwVYBzabQmKx6
         0iDDZPf9OLiuerOeERMyxHplIp4G4I9VpFpV2R3cMgXWGY692B8D4wKPrlingk7zmSsq
         dZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TBgCkH3JkIc+IniQbGJXoodAUuhOgxlJRYBUPHsWxrI=;
        b=voVCyOPR0pSSqjG9d8OaAQgCZoeTziAh1JtXDbDxuPIDrlqG0tSFxkycqYzZBNH1eT
         /IrKpTiH0b/NP/oGYT9TL0wqIMHLqRnpG//F5tzGhazF473/l14xQkpzj7ZHcK5VvLuY
         wvjCOUEMJg5c8rHNGZ3X992uzudTiLvBfLnCTy5ZG7RCpl2m6gY1TT7kxsdichpyre0Z
         EkI4dD/ECXyo/7ti5FxHez/o/bUF+a0foBkjH4On1jqYNnK5kvakGmFCbEwjF64eMncz
         d4amu93wpWeCEXdCEm7wUrZmvH/0yuINcOY6LNAg6UMwuXa5FFjPpAPUaYA3tImq7bN7
         G9EQ==
X-Gm-Message-State: ACrzQf1BKo+U3WGZskzgo+cE6FChOQ+2wIXmS8FqDZOK52bKs1uHMc9U
        Brw5K/TJhY8XVWoDWHR2YHvwmbqGA5fLtRVyBFs=
X-Google-Smtp-Source: AMsMyM4QI3NFuVE7jbBezi07MGbAGIS9C9tKu5xGC7qUD5zpzZDmKPoRQqBKf/+Vgo5GQ82PidRigAnXTNg7EXsNC5c=
X-Received: by 2002:a17:90b:2bd3:b0:203:1a03:6b1b with SMTP id
 ru19-20020a17090b2bd300b002031a036b1bmr5041786pjb.58.1663871199819; Thu, 22
 Sep 2022 11:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220922124306.34729-1-dev@pschenker.ch> <20220922124306.34729-4-dev@pschenker.ch>
In-Reply-To: <20220922124306.34729-4-dev@pschenker.ch>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 22 Sep 2022 20:26:28 +0200
Message-ID: <CABkfQAG0ADPnJZAPBhq0ks-FCCNDw6qz4o+PBHniuqv+kiwSmg@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/bridge: lt8912b: fix corrupted image output
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 22 sept. 2022 =C3=A0 14:43, Philippe Schenker <dev@pschenker.ch> a =
=C3=A9crit :
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Correct I2C address for the register list in lt8912_write_lvds_config(),
> these registers are on the first I2C address (0x48), the current
> function is just writing garbage to the wrong registers and this creates
> multiple issues (artifacts and output completely corrupted) on some HDMI
> displays.
>
> Correct I2C address comes from Lontium documentation and it is the one
> used on other out-of-tree LT8912B drivers [1].
>
> [1] https://github.com/boundarydevices/linux/blob/boundary-imx_5.10.x_2.0=
.0/drivers/video/lt8912.c#L296
>
> Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 6a4bb7422176..5968f4af190b 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -188,7 +188,7 @@ static int lt8912_write_lvds_config(struct lt8912 *lt=
)
>                 {0x03, 0xff},
>         };
>
> -       return regmap_multi_reg_write(lt->regmap[I2C_CEC_DSI], seq, ARRAY=
_SIZE(seq));
> +       return regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SI=
ZE(seq));
>  };
>
>  static inline struct lt8912 *bridge_to_lt8912(struct drm_bridge *b)
> --
> 2.37.3
>
