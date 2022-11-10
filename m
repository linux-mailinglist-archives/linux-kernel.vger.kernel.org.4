Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05C8623A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiKJDZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiKJDZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:25:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECBC1AF1F;
        Wed,  9 Nov 2022 19:25:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 799C6B82083;
        Thu, 10 Nov 2022 03:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E6C433C1;
        Thu, 10 Nov 2022 03:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668050708;
        bh=+oBQRQRKGOx/bxxQ4d3T1WtdN/WNJGx7LQ/mUoMIC6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQjc/gqh+5t2sz7/iqPFGvwRI3UVAV6A9JVX3E4Hp8CZAvYfOB90QCfchcvcUBgY6
         0e9BUOTMhQvpVZABErjAlHid3M80QKuN4OkZfNXXEx1LKnO4C26G1rxRSxMd2/yDDb
         wCjt5MABJ55R8nl7Ii/YvD+KiW3iZriZdEICJRk0xFKhfhx1PuXBzw2IrIFp7naVGL
         DBZQBgE2BGllEkr3s8Qo5YF72kiN62mLWf4HD2dkp75faId7p+Dn5PBjHX7dYE9FLd
         rNDaZWNMAbIxs17tzK+wusVo+5w87btP0Bl+W3vZOVhk1IHE0aOkHO8gx/KkbdGmAA
         fNWZXLKWwcIVw==
Date:   Wed, 9 Nov 2022 21:25:05 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH] clk: qcom: ipq8074: populate fw_name for all parents
Message-ID: <20221110032505.hkdlaad2vb7pqpdu@builder.lan>
References: <20221108194217.553303-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108194217.553303-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:42:17PM +0100, Robert Marko wrote:
> It appears that having only .name populated in parent_data for clocks
> which are only globally searchable currently will not work as the clk core
> won't copy that name if there is no .fw_name present as well.
> 

While we want to migrate users to .fw_name and .index, that sounds like
a bug. Where does this (not) happen?

Regards,
Bjorn

> So, populate .fw_name for all parent clocks in parent_data.
> 
> Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq8074.c | 48 +++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> index d231866804f6..bf64aa683605 100644
> --- a/drivers/clk/qcom/gcc-ipq8074.c
> +++ b/drivers/clk/qcom/gcc-ipq8074.c
> @@ -1137,7 +1137,7 @@ static const struct freq_tbl ftbl_nss_noc_bfdcd_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_bias_pll_nss_noc_clk_gpll0_gpll2[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "bias_pll_nss_noc_clk" },
> +	{ .fw_name = "bias_pll_nss_noc_clk", .name = "bias_pll_nss_noc_clk" },
>  	{ .hw = &gpll0.clkr.hw },
>  	{ .hw = &gpll2.clkr.hw },
>  };
> @@ -1362,7 +1362,7 @@ static const struct freq_tbl ftbl_nss_ppe_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_bias_gpll0_gpll4_nss_ubi32[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  	{ .hw = &gpll0.clkr.hw },
>  	{ .hw = &gpll4.clkr.hw },
>  	{ .hw = &nss_crypto_pll.clkr.hw },
> @@ -1413,10 +1413,10 @@ static const struct freq_tbl ftbl_nss_port1_rx_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_uniphy0_rx_tx_ubi32_bias[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "uniphy0_gcc_rx_clk" },
> -	{ .name = "uniphy0_gcc_tx_clk" },
> +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
>  	{ .hw = &ubi32_pll.clkr.hw },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  };
>  
>  static const struct parent_map gcc_xo_uniphy0_rx_tx_ubi32_bias_map[] = {
> @@ -1465,10 +1465,10 @@ static const struct freq_tbl ftbl_nss_port1_tx_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_uniphy0_tx_rx_ubi32_bias[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "uniphy0_gcc_tx_clk" },
> -	{ .name = "uniphy0_gcc_rx_clk" },
> +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
>  	{ .hw = &ubi32_pll.clkr.hw },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  };
>  
>  static const struct parent_map gcc_xo_uniphy0_tx_rx_ubi32_bias_map[] = {
> @@ -1696,12 +1696,12 @@ static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "uniphy0_gcc_rx_clk" },
> -	{ .name = "uniphy0_gcc_tx_clk" },
> -	{ .name = "uniphy1_gcc_rx_clk" },
> -	{ .name = "uniphy1_gcc_tx_clk" },
> +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> +	{ .fw_name = "uniphy1_gcc_rx_clk", .name = "uniphy1_gcc_rx_clk" },
> +	{ .fw_name = "uniphy1_gcc_tx_clk", .name = "uniphy1_gcc_tx_clk" },
>  	{ .hw = &ubi32_pll.clkr.hw },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  };
>  
>  static const struct parent_map
> @@ -1758,12 +1758,12 @@ static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "uniphy0_gcc_tx_clk" },
> -	{ .name = "uniphy0_gcc_rx_clk" },
> -	{ .name = "uniphy1_gcc_tx_clk" },
> -	{ .name = "uniphy1_gcc_rx_clk" },
> +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> +	{ .fw_name = "uniphy1_gcc_tx_clk", .name = "uniphy1_gcc_tx_clk" },
> +	{ .fw_name = "uniphy1_gcc_rx_clk", .name = "uniphy1_gcc_rx_clk" },
>  	{ .hw = &ubi32_pll.clkr.hw },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  };
>  
>  static const struct parent_map
> @@ -1820,10 +1820,10 @@ static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_uniphy2_rx_tx_ubi32_bias[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "uniphy2_gcc_rx_clk" },
> -	{ .name = "uniphy2_gcc_tx_clk" },
> +	{ .fw_name = "uniphy2_gcc_rx_clk", .name = "uniphy2_gcc_rx_clk" },
> +	{ .fw_name = "uniphy2_gcc_tx_clk", .name = "uniphy2_gcc_tx_clk" },
>  	{ .hw = &ubi32_pll.clkr.hw },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  };
>  
>  static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
> @@ -1877,10 +1877,10 @@ static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
>  
>  static const struct clk_parent_data gcc_xo_uniphy2_tx_rx_ubi32_bias[] = {
>  	{ .fw_name = "xo", .name = "xo" },
> -	{ .name = "uniphy2_gcc_tx_clk" },
> -	{ .name = "uniphy2_gcc_rx_clk" },
> +	{ .fw_name = "uniphy2_gcc_tx_clk", .name = "uniphy2_gcc_tx_clk" },
> +	{ .fw_name = "uniphy2_gcc_rx_clk", .name = "uniphy2_gcc_rx_clk" },
>  	{ .hw = &ubi32_pll.clkr.hw },
> -	{ .name = "bias_pll_cc_clk" },
> +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
>  };
>  
>  static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
> -- 
> 2.38.1
> 
