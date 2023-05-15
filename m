Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AE702201
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjEODIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEODHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B645BE78
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 20:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9D36121E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FF8C433EF;
        Mon, 15 May 2023 03:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684120073;
        bh=G7DedWUvd2Ek8z4UQYFYC7W6+CKbIg4FT6sWJitIhS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsc60lt7ra8ySXOoViw7PWORQ1NyxYIof4X//ctW2N42xyV0OeJ4GhKXLeVsjuncI
         AsIF3wzbd3HdkNG5MyG3Z0/A1lQrSEqYppCPeEWCc6L4nRBZiO1qCZxEzZdF5q61h1
         miKG5aA1j2kr+0xZW8Hxj39wxbvVeELA58T9RBrdIG24A+825ps2KueTjAiNJdmUNt
         X5PerN8+o6Ek+6OFpvuVyyaxBRlBje4J2QJt39uj1H95pfiM/0hVFDhG3EEysslh0f
         PCE5qNGDO+xlo0vBtb1Q992wzai7AX0t/unVbRopkb3LUa2PyZvympsAMzfaiknH2S
         m7G3YLC96BRBw==
Date:   Mon, 15 May 2023 11:07:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] soc: imx: support i.MX93 soc device
Message-ID: <20230515030741.GC767028@dragon>
References: <20230509091942.2923330-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509091942.2923330-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:19:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Similar to i.MX8M, add i.MX93 soc device support

This commit log doesn't provide too much helpful information.  You may
want to briefly introduce i.MX93 UID, which looks something new?

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  The ocotp yaml has got R-b from DT maintainer:
>  https://lore.kernel.org/all/01be24b3-aaf2-e27b-d00e-f8649a497463@linaro.org/
> 
>  Remove uid_length from V1 which is unused.
> 
>  drivers/soc/imx/Makefile    |  2 +-
>  drivers/soc/imx/soc-imx8m.c | 64 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index a28c44a1f16a..83aff181ae51 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -7,5 +7,5 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>  obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
>  obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
>  obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
> -obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
> +obj-$(CONFIG_SOC_IMX9) += soc-imx8m.o imx93-src.o imx93-pd.o
>  obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 1dcd243df567..0e69b8b48183 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -25,8 +25,11 @@
>  
>  #define IMX8MP_OCOTP_UID_OFFSET		0x10
>  
> +#define IMX93_OCOTP_UID_OFFSET		0x80c0
> +
>  /* Same as ANADIG_DIGPROG_IMX7D */
>  #define ANADIG_DIGPROG_IMX8MM	0x800
> +#define ANADIG_DIGPROG_IMX93	0x800
>  
>  struct imx8_soc_data {
>  	char *name;
> @@ -34,6 +37,7 @@ struct imx8_soc_data {
>  };
>  
>  static u64 soc_uid;
> +static u64 soc_uid_h;
>  
>  #ifdef CONFIG_HAVE_ARM_SMCCC
>  static u32 imx8mq_soc_revision_from_atf(void)
> @@ -141,6 +145,53 @@ static u32 __init imx8mm_soc_revision(void)
>  	return rev;
>  }
>  
> +static void __init imx93_soc_uid(void)
> +{
> +	void __iomem *ocotp_base;
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-ocotp");
> +	if (!np)
> +		return;
> +
> +	ocotp_base = of_iomap(np, 0);
> +	WARN_ON(!ocotp_base);
> +
> +	soc_uid = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x8);
> +	soc_uid <<= 32;
> +	soc_uid |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0xC);
> +
> +	soc_uid_h = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x0);
> +	soc_uid_h <<= 32;
> +	soc_uid_h |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x4);
> +
> +	iounmap(ocotp_base);
> +	of_node_put(np);
> +}
> +
> +static u32 __init imx93_soc_revision(void)
> +{
> +	struct device_node *np;
> +	void __iomem *anatop_base;
> +	u32 rev;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
> +	if (!np)
> +		return 0;
> +
> +	anatop_base = of_iomap(np, 0);
> +	WARN_ON(!anatop_base);
> +
> +	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX93);
> +
> +	iounmap(anatop_base);
> +	of_node_put(np);
> +
> +	imx93_soc_uid();
> +
> +	return rev;
> +}
> +
>  static const struct imx8_soc_data imx8mq_soc_data = {
>  	.name = "i.MX8MQ",
>  	.soc_revision = imx8mq_soc_revision,
> @@ -161,11 +212,17 @@ static const struct imx8_soc_data imx8mp_soc_data = {
>  	.soc_revision = imx8mm_soc_revision,
>  };
>  
> +static const struct imx8_soc_data imx93_soc_data = {
> +	.name = "i.MX93",
> +	.soc_revision = imx93_soc_revision,
> +};
> +
>  static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>  	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
>  	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
>  	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
>  	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
> +	{ .compatible = "fsl,imx93", .data = &imx93_soc_data, },
>  	{ }
>  };
>  
> @@ -212,7 +269,12 @@ static int __init imx8_soc_init(void)
>  		goto free_soc;
>  	}
>  
> -	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	if (soc_uid_h) {

Unnecessary parentheses.

Shawn

> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
> +							soc_uid_h, soc_uid);
> +	} else {
> +		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
> +	}
>  	if (!soc_dev_attr->serial_number) {
>  		ret = -ENOMEM;
>  		goto free_rev;
> -- 
> 2.37.1
> 
