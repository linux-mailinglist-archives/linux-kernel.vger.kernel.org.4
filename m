Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006D610E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJ1KYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJ1KYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452B1CB534;
        Fri, 28 Oct 2022 03:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F6A62762;
        Fri, 28 Oct 2022 10:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05631C433D6;
        Fri, 28 Oct 2022 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666952640;
        bh=1JtXCOpRqptIdX0DQSUwY7YoNsgQauDmJBdHmsHsiK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NdWGUQAo9OIMDnZhf8sSknwkusIA80E3ral84mYmh5p2WsibhWqBuyxClsD2IlDhP
         Bh8xuqaq2Fs/CkKRiVbge/J+K+RvyUOSD8kbcNj6Qk+P9Ok5uAn2mogFCTqN843F4y
         sh4PBJdpwkyf1zLfEsY8btNN5cKkThMLoLVFkOwO/cu+y72rZtoSvsgVOTnpjzeDwn
         z8c9B1iIJQi2bp2UMQxkQ7g6cYJRlEa27+zERDJnC7uzDMR4tusfm0yuvjUEAuA9pw
         AwqShO4Omo3T4qcymts8cUe/gGOSloZ96DGHd9QKDPVwTyspTQxdwQF6tVamVu68in
         euburMr6Sgceg==
Message-ID: <b0246184-8cb5-20b5-67ec-368917227562@kernel.org>
Date:   Fri, 28 Oct 2022 13:23:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL
 in J721e
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee@kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, dan.carpenter@oracle.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20221026074532.109220-1-s-vadapalli@ti.com>
 <20221026074532.109220-4-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221026074532.109220-4-s-vadapalli@ti.com>
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



On 26/10/2022 10:45, Siddharth Vadapalli wrote:
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

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
>  drivers/phy/ti/phy-gmii-sel.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index c8f30d2e1f46..8c667819c39a 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -218,6 +218,15 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
>  	.num_qsgmii_main_ports = 1,
>  };
>  
> +static const
> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
> +	.use_of_data = true,
> +	.regfields = phy_gmii_sel_fields_am654,
> +	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
> +	.num_ports = 8,
> +	.num_qsgmii_main_ports = 2,
> +};
> +
>  static const struct of_device_id phy_gmii_sel_id_table[] = {
>  	{
>  		.compatible	= "ti,am3352-phy-gmii-sel",
> @@ -243,6 +252,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
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

cheers,
-roger
