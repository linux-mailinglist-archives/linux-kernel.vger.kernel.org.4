Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451EF5B874F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiINLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiINLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:35:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7177552;
        Wed, 14 Sep 2022 04:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF05DB81A62;
        Wed, 14 Sep 2022 11:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CC9C433D6;
        Wed, 14 Sep 2022 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663155296;
        bh=ia0UlyWpO81OYMhvG9ZBvO4fqlKADUMRg3JooXCzaEE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ftbhB4eyx3LI1ZBtv6n5iIvxduLHIGz14kJAJ4ZyNVjzc8ovdk1iBxIU5DRFMsA82
         WVi7hEjm/6vD9UKR2meEvMT9ookNF5ZS1jjyRew/q7XVvqSuUjLYI/S0yHoqLtvVTP
         EJxLv0zkmpl8D9SxMoJTZSp/Iv69A3B19TrWGMSOZ1od3kDwS+9bj8kkOaQB3zrOiv
         Ab/RwC5+GZeVNwdkrxZwRxK4pFbE498Tl6bcZ35a2YroeyRUgh1hSujuJUIot+RANv
         i08vZAhadrvWb5DkK111W88ZfMB6YmrVUyCFqNVww+uDlnpn/THPcaOaV5xGOOYlno
         tpB8SyXfQbh3g==
Message-ID: <dfb88c31-b6ae-32d4-2b8a-db6027ed19c8@kernel.org>
Date:   Wed, 14 Sep 2022 14:34:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/6] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in
 J721e
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        dan.carpenter@oracle.com, grygorii.strashko@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sjakhade@cadence.com
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-4-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220914093911.187764-4-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

On 14/09/2022 12:39, Siddharth Vadapalli wrote:
> Each of the CPSW9G ports in J721e support additional modes like QSGMII.
> Add a new compatible for J721e to support the additional modes.
> 
> In TI's J721e, each of the CPSW9G ethernet interfaces can act as a
> QSGMII main or QSGMII-SUB port. The QSGMII main interface is responsible
> for performing auto-negotiation between the MAC and the PHY while the rest
> of the interfaces are designated as QSGMII-SUB interfaces, indicating that
> they will not be taking part in the auto-negotiation process.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 47 +++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index f0b2ba7a9c96..fdb1a7db123d 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -223,6 +223,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
>  	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
>  };
>  
> +static const
> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
> +	.use_of_data = true,
> +	.regfields = phy_gmii_sel_fields_am654,
> +	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
> +};
> +
>  static const struct of_device_id phy_gmii_sel_id_table[] = {
>  	{
>  		.compatible	= "ti,am3352-phy-gmii-sel",
> @@ -248,6 +255,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
>  		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
>  		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
>  	},
> +	{
> +		.compatible	= "ti,j721e-cpsw9g-phy-gmii-sel",
> +		.data		= &phy_gmii_sel_cpsw9g_soc_j721e,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
> @@ -389,7 +400,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *of_id;
>  	struct phy_gmii_sel_priv *priv;
> -	u32 main_ports = 1;
> +	u32 main_ports[2] = {1, 1};
>  	int ret;
>  
>  	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
> @@ -403,15 +414,31 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  	priv->dev = &pdev->dev;
>  	priv->soc_data = of_id->data;
>  	priv->num_ports = priv->soc_data->num_ports;
> -	of_property_read_u32(node, "ti,qsgmii-main-ports", &main_ports);
> -	/*
> -	 * Ensure that main_ports is within bounds. If the property
> -	 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
> -	 * is out of bounds, default to 1.
> -	 */
> -	if (main_ports < 1 || main_ports > 4)
> -		main_ports = 1;
> -	priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports);
> +	/* Differentiate between J7200 CPSW5G and J721e CPSW9G */
> +	if (of_device_is_compatible(node, "ti,j7200-cpsw5g-phy-gmii-sel") > 0) {

Why not just "if (of_device_is_compatible())" ?

> +		of_property_read_u32(node, "ti,qsgmii-main-ports", &main_ports[0]);
> +		/*
> +		 * Ensure that main_ports is within bounds. If the property
> +		 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
> +		 * is out of bounds, default to 1.
> +		 */
> +		if (main_ports[0] < 1 || main_ports[0] > 4)
> +			main_ports[0] = 1;

how about printing this issue with dev_err()?

> +		priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports[0]);
> +	} else if (of_device_is_compatible(node, "ti,j721e-cpsw9g-phy-gmii-sel") > 0) {
> +		of_property_read_u32_array(node, "ti,qsgmii-main-ports", &main_ports[0], 2);
> +		/*
> +		 * Ensure that main_ports is within bounds. If the property
> +		 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
> +		 * is out of bounds, default to 1.
> +		 */
> +		if (main_ports[0] < 1 || main_ports[0] > 8)
> +			main_ports[0] = 1;
> +		if (main_ports[1] < 1 || main_ports[1] > 8)
> +			main_ports[1] = 1;
> +		priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports[0]);
> +		priv->qsgmii_main_ports |= PHY_GMII_PORT(main_ports[1]);
> +	}

The whole if/else logic can be got rid of if you store num_qsgmii_main_ports in priv data structure
after obtaining it from of_data.

Then all the above reduces to
	for (i = 0; i < priv->num_qsgmii_main_ports; i++) {
		if (main_ports[i] ...)
	}

It will also make it very easy to scale later on for future platforms.

>  
>  	priv->regmap = syscon_node_to_regmap(node->parent);
>  	if (IS_ERR(priv->regmap)) {

cheers,
-roger
