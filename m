Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AE6B750B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCMLBk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 07:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCMLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:01:34 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD716367E3;
        Mon, 13 Mar 2023 04:01:07 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id nf5so7919574qvb.5;
        Mon, 13 Mar 2023 04:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JRXZxwFQvV/9ugP2yIyDpmVR7lwS7JaHigMB2zQJQQ=;
        b=BwpSA19iPS2qsryUE6w2U/kVIKjCcafLJyKuRNAyuO4xCJ4YODH/T//Lnommy6vWMA
         jkU7SofeAU0aJdy4kJxXZuaqIixV4dwovNIEJaAtpLjuROadB4IkKrJ5JJ6Q5tvd2s77
         hLuKO3EabYK6fyOqh4NNjxGuoRcg3obfPftVUhylDqVgwO7uJ31ID08l1cize7XyQrIm
         jqwXb1ARTeShg+PsgWgmXNiU1FI0+sRuKmN0FmBhtdr7jy0nBIau4rWHpDLELajLN1zQ
         YFanG5RuYbY2dwVmWEcPvWZeyUKY5Dg4M+5zJ7wVrim4/JQc0M3zWv456lKbGS1Ypszg
         k2nQ==
X-Gm-Message-State: AO0yUKWeeBzPERFCljyxNblHwFi72JNa4FJKjPweQ1eCMmRCCKZj0tzu
        2DwsSq6aXB5cnpu5e9PlR7h5aJ++pAy5Jw==
X-Google-Smtp-Source: AK7set+4nSF5jkl4sKWLWvT6P/gLtAg5lXVfupqZ+qDA8WsMqcszA4B2tyLrCIkJDsGqgZ7TDdaSeg==
X-Received: by 2002:ad4:5dea:0:b0:56e:c0df:8492 with SMTP id jn10-20020ad45dea000000b0056ec0df8492mr12473598qvb.31.1678705215979;
        Mon, 13 Mar 2023 04:00:15 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 198-20020a3707cf000000b007456efa7f73sm3179986qkh.85.2023.03.13.04.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:00:14 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5416698e889so112844517b3.2;
        Mon, 13 Mar 2023 04:00:14 -0700 (PDT)
X-Received: by 2002:a0d:ec14:0:b0:544:4008:baa1 with SMTP id
 q20-20020a0dec14000000b005444008baa1mr452333ywn.4.1678705213702; Mon, 13 Mar
 2023 04:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144721.1544669-1-robh@kernel.org> <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Mar 2023 12:00:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1=+WwWjfiWDYOjSzTjcYBEY+QR=XKuU+o5_SCyU7rag@mail.gmail.com>
Message-ID: <CAMuHMdX1=+WwWjfiWDYOjSzTjcYBEY+QR=XKuU+o5_SCyU7rag@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:00 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Mar 10, 2023 at 3:56 PM Rob Herring <robh@kernel.org> wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties. As
> > part of this, convert of_get_property/of_find_property calls to the
> > recently added of_property_present() helper when we just want to test
> > for presence of a property and nothing more.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!
>
> > --- a/drivers/pinctrl/renesas/pinctrl.c
> > +++ b/drivers/pinctrl/renesas/pinctrl.c
> > @@ -125,8 +125,8 @@ static int sh_pfc_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> >          * inside a subnode nor across subnodes.
> >          */
> >         if (!pmx->func_prop_name) {
> > -               if (of_find_property(np, "groups", NULL) ||
> > -                   of_find_property(np, "pins", NULL)) {
> > +               if (of_property_present(np, "groups")||
> > +                   of_property_present(np, "pins")) {
> >                         pmx->func_prop_name = "function";
> >                         pmx->groups_prop_name = "groups";
> >                         pmx->pins_prop_name = "pins";
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This check is used to auto-detect if the standard property names
> should be used, or the "renesas,"-prefixed ones.
> As the last users of the latter were removed from DTS in v4.10,
> perhaps I should just remove these checks instead?

Sent a patch just doing that, so you can drop this chunk.
https://lore.kernel.org/linux-renesas-soc/ff9c14781110bbf19b56b45dd1f01e6da90319ad.1678704441.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
