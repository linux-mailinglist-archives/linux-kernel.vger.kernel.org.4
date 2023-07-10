Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A5A74D606
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGJMx5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:53:55 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A860C9;
        Mon, 10 Jul 2023 05:53:54 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-577497ec6c6so47998647b3.2;
        Mon, 10 Jul 2023 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688993633; x=1691585633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZOBAzVYjXK3LDlHRwH+RyX9od9CvnTpwN65S7Xs+ro=;
        b=JWNU5NzllEu1w3nKr4E+zjK5dJRi6ghnKM+xHU15oP1uV0XmZeHZgFxIjH5mNHjRgK
         lCWKrGCyGKeyVFJsqzK/gufJfTxbctcsw8NQhmtgOa4xrkQ2Mlo1sqP8LJ2ynXZ1xlzJ
         IZqWfJGCQalUuNsWH7BRRTiotEWtCSUOYOW7CjAOdUlJN7VIHxfyGr53ZePw/c49uvpZ
         Z04zZtRCQ4/WPUMYf61VQYtzxAbIfVJwhNjaagrfC/But4HzmNCG9PZ0O4BGNWAUvFcN
         eQ6XoK695a1zGIi1jh+3GRYJ11fQsVfQECUL5WwIfq1LRLVAig1KE/EIzhbIQFoCHyVy
         zDig==
X-Gm-Message-State: ABy/qLYE5Xzf8Xmx1JEBnIosU+u50a2S6QaIAl5mV7+fMshIryUkx9nd
        d4rksBVVMuWY3xnt/aXDux+2zweALTTK1Q==
X-Google-Smtp-Source: APBJJlHvV4V+/sOXsbStTVlrSLhme6udEucKr1TSlnyIBzNjl46LuAvWKZ7/JfqJJhKysU8QtgvdDQ==
X-Received: by 2002:a81:5a8b:0:b0:56f:fbc6:3b0 with SMTP id o133-20020a815a8b000000b0056ffbc603b0mr14119576ywb.14.1688993633417;
        Mon, 10 Jul 2023 05:53:53 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id b127-20020a816785000000b0057a44e20fb8sm3031269ywc.73.2023.07.10.05.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:53:53 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5703cb4bcb4so47938297b3.3;
        Mon, 10 Jul 2023 05:53:53 -0700 (PDT)
X-Received: by 2002:a0d:cb56:0:b0:577:630d:ef63 with SMTP id
 n83-20020a0dcb56000000b00577630def63mr13531231ywd.24.1688993633075; Mon, 10
 Jul 2023 05:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org> <20230707140434.723349-10-ulf.hansson@linaro.org>
In-Reply-To: <20230707140434.723349-10-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:53:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcmbv7vRKJWACN9dobqKeZuLqjpd8sLgt7FeTBi4uKfA@mail.gmail.com>
Message-ID: <CAMuHMdUcmbv7vRKJWACN9dobqKeZuLqjpd8sLgt7FeTBi4uKfA@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: renesas: Move power-domain drivers to the
 genpd dir
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Fri, Jul 7, 2023 at 4:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: <linux-renesas-soc@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

> ---
>  MAINTAINERS                                   |  1 +
>  drivers/genpd/Makefile                        |  1 +
>  drivers/genpd/renesas/Makefile                | 30 +++++++++++++++++++
>  drivers/{soc => genpd}/renesas/r8a7742-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7743-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7745-sysc.c |  0
>  .../{soc => genpd}/renesas/r8a77470-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a774a1-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a774b1-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a774c0-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a774e1-sysc.c    |  0
>  drivers/{soc => genpd}/renesas/r8a7779-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7790-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7791-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7792-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7794-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7795-sysc.c |  0
>  drivers/{soc => genpd}/renesas/r8a7796-sysc.c |  0
>  .../{soc => genpd}/renesas/r8a77965-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a77970-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a77980-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a77990-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a77995-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a779a0-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a779f0-sysc.c    |  0
>  .../{soc => genpd}/renesas/r8a779g0-sysc.c    |  0
>  .../{soc => genpd}/renesas/rcar-gen4-sysc.c   |  0
>  .../{soc => genpd}/renesas/rcar-gen4-sysc.h   |  0
>  drivers/{soc => genpd}/renesas/rcar-sysc.c    |  0
>  drivers/{soc => genpd}/renesas/rcar-sysc.h    |  0
>  drivers/{soc => genpd}/renesas/rmobile-sysc.c |  0
>  drivers/soc/renesas/Makefile                  | 27 -----------------
>  32 files changed, 32 insertions(+), 27 deletions(-)

LGTM.

Is there any specific reason why you're not moving the SYSC_* symbols
from drivers/soc/renesas/Kconfig to drivers/genpd/renesas/Kconfig?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
