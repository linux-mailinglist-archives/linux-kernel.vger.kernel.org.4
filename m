Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1C7053FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEPQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEPQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBA9009;
        Tue, 16 May 2023 09:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CED063C67;
        Tue, 16 May 2023 16:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D3C433EF;
        Tue, 16 May 2023 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684254910;
        bh=xiAeS/BTnfeGpVs3pyu1705ZSwTqAkahLxezIeK6zis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsuxJHITpfMVLrlBAGajT14BlALyhbj1ocEXmV7V+0Cu1B5BhXO/+4jpKzVBS4lXJ
         5DasD3Ct/NvzcFmyGd7ryLbNt35wzFMF6bsMjMaMZBeRTHbqI1yUeQpexLv3dFgHT8
         iL0TG2pTxSnaCWQmSrdt9Y4DpCBqQeB4sEcetCzNyD1YQ9GO+hRTZj32a4fmGS2XYL
         52ULYgJLjeLCx1K6xsPjuNQNT22Y5mVlpsZXzarG+0xw4mnNf631D0Z1ly3+xTpbgR
         edrh9EeqZHeplPYxn7dOiRRG8AIdM4F4qnweWM3404bMADu2f3IV/5DEQXuwY9xEon
         aQDNsEnW59rGQ==
Date:   Tue, 16 May 2023 22:05:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v4 4/6] phy: cadence: salvo: add .set_mode API
Message-ID: <ZGOwukxGLdRHNL0l@matsya>
References: <20230516154329.3155031-1-Frank.Li@nxp.com>
 <20230516154329.3155031-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516154329.3155031-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-23, 11:43, Frank Li wrote:
> From: Peter Chen <peter.chen@nxp.com>
> 
> For NXP platform design, the PHY can't know VBUS well, it causes the FSM
> in controller seeing the disconnection at L1 use case. With .set_mode API
> introduced, the controller driver could force PHY seeing B Session VALID
> when it is at the device mode (VBUS is there), and keep FSM working well.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/phy/cadence/phy-cadence-salvo.c | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
> index b9866dc146ce..41616f786321 100644
> --- a/drivers/phy/cadence/phy-cadence-salvo.c
> +++ b/drivers/phy/cadence/phy-cadence-salvo.c
> @@ -92,6 +92,7 @@
>  /* USB2 PHY register definition */
>  #define UTMI_REG15				0xaf
>  #define UTMI_AFE_RX_REG5			0x12
> +#define UTMI_AFE_BC_REG4			0x29
>  
>  /* TB_ADDR_TX_RCVDETSC_CTRL */
>  #define RXDET_IN_P3_32KHZ			BIT(0)
> @@ -105,6 +106,9 @@
>  /* 0us, txvalid is ready just after HS/FS transmitters have powered up */
>  #define TXVALID_GATE_THRESHOLD_HS_0US		(BIT(4) | BIT(5))
>  
> +#define SET_B_SESSION_VALID			(BIT(6) | BIT(5))
> +#define CLR_B_SESSION_VALID			(BIT(6))
> +
>  struct cdns_reg_pairs {
>  	u16 val;
>  	u32 off;
> @@ -124,6 +128,13 @@ struct cdns_salvo_phy {
>  };
>  
>  static const struct of_device_id cdns_salvo_phy_of_match[];
> +static const struct cdns_salvo_data cdns_nxp_salvo_data;
> +
> +static bool cdns_is_nxp_phy(struct cdns_salvo_phy *salvo_phy)
> +{
> +	return salvo_phy->data == &cdns_nxp_salvo_data;
> +}
> +
>  static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 offset, u32 reg)
>  {
>  	return (u16)readl(salvo_phy->base + offset +
> @@ -273,11 +284,29 @@ static int cdns_salvo_phy_power_off(struct phy *phy)
>  	return 0;
>  }
>  
> +static int cdns_salvo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct cdns_salvo_phy *salvo_phy = phy_get_drvdata(phy);
> +
> +	if (!cdns_is_nxp_phy(salvo_phy))
> +		return 0;
> +
> +	if (mode == PHY_MODE_INVALID)
> +		cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_BC_REG4,
> +			 CLR_B_SESSION_VALID);
> +	else if (mode == PHY_MODE_USB_DEVICE)
> +		cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_BC_REG4,
> +			 SET_B_SESSION_VALID);

no else?

> +
> +	return 0;

return success even when mode is not handled?

> +}
> +
>  static const struct phy_ops cdns_salvo_phy_ops = {
>  	.init		= cdns_salvo_phy_init,
>  	.power_on	= cdns_salvo_phy_power_on,
>  	.power_off	= cdns_salvo_phy_power_off,
>  	.owner		= THIS_MODULE,
> +	.set_mode	= cdns_salvo_set_mode,
>  };
>  
>  static int cdns_salvo_phy_probe(struct platform_device *pdev)
> -- 
> 2.34.1

-- 
~Vinod
