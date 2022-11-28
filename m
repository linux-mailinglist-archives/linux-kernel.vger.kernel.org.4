Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396EF63A209
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiK1Hho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1Hhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:37:42 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139125584;
        Sun, 27 Nov 2022 23:37:41 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id u10so1237724qvp.4;
        Sun, 27 Nov 2022 23:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf6PpFgRdbUWXFIJ6gzSU4wMby+2q9WODUFq2erIU/Y=;
        b=4YlAaINwMftkTS1LfYAoFRGLvCkf+QblDorkY/p3HwZewuoEQGbh6XlbB+cLlSIZOC
         WoP0Oq4eJI+g3GDZJxYKlra1uQbd5oj1VWReroqbFnkQ+A2/mwu7OvexZfBWhTC19Kp+
         L0ArrW54gbJ2zOH/3vGGJYzHDJLEn9+Mq4phZwJ+v1LHrKT5N0iB1ztjv+pZVayJjnkq
         KLEWrltR1o32b6Y/l6kLpVL842/nxxinD9/cBQGWPLgZKlElnABh6ALGVJQxRs7GSSjK
         DYMeFXyWervgfFnNexJuUZSVoxqFsxGfuQh4ncq2I+UqIkiacS+EzIvB/HmAE3+M+zv8
         TUng==
X-Gm-Message-State: ANoB5pl/qQQ1WbynZanvAhFygC6sGl8AIvtwldh2Pj8IqYfkHuc4ilYV
        yOgFZtL8M0qx3/0po82N7/Wl5/xYbhaOXw==
X-Google-Smtp-Source: AA0mqf5DO96y1c7ru3SNBuRiMKqbVVkVrnXzbHUZS6GXc0YbWY68NuwNK6ywaMbUtiEY3OZXjy/zAA==
X-Received: by 2002:a0c:cb0c:0:b0:4c6:afdd:f1a2 with SMTP id o12-20020a0ccb0c000000b004c6afddf1a2mr27338201qvk.21.1669621059923;
        Sun, 27 Nov 2022 23:37:39 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id bj15-20020a05620a190f00b006cbe3be300esm7924674qkb.12.2022.11.27.23.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 23:37:38 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 205so12236309ybf.6;
        Sun, 27 Nov 2022 23:37:38 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr28827047ybp.202.1669621058200; Sun, 27
 Nov 2022 23:37:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669213027.git.geert+renesas@glider.be> <b500e42c-f782-79c6-70ce-650e4ea32c54@linaro.org>
 <a75b604c-a671-d2c5-7160-74dcb8a4fa2e@linaro.org>
In-Reply-To: <a75b604c-a671-d2c5-7160-74dcb8a4fa2e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Nov 2022 08:37:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVgmxVxKbTxXO90XaaL5-qf6WnEwbTwU+ZmSEcuzOFEgA@mail.gmail.com>
Message-ID: <CAMuHMdVgmxVxKbTxXO90XaaL5-qf6WnEwbTwU+ZmSEcuzOFEgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] memory: renesas-rpc-if: Rebind fixes and misc cleanups
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Nov 27, 2022 at 10:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 27/11/2022 22:31, Krzysztof Kozlowski wrote:
> > On 23/11/2022 15:41, Geert Uytterhoeven wrote:
> >> The Renesas RPC-IF provides either HyperFlash or SPI host access.
> >> To handle this, three drivers are used:
> >>   1. The RPC-IF core diver,
> >>   2. An HyperFlash child driver,
> >>   3. An SPI child driver.
> >
> > Thank you for the patch.
> > It is too late in the cycle for me to pick it up. I will take it after
> > the merge window.
>
> Optionally, if you want to push it via Renesas SoC tree and there are no
> conflicts with existing two patches, then these look good:

It's too late for the Renesas tree, too.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Otherwise, I'll pick them up after the merge window.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
