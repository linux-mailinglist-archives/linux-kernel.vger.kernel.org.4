Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC565CD90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjADHWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjADHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:22:21 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262BCDA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:22:20 -0800 (PST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200]) by mx-outbound46-4.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 04 Jan 2023 07:22:18 +0000
Received: by mail-lj1-f200.google.com with SMTP id c18-20020a2ebf12000000b00279a72705feso7673328ljr.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPr6Xd4nz1xJ4HkAPF7aPXqQXKgfzwm0p8dfzBvdBL4=;
        b=NygIbKg3K8OU6dHO4fevpu1TOszp/orSOULJFc+uAni8FwLTQIL5d2FurhVFoUfMZ8
         RY/l7sHX/yQTxe9hYjYhvZP15diSWGoNpAv3okkhnR7LGE7T+Q6ivVZ+nuyjquxuzdA2
         GTCyuyU0XIlfNMKXXHHaxj9YdwapBTrNnferc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPr6Xd4nz1xJ4HkAPF7aPXqQXKgfzwm0p8dfzBvdBL4=;
        b=nhFNVd07gn16no7Wo03D66sZwZNXciJiUX6TJgV0ShcsrCnjN/HcU30Fjach4/SjMH
         WxIta+MPAJBMbNpRn8VQRybIdiFm1SkxuSdC56HNvyxTUCzzZGhkCQWvyKa5bM6rSThw
         BxlckTplu9tYxFY8NQvB2adKvtG+dOnJscGL/xC8nLx2sMXeSaF6aShiudm7XkBGuFhB
         bR4a0JufUww0ex/zMS8Rd9FEzux0yypJ6MjyvGcGw/uirzq+ffM81TJ/oq8xomgiWjb4
         hchroR5K/FDFM+Np2CdqLb3bFTjqbQ5RNW+MdN7A71Y1zBFcCa1z4YpLtNyddJ/z4poE
         MLCA==
X-Gm-Message-State: AFqh2kq+jeM+2Vd4h4PKYcynLqE9bfOE1jqxh9YkGkbz9XhgO6dD3XZe
        x1PN++64ig1JgFvmsqjq9QFmHYHFpLlLqHh69Q0bkvrbj0trtVxLFEJZhm0q6SMw6lYlAytaROE
        ShCUDwk1myXwdfkR+cedDuufOQ1Fl5I3AkzjiXeW98jGWhssRKJUwv8uo/C7vofi4p1JomMhu7v
        eL
X-Received: by 2002:a2e:a37b:0:b0:27f:c04f:aa1d with SMTP id i27-20020a2ea37b000000b0027fc04faa1dmr2582405ljn.40.1672816936890;
        Tue, 03 Jan 2023 23:22:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXunuxL2xbl/2H1i2awmpkiFKs7C8YBoMpa9p5n32fbtyy9bvUMymVQM8rfpYxINyfARYqnZMrPyY56jNr/OJzI=
X-Received: by 2002:a2e:a37b:0:b0:27f:c04f:aa1d with SMTP id
 i27-20020a2ea37b000000b0027fc04faa1dmr2582399ljn.40.1672816936649; Tue, 03
 Jan 2023 23:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20221213124854.3779-1-sinthu.raja@ti.com> <20221213124854.3779-3-sinthu.raja@ti.com>
 <47c159b6-a1d3-dd7f-265e-6acbfc06ead0@kernel.org>
In-Reply-To: <47c159b6-a1d3-dd7f-265e-6acbfc06ead0@kernel.org>
From:   Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date:   Wed, 4 Jan 2023 12:52:04 +0530
Message-ID: <CAEd-yTSgABwuohxg=-GxDkJYkW1hSLHmtW=LUuSnzYN3X0AXLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1672816937-311780-5573-385-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.208.200
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245240 [from 
        cloudscan17-152.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,
On Wed, Dec 14, 2022 at 2:47 PM Roger Quadros <rogerq@kernel.org> wrote:
>
>
>
> On 13/12/2022 14:48, Sinthu Raja wrote:
> > Serdes wiz supports both LN23 and LN10 Type-C swap. Add support to
>
> SerDes?
>
> what is wiz?
The WIZ acts as a wrapper for the SerDes and can send control signals
to and report status signals from the SerDes, and muxes SerDes to
peripherals.
>
> It has nothing to do with Type-C. It is just a lane swap.
> There may or may not be a Type-C port.
According to the SerDes design, in the case of 4 lanes SerDes, Lane 0
and Lane 2 are reserved for USB for type-C lane swap if Lane 1 and
Lane 3 are integrated into USB3 PHY. The C-type lane swap is
responsible for swapping lanes 0 and 1 or lanes 2 and 3 based on the
configuration register. This allows a Type C USB connector to deal
with the connector orientation.
>
> > configure LN23 bit to swap between lane2 or lane3 if required.
>
> What do you mean by "swap between lane2 or lane3"?
>
> Do you mean "swap lanes 2 and 3"?
Yes.
>
> Is LN23 bit supported on all variants?
Yes, it is supported in all J7 variants if it is a 4 Lanes SerDes and
USB3 PHY is supported.
>
> >
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> >  drivers/phy/ti/phy-j721e-wiz.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> > index b17eec632d49..0091892af0b0 100644
> > --- a/drivers/phy/ti/phy-j721e-wiz.c
> > +++ b/drivers/phy/ti/phy-j721e-wiz.c
> > @@ -58,6 +58,11 @@ enum wiz_lane_standard_mode {
> >       LANE_MODE_GEN4,
> >  };
> >
> > +enum wiz_lane_typec_swap_mode {
> > +     LANE10_SWAP = 0,
> > +     LANE23_SWAP = 2,
> > +};
>
> What is this? Is it a register setting?
These are the master lane numbers that support the C-type lane swap.
Will change the enum name relatable and also shall add a comment for
more clarification.
>
> > +
> >  enum wiz_refclk_mux_sel {
> >       PLL0_REFCLK,
> >       PLL1_REFCLK,
> > @@ -194,6 +199,9 @@ static const struct reg_field p_mac_div_sel1[WIZ_MAX_LANES] = {
> >  static const struct reg_field typec_ln10_swap =
> >                                       REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
> >
> > +static const struct reg_field typec_ln23_swap =
> > +                                     REG_FIELD(WIZ_SERDES_TYPEC, 31, 31);
> > +
> >  struct wiz_clk_mux {
> >       struct clk_hw           hw;
> >       struct regmap_field     *field;
> > @@ -366,6 +374,7 @@ struct wiz {
> >       struct regmap_field     *mux_sel_field[WIZ_MUX_NUM_CLOCKS];
> >       struct regmap_field     *div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
> >       struct regmap_field     *typec_ln10_swap;
> > +     struct regmap_field     *typec_ln23_swap;
> >       struct regmap_field     *sup_legacy_clk_override;
> >
> >       struct device           *dev;
> > @@ -675,6 +684,13 @@ static int wiz_regfield_init(struct wiz *wiz)
> >               return PTR_ERR(wiz->typec_ln10_swap);
> >       }
> >
> > +     wiz->typec_ln23_swap = devm_regmap_field_alloc(dev, regmap,
> > +                                                    typec_ln23_swap);
> > +     if (IS_ERR(wiz->typec_ln23_swap)) {
> > +             dev_err(dev, "LN23_SWAP reg field init failed\n");
> > +             return PTR_ERR(wiz->typec_ln23_swap);
> > +     }
> > +
> >       wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap, phy_en_refclk);
> >       if (IS_ERR(wiz->phy_en_refclk)) {
> >               dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
> > @@ -1242,15 +1258,24 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
> >                               regmap_field_write(wiz->typec_ln10_swap, 0);
> >               } else {
> >                       /* if no typec-dir gpio was specified, and USB lines
> > -                      * are connected to Lane 0 then set LN10 SWAP bit to 1.
> > +                      * are connected to SWAP lanes '0' or '2' then set LN10 SWAP
> > +                      * or LN23 bit to 1 respectively.
> >                        */
> >                       u32 num_lanes = wiz->num_lanes;
> >                       int i;
> >
> >                       for (i = 0; i < num_lanes; i++) {
> > -                             if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3) \
> > -                                             && wiz->lane_phy_reg[i] == 0) {
> > -                                     regmap_field_write(wiz->typec_ln10_swap, 1);
> > +                             if (wiz->lane_phy_type[i] == PHY_TYPE_USB3) {
> > +                                     switch (wiz->lane_phy_reg[i]) {
> > +                                     case LANE10_SWAP:
> > +                                             regmap_field_write(wiz->typec_ln10_swap, 1);
> > +                                             break;
> > +                                     case LANE23_SWAP:
> > +                                             regmap_field_write(wiz->typec_ln23_swap, 1);
> > +                                             break;
> > +                                     default:
> > +                                             break;
> > +                                     }
>
> Could you please explain what is going on here?
> What is the basis for deciding if LN10 or LN23 bit must be set or not?
This snippet is used to configure the SerDes Type C control register
that allows the external lanes selection to be swapped. Based on the
master lane number and if the PHY type is USB3, we are configuring the
lane swap bits.
>

> What about clearing those bits?
According to the design this does not need to be cleared if it is set.
By default, it is set to 0.
>
> >                               }
> >                       }
> >               }
>
> cheers,
> -roger



-- 
With Regards
Sinthu Raja
