Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570856B66C7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCLNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCLNhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:37:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149324D639;
        Sun, 12 Mar 2023 06:37:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-21-162-nat.elisa-mobile.fi [85.76.21.162])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 025D1814;
        Sun, 12 Mar 2023 14:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678628248;
        bh=FbcA1Ew/FpHmmXM4Ifjz7Cw8tzLhiv2Rw9S2vFvrMms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsDXEn4Z6RdFHv8EtGBmVQbQ15qOVw0DTs9uxoHN9F9dJaDGDFM6jRFpzz18epDtT
         v5Ct0nyNg+pxEjjbQ/FU2IRixCsrTT5xi0HPbA/g4b1/SvEACwyFW8bGBYZJnrMv6t
         n3hL2VyWixK9riz//O1nw5GE8t1qgS02kbI3iw4o=
Date:   Sun, 12 Mar 2023 15:37:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v2 2/2] media: imx: imx8mq-mipi-csi2: remove unneeded
 state variable and function
Message-ID: <20230312133706.GJ2545@pendragon.ideasonboard.com>
References: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
 <20230307150047.1486186-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307150047.1486186-3-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Tue, Mar 07, 2023 at 04:00:47PM +0100, Martin Kepplinger wrote:
> Clean up the driver a bit by inlining the imx8mq_mipi_csi_system_enable()
> function to the callsites and removing the hs_settle variable from the
> driver state.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Could I volunteer you to also drop the struct csi_state state field ?
:-)

> ---
>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 41 ++++++++------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> index 1aa8622a3bae..f10b59b8f1c0 100644
> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> @@ -119,9 +119,8 @@ struct csi_state {
>  
>  	struct v4l2_mbus_config_mipi_csi2 bus;
>  
> -	struct mutex lock; /* Protect state and hs_settle */
> +	struct mutex lock; /* Protect state */
>  	u32 state;
> -	u32 hs_settle;
>  
>  	struct regmap *phy_gpr;
>  	u8 phy_gpr_reg;
> @@ -264,23 +263,6 @@ static int imx8mq_mipi_csi_sw_reset(struct csi_state *state)
>  	return 0;
>  }
>  
> -static void imx8mq_mipi_csi_system_enable(struct csi_state *state, int on)
> -{
> -	if (!on) {
> -		imx8mq_mipi_csi_write(state, CSI2RX_CFG_DISABLE_DATA_LANES, 0xf);
> -		return;
> -	}
> -
> -	regmap_update_bits(state->phy_gpr,
> -			   state->phy_gpr_reg,
> -			   0x3fff,
> -			   GPR_CSI2_1_RX_ENABLE |
> -			   GPR_CSI2_1_VID_INTFC_ENB |
> -			   GPR_CSI2_1_HSEL |
> -			   GPR_CSI2_1_CONT_CLK_MODE |
> -			   GPR_CSI2_1_S_PRG_RXHS_SETTLE(state->hs_settle));
> -}
> -
>  static void imx8mq_mipi_csi_set_params(struct csi_state *state)
>  {
>  	int lanes = state->bus.num_data_lanes;
> @@ -321,7 +303,8 @@ static int imx8mq_mipi_csi_clk_get(struct csi_state *state)
>  }
>  
>  static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
> -					  struct v4l2_subdev_state *sd_state)
> +					  struct v4l2_subdev_state *sd_state,
> +					  u32 *hs_settle)
>  {
>  	s64 link_freq;
>  	u32 lane_rate;
> @@ -377,10 +360,10 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
>  	max_ths_settle = 140 + 10 * 1000000 / (lane_rate / 1000);
>  	ths_settle_ns = (min_ths_settle + max_ths_settle) / 2;
>  
> -	state->hs_settle = ths_settle_ns / esc_clk_period_ns - 1;
> +	*hs_settle = ths_settle_ns / esc_clk_period_ns - 1;
>  
>  	dev_dbg(state->dev, "lane rate %u Ths_settle %u hs_settle %u\n",
> -		lane_rate, ths_settle_ns, state->hs_settle);
> +		lane_rate, ths_settle_ns, *hs_settle);
>  
>  	return 0;
>  }
> @@ -389,24 +372,32 @@ static int imx8mq_mipi_csi_start_stream(struct csi_state *state,
>  					struct v4l2_subdev_state *sd_state)
>  {
>  	int ret;
> +	u32 hs_settle;
>  
>  	ret = imx8mq_mipi_csi_sw_reset(state);
>  	if (ret)
>  		return ret;
>  
>  	imx8mq_mipi_csi_set_params(state);
> -	ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state);
> +	ret = imx8mq_mipi_csi_calc_hs_settle(state, sd_state, &hs_settle);
>  	if (ret)
>  		return ret;
>  
> -	imx8mq_mipi_csi_system_enable(state, true);
> +	regmap_update_bits(state->phy_gpr,
> +			   state->phy_gpr_reg,
> +			   0x3fff,
> +			   GPR_CSI2_1_RX_ENABLE |
> +			   GPR_CSI2_1_VID_INTFC_ENB |
> +			   GPR_CSI2_1_HSEL |
> +			   GPR_CSI2_1_CONT_CLK_MODE |
> +			   GPR_CSI2_1_S_PRG_RXHS_SETTLE(hs_settle));
>  
>  	return 0;
>  }
>  
>  static void imx8mq_mipi_csi_stop_stream(struct csi_state *state)
>  {
> -	imx8mq_mipi_csi_system_enable(state, false);
> +	imx8mq_mipi_csi_write(state, CSI2RX_CFG_DISABLE_DATA_LANES, 0xf);
>  }
>  
>  /* -----------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart
