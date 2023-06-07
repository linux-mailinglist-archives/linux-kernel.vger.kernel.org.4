Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5E7260FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjFGNSH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjFGNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:18:04 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF7795;
        Wed,  7 Jun 2023 06:18:03 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-565bdae581eso91258157b3.2;
        Wed, 07 Jun 2023 06:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143882; x=1688735882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Es088mB1G74PH8cSnIPoWoMThT+n2oIcmc2G12tfec=;
        b=RAeb1V/uYUmxpvUlUpCVGBRLpkzxbl/QkmK5cwwYkQgGdAdcdRXzqYyT/F5dXLeAWq
         B1OZ+3ABeXsAm25Fhduo5OBDC3bNv8wbcz8BeUkqsp5QcyjKMOZ/gM/XeyfZfZG1OzYE
         Ya9coTNHQBuPDiGt2ScSLFGF1cs3oOFboGQB/9ctbNWJGXfIt3QVAVyHencjNhw5rRIP
         h8LvRvkvxS51h6+TPvSLhaMqXVeIovPovcva4UTVDzvsAD5eDEmEHbaGkL3pqvXWEOCj
         rlhRG0eCzG3pSn8CZjhoPvBD9YgEgW+0HHSomPad+i2euFUBdQcrWAAl5SJ/fNWovO/p
         XYuw==
X-Gm-Message-State: AC+VfDyFfkAXQx6YciouBXJjMD4rmSc+uEx0rNYirVyTMtHDGWJXkW/h
        vsuRubZrmDsfUfjmsc603DrhhtVBvujD8g==
X-Google-Smtp-Source: ACHHUZ5jPGfVqEHJcFDUfjQVqjgDvQjcXOoV55F9Ua0EgXbIyDezvW4ulHXZN8jzsUWf4itsrl4/4A==
X-Received: by 2002:a0d:d7c9:0:b0:561:d6a2:fdb9 with SMTP id z192-20020a0dd7c9000000b00561d6a2fdb9mr6255238ywd.5.1686143882081;
        Wed, 07 Jun 2023 06:18:02 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id w14-20020a81a20e000000b0055aad7d3f34sm4664814ywg.142.2023.06.07.06.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:18:01 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ba829e17aacso9336393276.0;
        Wed, 07 Jun 2023 06:18:01 -0700 (PDT)
X-Received: by 2002:a0d:e604:0:b0:568:e7e6:4199 with SMTP id
 p4-20020a0de604000000b00568e7e64199mr7449722ywe.6.1686143880825; Wed, 07 Jun
 2023 06:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230530112050.5635-1-aford173@gmail.com>
In-Reply-To: <20230530112050.5635-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 15:17:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV8nWAMzetnSGGQvtvdyaMpMsYf3hg_scUXFFSowvxeLQ@mail.gmail.com>
Message-ID: <CAMuHMdV8nWAMzetnSGGQvtvdyaMpMsYf3hg_scUXFFSowvxeLQ@mail.gmail.com>
Subject: Re: [RFC 1/3] clk: renesas: rcar-gen3: Add support for ZG clock
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        marek.vasut+renesas@gmail.com, cstevens@beaconembedded.com,
        aford@beaconembedded.com, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, May 30, 2023 at 1:21 PM Adam Ford <aford173@gmail.com> wrote:
> A clock used for the 3D graphics appears to be common
> among multiple SoC's, so add a generic gen3 clock
> for clocking the graphics.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rcar-gen3-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen3-cpg.c
> @@ -301,6 +301,39 @@ static struct clk * __init cpg_z_clk_register(const char *name,
>         return clk;
>  }
>
> +static struct clk * __init cpg_zg_clk_register(const char *name,
> +                                              const char *parent_name,
> +                                              void __iomem *reg,
> +                                              unsigned int div,
> +                                              unsigned int offset)
> +{
> +       struct clk_init_data init;

"= {};", as you do not initialize all fields below.

> +       struct cpg_z_clk *zclk;
> +       struct clk *clk;
> +
> +       zclk = kzalloc(sizeof(*zclk), GFP_KERNEL);
> +       if (!zclk)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &cpg_z_clk_ops;
> +       init.flags = 0;
> +       init.parent_names = &parent_name;
> +       init.num_parents = 1;
> +
> +       zclk->reg = reg + CPG_FRQCRB;
> +       zclk->kick_reg = reg + CPG_FRQCRB;
> +       zclk->hw.init = &init;
> +       zclk->mask = GENMASK(offset + 4, offset);
> +       zclk->fixed_div = div; /* PLLVCO x 1/div1 x 3DGE divider x 1/div2 */
> +
> +       clk = clk_register(NULL, &zclk->hw);
> +       if (IS_ERR(clk))
> +               kfree(zclk);
> +
> +       return clk;
> +}

This new function is very similar to the existing cpg_z_clk_register().
The only differences are:
  - init.flags = 0 vs. CLK_SET_RATE_PARENT, which should not matter
    much,
  - register CPG_FRQCRB vs. CPG_FRQCRC.

So I think it would be good to avoid duplication by adding a register
parameter to cpg_z_clk_register(), to pass the Frequency Control Register
offset to use.


> +
>  static const struct clk_div_table cpg_rpcsrc_div_table[] = {
>         { 2, 5 }, { 3, 6 }, { 0, 0 },
>  };
> @@ -502,6 +535,9 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
>         case CLK_TYPE_GEN3_RPCD2:
>                 return cpg_rpcd2_clk_register(core->name, base + CPG_RPCCKCR,
>                                               __clk_get_name(parent));
> +       case CLK_TYPE_GEN3_ZG:
> +               return cpg_zg_clk_register(core->name, __clk_get_name(parent),
> +                                          base, core->div, core->offset);

Please insert this right below the CLK_TYPE_GEN3_Z case.

>         default:
>                 return ERR_PTR(-EINVAL);

The rest LGTM.

(Ideally, we wouldn't need a new clock type, and could just use
 CLK_TYPE_GEN3_Z.  But then we would need to add a new field to struct
 cpg_core_clk to store the FRQCR offset, as the .offset field is already
 in use, which would increase all clock table sizes a lot.  Or we can
 encode both register and bit offset in .offset...
 All of this needs a big overhaul for switching to of_clk_add_hw_provider()
 anyway, so I wouldn't bother for now.)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
