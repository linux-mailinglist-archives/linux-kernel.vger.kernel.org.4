Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D3656E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiL0TQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiL0TQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:16:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDDCED
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:16:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso6690632wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHHYbF8blZApfLt2s5oK0ienPE3LfV9SI3YQCg0fjFc=;
        b=MV3RSSZ7d21P50o6EhCPIHZBKPvMdWC+6QLgxA9vcvpiLQWYO/A4pAaG4prJvdvIrF
         NynBGDAD9F3HBv1OKyqd8uiCnbq61ORomCqwLnH5vFmfyyk6YlzK0w6Wr7bRhb7nJMR1
         Oorf20wt2iLd0I+cD+iB57mpLiIwXeyvDOs4EIO/E+YBxA8KFdR9kbDkyWdgCxYuEOgY
         9GYdA6pZR6Xei0FtxQ8B1HMACZpedptvZh30oKIMJ35FG8bCtd63pmYeCDZceCTmui3+
         lSerD0zEWzzYMCKACJ5nxtKzx4gvVfJFf8AqCbX78GVpGZpUlQlfXBSfKRsSfsHN7lfO
         PcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHHYbF8blZApfLt2s5oK0ienPE3LfV9SI3YQCg0fjFc=;
        b=BU+o/mnpms/2gSYFH6dAoypMcaksm/oBliPH9OGQ1tZ8Ujn5OuTfivc/4dGoLqYwSd
         9UMtq01aaovkMsg+lHEwJKc+9ZgN3LDpGWB9WI5Pwccov5c5LkaeUUYFn6uCQYCm9B4+
         U2qKo4ZGiSrHssuNw4TfxyA8KVzxGO1nV4Jj14ME2z4Ar6GMTaEgjLTOJrFWlLZtrZxt
         oifJKlzfO/JzSQJovm9yuI6Keh9DJrrSCBoBBN+Mu94nHrVXnR8Heml/xOJB0Pxt42zR
         /BLeUZ1Tf1kmAhDkeZbHJzfn17KI2UcEjnHphNh53XJgN7+nn5baA/SmjChn8rDDvNmK
         GkNA==
X-Gm-Message-State: AFqh2kovjR5Oqh8YfLAqrhzuQVoMi8KaAJPntVCb1lRIPDVBRZs633tu
        +0yovVkIo4jdmm3/Nds006TfpQ==
X-Google-Smtp-Source: AMrXdXtO1lV7/QQ0LfTBYOaeR46HZiiKlkeog7cuHWpdZwfdG+uYUPASn1BOE3cXW0aEkZq/9mWoOw==
X-Received: by 2002:a05:600c:41c2:b0:3d3:5565:3617 with SMTP id t2-20020a05600c41c200b003d355653617mr19140428wmh.24.1672168600282;
        Tue, 27 Dec 2022 11:16:40 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n7-20020a1c7207000000b003cf6a55d8e8sm17856559wmc.7.2022.12.27.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 11:16:39 -0800 (PST)
Date:   Tue, 27 Dec 2022 21:16:38 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <Y6tElj1qVq2jXAxu@linaro.org>
References: <20221225164705.437944-1-abel.vesa@linaro.org>
 <CAA8EJpq0Ea_CEyRXwzoNmyoj7R3nzCpr0nVADB-koo6BTTLuiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpq0Ea_CEyRXwzoNmyoj7R3nzCpr0nVADB-koo6BTTLuiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-26 02:54:22, Dmitry Baryshkov wrote:
> On Sun, 25 Dec 2022 at 18:47, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > There are unused clocks that need to remain untouched by clk_disable_unused,
> > and most likely could be disabled later on sync_state. So provide a generic
> > sync_state callback for the clock providers that register such clocks.
> > Then, use the same mechanism as clk_disable_unused from that generic
> > callback, but pass the device to make sure only the clocks belonging to
> > the current clock provider get disabled, if unused. Also, during the
> > default clk_disable_unused, if the driver that registered the clock has
> > the generic clk_sync_state_disable_unused callback set for sync_state,
> > skip disabling its clocks.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >
> > Changes since v1:
> >  * Dropped the 0 returned by __clk_disable_unused when clk_ignore_unused
> >    is set.
> >  * Dropped __initdata for clk_ignore_unused
> >
> >  drivers/clk/clk.c            | 59 +++++++++++++++++++++++++++++-------
> >  include/linux/clk-provider.h |  1 +
> >  2 files changed, 49 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index e62552a75f08..5185b857fc65 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1302,14 +1302,27 @@ static void clk_core_disable_unprepare(struct clk_core *core)
> >         clk_core_unprepare_lock(core);
> >  }
> >
> > -static void __init clk_unprepare_unused_subtree(struct clk_core *core)
> > +static void clk_unprepare_unused_subtree(struct clk_core *core,
> > +                                               struct device *dev)
> >  {
> > +       bool from_sync_state = !!dev;
> >         struct clk_core *child;
> >
> >         lockdep_assert_held(&prepare_lock);
> >
> >         hlist_for_each_entry(child, &core->children, child_node)
> > -               clk_unprepare_unused_subtree(child);
> > +               clk_unprepare_unused_subtree(child, dev);
> > +
> > +       if (from_sync_state && core->dev != dev)
> > +               return;
> > +
> > +       /*
> > +        * clock will be unprepared on sync_state,
> > +        * so leave as is for now
> > +        */
> > +       if (!from_sync_state && dev_has_sync_state(core->dev) &&
> > +               core->dev->driver->sync_state == clk_sync_state_disable_unused)
> 
> I link the overall approach, but I don't think we should check the
> sync_state function.
> Such a check would disallow a driver to wrap the
> clk_sync_state_disable_unused() into some driver-specific code.

OK, will drop it and resend.

> 
> > +               return;
> >
> >         if (core->prepare_count)
> >                 return;
> > @@ -1332,15 +1345,28 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
> >         clk_pm_runtime_put(core);
> >  }
> >
> > -static void __init clk_disable_unused_subtree(struct clk_core *core)
> > +static void clk_disable_unused_subtree(struct clk_core *core,
> > +                                       struct device *dev)
> >  {
> > +       bool from_sync_state = !!dev;
> >         struct clk_core *child;
> >         unsigned long flags;
> >
> >         lockdep_assert_held(&prepare_lock);
> >
> >         hlist_for_each_entry(child, &core->children, child_node)
> > -               clk_disable_unused_subtree(child);
> > +               clk_disable_unused_subtree(child, dev);
> > +
> > +       if (from_sync_state && core->dev != dev)
> > +               return;
> > +
> > +       /*
> > +        * clock will be disabled on sync_state,
> > +        * so leave as is for now
> > +        */
> > +       if (!from_sync_state &&
> > +               core->dev->driver->sync_state == clk_sync_state_disable_unused)
> > +               return;
> >
> >         if (core->flags & CLK_OPS_PARENT_ENABLE)
> >                 clk_core_prepare_enable(core->parent);
> > @@ -1378,7 +1404,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
> >                 clk_core_disable_unprepare(core->parent);
> >  }
> >
> > -static bool clk_ignore_unused __initdata;
> > +static bool clk_ignore_unused;
> >  static int __init clk_ignore_unused_setup(char *__unused)
> >  {
> >         clk_ignore_unused = true;
> > @@ -1386,35 +1412,46 @@ static int __init clk_ignore_unused_setup(char *__unused)
> >  }
> >  __setup("clk_ignore_unused", clk_ignore_unused_setup);
> >
> > -static int __init clk_disable_unused(void)
> > +static void __clk_disable_unused(struct device *dev)
> >  {
> >         struct clk_core *core;
> >
> >         if (clk_ignore_unused) {
> >                 pr_warn("clk: Not disabling unused clocks\n");
> > -               return 0;
> > +               return;
> >         }
> >
> >         clk_prepare_lock();
> >
> >         hlist_for_each_entry(core, &clk_root_list, child_node)
> > -               clk_disable_unused_subtree(core);
> > +               clk_disable_unused_subtree(core, dev);
> >
> >         hlist_for_each_entry(core, &clk_orphan_list, child_node)
> > -               clk_disable_unused_subtree(core);
> > +               clk_disable_unused_subtree(core, dev);
> >
> >         hlist_for_each_entry(core, &clk_root_list, child_node)
> > -               clk_unprepare_unused_subtree(core);
> > +               clk_unprepare_unused_subtree(core, dev);
> >
> >         hlist_for_each_entry(core, &clk_orphan_list, child_node)
> > -               clk_unprepare_unused_subtree(core);
> > +               clk_unprepare_unused_subtree(core, dev);
> >
> >         clk_prepare_unlock();
> > +}
> > +
> > +static int __init clk_disable_unused(void)
> > +{
> > +       __clk_disable_unused(NULL);
> >
> >         return 0;
> >  }
> >  late_initcall_sync(clk_disable_unused);
> >
> > +void clk_sync_state_disable_unused(struct device *dev)
> > +{
> > +       __clk_disable_unused(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(clk_sync_state_disable_unused);
> > +
> >  static int clk_core_determine_round_nolock(struct clk_core *core,
> >                                            struct clk_rate_request *req)
> >  {
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 842e72a5348f..cf1adfeaf257 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
> >                 void __iomem *reg, u8 shift, u8 width,
> >                 u8 clk_divider_flags, const struct clk_div_table *table,
> >                 spinlock_t *lock);
> > +void clk_sync_state_disable_unused(struct device *dev);
> >  /**
> >   * clk_register_divider - register a divider clock with the clock framework
> >   * @dev: device registering this clock
> > --
> > 2.34.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry
