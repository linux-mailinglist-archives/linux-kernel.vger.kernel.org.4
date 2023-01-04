Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92D665D445
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjADNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbjADNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:31:21 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6E3D9DA;
        Wed,  4 Jan 2023 05:27:06 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id c7so27127172qtw.8;
        Wed, 04 Jan 2023 05:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3apLs5SUEYCS8chIsKhmtTxwRF+eOByUathcApBcwhU=;
        b=tREeZoatX4hC/sEGfSkC1T1RW1lXCIzjWw+rj9cIsb9iu8R8hZTL2c+vcMs+mEgx+r
         2HASgJVSloNieaOSRBx6DCScq/wFT7yT0giPVLl95oOgwNzK2xQRWm22i/VWaJY1Fogl
         Z7AKmlIq2i8zjj6Q/CW8vbB8ztiG9V+w0ANKO0bVbGVcwdJCoSUcWJOg2+DaQWAo0kd6
         1SKd6TMi2W7pL2YzdHFr3HGSHrocdGEqnKSFpFP0MQ7bsqXX+XPf7NKAUfVdQD/LAVYF
         7zKugAyV0elP7apZoW9LsUjzzFYj9T1kaFkV5PIl+aqC1F2lCbSmLDoAVtY5BKFdK0Pe
         ubIA==
X-Gm-Message-State: AFqh2kobJKjg+4uKtGowr/HMaFm4VeFeVzVF8+JVpcSPGwG+bM8ATn+Q
        t50nxYqVvrRtlq73k0kpC/8fl2i2Lu4LKw==
X-Google-Smtp-Source: AMrXdXsRMiUBdFPQxgwSndmnnsvCE17pTM+kW/eH0JJCydi8O/nTMKjYyO0fMfFeldbzuW4PnIow1Q==
X-Received: by 2002:ac8:7457:0:b0:3a8:2122:7c28 with SMTP id h23-20020ac87457000000b003a821227c28mr69960797qtr.47.1672838825357;
        Wed, 04 Jan 2023 05:27:05 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id g14-20020ac87d0e000000b003a7eceb8cbasm20494228qtb.90.2023.01.04.05.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 05:27:05 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-43ea87d0797so476160087b3.5;
        Wed, 04 Jan 2023 05:27:04 -0800 (PST)
X-Received: by 2002:a81:1b0a:0:b0:37e:6806:a5f9 with SMTP id
 b10-20020a811b0a000000b0037e6806a5f9mr5542429ywb.47.1672838824691; Wed, 04
 Jan 2023 05:27:04 -0800 (PST)
MIME-Version: 1.0
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
 <Y7RmnswYX+1g5vci@spud>
In-Reply-To: <Y7RmnswYX+1g5vci@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Jan 2023 14:26:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX--sfenmb7WMgpe5045YfR7UjXAM-T9ZNZO3eTN_R=bg@mail.gmail.com>
Message-ID: <CAMuHMdX--sfenmb7WMgpe5045YfR7UjXAM-T9ZNZO3eTN_R=bg@mail.gmail.com>
Subject: Re: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
To:     Conor Dooley <conor@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Jan 3, 2023 at 6:32 PM Conor Dooley <conor@kernel.org> wrote:
> On Tue, Jan 03, 2023 at 05:45:30PM +0100, Geert Uytterhoeven wrote:
> > In various places, string buffers of a fixed size are allocated, and
> > filled using snprintf() with the same fixed size, which is error-prone.
> >
> > Replace this by calling devm_kasprintf() instead, which always uses the
> > appropriate size.
> >
> > While at it, remove an unneeded intermediate variable, which allows us
> > to drop a cast as a bonus.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

> I half wonder if this should actually have a fixes tag too. Since it
> used what came after the @ in $full_name, it'd be possible to create
> (an incorrect) DTS that would lead to a clash between pll names &
> therefore probe would fail.
> The tag would be:
> Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")

But I don't change any of that in my patch?
/me confused.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
