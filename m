Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB353635406
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiKWJBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiKWJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:01:49 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82961025D6;
        Wed, 23 Nov 2022 01:01:47 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oxldM-0006px-PE; Wed, 23 Nov 2022 10:01:32 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     mturquette@baylibre.com, sboyd@kernel.org, mturquette@linaro.org,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: Fix memory leak in rockchip_clk_register_pll()
Date:   Wed, 23 Nov 2022 10:01:30 +0100
Message-ID: <6301679.31r3eYUQgx@phil>
In-Reply-To: <20221123032237.64567-1-xiujianfeng@huawei.com>
References: <20221123032237.64567-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 23. November 2022, 04:22:37 CET schrieb Xiu Jianfeng:
> If clk_register() fails, @pll->rate_table may have allocated memory by
> kmemdup(), so it needs to be freed, otherwise will cause memory leak
> issue, this patch fixes it.
> 
> Fixes: 90c590254051 ("clk: rockchip: add clock type for pll clocks and pll used on rk3066")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/clk/rockchip/clk-pll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 4b9840994295..dc4ce280d125 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -1200,6 +1200,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
>  	clk_unregister(mux_clk);
>  	mux_clk = pll_clk;
>  err_mux:
> +	kfree(pll->rate_table);

I think this free needs to go up to the err_pll block.

In the code it is
- clk_register(pll_mux->hw)   -> err_mux
- kmemdup
- clk_register(pll->hw)	-> err_pll

so the kfree for the rate-table should probably
be at
	err_pll:
		kfree(rate_table)
		clk_unregister(mux_clk);
		...


Heiko

>  	kfree(pll);
>  	return mux_clk;
>  }
> 




