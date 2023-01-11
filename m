Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8366585C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjAKJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjAKJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:57:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1542000
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53B6FB81B79
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428EBC433D2;
        Wed, 11 Jan 2023 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673430892;
        bh=kbawuu+G4uhdhk6Z3iHZybE1MSwuvuLFahb8EbDh9VM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BQoovrkzqShYA5ElXnNFPZZMv8OCDbzkP7k+/fTO0DWODS9jAXrtliuh3qjaSkwpu
         65apxuUgPGLr/gj7eW/qE0qAsCwasphkV//btWgaOOK8z3Uner+mpVXULd7Md+Pjet
         U7cu8oWMPawGFJAD/sJH9xWMwqJqZczd79EVKm7E9tianfU/cyl6Pf9YSjlG3Br0RE
         Ngqy4ejUdsJKC6JO1LQD3NxK6E7592v9u57Q97gEszAHVR3srbDEcGDQxiT3NMV1+t
         3ToMATiJX9TQSauuDlN0+RginTu5NVmCryA37cBZtG6SQA4BzTAjMNNgqh5C17yW0R
         xXca0N8L9iwJg==
Message-ID: <cf854af6-fbbc-6e5c-f773-c4a868d85278@kernel.org>
Date:   Wed, 11 Jan 2023 11:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 2/2] phy: ti: j721e-wiz: Add support to enable LN23
 Type-C swap
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230106071714.30562-1-sinthu.raja@ti.com>
 <20230106071714.30562-3-sinthu.raja@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230106071714.30562-3-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu,

On 06/01/2023 09:17, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The WIZ acts as a wrapper for SerDes and has Lanes 0 and 2 reserved
> for USB for type-C lane swap if Lane 1 and Lane 3 are linked to the
> USB PHY that is integrated into the SerDes IP. The WIZ control register
> has to be configured to support this lane swap feature.
> 
> The support for swapping lanes 2 and 3 is missing and therefore
> add support to configure the control register to swap between
> lanes 2 and 3 if PHY type is USB.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Changes in V2:
> =============
> Address review comments:
> - Update commit description.
> - Rename enum variable name from wiz_lane_typec_swap_mode to wiz_typec_master_lane.
> - Rename enumerators name specific to list of master lanes used for lane swapping.
> - Add inline comments.
> 
> V1: https://lore.kernel.org/lkml/20221213124854.3779-2-sinthu.raja@ti.com/T/#m5e2d1a15d647f5df9dd28ed2dedc4b0812d6466f
> 
>  drivers/phy/ti/phy-j721e-wiz.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 571f0ca18874..815e8124b94a 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -58,6 +58,14 @@ enum wiz_lane_standard_mode {
>  	LANE_MODE_GEN4,
>  };
>  
> +/*
> + * List of master lanes used for lane swapping
> + */
> +enum wiz_typec_master_lane {
> +	LANE0 = 0,
> +	LANE2 = 2,
> +};
> +
>  enum wiz_refclk_mux_sel {
>  	PLL0_REFCLK,
>  	PLL1_REFCLK,
> @@ -194,6 +202,9 @@ static const struct reg_field p_mac_div_sel1[WIZ_MAX_LANES] = {
>  static const struct reg_field typec_ln10_swap =
>  					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
>  
> +static const struct reg_field typec_ln23_swap =
> +					REG_FIELD(WIZ_SERDES_TYPEC, 31, 31);
> +
>  struct wiz_clk_mux {
>  	struct clk_hw		hw;
>  	struct regmap_field	*field;
> @@ -367,6 +378,7 @@ struct wiz {
>  	struct regmap_field	*mux_sel_field[WIZ_MUX_NUM_CLOCKS];
>  	struct regmap_field	*div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
>  	struct regmap_field	*typec_ln10_swap;
> +	struct regmap_field	*typec_ln23_swap;
>  	struct regmap_field	*sup_legacy_clk_override;
>  
>  	struct device		*dev;
> @@ -676,6 +688,13 @@ static int wiz_regfield_init(struct wiz *wiz)
>  		return PTR_ERR(wiz->typec_ln10_swap);
>  	}
>  
> +	wiz->typec_ln23_swap = devm_regmap_field_alloc(dev, regmap,
> +						       typec_ln23_swap);
> +	if (IS_ERR(wiz->typec_ln23_swap)) {
> +		dev_err(dev, "LN23_SWAP reg field init failed\n");
> +		return PTR_ERR(wiz->typec_ln23_swap);
> +	}
> +
>  	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap, phy_en_refclk);
>  	if (IS_ERR(wiz->phy_en_refclk)) {
>  		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
> @@ -1254,9 +1273,17 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>  			int i;
>  

Don't you have to update the below comment you added in patch 1 to mention about LN23 as well?

+			/* if no typec-dir gpio was specified and PHY type is
+			 * USB3 with master lane number is '0', set LN10 SWAP
+			 * bit to '1'
+			 */


>  			for (i = 0; i < num_lanes; i++) {
> -				if ((wiz->lane_phy_type[i] == PHY_TYPE_USB3)
> -						&& wiz->master_lane_num[i] == 0) {
> -					regmap_field_write(wiz->typec_ln10_swap, 1);
> +				if (wiz->lane_phy_type[i] == PHY_TYPE_USB3) {
> +					switch (wiz->master_lane_num[i]) {
> +					case LANE0:
> +						regmap_field_write(wiz->typec_ln10_swap, 1);
> +						break;
> +					case LANE2:
> +						regmap_field_write(wiz->typec_ln23_swap, 1);
> +						break;
> +					default:
> +						break;
> +					}
>  				}
>  			}
>  		}

Otherwise looks good.

cheers,
-roger

