Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C7660599
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAFRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjAFRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:22:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B57D1F5;
        Fri,  6 Jan 2023 09:22:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF68461ED9;
        Fri,  6 Jan 2023 17:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4E2C433D2;
        Fri,  6 Jan 2023 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673025765;
        bh=5nhQGJBlwZRgtktDyOeQXomqZq9l0TTuMv2pcEW3Dyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6bjt0N6sfGZ2vXShltgBfi2rXH6rCpDl4gWYbjHxSIcl8X1UfILOcpMOSSfVoEkc
         GY0AjhSgPgL3pZ9675tU2VkvDfKWObOc9pXDyf41vIB87RwQ1Zbj/v6223ty5txDxu
         10tjGuIhPasVmB0RgwgnpQcO1/3408SCGNQmgDQI8Cc012kkVKPp2dMn1EeJiU5IQE
         v4yygWY08VS1XkARwqlH15d4lVoqbJlTShwfGVqzRD9EsVxpjzweldDb6UK7tzqhxV
         uGOiP5CyF8Uj9qnQW95mk9Hf1MmZakXfdISjZi4/zXEZ0ZOCJme7x68+hQR5z6qLPQ
         qKdkAQLd4YW/Q==
Date:   Fri, 6 Jan 2023 11:22:42 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <20230106172242.bvuwzysjlh2cp7pw@builder.lan>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227204528.1899863-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:45:27PM +0200, Abel Vesa wrote:
> There are unused clocks that need to remain untouched by clk_disable_unused,
> and most likely could be disabled later on sync_state. So provide a generic
> sync_state callback for the clock providers that register such clocks.
> Then, use the same mechanism as clk_disable_unused from that generic
> callback, but pass the device to make sure only the clocks belonging to
> the current clock provider get disabled, if unused. Also, during the
> default clk_disable_unused, if the driver that registered the clock has
> the generic clk_sync_state_disable_unused callback set for sync_state,
> skip disabling its clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
> Changes since v2:
>  * dropped the check for sync_state callback (clk_sync_state_disable_unused),
>    like Dmitry suggested
> 
>  drivers/clk/clk.c            | 57 +++++++++++++++++++++++++++++-------
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e62552a75f08..ac7182903d88 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1302,14 +1302,26 @@ static void clk_core_disable_unprepare(struct clk_core *core)
>  	clk_core_unprepare_lock(core);
>  }
>  
> -static void __init clk_unprepare_unused_subtree(struct clk_core *core)
> +static void clk_unprepare_unused_subtree(struct clk_core *core,
> +						struct device *dev)
>  {
> +	bool from_sync_state = !!dev;
>  	struct clk_core *child;
>  
>  	lockdep_assert_held(&prepare_lock);
>  
>  	hlist_for_each_entry(child, &core->children, child_node)
> -		clk_unprepare_unused_subtree(child);
> +		clk_unprepare_unused_subtree(child, dev);
> +
> +	if (from_sync_state && core->dev != dev)
> +		return;
> +
> +	/*
> +	 * clock will be unprepared on sync_state,
> +	 * so leave as is for now
> +	 */
> +	if (!from_sync_state && dev_has_sync_state(core->dev))
> +		return;
>  
>  	if (core->prepare_count)
>  		return;
> @@ -1332,15 +1344,27 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>  	clk_pm_runtime_put(core);
>  }
>  
> -static void __init clk_disable_unused_subtree(struct clk_core *core)
> +static void clk_disable_unused_subtree(struct clk_core *core,
> +					struct device *dev)
>  {
> +	bool from_sync_state = !!dev;
>  	struct clk_core *child;
>  	unsigned long flags;
>  
>  	lockdep_assert_held(&prepare_lock);
>  
>  	hlist_for_each_entry(child, &core->children, child_node)
> -		clk_disable_unused_subtree(child);
> +		clk_disable_unused_subtree(child, dev);
> +
> +	if (from_sync_state && core->dev != dev)
> +		return;
> +
> +	/*
> +	 * clock will be disabled on sync_state,
> +	 * so leave as is for now
> +	 */
> +	if (!from_sync_state && dev_has_sync_state(core->dev))
> +		return;
>  
>  	if (core->flags & CLK_OPS_PARENT_ENABLE)
>  		clk_core_prepare_enable(core->parent);
> @@ -1378,7 +1402,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  		clk_core_disable_unprepare(core->parent);
>  }
>  
> -static bool clk_ignore_unused __initdata;
> +static bool clk_ignore_unused;
>  static int __init clk_ignore_unused_setup(char *__unused)
>  {
>  	clk_ignore_unused = true;
> @@ -1386,35 +1410,46 @@ static int __init clk_ignore_unused_setup(char *__unused)
>  }
>  __setup("clk_ignore_unused", clk_ignore_unused_setup);
>  
> -static int __init clk_disable_unused(void)
> +static void __clk_disable_unused(struct device *dev)
>  {
>  	struct clk_core *core;
>  
>  	if (clk_ignore_unused) {
>  		pr_warn("clk: Not disabling unused clocks\n");
> -		return 0;
> +		return;
>  	}
>  
>  	clk_prepare_lock();
>  
>  	hlist_for_each_entry(core, &clk_root_list, child_node)
> -		clk_disable_unused_subtree(core);
> +		clk_disable_unused_subtree(core, dev);
>  
>  	hlist_for_each_entry(core, &clk_orphan_list, child_node)
> -		clk_disable_unused_subtree(core);
> +		clk_disable_unused_subtree(core, dev);
>  
>  	hlist_for_each_entry(core, &clk_root_list, child_node)
> -		clk_unprepare_unused_subtree(core);
> +		clk_unprepare_unused_subtree(core, dev);
>  
>  	hlist_for_each_entry(core, &clk_orphan_list, child_node)
> -		clk_unprepare_unused_subtree(core);
> +		clk_unprepare_unused_subtree(core, dev);
>  
>  	clk_prepare_unlock();
> +}
> +
> +static int __init clk_disable_unused(void)
> +{
> +	__clk_disable_unused(NULL);
>  
>  	return 0;
>  }
>  late_initcall_sync(clk_disable_unused);
>  
> +void clk_sync_state_disable_unused(struct device *dev)
> +{
> +	__clk_disable_unused(dev);
> +}
> +EXPORT_SYMBOL_GPL(clk_sync_state_disable_unused);
> +
>  static int clk_core_determine_round_nolock(struct clk_core *core,
>  					   struct clk_rate_request *req)
>  {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 842e72a5348f..cf1adfeaf257 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
>  		void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_divider_flags, const struct clk_div_table *table,
>  		spinlock_t *lock);
> +void clk_sync_state_disable_unused(struct device *dev);
>  /**
>   * clk_register_divider - register a divider clock with the clock framework
>   * @dev: device registering this clock
> -- 
> 2.34.1
> 
