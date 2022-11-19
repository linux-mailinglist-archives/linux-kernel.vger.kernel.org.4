Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A83630E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiKSKnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:43:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081484824;
        Sat, 19 Nov 2022 02:43:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73C560959;
        Sat, 19 Nov 2022 10:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3B3C433C1;
        Sat, 19 Nov 2022 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668854591;
        bh=/+iRDvo5pjoK/3d+uFgmlFaUxqq5N45gM/Zxq/W3Tx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CG/RU7Ua81xKFWKG+czQ5Up/u88hGSTpEFf58HsFm8vLhhdQoX5CH1Oa72ZPfo7zI
         HqxL5pMi8jh/j2iu0aJftZ92NsL3tyCeYLUpRSaj5EEOOPC53JaRaxVK+lxNtvCJ5y
         ruZpj20hvwbi5OxiBR7S2At6nPJqnyZ0hUu5XcmCU5SbYAwlgN+1sMsWAAwuHA+4FX
         7ZMS/E0xsoOmkYGurwLtppLUNR3qb+YYa0pllt0r0mDz4YDRx4yE7QenBdGOEJq+Pc
         8/fWrS9DoMoZnjLYCrOEXIf9S2ftIaFluWjGQye+fXGKhVC/CamnocqI+n7ckXXrXt
         5bb91z8TzpwCQ==
Date:   Sat, 19 Nov 2022 10:43:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com, claudiu.beznea@microchip.com,
        conor.dooley@microchip.com
Subject: Re: [PATCH] clk: microchip: check for null return of devm_kzalloc()
Message-ID: <Y3izOuF56/NywpOR@spud>
References: <20221119054858.178629-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119054858.178629-1-tanghui20@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:48:58PM +0800, Hui Tang wrote:
> Because of the possilble failure of devm_kzalloc(), name might be NULL and
> will cause null pointer derefrence later.

In theory, yeah?

(note to self, s/refrence/reference/, s/possilble/possible)

> Therefore, it might be better to check it and directly return -ENOMEM.

I agree with your use of might here. If the allocations do fail, we
likely aren't getting the system off the ground anyway - but there is
no harm in checking.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

@Claudiu, supposedly I can push to the at91 repo now so I will try to do
that.

Thanks,
Conor.

> 
> Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/clk/microchip/clk-mpfs-ccc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
> index 7be028dced63..32aae880a14f 100644
> --- a/drivers/clk/microchip/clk-mpfs-ccc.c
> +++ b/drivers/clk/microchip/clk-mpfs-ccc.c
> @@ -166,6 +166,9 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
>  		struct mpfs_ccc_out_hw_clock *out_hw = &out_hws[i];
>  		char *name = devm_kzalloc(dev, 23, GFP_KERNEL);
>  
> +		if (!name)
> +			return -ENOMEM;
> +
>  		snprintf(name, 23, "%s_out%u", parent->name, i);
>  		out_hw->divider.hw.init = CLK_HW_INIT_HW(name, &parent->hw, &clk_divider_ops, 0);
>  		out_hw->divider.reg = data->pll_base[i / MPFS_CCC_OUTPUTS_PER_PLL] +
> @@ -200,6 +203,9 @@ static int mpfs_ccc_register_plls(struct device *dev, struct mpfs_ccc_pll_hw_clo
>  		struct mpfs_ccc_pll_hw_clock *pll_hw = &pll_hws[i];
>  		char *name = devm_kzalloc(dev, 18, GFP_KERNEL);
>  
> +		if (!name)
> +			return -ENOMEM;
> +
>  		pll_hw->base = data->pll_base[i];
>  		snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '@'), i);
>  		pll_hw->name = (const char *)name;
> -- 
> 2.17.1
> 
