Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA56B6711
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCLOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCLOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:04:51 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F583525A;
        Sun, 12 Mar 2023 07:04:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B287EDFD58;
        Sun, 12 Mar 2023 07:04:14 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ka9XBUHarGxD; Sun, 12 Mar 2023 07:04:13 -0700 (PDT)
Message-ID: <25ed971e90324ad596353ba6aade2e14c40c7183.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678629853; bh=t035979amfITjZRqgqTKWrJc10CGLu8KaSMBfmOi8yM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bslNF/i1wt9nof/SaOLLyAPqtVbTHzPNKJzZZWBFkVn2PfyrDf0ojKm2PjVl+cJqS
         0MVRB4hNTifDnJSSY3Jft0FssaEq7AqptaE2kZVh+qCDMas92fv4go7VRZqPFSPWXj
         USVbh3diBv1vgBXtnaVYFijEOmeDA9tWObcfAy0W1PFjbohskJDbuHbqOCwPHMROfV
         wioBFHVELUDqxwGV6oaCOKFJZ3dsvS5BAUpuq1wpL2nnqdynTEJvHaHPVXVwb88law
         epBQGrorlAOREd5Maj0ASmjf9twc1riCXmwJDR/kWKm1GCE5nCQNqDNTgwXZ2z6wFw
         wevl/blziNkZQ==
Subject: Re: [PATCH v2 2/2] media: imx: imx8mq-mipi-csi2: remove unneeded
 state variable and function
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Date:   Sun, 12 Mar 2023 15:04:09 +0100
In-Reply-To: <20230312133706.GJ2545@pendragon.ideasonboard.com>
References: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
         <20230307150047.1486186-3-martin.kepplinger@puri.sm>
         <20230312133706.GJ2545@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 12.03.2023 um 15:37 +0200 schrieb Laurent Pinchart:
> Hi Martin,
> 
> Thank you for the patch.
> 
> On Tue, Mar 07, 2023 at 04:00:47PM +0100, Martin Kepplinger wrote:
> > Clean up the driver a bit by inlining the
> > imx8mq_mipi_csi_system_enable()
> > function to the callsites and removing the hs_settle variable from
> > the
> > driver state.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Could I volunteer you to also drop the struct csi_state state field ?
> :-)

sure :) it can become at least a bit more tricky than this patch. I'll
take the time after this is merged.

thanks for the fast reviewing

> 
> > ---
> >  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 41 ++++++++--------
> > ----
> >  1 file changed, 16 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > index 1aa8622a3bae..f10b59b8f1c0 100644
> > --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> > @@ -119,9 +119,8 @@ struct csi_state {
> >  
> >         struct v4l2_mbus_config_mipi_csi2 bus;
> >  
> > -       struct mutex lock; /* Protect state and hs_settle */
> > +       struct mutex lock; /* Protect state */
> >         u32 state;
> > -       u32 hs_settle;
> >  
> >         struct regmap *phy_gpr;
> >         u8 phy_gpr_reg;
> > @@ -264,23 +263,6 @@ static int imx8mq_mipi_csi_sw_reset(struct
> > csi_state *state)
> >         return 0;
> >  }
> >  
> > -static void imx8mq_mipi_csi_system_enable(struct csi_state *state,
> > int on)
> > -{
> > -       if (!on) {
> > -               imx8mq_mipi_csi_write(state,
> > CSI2RX_CFG_DISABLE_DATA_LANES, 0xf);
> > -               return;
> > -       }
> > -
> > -       regmap_update_bits(state->phy_gpr,
> > -                          state->phy_gpr_reg,
> > -                          0x3fff,
> > -                          GPR_CSI2_1_RX_ENABLE |
> > -                          GPR_CSI2_1_VID_INTFC_ENB |
> > -                          GPR_CSI2_1_HSEL |
> > -                          GPR_CSI2_1_CONT_CLK_MODE |
> > -                          GPR_CSI2_1_S_PRG_RXHS_SETTLE(state-
> > >hs_settle));
> > -}
> > -
> >  static void imx8mq_mipi_csi_set_params(struct csi_state *state)
> >  {
> >         int lanes = state->bus.num_data_lanes;
> > @@ -321,7 +303,8 @@ static int imx8mq_mipi_csi_clk_get(struct
> > csi_state *state)
> >  }
> >  
> >  static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
> > -                                         struct v4l2_subdev_state
> > *sd_state)
> > +                                         struct v4l2_subdev_state
> > *sd_state,
> > +                                         u32 *hs_settle)
> >  {
> >         s64 link_freq;
> >         u32 lane_rate;
> > @@ -377,10 +360,10 @@ static int
> > imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
> >         max_ths_settle = 140 + 10 * 1000000 / (lane_rate / 1000);
> >         ths_settle_ns = (min_ths_settle + max_ths_settle) / 2;
> >  
> > -       state->hs_settle = ths_settle_ns / esc_clk_period_ns - 1;
> > +       *hs_settle = ths_settle_ns / esc_clk_period_ns - 1;
> >  
> >         dev_dbg(state->dev, "lane rate %u Ths_settle %u hs_settle
> > %u\n",
> > -               lane_rate, ths_settle_ns, state->hs_settle);
> > +               lane_rate, ths_settle_ns, *hs_settle);
> >  
> >         return 0;
> >  }
> > @@ -389,24 +372,32 @@ static int
> > imx8mq_mipi_csi_start_stream(struct csi_state *state,
> >                                         struct v4l2_subdev_state
> > *sd_state)
> >  {
> >         int ret;
> > +       u32 hs_settle;
> >  
> >         ret = imx8mq_mipi_csi_sw_reset(state);
> >         if (ret)
> >                 return ret;
> >  
> >         imx8mq_mipi_csi_set_params(state);
> > -       ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state);
> > +       ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state,
> > &hs_settle);
> >         if (ret)
> >                 return ret;
> >  
> > -       imx8mq_mipi_csi_system_enable(state, true);
> > +       regmap_update_bits(state->phy_gpr,
> > +                          state->phy_gpr_reg,
> > +                          0x3fff,
> > +                          GPR_CSI2_1_RX_ENABLE |
> > +                          GPR_CSI2_1_VID_INTFC_ENB |
> > +                          GPR_CSI2_1_HSEL |
> > +                          GPR_CSI2_1_CONT_CLK_MODE |
> > +                         
> > GPR_CSI2_1_S_PRG_RXHS_SETTLE(hs_settle));
> >  
> >         return 0;
> >  }
> >  
> >  static void imx8mq_mipi_csi_stop_stream(struct csi_state *state)
> >  {
> > -       imx8mq_mipi_csi_system_enable(state, false);
> > +       imx8mq_mipi_csi_write(state, CSI2RX_CFG_DISABLE_DATA_LANES,
> > 0xf);
> >  }
> >  
> >  /* ---------------------------------------------------------------
> > --------------
> 


