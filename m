Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D995EF864
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiI2PK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiI2PKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4887B795;
        Thu, 29 Sep 2022 08:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9AB8B824D7;
        Thu, 29 Sep 2022 15:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2747C433D7;
        Thu, 29 Sep 2022 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664464250;
        bh=LYs8gbq9wOk+4E8dz7WVHNsgZrKBNxm+rh4gOlOaP28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SImofIFQoxMQc2wnOX8M8BNkFmr/Y7GB4fvsXSybAg2BNtvGxXBM3AsZvK65+nvbT
         kgxcSPU0DOkIjn+3DBbooaQjfL2t4JFgY4dhMqONXT3VYSyrV08fj+vU9NYAlhzkoi
         sL9JjHvnuJzVlF7exL5D244QcwIZGaRFHqh8oDqn2AviVW5hLQh/D3Nxi8SelBWWKT
         Ch1eFqZo4lVF5WFQg+9PfZQ4zMgBSvpHOmIAGNWoJujtAP9LHtO3F+RoOWGCk9gR49
         qvRAl+zkR4cyGkawChkWPTrCijpr4hcyV+6D6Rlq6kzQ0JYP+Gic/+RIFAwXB0vBsO
         CHRqy2YtMX0Kg==
Date:   Thu, 29 Sep 2022 10:10:47 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
Message-ID: <20220929151047.wom3m2ydgxme5nhh@builder.lan>
References: <20220706150411.708213-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706150411.708213-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 06:04:10PM +0300, Abel Vesa wrote:
> There are unused clocks that need to stay enabled on clk_disable_unused,
> but rather should be disabled later on on sync_state. Provide a generic
> sync_state callback for the clock providers that register such clocks.
> Then, use the same mechanism as clk_disable_unused from that generic
> callback, but pass the device to make sure only the clocks belonging to
> the current clock provider get disabled, if unused. Also, during the
> default clk_disable_unused, if the driver that registered the clock has
> the generic clk_sync_state_disable_unused callback set for sync_state,
> leave its clocks enabled.
> 

Overall I like this, just a minor thing about ignoring CLK_IGNORE_UNUSED
from the sync_stat path below.


We've talked about this not being the whole solution, because there
might be devices that will enable/disable clocks that will be used by
later devices. It seems to me that this would be an additional issue
that needs to be fixed - so I don't have a problem with us picking this
up as a first step.

But for boards where this would be a problem there's no longer a way to
opt-out of the disabling of unused clocks. So perhaps we'd want
clk_ignore_unused to affect the sync_state based case as well?

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/clk.c            | 67 +++++++++++++++++++++++++++---------
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 7fc191c15507..ea55806505c0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1218,19 +1218,31 @@ static void clk_core_disable_unprepare(struct clk_core *core)
>  	clk_core_unprepare_lock(core);
>  }
>  
> -static void __init clk_unprepare_unused_subtree(struct clk_core *core)
> +static void clk_unprepare_unused_subtree(struct clk_core *core,
> +						struct device *dev)
>  {
>  	struct clk_core *child;
>  
>  	lockdep_assert_held(&prepare_lock);
>  
>  	hlist_for_each_entry(child, &core->children, child_node)
> -		clk_unprepare_unused_subtree(child);
> +		clk_unprepare_unused_subtree(child, dev);
> +
> +	if (dev && core->dev != dev)
> +		return;
> +
> +	/*
> +	 * clock will be unprepared on sync_state,
> +	 * so leave as is on clk_disable_unused
> +	 */
> +	if (!dev && dev_has_sync_state(core->dev) &&

How about introducing a local variable bool from_sync_state = !!dev, to
make these conditionals easier to read?

> +		core->dev->driver->sync_state == clk_sync_state_disable_unused)
> +		return;
>  
>  	if (core->prepare_count)
>  		return;
>  
> -	if (core->flags & CLK_IGNORE_UNUSED)
> +	if (!dev && core->flags & CLK_IGNORE_UNUSED)

Iiuc, when being called from the sync_state path, CLK_IGNORE_UNUSED will
now be ignored (and the clock will be disabled).

We don't have a lot of users of this flag, but would it not make sense
to adhere to this flag even in that case? As a continued means to
describe a clock which shouldn't be automatically disabled...

>  		return;
>  
>  	if (clk_pm_runtime_get(core))
> @@ -1248,7 +1260,8 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>  	clk_pm_runtime_put(core);
>  }
>  
> -static void __init clk_disable_unused_subtree(struct clk_core *core)
> +static void clk_disable_unused_subtree(struct clk_core *core,
> +					struct device *dev)
>  {
>  	struct clk_core *child;
>  	unsigned long flags;
> @@ -1256,7 +1269,18 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	lockdep_assert_held(&prepare_lock);
>  
>  	hlist_for_each_entry(child, &core->children, child_node)
> -		clk_disable_unused_subtree(child);
> +		clk_disable_unused_subtree(child, dev);
> +
> +	if (dev && core->dev != dev)
> +		return;
> +
> +	/*
> +	 * clock will be disabled on sync_state,
> +	 * so leave as is on clk_disable_unused
> +	 */
> +	if (!dev && dev_has_sync_state(core->dev) &&
> +		core->dev->driver->sync_state == clk_sync_state_disable_unused)
> +		return;
>  
>  	if (core->flags & CLK_OPS_PARENT_ENABLE)
>  		clk_core_prepare_enable(core->parent);
> @@ -1269,7 +1293,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	if (core->enable_count)
>  		goto unlock_out;
>  
> -	if (core->flags & CLK_IGNORE_UNUSED)
> +	if (!dev && core->flags & CLK_IGNORE_UNUSED)
>  		goto unlock_out;
>  
>  	/*
> @@ -1302,35 +1326,46 @@ static int __init clk_ignore_unused_setup(char *__unused)
>  }
>  __setup("clk_ignore_unused", clk_ignore_unused_setup);
>  
> -static int __init clk_disable_unused(void)
> +static void __clk_disable_unused(struct device *dev)
>  {
>  	struct clk_core *core;
>  
> -	if (clk_ignore_unused) {
> -		pr_warn("clk: Not disabling unused clocks\n");
> -		return 0;
> -	}

As mentioned above, I think it's reasonable to keep this here.

Regards,
Bjorn

> -
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
> +	if (clk_ignore_unused) {
> +		pr_warn("clk: Not disabling unused clocks\n");
> +		return 0;
> +	}
> +
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
> index 72d937c03a3e..5d3ed2b14f2c 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -679,6 +679,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
>  		void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_divider_flags, const struct clk_div_table *table,
>  		spinlock_t *lock);
> +void clk_sync_state_disable_unused(struct device *dev);
>  /**
>   * clk_register_divider - register a divider clock with the clock framework
>   * @dev: device registering this clock
> -- 
> 2.34.3
> 
