Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510B5ED7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiI1I3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI1I32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:29:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867374CD5;
        Wed, 28 Sep 2022 01:29:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c30so15130828edn.2;
        Wed, 28 Sep 2022 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w0oCFVbsIR+JjV/gDmNe5Qcxa+IyfAvzzy/EcJvtCNY=;
        b=Q/SsPmY7B+fAJUl+Spw8ngVH+HuKsYlaXXQTdegB+igN/r94LsiM/6mQE32R40FIct
         JfqDSrAT2I2alnLfwF4qM3Y+5HawHPeRGtlK0TOmJR+P63nFjws5yvrrnkxGcd24/iDM
         SlrfOpYcNE2kGttZnpI1pyslhFWlaZqMfYY63kSpZc7s3wop9F/g8teD8rYq4iYUDS/l
         LseP+Dh7v/DCOeRdptNvvXChaE+PI5y27se663CNTYVBUa9p2YER5FgJGa5FbNSuFmNJ
         TiuHDYKSUDCoaBw2Jp/E+cI9qzoGPv8ZzOXx92KWwnhdkeBezQ0ObZAW6vYyTwksaR37
         t86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w0oCFVbsIR+JjV/gDmNe5Qcxa+IyfAvzzy/EcJvtCNY=;
        b=JwNs3uIUh7g5FvX4Aj8gDIBaBB7vdZa4CEUbmyRwuBAIQJLSa/nGQgwRao6ywMVd/U
         4I4G0mXl8/PLQTVsNUzdhOrcVUpXscTLHJzMjj1yXvQbFO6LsLJmJcna8hVXEL5/lf6M
         9zjSa5FyCkG86OLTun0Z8zIQ5Z0hroQ2YsWd9PxKnWdUr3IsikN+HqQy2W4WeB+NINT1
         6J4XQ5KtKkUHJzOFKJ7XcWl6fCOkypXDBOnQZ/XmP4uNZHxc1T7yh5WUrW4B59eQaZcN
         lW6yg6hRFotUIPr3yjVPevYA0IwaemXcHa5TmqMjRwkODwbdtSwnX/fkzuV4RPBMwDpG
         32zg==
X-Gm-Message-State: ACrzQf11XVEbjRo2aZjL6HWuIe+XpO9dm+TCfxgYgYw41vbNUJaR+6xu
        6Jmd9mywVjIg5lHN04OFw+phU4QIMmlgqZK3lQw=
X-Google-Smtp-Source: AMsMyM50ywTBWlF6n2lFkeDW3bZoGqCI0vlDBC8k5yxSEE6k8OR+XTIPbCbhj953UkRHKUvxG7OzMO25Qu9Xg1MZjZc=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr32098451edb.0.1664353765894; Wed, 28
 Sep 2022 01:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220927203044.751611-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922BE73295E3562DC3FBA6E86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922BE73295E3562DC3FBA6E86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 28 Sep 2022 09:28:58 +0100
Message-ID: <CA+V-a8s=wqGpfWBv7+=tG1pu6fZCL7EtRoTEmo-wjK5CGZyLnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
 clocks support PM
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

Thank you for the review.

On Wed, Sep 28, 2022 at 8:02 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> > Subject: [RFC PATCH 1/2] clk: renesas: rzg2l: Don't assume all CPG_MOD
> > clocks support PM
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > There are cases where not all CPG_MOD clocks should be assumed to
> > support PM. For example on the CRU block there is a particular
> > sequence that needs to be followed to initialize the CSI-2 D-PHY in
> > which individual clocks need to be turned ON/OFF, due to which Runtime
> > PM support wasn't used by the CRU CSI-2 driver.
> >
> > This patch adds support to allow indicating if PM is supported by the
> > CPG_MOD clocks. A new macro is DEF_NO_PM() is added which sets the
> > no_pm flag in struct rzg2l_mod_clk and when the driver uses Runtime PM
> > support no_pm flag is checked to see if the clk needs to included as
> > part of Runtime PM.
> >
> > CPG_MOD clocks with no_pm flag set need to be individually turned
> > ON/OFF depending on the requirement of the driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/clk/renesas/rzg2l-cpg.c | 35 +++++++++++++++++++++++++++++---
> > -  drivers/clk/renesas/rzg2l-cpg.h | 12 ++++++++---
> >  2 files changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.c
> > b/drivers/clk/renesas/rzg2l-cpg.c index 3ff6ecd61756..d275324909e7
> > 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -114,6 +114,8 @@ struct rzg2l_cpg_priv {
> >       struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;  };
> >
> > +static struct rzg2l_cpg_priv *rzg2l_cpg_priv;
> > +
> >  static void rzg2l_cpg_del_clk_provider(void *data)  {
> >       of_clk_del_provider(data);
> > @@ -1223,18 +1225,42 @@ static int
> > rzg2l_cpg_reset_controller_register(struct rzg2l_cpg_priv *priv)
> >       return devm_reset_controller_register(priv->dev, &priv->rcdev);
> > }
> >
> > +static inline const struct rzg2l_mod_clk *rzg2l_get_mod_clk(const
> > +struct rzg2l_cpg_info *info, int id) {
> > +     unsigned int i;
> > +
> > +     id += info->num_total_core_clks;
> > +     for (i = 0; i < info->num_mod_clks; i++) {
> > +             if (info->mod_clks[i].id == id)
> > +                     return &info->mod_clks[i];
> > +     }
>
> May be as an optimization add ID and clk to a separate list
> and traverse that smaller list for DEF_NO_PM case.
>
> case CPG_MOD:
>         return rzg2l_cpg_is_pm_mod(clkspec->args[1]);
>
Are you suggesting adding no_pm_mod_clks and no_pm_mod_clks or
building an internal structure in struct rzg2l_cpg_priv while calling
rzg2l_cpg_register_mod_clk() for each mod clock?

Cheers,
Prabhakar
