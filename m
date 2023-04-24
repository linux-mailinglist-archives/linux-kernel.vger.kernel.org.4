Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB36ED3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjDXRjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjDXRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:39:15 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D33A5F0;
        Mon, 24 Apr 2023 10:38:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-555e853d3c5so31951537b3.2;
        Mon, 24 Apr 2023 10:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682357886; x=1684949886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43eVrCXPQ3JCvD9a2+R69fZ/LkUiFUI38jpabfj7B7U=;
        b=TgkboWY74aLy6vHBN94U5NTxLaG+FuJAJDzVjfBdPOvpV73rmMT+jPIrab3HoxDfDI
         jci+lbAiM8qJDG9AoUQ6h2YHNGW5C+arHVbNHaD1Ze5EfP6g9f7h/qi68Q3IGAkqLY7V
         7h780hq7UR3uj3STDU5M8lj06FFG3QJEOnCKcQ3d6/tJH8+uvb9A+WUkCH0lq7w2xuTe
         fVUG6nU9gxlyzy5ZpbygRqy7iyO326SuhBs8YLyEmz47dd3KdAj8C/jlLv4d12lTnWNW
         Sa0m8slKRhYsqyOnxjRFCTzO3EPoGZbahQZl4bl6qfyvDI+nfl8+MftXRIqYeE29yYk3
         +c+Q==
X-Gm-Message-State: AAQBX9fmER9dlQkwdpIZ8A1NOhKDjPkt4R4KFMmXJnbBg4sZ8VbaTZDq
        yv1m42jYrczBlwoHA1F9HSaiGFxTZCVoAQ==
X-Google-Smtp-Source: AKy350YGGKQCvcFhIoCo23Pfqo7TjqOkFz8ETKjx1Q4i3RX6Q2NaAsmwLN8QtYUUt1RHYO/M7yLpEg==
X-Received: by 2002:a0d:f306:0:b0:54e:fad7:7485 with SMTP id c6-20020a0df306000000b0054efad77485mr8306256ywf.31.1682357885646;
        Mon, 24 Apr 2023 10:38:05 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id t1-20020a0dea01000000b00545a08184fesm3021978ywe.142.2023.04.24.10.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 10:38:05 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-555e853d3c5so31951307b3.2;
        Mon, 24 Apr 2023 10:38:05 -0700 (PDT)
X-Received: by 2002:a0d:f306:0:b0:54e:fad7:7485 with SMTP id
 c6-20020a0df306000000b0054efad77485mr8306240ywf.31.1682357885170; Mon, 24 Apr
 2023 10:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com> <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Apr 2023 19:37:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQiMbupkCYhZ86WHND25E==iA1DyVwGf2rg32zJLcV2g@mail.gmail.com>
Message-ID: <CAMuHMdVQiMbupkCYhZ86WHND25E==iA1DyVwGf2rg32zJLcV2g@mail.gmail.com>
Subject: Re: [PATCH 05/11] media: renesas: fdp1: remove R-Car H3 ES1.* handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Mar 7, 2023 at 5:31 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> and disable booting for this SoC. Public users only have ES2 onwards.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch, which is now commit af4273b43f2bd9ee ("media:
renesas: fdp1: remove R-Car H3 ES1.* handling") in media/master
(next-20230417 and later).

> --- a/drivers/media/platform/renesas/rcar_fdp1.c
> +++ b/drivers/media/platform/renesas/rcar_fdp1.c
> @@ -254,7 +254,6 @@ MODULE_PARM_DESC(debug, "activate debug info");
>
>  /* Internal Data (HW Version) */
>  #define FD1_IP_INTDATA                 0x0800
> -#define FD1_IP_H3_ES1                  0x02010101
>  #define FD1_IP_M3W                     0x02010202
>  #define FD1_IP_H3                      0x02010203
>  #define FD1_IP_M3N                     0x02010204
> @@ -2359,9 +2358,6 @@ static int fdp1_probe(struct platform_device *pdev)
>
>         hw_version = fdp1_read(fdp1, FD1_IP_INTDATA);
>         switch (hw_version) {
> -       case FD1_IP_H3_ES1:
> -               dprintk(fdp1, "FDP1 Version R-Car H3 ES1\n");
> -               break;
>         case FD1_IP_M3W:
>                 dprintk(fdp1, "FDP1 Version R-Car M3-W\n");
>                 break;

Apparently 0x02010101 is also used on (at least) R-Car M2-W ES1.0,
causing the following annoying (but further harmless?) messages
during boot:

    rcar_fdp1 fe940000.fdp1: FDP1 Unidentifiable (0x02010101)
    rcar_fdp1 fe944000.fdp1: FDP1 Unidentifiable (0x02010101)

Note that the R-Car Gen2 documentation states the register's contents
are all zeroes.  But that value would trigger the error message, too.

Sorry for not noticing before. Apparently I never booted a kernel
with this patch on koelsch...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
