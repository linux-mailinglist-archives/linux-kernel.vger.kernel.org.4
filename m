Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3C655EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 01:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiLZAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 19:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLZAyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 19:54:36 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97716E7F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 16:54:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i186so10518477ybc.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 16:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EySMm2yHyan1KtzkpjHPhtjwc1DPUZ8nt91Q3dCNhcU=;
        b=LKOMKPU36QHeSUEzwm0YnSwrR/M/z7XkhBb/M89D8iZEkfAq5La/EeWAh8tCQrsIlc
         863aMtRg6szyzyK2b3GsO2KFxUYkBlyRKkHEPXjHR8kW0+cYANuwW64sLtfIUmUeIqB0
         xOVUXGNF+hN3T5QVSEGBSGFsxUBWEhCfKVUuUGPRETunXA6uTzlHhkzWCZcBirWWwLnG
         WOx+h1mD4Vtf1QrYxIPTCJKioSSZOgmpEcObJrMczToe30WAFcbRMHbRLpVfUR2fJHh4
         8lqvAX3gxpCPCxxYEkbxx2Cd16cgLZF6bp9ovobsZsUpbvPBEhWRy42cY7wmCDVvQl9c
         O8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EySMm2yHyan1KtzkpjHPhtjwc1DPUZ8nt91Q3dCNhcU=;
        b=TGQhRLYsCiri9704fKIqcLwkIGD/slYirbw3rANxmlq+dV4w6o7QcOL+Z6bsWak+2U
         6984e8JYI6RLpftWJODE2+PS6oyJPagR58jtWrzUGJFjQt/hWeKoHZza2TwGItnZWdcL
         CnooShWuBI+5OCh5AhyWtEpSzUSCbjhV5GyloibyG36Q9F4uKq9PtX1Y9XB2poP6qpHu
         S4wlwBR0ktdSj4VgOEDYCeD2NpAroIkqHxaQQWDKkU4ZcoOsR2pwg+lxf0YRQdB8ZIcz
         ydvtCgxj10oCPhA5HuB/Rc014WYwDCTkODw2w2ixuiU+qgS8DpFLItvCuYEm/j6PqKmw
         +gTg==
X-Gm-Message-State: AFqh2kohXhOVP0mshElW8HXoQbtsCmAZW2oYCSPjWh79U0r8uMiSxMk8
        uBfvFt4qx+kHMsrdGiCw8P4mTcSpk5+ePpC4nYqOOA==
X-Google-Smtp-Source: AMrXdXuaDdBwTwlYJ8bWHJ/ndwWneh+8NrkzyAvRsXYaOwNMwNB3Cy8b2+moM9/DiAoCBn5/yeLFWtZCR0G+y5pRg08=
X-Received: by 2002:a25:aa0d:0:b0:76d:bea0:8a05 with SMTP id
 s13-20020a25aa0d000000b0076dbea08a05mr856251ybi.153.1672016073586; Sun, 25
 Dec 2022 16:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20221225164705.437944-1-abel.vesa@linaro.org>
In-Reply-To: <20221225164705.437944-1-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 26 Dec 2022 02:54:22 +0200
Message-ID: <CAA8EJpq0Ea_CEyRXwzoNmyoj7R3nzCpr0nVADB-koo6BTTLuiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2022 at 18:47, Abel Vesa <abel.vesa@linaro.org> wrote:
>
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
> ---
>
> Changes since v1:
>  * Dropped the 0 returned by __clk_disable_unused when clk_ignore_unused
>    is set.
>  * Dropped __initdata for clk_ignore_unused
>
>  drivers/clk/clk.c            | 59 +++++++++++++++++++++++++++++-------
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e62552a75f08..5185b857fc65 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1302,14 +1302,27 @@ static void clk_core_disable_unprepare(struct clk_core *core)
>         clk_core_unprepare_lock(core);
>  }
>
> -static void __init clk_unprepare_unused_subtree(struct clk_core *core)
> +static void clk_unprepare_unused_subtree(struct clk_core *core,
> +                                               struct device *dev)
>  {
> +       bool from_sync_state = !!dev;
>         struct clk_core *child;
>
>         lockdep_assert_held(&prepare_lock);
>
>         hlist_for_each_entry(child, &core->children, child_node)
> -               clk_unprepare_unused_subtree(child);
> +               clk_unprepare_unused_subtree(child, dev);
> +
> +       if (from_sync_state && core->dev != dev)
> +               return;
> +
> +       /*
> +        * clock will be unprepared on sync_state,
> +        * so leave as is for now
> +        */
> +       if (!from_sync_state && dev_has_sync_state(core->dev) &&
> +               core->dev->driver->sync_state == clk_sync_state_disable_unused)

I link the overall approach, but I don't think we should check the
sync_state function.
Such a check would disallow a driver to wrap the
clk_sync_state_disable_unused() into some driver-specific code.

> +               return;
>
>         if (core->prepare_count)
>                 return;
> @@ -1332,15 +1345,28 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>         clk_pm_runtime_put(core);
>  }
>
> -static void __init clk_disable_unused_subtree(struct clk_core *core)
> +static void clk_disable_unused_subtree(struct clk_core *core,
> +                                       struct device *dev)
>  {
> +       bool from_sync_state = !!dev;
>         struct clk_core *child;
>         unsigned long flags;
>
>         lockdep_assert_held(&prepare_lock);
>
>         hlist_for_each_entry(child, &core->children, child_node)
> -               clk_disable_unused_subtree(child);
> +               clk_disable_unused_subtree(child, dev);
> +
> +       if (from_sync_state && core->dev != dev)
> +               return;
> +
> +       /*
> +        * clock will be disabled on sync_state,
> +        * so leave as is for now
> +        */
> +       if (!from_sync_state &&
> +               core->dev->driver->sync_state == clk_sync_state_disable_unused)
> +               return;
>
>         if (core->flags & CLK_OPS_PARENT_ENABLE)
>                 clk_core_prepare_enable(core->parent);
> @@ -1378,7 +1404,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>                 clk_core_disable_unprepare(core->parent);
>  }
>
> -static bool clk_ignore_unused __initdata;
> +static bool clk_ignore_unused;
>  static int __init clk_ignore_unused_setup(char *__unused)
>  {
>         clk_ignore_unused = true;
> @@ -1386,35 +1412,46 @@ static int __init clk_ignore_unused_setup(char *__unused)
>  }
>  __setup("clk_ignore_unused", clk_ignore_unused_setup);
>
> -static int __init clk_disable_unused(void)
> +static void __clk_disable_unused(struct device *dev)
>  {
>         struct clk_core *core;
>
>         if (clk_ignore_unused) {
>                 pr_warn("clk: Not disabling unused clocks\n");
> -               return 0;
> +               return;
>         }
>
>         clk_prepare_lock();
>
>         hlist_for_each_entry(core, &clk_root_list, child_node)
> -               clk_disable_unused_subtree(core);
> +               clk_disable_unused_subtree(core, dev);
>
>         hlist_for_each_entry(core, &clk_orphan_list, child_node)
> -               clk_disable_unused_subtree(core);
> +               clk_disable_unused_subtree(core, dev);
>
>         hlist_for_each_entry(core, &clk_root_list, child_node)
> -               clk_unprepare_unused_subtree(core);
> +               clk_unprepare_unused_subtree(core, dev);
>
>         hlist_for_each_entry(core, &clk_orphan_list, child_node)
> -               clk_unprepare_unused_subtree(core);
> +               clk_unprepare_unused_subtree(core, dev);
>
>         clk_prepare_unlock();
> +}
> +
> +static int __init clk_disable_unused(void)
> +{
> +       __clk_disable_unused(NULL);
>
>         return 0;
>  }
>  late_initcall_sync(clk_disable_unused);
>
> +void clk_sync_state_disable_unused(struct device *dev)
> +{
> +       __clk_disable_unused(dev);
> +}
> +EXPORT_SYMBOL_GPL(clk_sync_state_disable_unused);
> +
>  static int clk_core_determine_round_nolock(struct clk_core *core,
>                                            struct clk_rate_request *req)
>  {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 842e72a5348f..cf1adfeaf257 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
>                 void __iomem *reg, u8 shift, u8 width,
>                 u8 clk_divider_flags, const struct clk_div_table *table,
>                 spinlock_t *lock);
> +void clk_sync_state_disable_unused(struct device *dev);
>  /**
>   * clk_register_divider - register a divider clock with the clock framework
>   * @dev: device registering this clock
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
