Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20C64D9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLOLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiLOLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:01:23 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890362E6A1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:00:18 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1447c7aa004so20421143fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6pQ9de+Vc2wR7bYvymc7ZHtpYqEL/DcrRHJx1Mh2KsQ=;
        b=bMgSIdc2m2S+3BHH0vvxtn6c3YBRRts62w7RRM8K164kP11hfL33lCFdKMf6QFK1Wi
         Izww7lPRkRuleqOx6OmG/jlKopV3ENZFh5nUYZlwPapi5VIVSw6NIb0EgEm3m1HKn0nh
         5OPh6NkPbi+0jOYrnYhEMaKAu8NKIlZU8xiAS8BxUrOFlG40jdfo07cQZ7SbK9qLClUK
         J6snoDHqoXBRghrlPJ5mrSnMfKTJB8Xrm/8qQc92nlkeTWqTg+RhRVGYmEGhf+PAh3cX
         iADIL99Fau45ZW5+ADUKPEL++yMAcejX9Wa5e4+6pwJhYkcD/He9RXT2+d9BgvcUg3Qz
         oSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pQ9de+Vc2wR7bYvymc7ZHtpYqEL/DcrRHJx1Mh2KsQ=;
        b=bb37adBHAFx7B4KsNqzRwwwQ7PQWC+GnTYhIsFSUwKZQah+4eQA+afBsX2A+KPgWuZ
         hHVRaItLBM2NSjEpJCmFsSvSIRtJ7DQhWMCWir/XuHa1MZo+Yhu6gT8h+Lb8B2jjR5Lq
         sFm4NexQqQ7Ss64BzYFF8HISTdMXnNpIJvy92mjeE07RjU3HUoHJKH9KdCsjhFOvIhbs
         U5rkBTkxyGzjYH8ii9EoW/Ls65wfHEXfJftFCoUcLHyp9IG7C0B1rA18PS+R0EmwzShI
         ieJbf3EHSqy/1xIQI/88pZQ8xNB15aY3rBzmVocZ7Uuxkbz9WGoOo//msIYisvpkSZFM
         Omrg==
X-Gm-Message-State: AFqh2kqtIx9kt4yd4+hqz5Svv1a1JJjazKuLQKTX/hd0u4ZAD6P5L3u5
        OwX7/BCLphH8ZCY7qp1260GNctdvItcqcw9aKeINFg==
X-Google-Smtp-Source: AA0mqf5F/5kRIJI2tVYm8OqRlAYZXRqyjtT57M3LL5Z46ZREVwwUH72F0qonNnKrqu9vgBKMSg8xRqpoW9tgmWe8yd0=
X-Received: by 2002:a05:6870:9e4c:b0:13c:33d0:22e2 with SMTP id
 pt12-20020a0568709e4c00b0013c33d022e2mr588342oab.14.1671102017941; Thu, 15
 Dec 2022 03:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20221214125821.12489-1-paul@crapouillou.net> <20221214125821.12489-4-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-4-paul@crapouillou.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 12:00:07 +0100
Message-ID: <CAG3jFysiZMVbrwDuuqN+uKEH7ge7q-z0VRtbLfBLxOEYkaC=ww@mail.gmail.com>
Subject: Re: [PATCH 03/10] drm: bridge: it66121: Use regmap_noinc_read()
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 13:58, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use regmap_noinc_read() instead of reading the data from the DDC FIFO one
> byte at a time.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index a698eec8f250..12222840df30 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -589,13 +589,12 @@ static int it66121_get_edid_block(void *context, u8 *buf,
>                 if (ret)
>                         return ret;
>
> -               do {
> -                       ret = regmap_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG, &val);
> -                       if (ret)
> -                               return ret;
> -                       *(buf++) = val;
> -                       cnt--;
> -               } while (cnt > 0);
> +               ret = regmap_noinc_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG,
> +                                       buf, cnt);
> +               if (ret)
> +                       return ret;
> +
> +               buf += cnt;
>         }
>
>         return 0;
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
