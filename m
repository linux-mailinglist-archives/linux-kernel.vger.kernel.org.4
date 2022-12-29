Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03465931B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiL2XSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiL2XSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:18:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 927B516582;
        Thu, 29 Dec 2022 15:18:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C1032F4;
        Thu, 29 Dec 2022 15:19:23 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B21A43F663;
        Thu, 29 Dec 2022 15:18:40 -0800 (PST)
Date:   Thu, 29 Dec 2022 23:17:03 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] rtc: sun6i: Always export the internal oscillator
Message-ID: <20221229231703.19f5eda7@slackpad.lan>
In-Reply-To: <20221229215319.14145-1-samuel@sholland.org>
References: <20221229215319.14145-1-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 15:53:19 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> On all variants of the hardware, the internal oscillator is one possible
> parent for the AR100 clock. It needs to be exported so we can model that
> relationship correctly in the devicetree.

So do you plan to use this third clock on any SoCs that don't export it
yet, like the R40 or V3s, or the older SoCs? This would then create a
non-compatible DT change, wouldn't it? Since existing/older kernels
cannot resolve clock index 2?
Or would that not be used by kernels, or would not be fatal?

Cheers,
Andre

> Fixes: c56afc1844d6 ("rtc: sun6i: Expose internal oscillator through device tree")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> This patch should be applied before [1] so this patch can be backported.
> [1]: https://lore.kernel.org/linux-rtc/20221229184011.62925-2-samuel@sholland.org/
> 
>  drivers/rtc/rtc-sun6i.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index ed5516089e9a..7038f47d77ff 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -136,7 +136,6 @@ struct sun6i_rtc_clk_data {
>  	unsigned int fixed_prescaler : 16;
>  	unsigned int has_prescaler : 1;
>  	unsigned int has_out_clk : 1;
> -	unsigned int export_iosc : 1;
>  	unsigned int has_losc_en : 1;
>  	unsigned int has_auto_swt : 1;
>  };
> @@ -271,10 +270,8 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>  	/* Yes, I know, this is ugly. */
>  	sun6i_rtc = rtc;
>  
> -	/* Only read IOSC name from device tree if it is exported */
> -	if (rtc->data->export_iosc)
> -		of_property_read_string_index(node, "clock-output-names", 2,
> -					      &iosc_name);
> +	of_property_read_string_index(node, "clock-output-names", 2,
> +				      &iosc_name);
>  
>  	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
>  								iosc_name,
> @@ -315,13 +312,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>  		goto err_register;
>  	}
>  
> -	clk_data->num = 2;
> +	clk_data->num = 3;
>  	clk_data->hws[0] = &rtc->hw;
>  	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
> -	if (rtc->data->export_iosc) {
> -		clk_data->hws[2] = rtc->int_osc;
> -		clk_data->num = 3;
> -	}
> +	clk_data->hws[2] = rtc->int_osc;
>  	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  	return;
>  
> @@ -361,7 +355,6 @@ static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
>  	.fixed_prescaler = 32,
>  	.has_prescaler = 1,
>  	.has_out_clk = 1,
> -	.export_iosc = 1,
>  };
>  
>  static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
> @@ -379,7 +372,6 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
>  	.fixed_prescaler = 32,
>  	.has_prescaler = 1,
>  	.has_out_clk = 1,
> -	.export_iosc = 1,
>  	.has_losc_en = 1,
>  	.has_auto_swt = 1,
>  };

