Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B706D18D8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCaHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCaHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:45:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193211166B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B4F3B82C78
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7A2C433EF;
        Fri, 31 Mar 2023 07:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680248705;
        bh=OGbRPiaaux5ZDB6f0vTfcVN9xGnQb7wk/z86yCbkj70=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D4Lex/3IWiDJsKJXdxeZn0qRWsfwSHsWcz26FNZAps4vR64qDh8LZULTWKiIm+/rl
         3AL3XgQ2ftWVfSebTf5ekVIZN8NZltDBJ6lyvOiGnZvNfCc/EKMOiSWieeY6nWKcS/
         cg2IAZ5xjHhhzeIdxObkbJgeCX3+zAMR6DQPqJQ1feQS2ed5ZtJcjc69MiHMG6TL3i
         vVQ5jeR7nsFanRMh4ht2VB4uy3A3vqoH8kfMc3xuD5uKTVPovwA0S0YSsU7YZz5yt7
         x15ivxK+fq8GNfAzfHsKPx0GdObzJ89AmbvTQ5lN+WgaeEF++sBnd5C/pLMelWKhiy
         knyAP54bQKb7g==
Message-ID: <cfcdb25b-5426-2532-ab8c-224a5e33baf3@kernel.org>
Date:   Fri, 31 Mar 2023 10:45:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in
 J784S4
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20230331062521.529005-1-s-vadapalli@ti.com>
 <20230331062521.529005-2-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230331062521.529005-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2023 09:25, Siddharth Vadapalli wrote:
> Each of the CPSW9G ports in TI's J784S4 SoC support modes such as QSGMII.
> 
> Add a new compatible for it and allow the usage of "ti,qsgmii-main-ports"
> property for J784S4.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index c87118cb2af9..fba5c0c0771c 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -235,6 +235,15 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
>  	.num_qsgmii_main_ports = 2,
>  };
>  
> +static const
> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j784s4 = {

Please make it into one line

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
> @@ -264,6 +273,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
>  		.compatible	= "ti,j721e-cpsw9g-phy-gmii-sel",
>  		.data		= &phy_gmii_sel_cpsw9g_soc_j721e,
>  	},
> +	{
> +		.compatible	= "ti,j784s4-cpsw9g-phy-gmii-sel",
> +		.data		= &phy_gmii_sel_cpsw9g_soc_j784s4,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
--
cheers,
-roger
