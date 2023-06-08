Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEC728371
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbjFHPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbjFHPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:16:15 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B330C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:16:09 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33b04c8f3eeso2295035ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686237368; x=1688829368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJwtygG96EsLUnJEr5SXwbHpM9NJlbjJDKOEG9/I2wc=;
        b=jLRAJDAM1zP/l86YOfAUElwb1YY+B1bfoeDLM24tXf5PfMeRwy/scpuLqQxbnAhAb2
         7voLW0llPtDcxBZpUgwmHEvDuNNi3Bofwyu9pgkYBFtYyvEe2iXn8MNfnBsi1VO7MK4s
         4Ft2n+3qMY814s6FSDFC+PALRvZGjeaBjUwfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686237368; x=1688829368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJwtygG96EsLUnJEr5SXwbHpM9NJlbjJDKOEG9/I2wc=;
        b=ZJNu1Px3YJUlb97O16BGqqhdTovwov7svCm66WgYxN4WTarKWv4IlA9gMjPBbHq6b4
         1FeV3fH1QObHFYp0PQ2UgNp+1dhFjjs8P4HEk9qlkaHb2L1w9U7VjZyYfO8Ktbqo6zHA
         Ne3qsmmgRJCabbZDrqW2qzzbnykD3haafvSZzkgKx7X00kRYtALEJdu4BtL9gk0dZeBf
         qfSMe10FAZ7rWrlQ2aSaJq4rYb1854wV7Yr58WcTFG+S6rHw2qiOxs2e8yvwGF3HUq5l
         Pz+S1nxSbcAC3NuY8OuMXUJuCS0j3qf7RuVuGYjUNBIjqSKXtUTI9IUxSf7bggIeagrF
         /gTg==
X-Gm-Message-State: AC+VfDwSxywxrfzdCcDEOrGlThFMF7RlKXIzEzd8Y85YNPsULKT4PkGu
        JDig+jCSs7h3ycMwOwOxJ73gPj0d3M99MD7Y7SI=
X-Google-Smtp-Source: ACHHUZ7AdDRKWlFCDH6J3vjxV6Mn+PasSI1fCG7fIi6e7Pk9qf6exQtndqDS1cRJQ2tFpY6k98REGA==
X-Received: by 2002:a92:d98e:0:b0:33d:59d9:7de7 with SMTP id r14-20020a92d98e000000b0033d59d97de7mr6986306iln.12.1686237368310;
        Thu, 08 Jun 2023 08:16:08 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id a12-20020a92ce4c000000b00330a9a362c8sm477868ilr.8.2023.06.08.08.16.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:16:07 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so149265ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:16:06 -0700 (PDT)
X-Received: by 2002:a05:6e02:20e1:b0:335:5940:5ca6 with SMTP id
 q1-20020a056e0220e100b0033559405ca6mr212512ilv.13.1686237366240; Thu, 08 Jun
 2023 08:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230608012443.839372-1-suhui@nfschina.com>
In-Reply-To: <20230608012443.839372-1-suhui@nfschina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jun 2023 08:15:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqmqaKXG20MuMwjwyR-8deFF7+chqphN=hiJ05mfC=HA@mail.gmail.com>
Message-ID: <CAD=FV=WqmqaKXG20MuMwjwyR-8deFF7+chqphN=hiJ05mfC=HA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
To:     Su Hui <suhui@nfschina.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andersson@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        u.kleine-koenig@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 6:25=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <=3D 5.
>
> Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 7a748785c545..4676cf2900df 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -298,6 +298,10 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_s=
n65dsi86 *pdata)
>                 if (refclk_lut[i] =3D=3D refclk_rate)
>                         break;
>
> +       /* avoid buffer overflow and "1" is the default rate in the datas=
heet. */
> +       if (i >=3D refclk_lut_size)
> +               i =3D 1;
> +

Looks great now, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Unless someone beats me to it or objects, I'll plan to commit this to
drm-misc-fixes early next week.

-Doug
