Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B67610E56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJ1KXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJ1KX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43751CB52C;
        Fri, 28 Oct 2022 03:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA2962762;
        Fri, 28 Oct 2022 10:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3E5C433D7;
        Fri, 28 Oct 2022 10:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666952605;
        bh=pBCdGb929chY5ppQKuDgVYnGog6hqh/6E2N9jwb1/Zc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CK14ehMMVSXCsyikJLRvsO703TSBA8hqBDTbHmB56WimZGqIliGCQ1TWofoZSDoCr
         t6/KsOtbaegq8xYk4ebOZgF9CcDB3s7586rzQHivwFpOGMmlUjgqvoun8vpJr+4jFn
         YhfILNBOUKzylZp6ud4Yzuo1sVZgd1eciJniazjy12vcMOZ2N1VwvW7yXpUvUkFf7O
         F53a48BF4p9aOPto6Ft5NUoKonXeRbRrCO+gqK+xMmQv0dnXcJb/7QtCXaofZntwSP
         4ZmlXl4yibOboMPcPGehGwKvgyVGmXsVSP42/BGXJMyKdY4TxacyBfPiEhsgX97rh3
         BJDnM2eOXBnMw==
Message-ID: <ad852357-98a3-b8b9-e9eb-d65c28947ed5@kernel.org>
Date:   Fri, 28 Oct 2022 13:23:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] phy: ti: gmii-sel: Update methods for fetching and
 using qsgmii main port
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee@kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, dan.carpenter@oracle.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20221026074532.109220-1-s-vadapalli@ti.com>
 <20221026074532.109220-3-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221026074532.109220-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

On 26/10/2022 10:45, Siddharth Vadapalli wrote:
> The number of QSGMII main ports are specific to the device. TI's J7200 for
> which the QSGMII main port property is fetched from the device-tree has
> only one QSGMII main port. However, devices like TI's J721e support up to
> two QSGMII main ports. Thus, the existing methods for fetching and using
> the QSGMII main port are not scalable.
> 
> Update the existing methods for handling the QSGMII main ports and its
> associated requirements to make it scalable for future devices.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index 0bcfd6d96b4d..c8f30d2e1f46 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -50,6 +50,7 @@ struct phy_gmii_sel_soc_data {
>  	const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
>  	bool use_of_data;
>  	u64 extra_modes;
> +	u32 num_qsgmii_main_ports;
>  };
>  
>  struct phy_gmii_sel_priv {
> @@ -213,6 +214,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
>  	.use_of_data = true,
>  	.regfields = phy_gmii_sel_fields_am654,
>  	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
> +	.num_ports = 4,
> +	.num_qsgmii_main_ports = 1,
>  };
>  
>  static const struct of_device_id phy_gmii_sel_id_table[] = {
> @@ -378,11 +381,13 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
>  static int phy_gmii_sel_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	const struct phy_gmii_sel_soc_data *soc_data;
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *of_id;
>  	struct phy_gmii_sel_priv *priv;
>  	u32 main_ports = 1;
>  	int ret;
> +	u32 i;
>  
>  	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
>  	if (!of_id)
> @@ -394,16 +399,26 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  
>  	priv->dev = &pdev->dev;
>  	priv->soc_data = of_id->data;
> +	soc_data = priv->soc_data;
>  	priv->num_ports = priv->soc_data->num_ports;
> -	of_property_read_u32(node, "ti,qsgmii-main-ports", &main_ports);
> +	priv->qsgmii_main_ports = 0;
> +
>  	/*
> -	 * Ensure that main_ports is within bounds. If the property
> -	 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
> -	 * is out of bounds, default to 1.
> +	 * Based on the compatible, try to read the appropriate number of
> +	 * QSGMII main ports from the "ti,qsgmii-main-ports" property from
> +	 * the device-tree node.
>  	 */
> -	if (main_ports < 1 || main_ports > 4)
> -		main_ports = 1;
> -	priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports);
> +	for (i = 0; i < soc_data->num_qsgmii_main_ports; i++) {
> +		of_property_read_u32_index(node, "ti,qsgmii-main-ports", i, &main_ports);
> +		/*
> +		 * Ensure that main_ports is within bounds.
> +		 */
> +		if (main_ports < 1 || main_ports > soc_data->num_ports) {
> +			dev_err(dev, "Invalid qsgmii main port provided\n");

nit: This message is a bit misleading if the property does not exist in DT.

How about just "Invalid ti,qsgmii-main-ports"

> +			return -EINVAL;
> +		}
> +		priv->qsgmii_main_ports |= PHY_GMII_PORT(main_ports);
> +	}
>  
>  	priv->regmap = syscon_node_to_regmap(node->parent);
>  	if (IS_ERR(priv->regmap)) {

Reviewed-by: Roger Quadros <rogerq@kernel.org>

cheers,
-roger
