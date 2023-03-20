Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272106C1FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjCTS0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjCTSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF01816B;
        Mon, 20 Mar 2023 11:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B56161787;
        Mon, 20 Mar 2023 18:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E4C433A4;
        Mon, 20 Mar 2023 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679336284;
        bh=vWg765y10j4OS331b9rPl2+YrzmXue9TgKc5uUPg6SE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d0EShuTb90IYTui1Yvb5dTQm0ZdBzbLHwIdXjNMjBe1t4/PYzPQmrgKqZ9bAcsDOT
         GKvGwIH+xdTtkmTMMyOdiGo67BhnrM2V4uBqV7oONOcdyRoGVLSzOWeKb2Y6Av8sgm
         2Pve+TPBIQMb5xiNwMGaxCLrKdA9f+b/WGE+aWoeTJY8rDFmBkgqiyj8aY0/xrNc+W
         7uTb9rrP+PCxabfTATj2ZosK1TWPRLrUv6rkGo+OwIfhgdb177MgnR8ndTccPIfYD1
         pbEg99edRbwyz7LbDlOYQojGgNYi2hc0LoXGMB755eho1B412HFdkGcXJj9s1brLCw
         h5MqK9ObmFgXg==
Received: by mail-ua1-f50.google.com with SMTP id 89so8589968uao.0;
        Mon, 20 Mar 2023 11:18:04 -0700 (PDT)
X-Gm-Message-State: AO0yUKUIgQargX+s2l5qMqI2Ova8ZnyuhOsNGwV2rJYhLjp8Cyfg5cXj
        I35nqC5e8t8tyf6gW8SuV2zACfT9wqcTutCitg==
X-Google-Smtp-Source: AK7set9vhgJMbGJRf/P0PPWHB2mniWwp+5MfPmkCG1+Fia2Jvmr6Jhb32FMBmmkaSyyxxpPtHEVnEx5LGAkbE4I2Yng=
X-Received: by 2002:a1f:2982:0:b0:401:8898:ea44 with SMTP id
 p124-20020a1f2982000000b004018898ea44mr142394vkp.3.1679336283507; Mon, 20 Mar
 2023 11:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144721.1544669-1-robh@kernel.org> <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
 <CAMuHMdX1=+WwWjfiWDYOjSzTjcYBEY+QR=XKuU+o5_SCyU7rag@mail.gmail.com> <CACRpkdaw7TodD0hr3vD8cGB80k0qtEiaC1ne-ivCj6YEefi44w@mail.gmail.com>
In-Reply-To: <CACRpkdaw7TodD0hr3vD8cGB80k0qtEiaC1ne-ivCj6YEefi44w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Mar 2023 13:17:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pzQvsvk8KiyVZPrebMvV6-PfxFXFXcPOf0C21+-yo9A@mail.gmail.com>
Message-ID: <CAL_Jsq+pzQvsvk8KiyVZPrebMvV6-PfxFXFXcPOf0C21+-yo9A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_property_present() for testing DT
 property presence
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sean Wang <sean.wang@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 3:55=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Mon, Mar 13, 2023 at 12:00=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Mar 13, 2023 at 10:00=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Fri, Mar 10, 2023 at 3:56=E2=80=AFPM Rob Herring <robh@kernel.org>=
 wrote:
> > > > It is preferred to use typed property access functions (i.e.
> > > > of_property_read_<type> functions) rather than low-level
> > > > of_get_property/of_find_property functions for reading properties. =
As
> > > > part of this, convert of_get_property/of_find_property calls to the
> > > > recently added of_property_present() helper when we just want to te=
st
> > > > for presence of a property and nothing more.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/pinctrl/renesas/pinctrl.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl.c
> > > > @@ -125,8 +125,8 @@ static int sh_pfc_dt_subnode_to_map(struct pinc=
trl_dev *pctldev,
> > > >          * inside a subnode nor across subnodes.
> > > >          */
> > > >         if (!pmx->func_prop_name) {
> > > > -               if (of_find_property(np, "groups", NULL) ||
> > > > -                   of_find_property(np, "pins", NULL)) {
> > > > +               if (of_property_present(np, "groups")||
> > > > +                   of_property_present(np, "pins")) {
> > > >                         pmx->func_prop_name =3D "function";
> > > >                         pmx->groups_prop_name =3D "groups";
> > > >                         pmx->pins_prop_name =3D "pins";
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > This check is used to auto-detect if the standard property names
> > > should be used, or the "renesas,"-prefixed ones.
> > > As the last users of the latter were removed from DTS in v4.10,
> > > perhaps I should just remove these checks instead?
> >
> > Sent a patch just doing that, so you can drop this chunk.
> > https://lore.kernel.org/linux-renesas-soc/ff9c14781110bbf19b56b45dd1f01=
e6da90319ad.1678704441.git.geert+renesas@glider.be
>
> So I need a new version of this patch before I can apply it
> I guess, or there will be conflict with Reseas stuff?

Can you just drop drivers/pinctrl/renesas/pinctrl.c from this patch?

Rob
