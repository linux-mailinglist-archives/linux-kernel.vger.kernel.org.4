Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B546FC049
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjEIHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjEIHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:16:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56B210D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:16:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3062b101ae1so3401356f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683616582; x=1686208582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zV8I60kyr/duLFC6koHipgTZUu3f0+TrYYdM3dUr30=;
        b=YXqUvaJlzhOKBpI+x4uew1JBxo03mm5PTfJUOR+SXB+sjBIEKX4Bd8CsrXQKrWu7kg
         McZgIPeGe6aEh0xILSsZhlpAGvvivhBRNEOB2j69RRKDfd+YybfO/VUf5Md6DzZeP0ff
         hADplbDAiAyGQjrAF1sWpqbX5qrtKFm/RmWsoDdhQQdStgcr5k/ff6v5cmoy3b7ljagA
         eyomEB8pJzOos9CImmahj/zivQSXueyBvAk/EzKMlyZ+9HPJG2izYHJYPJtBxpcc5TZw
         /lJEykA0zUq3tJiIrrIuHwSYdB6vG5500TkHX/LgVmH6Lb+sBtznvyo9dPwH+MoKzVf9
         Urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683616582; x=1686208582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zV8I60kyr/duLFC6koHipgTZUu3f0+TrYYdM3dUr30=;
        b=AX6VTgL9yRb4JVYK1HN/v8xzMwzwpeagUBtBPr/B/YGaD2L70y0imoORtESw71z/YT
         +p/CGlV2SPH02BxYoAVsTxUagSax26LkU9rs4pDigKE0akI4kYzcpQyvLBw4pzmXP0or
         Xs8uI/InJH5tcabNJ/kjXsFLRG/qUZmt8BhlqDKUyEbjCMjtJOYH6vikGb3aeVTAevp+
         P08hgFytnKIMA1uqjYiV1udN63mGXNF6Wb9DgSNHVKR8WZ0/+I4l1U+x6v9SABzQH0Xi
         Oz/js/tCaf+G9koGJv4AyoxqoTydnYxP9te9RTqSzdbRO1SoxxSoRGRIFkMVNahKBUxC
         GbLA==
X-Gm-Message-State: AC+VfDzBc9FDjFG9uV0xUd2VGhEf9xMa5w62qFNw5lIbi0tJLblh49nH
        xEuMfus/0VC9V3EIoKh6wP+tow==
X-Google-Smtp-Source: ACHHUZ7xZh5XUfIBj39z/ocPaZauzFBEVCazPYU32WDWQ3cmX7amUGDoS/V4zAOozPjq9F8MY92oeA==
X-Received: by 2002:a5d:6586:0:b0:306:e59b:e272 with SMTP id q6-20020a5d6586000000b00306e59be272mr7505676wru.51.1683616581909;
        Tue, 09 May 2023 00:16:21 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6101000000b003062b57ffd1sm13488062wrt.50.2023.05.09.00.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:16:21 -0700 (PDT)
Date:   Tue, 9 May 2023 10:16:20 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] clk: Add support for sync_state()
Message-ID: <ZFnzRJu/SVh+zd6O@linaro.org>
References: <20210407034456.516204-1-saravanak@google.com>
 <20210407034456.516204-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407034456.516204-3-saravanak@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-06 20:44:55, Saravana Kannan wrote:
> Clocks can be turned on (by the hardware, bootloader, etc) upon a
> reset/boot of a hardware platform. These "boot clocks" could be clocking
> devices that are active before the kernel starts running. For example,
> clocks needed for the interconnects, UART console, display, CPUs, DDR,
> etc.
> 
> When a boot clock is used by more than one consumer or multiple boot
> clocks share a parent clock, the boot clock (or the common parent) can
> be turned off when the first consumer probes. This can crash the device
> or cause poor user experience.
> 
> Fix this by explicitly enabling the boot clocks during clock
> registration and then removing the enable vote when the clock provider
> device gets its sync_state() callback. Since sync_state() callback comes
> only when all the consumers of a device (not a specific clock) have
> probed, this ensures the boot clocks are kept on at least until all
> their consumers have had a chance to vote on them (in their respective
> probe functions).
> 
> Also, if a clock provider is loaded as a module and it has some boot
> clocks, they get turned off only when a consumer explicitly turns them
> off. So clocks that are boot clocks and are unused never get turned off
> because the logic to turn off unused clocks has already run during
> late_initcall_sync(). Adding sync_state() support also makes sure these
> unused boot clocks are turned off once all the consumers have probed.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++-
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d6301a3351f2..cd07f4d1254c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -72,6 +72,8 @@ struct clk_core {
>  	unsigned long		flags;
>  	bool			orphan;
>  	bool			rpm_enabled;
> +	bool			need_sync;
> +	bool			boot_enabled;
>  	unsigned int		enable_count;
>  	unsigned int		prepare_count;
>  	unsigned int		protect_count;
> @@ -1215,6 +1217,15 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>  	hlist_for_each_entry(child, &core->children, child_node)
>  		clk_unprepare_unused_subtree(child);
>  
> +	/*
> +	 * Orphan clocks might still not have their state held if one of their
> +	 * ancestors hasn't been registered yet. We don't want to turn off
> +	 * these orphan clocks now as they will be turned off later when their
> +	 * device gets a sync_state() call.
> +	 */
> +	if (dev_has_sync_state(core->dev))
> +		return;
> +
>  	if (core->prepare_count)
>  		return;
>  
> @@ -1246,6 +1257,15 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>  	hlist_for_each_entry(child, &core->children, child_node)
>  		clk_disable_unused_subtree(child);
>  
> +	/*
> +	 * Orphan clocks might still not have their state held if one of their
> +	 * ancestors hasn't been registered yet. We don't want to turn off
> +	 * these orphan clocks now as they will be turned off later when their
> +	 * device gets a sync_state() call.
> +	 */
> +	if (dev_has_sync_state(core->dev))
> +		return;
> +
>  	if (core->flags & CLK_OPS_PARENT_ENABLE)
>  		clk_core_prepare_enable(core->parent);
>  
> @@ -1319,6 +1339,38 @@ static int __init clk_disable_unused(void)
>  }
>  late_initcall_sync(clk_disable_unused);
>  
> +static void clk_unprepare_disable_dev_subtree(struct clk_core *core,
> +					      struct device *dev)
> +{
> +	struct clk_core *child;
> +
> +	lockdep_assert_held(&prepare_lock);
> +
> +	hlist_for_each_entry(child, &core->children, child_node)
> +		clk_unprepare_disable_dev_subtree(child, dev);
> +
> +	if (core->dev != dev || !core->need_sync)
> +		return;
> +
> +	clk_core_disable_unprepare(core);
> +}
> +
> +void clk_sync_state(struct device *dev)
> +{
> +	struct clk_core *core;
> +
> +	clk_prepare_lock();
> +
> +	hlist_for_each_entry(core, &clk_root_list, child_node)
> +		clk_unprepare_disable_dev_subtree(core, dev);
> +
> +	hlist_for_each_entry(core, &clk_orphan_list, child_node)
> +		clk_unprepare_disable_dev_subtree(core, dev);
> +
> +	clk_prepare_unlock();
> +}
> +EXPORT_SYMBOL_GPL(clk_sync_state);
> +
>  static int clk_core_determine_round_nolock(struct clk_core *core,
>  					   struct clk_rate_request *req)
>  {
> @@ -1725,6 +1777,30 @@ int clk_hw_get_parent_index(struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
>  
> +static void clk_core_hold_state(struct clk_core *core)
> +{
> +	if (core->need_sync || !core->boot_enabled)
> +		return;
> +
> +	if (core->orphan || !dev_has_sync_state(core->dev))
> +		return;
> +
> +	core->need_sync = !clk_core_prepare_enable(core);
> +}
> +
> +static void __clk_core_update_orphan_hold_state(struct clk_core *core)
> +{
> +	struct clk_core *child;
> +
> +	if (core->orphan)
> +		return;
> +
> +	clk_core_hold_state(core);
> +
> +	hlist_for_each_entry(child, &core->children, child_node)
> +		__clk_core_update_orphan_hold_state(child);
> +}
> +
>  /*
>   * Update the orphan status of @core and all its children.
>   */
> @@ -3392,6 +3468,7 @@ static void clk_core_reparent_orphans_nolock(void)
>  			__clk_set_parent_after(orphan, parent, NULL);
>  			__clk_recalc_accuracies(orphan);
>  			__clk_recalc_rates(orphan, 0);
> +			__clk_core_update_orphan_hold_state(orphan);
>  		}
>  	}
>  }
> @@ -3550,6 +3627,8 @@ static int __clk_core_init(struct clk_core *core)
>  		rate = 0;
>  	core->rate = core->req_rate = rate;
>  
> +	core->boot_enabled = clk_core_is_enabled(core);
> +
>  	/*
>  	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>  	 * don't get accidentally disabled when walking the orphan tree and
> @@ -3572,6 +3651,7 @@ static int __clk_core_init(struct clk_core *core)
>  		}
>  	}
>  
> +	clk_core_hold_state(core);

Sorry for bringing up this old thread. Per your suggestion, I'm trying
to respin this patchset.

The problem with this approach is that it re-enables 'boot enabled'
clocks on init. This messes up the clock slice for uart, for example.
More so, think what happens with PLLs that need to lock again or clocks
for which writing the enable bit again require some time to become
stable again.

As a whole, I believe this patchset looks good, but the re-enabling
needs to be dropped.

>  	clk_core_reparent_orphans_nolock();
>  
>  
> @@ -3837,8 +3917,10 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>  		core->rpm_enabled = true;
>  	core->dev = dev;
>  	core->of_node = np;
> -	if (dev && dev->driver)
> +	if (dev && dev->driver) {
>  		core->owner = dev->driver->owner;
> +		dev_set_drv_sync_state(dev, clk_sync_state);
> +	}
>  	core->hw = hw;
>  	core->flags = init->flags;
>  	core->num_parents = init->num_parents;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 58f6fe866ae9..429c413dadce 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1112,6 +1112,7 @@ void devm_clk_unregister(struct device *dev, struct clk *clk);
>  
>  void clk_hw_unregister(struct clk_hw *hw);
>  void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
> +void clk_sync_state(struct device *dev);
>  
>  /* helper functions */
>  const char *__clk_get_name(const struct clk *clk);
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
> 
