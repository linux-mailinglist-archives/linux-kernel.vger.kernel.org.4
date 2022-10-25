Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F460C702
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJYI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJYI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:56:09 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479A153E2C;
        Tue, 25 Oct 2022 01:56:08 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id m6so7613946qkm.4;
        Tue, 25 Oct 2022 01:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWkBsZu1Wz+p8BCKpy0M2HDp5F+TqOPG1wuR2OL70a4=;
        b=ku2aHr6INTjqCaH7wPkNAj4YHWSZmS5H/jw1MBAUt3a+YI917WyIcltNoPevLLVdeC
         zqgkr9Qnzq/L0nkatRu+FZRyOxRU7u4Ov6tzTA29tSaaLuG+ZlmRPfalRJscbL3LM5N0
         XI0LKQxjKgHQcAOn8xnOMjg676LzV3h/Gm/kISHCnZJUG/R5n88igsppnzH4PmWL+ZqY
         SBaIofdFd6+SKBi5nPC6LESSXH64JQrRq9egbdzrYYaQJMoial4XQ9Hvs7/2PHvyV0mv
         9e8V/kW6TFgR5uXTtXyw9BeU4t8onXx1K7YAKJMBW0zlF79ySoETNy+20tKy4yrOzbhl
         lTyQ==
X-Gm-Message-State: ACrzQf3p6kNY1ZCiZg+CZYtVsUgD8RjKeft3Uk3eSh7l5Gl4dS+5v3Co
        YLEegyX49k0Iap2K0CQiDqjuowXk6IQBFQ==
X-Google-Smtp-Source: AMsMyM6G+Tz0x+2HfKSSgXLl47hDE0iNoGZTqVBFXQHd6pyCv6TF28JGUHtyXyP6CEZQd2R5e2IqWA==
X-Received: by 2002:a37:9304:0:b0:6f0:504c:88e3 with SMTP id v4-20020a379304000000b006f0504c88e3mr13983958qkd.281.1666688167358;
        Tue, 25 Oct 2022 01:56:07 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x10-20020ac84a0a000000b00398ed306034sm1274366qtq.81.2022.10.25.01.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 01:56:06 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-333a4a5d495so107068557b3.10;
        Tue, 25 Oct 2022 01:56:05 -0700 (PDT)
X-Received: by 2002:a81:1b09:0:b0:35d:cf91:aadc with SMTP id
 b9-20020a811b09000000b0035dcf91aadcmr32762242ywb.47.1666688165655; Tue, 25
 Oct 2022 01:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220929185119.335273-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220929185119.335273-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 10:55:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXR+Nsyd0EkNeBvUOpm+qPNUDMZedfY0wErESi5x2Z9JA@mail.gmail.com>
Message-ID: <CAMuHMdXR+Nsyd0EkNeBvUOpm+qPNUDMZedfY0wErESi5x2Z9JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD clocks
 support PM
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Thu, Sep 29, 2022 at 8:51 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> There are cases where not all CPG_MOD clocks should be assumed to support
> PM. For example on the CRU block there is a particular sequence that needs
> to be followed to initialize the CSI-2 D-PHY in which individual clocks
> need to be turned ON/OFF, due to which Runtime PM support wasn't used by
> the CRU CSI-2 driver.
>
> This patch adds support to allow indicating if PM is supported by the
> CPG_MOD clocks. A new macro is DEF_NO_PM() is added which sets the no_pm
> flag in struct rzg2l_mod_clk and when the driver uses Runtime PM support
> no_pm flag is checked to see if the clk needs to included as part of
> Runtime PM.
>
> CPG_MOD clocks with no_pm flag set need to be individually turned ON/OFF
> depending on the requirement of the driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC->v1
> * Added no_pm_mod_clks and num_no_pm_mod_clks members as part of
>   struct rzg2l_cpg_priv

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -108,12 +108,16 @@ struct rzg2l_cpg_priv {
>         unsigned int num_mod_clks;
>         unsigned int num_resets;
>         unsigned int last_dt_core_clk;
> +       int *no_pm_mod_clks;
> +       unsigned int num_no_pm_mod_clks;
>
>         const struct rzg2l_cpg_info *info;
>
>         struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
>  };
>
> +static struct rzg2l_cpg_priv *rzg2l_cpg_priv;

I think you can do without this, by moving the currently separately
allocated struct generic_pm_domain into struct rzg2l_cpg_priv,
and using container_of() on the currently unused pointer passed to
rzg2l_cpg_attach_dev().

Note to self: get rid of the cpg_mssr_clk_domain static pointer in
the CPG/MSSR driver.

> +
>  static void rzg2l_cpg_del_clk_provider(void *data)
>  {
>         of_clk_del_provider(data);
> @@ -1225,16 +1229,24 @@ static int rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
>
>  static bool rzg2l_cpg_is_pm_clk(const struct of_phandle_args *clkspec)
>  {
> +       struct rzg2l_cpg_priv *priv = rzg2l_cpg_priv;
> +       const struct rzg2l_cpg_info *info = priv->info;

info is used only once, expand user below?

> +       unsigned int id;
> +       unsigned int i;
> +
>         if (clkspec->args_count != 2)
>                 return false;
>
> -       switch (clkspec->args[0]) {
> -       case CPG_MOD:
> -               return true;
> -
> -       default:
> +       if (clkspec->args[0] != CPG_MOD)
>                 return false;
> +
> +       id = clkspec->args[1] + info->num_total_core_clks;
> +       for (i = 0; i < priv->num_no_pm_mod_clks; i++) {
> +               if (priv->no_pm_mod_clks[i] == id)
> +                       return false;
>         }
> +
> +       return true;
>  }
>
>  static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device *dev)

> @@ -1366,8 +1379,26 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
>         for (i = 0; i < info->num_core_clks; i++)
>                 rzg2l_cpg_register_core_clk(&info->core_clks[i], info, priv);
>
> -       for (i = 0; i < info->num_mod_clks; i++)
> +       priv->num_no_pm_mod_clks = 0;
> +       for (i = 0; i < info->num_mod_clks; i++) {
> +               if (info->mod_clks[i].no_pm)
> +                       priv->num_no_pm_mod_clks++;
> +       }
> +
> +       if (priv->num_no_pm_mod_clks && info->num_mod_clks) {
> +               priv->no_pm_mod_clks =
> +                               devm_kmalloc_array(dev, priv->num_no_pm_mod_clks,
> +                                                  sizeof(info->mod_clks[0].id),
> +                                                  GFP_KERNEL);
> +               if (!priv->no_pm_mod_clks)
> +                       return -ENOMEM;
> +       }
> +
> +       for (i = 0, j = 0; i < info->num_mod_clks; i++) {
> +               if (info->mod_clks[i].no_pm)
> +                       priv->no_pm_mod_clks[j++] = info->mod_clks[i].id;
>                 rzg2l_cpg_register_mod_clk(&info->mod_clks[i], info, priv);
> +       }

Alternatively, you could have a separate rzg2l_cpg_info.no_pm_clks[]
array, like .crit_mod_clks[], and do the counting etc. at compile-time.

>
>         error = of_clk_add_provider(np, rzg2l_cpg_clk_src_twocell_get, priv);
>         if (error)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
