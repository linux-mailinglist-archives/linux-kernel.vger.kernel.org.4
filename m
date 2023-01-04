Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9565D4A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbjADNoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbjADNo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:44:27 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F951A233;
        Wed,  4 Jan 2023 05:44:25 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id h21so27145454qta.12;
        Wed, 04 Jan 2023 05:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDWBQtfUue4D//RkJsCkT1dtQlk9Aei9WCaWskGbj98=;
        b=B5Ux4fyJh0tM31q74XxMcEH77oNduGvAHOx+a+udKb/80L5eQyPiHvEbkMKSN18LAx
         pCCoI11bEJe1oaAVsYmkA13B3A4qSBWrhwKeHvdXRbndEj+/sW3LVvQp98qjLubgIffC
         H01BQjVQXLnVbf0PqhfDL2Q8h0RPMxETV+p/NolLTAlxXpLwsS7xPjq3UO9rjRguVz5s
         H72ZqZJ7TKPQLHz8Jops7HliqpiuVR9aK+W9tgB9QFzyBAFXqttoPPQjwpxaTXIcAEhH
         58ulCGqF71bz75T+DmfOA4uifzgPA3tGzWG0RsazOd1yaxVq7Y2m1MD5+V46NtxXipio
         NZ6Q==
X-Gm-Message-State: AFqh2kpL6YErio7bvGh9//vMKtX4dj7OImCVzJE0OKqgyZ5eCnTKzCV+
        FjdeD3ZqqPfOvW8BZerCunec5luIUoqc6g==
X-Google-Smtp-Source: AMrXdXvTHcfT75ncXVh2O8PiWGRT3HPtP8I7mZXbmFHvrxn0xFcaktoLvBx6DQoCCTVl9QjgZ5cRJg==
X-Received: by 2002:ac8:4705:0:b0:3ab:5a62:453b with SMTP id f5-20020ac84705000000b003ab5a62453bmr61029070qtp.53.1672839864155;
        Wed, 04 Jan 2023 05:44:24 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t1-20020ac865c1000000b003a7e4129f83sm19848574qto.85.2023.01.04.05.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 05:44:23 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id t15so36511485ybq.4;
        Wed, 04 Jan 2023 05:44:23 -0800 (PST)
X-Received: by 2002:a25:d243:0:b0:702:90b4:2e24 with SMTP id
 j64-20020a25d243000000b0070290b42e24mr3295573ybg.365.1672839863439; Wed, 04
 Jan 2023 05:44:23 -0800 (PST)
MIME-Version: 1.0
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
 <Y7RmnswYX+1g5vci@spud> <CAMuHMdX--sfenmb7WMgpe5045YfR7UjXAM-T9ZNZO3eTN_R=bg@mail.gmail.com>
 <Y7WBtMmLzYvk60tD@spud>
In-Reply-To: <Y7WBtMmLzYvk60tD@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Jan 2023 14:44:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV22j=24mCsOUFfd0K001eUvVYH-PRkhhquApnm9bvokg@mail.gmail.com>
Message-ID: <CAMuHMdV22j=24mCsOUFfd0K001eUvVYH-PRkhhquApnm9bvokg@mail.gmail.com>
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

On Wed, Jan 4, 2023 at 2:40 PM Conor Dooley <conor@kernel.org> wrote:
> On Wed, Jan 04, 2023 at 02:26:53PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Jan 3, 2023 at 6:32 PM Conor Dooley <conor@kernel.org> wrote:
> > > I half wonder if this should actually have a fixes tag too. Since it
> > > used what came after the @ in $full_name, it'd be possible to create
> > > (an incorrect) DTS that would lead to a clash between pll names &
> > > therefore probe would fail.
> > > The tag would be:
> > > Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
> >
> > But I don't change any of that in my patch?
> > /me confused.
>
> The numbers in there were chosen to fit exactly what is in mpfs.dtsi
> (IOW the correct node address), so doing
> @@ -201,14 +200,13 @@ static int mpfs_ccc_register_plls(struct device *dev, struct mpfs_ccc_pll_hw_clo
>
>         for (unsigned int i = 0; i < num_clks; i++) {
>                 struct mpfs_ccc_pll_hw_clock *pll_hw = &pll_hws[i];
> -               char *name = devm_kzalloc(dev, 18, GFP_KERNEL);
>
> -               if (!name)
> +               pll_hw->name = devm_kasprintf(dev, GFP_KERNEL, "ccc%s_pll%u",
> +                                             strchrnul(dev->of_node->full_name, '@'), i);
> +               if (!pll_hw->name)
>                         return -ENOMEM;
>
>                 pll_hw->base = data->pll_base[i];
> -               snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '@'), i);
> -               pll_hw->name = (const char *)name;
>                 pll_hw->hw.init = CLK_HW_INIT_PARENTS_DATA_FIXED_SIZE(pll_hw->name,
>                                                                       pll_hw->parents,
>                                                                       &mpfs_ccc_pll_ops, 0);
>
> means that we no longer have to worry that someone would provide a
> device tree with a node address that would make "ccc<node_address>_pll<N>"
> exceed 18 characters. If that happened, the <N> would be cut off & both
> pll 0 & 1 would be named identically. If that happens, pll1 would fail
> to register.

Oh right.  Yeah, before we would get collisions, now we would get
a different broken system.
DTS garbage in, garbage behavior out ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
