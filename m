Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C266FA139
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjEHHmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEHHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9A40D1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1541B6201E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB2CC433EF;
        Mon,  8 May 2023 07:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683531718;
        bh=yNTGKvnvEJLVtEyVTqWeDENaezR1MgGHS3g9B/4BDWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3loFkYDYcjTv69jeH0SfBGgatd4d0Uo1oq9tbaCm8wUO/Dbha5dCWXW8U/lykg+z
         i8iD4eV8sVHXD9lwkcFopZ18gbOawcg+NoybYJY9UDpRAXGP6BTMDNtn9GKhi99cJz
         4aMwS6DYHDYDxMtNNl7Wd8JzAzKMxdk79LuNCIrtaFEKY0rTyqCT4mFsQFQre2QxYe
         IUDi74XXSv3W+Hw0/ipaaGHT6VWWpu/0eZNMwlx1CxCcRFLmrtAUcELCNsC2PMlRsB
         QLDZ0zmQw6IZj8z1IDc5oOiZ5J22s4qptOcwdvxHERfGILH0bVIzyLzH0pRAoeUWa6
         9Fpg+y7KvRo9w==
Date:   Mon, 8 May 2023 13:11:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to Hi3798MV100
Message-ID: <ZFinwhFphe71VeLk@matsya>
References: <20230507154615.793942-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507154615.793942-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-23, 23:46, David Yang wrote:
> Hisilicon also uses phy-hisi-inno-usb2 on Hi3798MV100, with a slightly
> different register convention.

OK, so what should I expect from this patch, pls document that here...

> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/phy/hisilicon/Kconfig              |  2 +-
>  drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 67 ++++++++++++++++------
>  2 files changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
> index d3b92c288554..6c89136fc8c2 100644
> --- a/drivers/phy/hisilicon/Kconfig
> +++ b/drivers/phy/hisilicon/Kconfig
> @@ -54,7 +54,7 @@ config PHY_HISTB_COMBPHY
>  
>  config PHY_HISI_INNO_USB2
>  	tristate "HiSilicon INNO USB2 PHY support"
> -	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> +	depends on ARCH_HISI || COMPILE_TEST

why this change?

>  	select GENERIC_PHY
>  	select MFD_SYSCON
>  	help
> diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> index b133ae06757a..b5d006f38934 100644
> --- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> +++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
> @@ -9,7 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
> +#include <linux/of_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/reset.h>
>  
> @@ -20,12 +20,28 @@
>  #define PHY_CLK_STABLE_TIME	2	/* unit:ms */
>  #define UTMI_RST_COMPLETE_TIME	2	/* unit:ms */
>  #define POR_RST_COMPLETE_TIME	300	/* unit:us */
> -#define PHY_TEST_DATA		GENMASK(7, 0)
> -#define PHY_TEST_ADDR		GENMASK(15, 8)
> -#define PHY_TEST_PORT		GENMASK(18, 16)
> -#define PHY_TEST_WREN		BIT(21)
> -#define PHY_TEST_CLK		BIT(22)	/* rising edge active */
> -#define PHY_TEST_RST		BIT(23)	/* low active */
> +
> +#define PHY_TYPE_0	0
> +#define PHY_TYPE_1	1
> +
> +#define PHY0_TEST_DATA		GENMASK(7, 0)

same as previous what changed??

> +#define PHY0_TEST_ADDR_OFFSET	8
> +#define PHY0_TEST_ADDR		GENMASK(15, 8)
> +#define PHY0_TEST_PORT_OFFSET	16
> +#define PHY0_TEST_PORT		GENMASK(18, 16)
> +#define PHY0_TEST_WREN		BIT(21)
> +#define PHY0_TEST_CLK		BIT(22)	/* rising edge active */
> +#define PHY0_TEST_RST		BIT(23)	/* low active */
> +
> +#define PHY1_TEST_DATA		GENMASK(7, 0)
> +#define PHY1_TEST_ADDR_OFFSET	8
> +#define PHY1_TEST_ADDR		GENMASK(11, 8)
> +#define PHY1_TEST_PORT_OFFSET	12
> +#define PHY1_TEST_PORT		BIT(12)
> +#define PHY1_TEST_WREN		BIT(13)
> +#define PHY1_TEST_CLK		BIT(14)	/* rising edge active */
> +#define PHY1_TEST_RST		BIT(15)	/* low active */
> +
>  #define PHY_CLK_ENABLE		BIT(2)
>  
>  struct hisi_inno_phy_port {
> @@ -37,6 +53,7 @@ struct hisi_inno_phy_priv {
>  	void __iomem *mmio;
>  	struct clk *ref_clk;
>  	struct reset_control *por_rst;
> +	unsigned int type;
>  	struct hisi_inno_phy_port ports[INNO_PHY_PORT_NUM];
>  };
>  
> @@ -45,17 +62,27 @@ static void hisi_inno_phy_write_reg(struct hisi_inno_phy_priv *priv,
>  {
>  	void __iomem *reg = priv->mmio;
>  	u32 val;
> -
> -	val = (data & PHY_TEST_DATA) |
> -	      ((addr << 8) & PHY_TEST_ADDR) |
> -	      ((port << 16) & PHY_TEST_PORT) |
> -	      PHY_TEST_WREN | PHY_TEST_RST;
> +	u32 value;
> +
> +	if (priv->type == PHY_TYPE_0)
> +		val = (data & PHY0_TEST_DATA) |
> +		      ((addr << PHY0_TEST_ADDR_OFFSET) & PHY0_TEST_ADDR) |
> +		      ((port << PHY0_TEST_PORT_OFFSET) & PHY0_TEST_PORT) |
> +		      PHY0_TEST_WREN | PHY0_TEST_RST;
> +	else
> +		val = (data & PHY1_TEST_DATA) |
> +		      ((addr << PHY1_TEST_ADDR_OFFSET) & PHY1_TEST_ADDR) |
> +		      ((port << PHY1_TEST_PORT_OFFSET) & PHY1_TEST_PORT) |
> +		      PHY1_TEST_WREN | PHY1_TEST_RST;
>  	writel(val, reg);
>  
> -	val |= PHY_TEST_CLK;
> -	writel(val, reg);
> +	value = val;
> +	if (priv->type == PHY_TYPE_0)
> +		value |= PHY0_TEST_CLK;
> +	else
> +		value |= PHY1_TEST_CLK;
> +	writel(value, reg);
>  
> -	val &= ~PHY_TEST_CLK;
>  	writel(val, reg);
>  }
>  
> @@ -135,6 +162,8 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->por_rst))
>  		return PTR_ERR(priv->por_rst);
>  
> +	priv->type = (unsigned int) of_device_get_match_data(dev);
> +
>  	for_each_child_of_node(np, child) {
>  		struct reset_control *rst;
>  		struct phy *phy;
> @@ -170,8 +199,12 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id hisi_inno_phy_of_match[] = {
> -	{ .compatible = "hisilicon,inno-usb2-phy", },
> -	{ .compatible = "hisilicon,hi3798cv200-usb2-phy", },
> +	{ .compatible = "hisilicon,inno-usb2-phy",
> +	  .data = (void *) PHY_TYPE_0 },
> +	{ .compatible = "hisilicon,hi3798cv200-usb2-phy",
> +	  .data = (void *) PHY_TYPE_0 },
> +	{ .compatible = "hisilicon,hi3798mv100-usb2-phy",
> +	  .data = (void *) PHY_TYPE_1 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, hisi_inno_phy_of_match);
> -- 
> 2.39.2

-- 
~Vinod
