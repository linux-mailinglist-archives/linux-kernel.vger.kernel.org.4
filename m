Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654A46DC551
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDJJqD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDJJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:46:01 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D66194;
        Mon, 10 Apr 2023 02:46:00 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id bv15so2215831ybb.1;
        Mon, 10 Apr 2023 02:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681119959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW3geLGISJ5Wl59n77OgvFtQOg4LkNPXguyTMjOYNek=;
        b=onwLkj9Nt1lbs/R3TyhoppSSq4rIdeH+SaR8vgVZG7Et2ELfy3BGG5X1MH+THxMsAu
         gVADzVq+WhNXCru+DfkC0wh93zdUWfaFgU0QXL8qON+W4Xefyh6hdyEWEqy+1QRoM+Wq
         igqMrVHdkAQ7yXjrg3XiOwovfBbWQt3AfjSLMiQXI3a/cf13t2x/m4/EDotK5sjWyKcp
         d5fhdKlnH8d73INJI8vGQZAYBmqGJ8hXf4lPPekKZ8wRmuYEMNcUkNn1TmUOo+1elCxN
         NCvktTs7u4cZZ7DQb5T9Cvqu9D9HfOmSCjkKJVltxJXJoK71DP4mBzyRobg9HkCq9Y4Z
         tFdw==
X-Gm-Message-State: AAQBX9ex2ICFy3Mf7g4Vd37WoRTW8bIRcUBpj5UajSY/HVjyZrXNLwVS
        R4q4o5jznU/pwcL9HFHsLbvDbQDRAVEyzQ==
X-Google-Smtp-Source: AKy350ajo5e3lje86XLdbE0uIgAhV6LqdqFJa30RJC2cHaUbTFMrQDy4b+GHdtyyhU4KGsPCSRpgvQ==
X-Received: by 2002:a25:6585:0:b0:b7e:ef3b:bca5 with SMTP id z127-20020a256585000000b00b7eef3bbca5mr8192343ybb.15.1681119959337;
        Mon, 10 Apr 2023 02:45:59 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 130-20020a250a88000000b00b8bd10ad9b0sm2870547ybk.11.2023.04.10.02.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 02:45:59 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f188so35797685ybb.3;
        Mon, 10 Apr 2023 02:45:58 -0700 (PDT)
X-Received: by 2002:a25:cb52:0:b0:a02:a3a6:78fa with SMTP id
 b79-20020a25cb52000000b00a02a3a678famr4936366ybg.12.1681119958795; Mon, 10
 Apr 2023 02:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680273039.git.geert+renesas@glider.be> <972e66cd36e9173ea6817d41565f708cb84bc2f4.1680273039.git.geert+renesas@glider.be>
 <20230405040211.GK9915@pendragon.ideasonboard.com>
In-Reply-To: <20230405040211.GK9915@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Apr 2023 11:45:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjry9-owh6nrtdXXi9wtvgJRROd+P6=zRq0se8PJ4jMQ@mail.gmail.com>
Message-ID: <CAMuHMdXjry9-owh6nrtdXXi9wtvgJRROd+P6=zRq0se8PJ4jMQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm: shmobile: Make DRM_SHMOBILE visible on Renesas
 SoC platforms
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Apr 5, 2023 at 6:02 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Mar 31, 2023 at 04:48:11PM +0200, Geert Uytterhoeven wrote:
> > The LCD Controller supported by the drm-shmob driver is not only present
> > on SuperH SH-Mobile SoCs, but also on Renesas ARM SH/R-Mobile SoCs.
> > Make its option visible, so the user can enable support for it.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/gpu/drm/shmobile/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
> > index 4ec5dc74a6b0b880..719d4e7a5cd75aad 100644
> > --- a/drivers/gpu/drm/shmobile/Kconfig
> > +++ b/drivers/gpu/drm/shmobile/Kconfig
> > @@ -2,7 +2,7 @@
> >  config DRM_SHMOBILE
> >       tristate "DRM Support for SH Mobile"
> >       depends on DRM && ARM
>
> There shouldn't be anything ARM-dependent, could you drop "&& ARM" while
> at it ?

Oops, that was added back in 2014, when the driver stopped building on SH.
The build issue seems to be fixed, so I'll drop the dependency on ARM.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
