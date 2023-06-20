Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D23737321
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFTRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFTRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:45:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ACD1713
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:45:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id BfPwqBhhGRr8lBfPxqaN3y; Tue, 20 Jun 2023 19:45:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687283129;
        bh=2/+waEnWzeXtMJOt/78trIu5ZlSU+NbBWG4rUb/r93w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PEXJmsHVM3HsE5eoiGCxiZusIAoa9bGMvrAaQlxRo11qisIgoLn3uYvyOowc3PL7E
         UuSKuaL8Kfa5Gp03Dq6qLKeLqcBwnq27wyv+a/9Iq7rHtT5bMeVKS5+cOTJHzs4XQv
         oGfQ7COcU9u2e16RCPixnJedOPVxnBEO1i+Aw4BxIrYP049kT8hFYwjQnAZeR4ABBK
         TOENup196BhnkA+0M54AYCg08IFgkyi77fjIq5xSALfJioevaHxL19gRVGvWSldjdh
         AVSamY5b7h4Il3CS4BE6kqtbXmu/Hb4nkW0NtbLjs1FhsyUQk+CaIane+4+2NG92AC
         V7bhMzTNyoc+g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Jun 2023 19:45:29 +0200
X-ME-IP: 86.243.2.178
Message-ID: <6f7a5ee4-7ebf-2973-de3f-b72af631f52a@wanadoo.fr>
Date:   Tue, 20 Jun 2023 19:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next] net: phy: at803x: Use
 devm_regulator_get_enable_optional()
Content-Language: fr, en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
References: <f5fdf1a50bb164b4f59409d3a70a2689515d59c9.1687011839.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f5fdf1a50bb164b4f59409d3a70a2689515d59c9.1687011839.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/06/2023 à 16:24, Christophe JAILLET a écrit :
> Use devm_regulator_get_enable_optional() instead of hand writing it. It
> saves some line of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> 
> If my reading is correct, regulator_disable() is still called in the same
> order, should an error occur or the driver be removed.
> ---
>   drivers/net/phy/at803x.c | 44 +++++++---------------------------------
>   1 file changed, 7 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 656136628ffd..c1f307d90518 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -304,7 +304,6 @@ struct at803x_priv {
>   	bool is_1000basex;
>   	struct regulator_dev *vddio_rdev;
>   	struct regulator_dev *vddh_rdev;
> -	struct regulator *vddio;
>   	u64 stats[ARRAY_SIZE(at803x_hw_stats)];
>   };
>   
> @@ -824,11 +823,11 @@ static int at803x_parse_dt(struct phy_device *phydev)
>   		if (ret < 0)
>   			return ret;
>   
> -		priv->vddio = devm_regulator_get_optional(&phydev->mdio.dev,
> -							  "vddio");
> -		if (IS_ERR(priv->vddio)) {

Hi,

my patch is not broken by itself, but the existing code looks spurious.

If the optional regulator is not found, then -ENODEV is returned, 
at803x_parse_dt() will return this error and the probe will fail.

It looks that the test should be more subtle.

I can send a follow up patch, unless there is a better way to fix the 
pre-existing issue.

See [1] for a more detailed explanation.

CJ

[1]: https://lore.kernel.org/all/ZJFqCQ8bbBoX3l1g@hovoldconsulting.com/

> +		ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
> +							 "vddio");
> +		if (ret) {
>   			phydev_err(phydev, "failed to get VDDIO regulator\n");
> -			return PTR_ERR(priv->vddio);
> +			return ret;
>   		}
>   
>   		/* Only AR8031/8033 support 1000Base-X for SFP modules */
> @@ -856,12 +855,6 @@ static int at803x_probe(struct phy_device *phydev)
>   	if (ret)
>   		return ret;
>   
> -	if (priv->vddio) {
> -		ret = regulator_enable(priv->vddio);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>   	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
>   		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
>   		int mode_cfg;
> @@ -869,10 +862,8 @@ static int at803x_probe(struct phy_device *phydev)
>   			.wolopts = 0,
>   		};
>   
> -		if (ccr < 0) {
> -			ret = ccr;
> -			goto err;
> -		}
> +		if (ccr < 0)
> +			return ccr;
>   		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
>   
>   		switch (mode_cfg) {
> @@ -890,25 +881,11 @@ static int at803x_probe(struct phy_device *phydev)
>   		ret = at803x_set_wol(phydev, &wol);
>   		if (ret < 0) {
>   			phydev_err(phydev, "failed to disable WOL on probe: %d\n", ret);
> -			goto err;
> +			return ret;
>   		}
>   	}
>   
>   	return 0;
> -
> -err:
> -	if (priv->vddio)
> -		regulator_disable(priv->vddio);
> -
> -	return ret;
> -}
> -
> -static void at803x_remove(struct phy_device *phydev)
> -{
> -	struct at803x_priv *priv = phydev->priv;
> -
> -	if (priv->vddio)
> -		regulator_disable(priv->vddio);
>   }
>   
>   static int at803x_get_features(struct phy_device *phydev)
> @@ -2021,7 +1998,6 @@ static struct phy_driver at803x_driver[] = {
>   	.name			= "Qualcomm Atheros AR8035",
>   	.flags			= PHY_POLL_CABLE_TEST,
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.config_aneg		= at803x_config_aneg,
>   	.config_init		= at803x_config_init,
>   	.soft_reset		= genphy_soft_reset,
> @@ -2043,7 +2019,6 @@ static struct phy_driver at803x_driver[] = {
>   	.name			= "Qualcomm Atheros AR8030",
>   	.phy_id_mask		= AT8030_PHY_ID_MASK,
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.config_init		= at803x_config_init,
>   	.link_change_notify	= at803x_link_change_notify,
>   	.set_wol		= at803x_set_wol,
> @@ -2059,7 +2034,6 @@ static struct phy_driver at803x_driver[] = {
>   	.name			= "Qualcomm Atheros AR8031/AR8033",
>   	.flags			= PHY_POLL_CABLE_TEST,
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.config_init		= at803x_config_init,
>   	.config_aneg		= at803x_config_aneg,
>   	.soft_reset		= genphy_soft_reset,
> @@ -2082,7 +2056,6 @@ static struct phy_driver at803x_driver[] = {
>   	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
>   	.name			= "Qualcomm Atheros AR8032",
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.flags			= PHY_POLL_CABLE_TEST,
>   	.config_init		= at803x_config_init,
>   	.link_change_notify	= at803x_link_change_notify,
> @@ -2100,7 +2073,6 @@ static struct phy_driver at803x_driver[] = {
>   	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
>   	.name			= "Qualcomm Atheros AR9331 built-in PHY",
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.suspend		= at803x_suspend,
>   	.resume			= at803x_resume,
>   	.flags			= PHY_POLL_CABLE_TEST,
> @@ -2117,7 +2089,6 @@ static struct phy_driver at803x_driver[] = {
>   	PHY_ID_MATCH_EXACT(QCA9561_PHY_ID),
>   	.name			= "Qualcomm Atheros QCA9561 built-in PHY",
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.suspend		= at803x_suspend,
>   	.resume			= at803x_resume,
>   	.flags			= PHY_POLL_CABLE_TEST,
> @@ -2183,7 +2154,6 @@ static struct phy_driver at803x_driver[] = {
>   	.name			= "Qualcomm QCA8081",
>   	.flags			= PHY_POLL_CABLE_TEST,
>   	.probe			= at803x_probe,
> -	.remove			= at803x_remove,
>   	.config_intr		= at803x_config_intr,
>   	.handle_interrupt	= at803x_handle_interrupt,
>   	.get_tunable		= at803x_get_tunable,

