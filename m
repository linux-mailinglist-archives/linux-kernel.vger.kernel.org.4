Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A016C0BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCTIBX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCTIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:01:18 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9E132C6;
        Mon, 20 Mar 2023 01:01:17 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id r16so12081776qtx.9;
        Mon, 20 Mar 2023 01:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679299276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YDU8IzF0EsSpDkzRDjzs/d7Q1NfYw1Ou2xNB8kfdm8=;
        b=ZF3taVLGj6p5NQ0ktZFXkNENzlu54mi1CPuhErVVCfY+wqdgwlS1ulIEMCOdZPW1Qs
         QagB6yKvsLnfJCabixWuNjCzdUMl6js1q5FO5WiFUlTH/viJlvTG0vqoLogxGmIxnMfP
         CzakzXDUZ5qAt9ga0DvzZijTIQdrC75G7E/TdJb9FU6/5sYrOpsVapNlJxh4YpSVBPZj
         OJi4iMlL/k0KWcX0C7NEkBVB3DFPZOoMylx1+Qy1ah43q9QQ/aByVQRivGerVkox4uXd
         p0O3d+bitkUvZNGCV9PHoR3BCpdEmYlOUtvAbuGba2UA/RwjJ3uEBRsZA22/ii5ptkMx
         kJWg==
X-Gm-Message-State: AO0yUKW7UiDBbj2kk9NT+sglee16Cp8YwaUIMQsbAuYUe741T+VOWLGl
        ixOH70QpJZl/AdT3yTf7gSKbYFCRRkPuig==
X-Google-Smtp-Source: AK7set9wKCjL9JyrlRTw4jWPcXjkkvkIn3NAxrnMK4AytsO3ekZIyiJO7P0vFM6REENGt8zOG0b/uQ==
X-Received: by 2002:ac8:5c03:0:b0:3d5:6eaf:fe8f with SMTP id i3-20020ac85c03000000b003d56eaffe8fmr18445959qti.11.1679299276270;
        Mon, 20 Mar 2023 01:01:16 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id a72-20020ae9e84b000000b00745a3b63569sm6839336qkg.107.2023.03.20.01.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 01:01:15 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-53d277c1834so209022017b3.10;
        Mon, 20 Mar 2023 01:01:14 -0700 (PDT)
X-Received: by 2002:a81:e508:0:b0:544:5fc7:f01f with SMTP id
 s8-20020a81e508000000b005445fc7f01fmr9057012ywl.4.1679299274592; Mon, 20 Mar
 2023 01:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144721.1544669-1-robh@kernel.org> <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
 <CAMuHMdX1=+WwWjfiWDYOjSzTjcYBEY+QR=XKuU+o5_SCyU7rag@mail.gmail.com> <CACRpkdaw7TodD0hr3vD8cGB80k0qtEiaC1ne-ivCj6YEefi44w@mail.gmail.com>
In-Reply-To: <CACRpkdaw7TodD0hr3vD8cGB80k0qtEiaC1ne-ivCj6YEefi44w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Mar 2023 09:01:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVgWne0goeJ3A1=v8FZCz3hmHC2j_UEYPn51gD1jz-9uA@mail.gmail.com>
Message-ID: <CAMuHMdVgWne0goeJ3A1=v8FZCz3hmHC2j_UEYPn51gD1jz-9uA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_property_present() for testing DT
 property presence
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Sean Wang <sean.wang@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Mar 19, 2023 at 9:55 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Mar 13, 2023 at 12:00 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Mar 13, 2023 at 10:00 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Fri, Mar 10, 2023 at 3:56 PM Rob Herring <robh@kernel.org> wrote:
> > > > It is preferred to use typed property access functions (i.e.
> > > > of_property_read_<type> functions) rather than low-level
> > > > of_get_property/of_find_property functions for reading properties. As
> > > > part of this, convert of_get_property/of_find_property calls to the
> > > > recently added of_property_present() helper when we just want to test
> > > > for presence of a property and nothing more.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/pinctrl/renesas/pinctrl.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl.c
> > > > @@ -125,8 +125,8 @@ static int sh_pfc_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> > > >          * inside a subnode nor across subnodes.
> > > >          */
> > > >         if (!pmx->func_prop_name) {
> > > > -               if (of_find_property(np, "groups", NULL) ||
> > > > -                   of_find_property(np, "pins", NULL)) {
> > > > +               if (of_property_present(np, "groups")||
> > > > +                   of_property_present(np, "pins")) {
> > > >                         pmx->func_prop_name = "function";
> > > >                         pmx->groups_prop_name = "groups";
> > > >                         pmx->pins_prop_name = "pins";
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > This check is used to auto-detect if the standard property names
> > > should be used, or the "renesas,"-prefixed ones.
> > > As the last users of the latter were removed from DTS in v4.10,
> > > perhaps I should just remove these checks instead?
> >
> > Sent a patch just doing that, so you can drop this chunk.
> > https://lore.kernel.org/linux-renesas-soc/ff9c14781110bbf19b56b45dd1f01e6da90319ad.1678704441.git.geert+renesas@glider.be
>
> So I need a new version of this patch before I can apply it
> I guess, or there will be conflict with Reseas stuff?

It would be a minor conflict, though, and you would have to resolve
that yourself, when merging my renesas-pinctrl PR.  So when you
will send a PR to The Other Linus, there won't be a conflict anymore,
and no angriness ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
