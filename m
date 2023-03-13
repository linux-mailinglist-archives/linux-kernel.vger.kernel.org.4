Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970106B71FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCMJFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 05:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCMJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:04:40 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1B3C29;
        Mon, 13 Mar 2023 02:01:02 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id l18so12414410qtp.1;
        Mon, 13 Mar 2023 02:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678698061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMjv67oqH0XcHnu1slnz7obBOYeNA0kXm4szuRMQips=;
        b=aw1AdWyNMcEeGLnQunCJe99uq/ZZs0gLThSnXLv+UBhc9Rib6ovcsXKl3FGetg/oI6
         ELwDiOyJtQjDTNja5v2ZagaJPgs9QPrssPZvAR2Vz3O5XHvJki7Ry/CJEzk45yPkT/LE
         Idjww0rBB6xtPzaYnzWxrYjHP5XGwhR4VlTHBM9Rz8rXW1Z/OFh8CBGYDxWate6iW781
         HOwK5AE9Y5kAF9OP9pQ6PY7ESjW7riNLsFouQnySoJlb7CyunaMaHQHtOpq9iBFh7/+C
         dDd3aHEu8Q27kQM1Wts1lqnAgTacpIgXs01//Igy+aGGfzE8UQkVYjBi1PNxpDI41son
         dTJg==
X-Gm-Message-State: AO0yUKW0XN2nKFEHPr37VqxYuhiuf0+D+au45+Lp5+h1X2S9ZQAWjXkJ
        3eA0TA/xPaXgXIybuo+Q6zMoEka+I/bVoQ==
X-Google-Smtp-Source: AK7set8WzH26vCM0R1qdZpsSSh6qK0fRhpddR77RNdbVXnu1G9x9/BW/Idu5OTcljORGnqz/50GFlg==
X-Received: by 2002:a05:622a:1a0e:b0:3b9:cc9b:1d9d with SMTP id f14-20020a05622a1a0e00b003b9cc9b1d9dmr16045605qtb.20.1678698061442;
        Mon, 13 Mar 2023 02:01:01 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id j6-20020ac86646000000b003bfb820f17csm5074246qtp.63.2023.03.13.02.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:01:01 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id t4so10929109ybg.11;
        Mon, 13 Mar 2023 02:01:00 -0700 (PDT)
X-Received: by 2002:a25:8b08:0:b0:b14:91e:4d19 with SMTP id
 i8-20020a258b08000000b00b14091e4d19mr14474451ybl.7.1678698060305; Mon, 13 Mar
 2023 02:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144721.1544669-1-robh@kernel.org>
In-Reply-To: <20230310144721.1544669-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Mar 2023 10:00:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
Message-ID: <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Mar 10, 2023 at 3:56 PM Rob Herring <robh@kernel.org> wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl.c
> +++ b/drivers/pinctrl/renesas/pinctrl.c
> @@ -125,8 +125,8 @@ static int sh_pfc_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>          * inside a subnode nor across subnodes.
>          */
>         if (!pmx->func_prop_name) {
> -               if (of_find_property(np, "groups", NULL) ||
> -                   of_find_property(np, "pins", NULL)) {
> +               if (of_property_present(np, "groups")||
> +                   of_property_present(np, "pins")) {
>                         pmx->func_prop_name = "function";
>                         pmx->groups_prop_name = "groups";
>                         pmx->pins_prop_name = "pins";

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

This check is used to auto-detect if the standard property names
should be used, or the "renesas,"-prefixed ones.
As the last users of the latter were removed from DTS in v4.10,
perhaps I should just remove these checks instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
