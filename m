Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974346A6CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCANHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCANHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:07:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D81B2D7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:06:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so12201332pla.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NF6I37ZMXUZT2UAfhqZz45LoPVH4Elbw4xdIU+68u8Q=;
        b=UaYDQ4t4JxPnJkgU24ZAhgOpeh4qTF1dQDw+7OwLtO214cMzoEfEWv+eW20tNyhE4L
         yJSIz0na+KLfg2rEKU28yJHMI9VowIhmPeuDRLEv9t892DVUj+YMjA3sqRW/wVvYOpGM
         vNobgi5NuvtkqPFzgZb6LnotETc73PAp6Wqze2xSvXhT5QRQq3NtagUzKUS3QUPPTpWc
         NVz59WXQCW+/xwQEmmU2qWRIMdwmaEOetGaHhkwJRL/q4t3e72u6pHGa/eAaQqjKUOpH
         Zd7zs99siaMwPKnUOW1I2wTT98wyClaTZkQ4sPKfZWC8d7+58XxnzIeiSqzSaQY6cj11
         AKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF6I37ZMXUZT2UAfhqZz45LoPVH4Elbw4xdIU+68u8Q=;
        b=4xGsSfzBZH2BjFrhjhwKcboIqonBWN1JT11jDjTZzJH2H4G4G14G5ykD7+QIo9k4yj
         8IsTaqmzZa6kLuaRt3ChAJDUQY+7LVZC7IXDsoxm0BxTYiuIBA22RsEYfuNX9v8bBvdV
         GLeS4BjbdsYqyt7mLc0BmC9iismo1MA0RP/0MqmBPcJZrL89v1dw2EdZOVMNYqMmlhS0
         x1wQLwo6f6HU8T0K5PgKPNPpMGCo87wFywCmshnuO7QtAgkbVGisxNfWbCXsKwzHTnAY
         lNiAT0BtMwmgQPWsQhgszIeJHyA2qUTZ4oA1XfmvTvUgh6jbCcrSXikRYD3UNZSt4HiV
         okDg==
X-Gm-Message-State: AO0yUKWjeGS+B4FA4WJpxfvZ2eoVwGDSea95f8XaLl/Q+AM43Uahj5Ls
        5e2sLU2kVN3Jjk5/BMcAA4BcnE3ZGIuPlI14zC9IsA==
X-Google-Smtp-Source: AK7set9fZJ/p/mdPhK2VDCagbbzYdCfXTlz/obO2rxZsMgJMxfseSr3uIA3AHHZ2r+FKnSw84J/xGV01Zx8zuUA5vPg=
X-Received: by 2002:a17:903:1c9:b0:19c:b7da:d41f with SMTP id
 e9-20020a17090301c900b0019cb7dad41fmr2382739plh.11.1677676018573; Wed, 01 Mar
 2023 05:06:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677063656.git.viresh.kumar@linaro.org> <56b9926836652e9dbf56ca6b7628e836cddca351.1677063656.git.viresh.kumar@linaro.org>
In-Reply-To: <56b9926836652e9dbf56ca6b7628e836cddca351.1677063656.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Mar 2023 14:06:22 +0100
Message-ID: <CAPDyKFoQu1=XVCueOaUDgke3xdDy3bt9VRHPo2xdqkLbSbP8CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] OPP: Move required opps configuration to specialized callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 at 12:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The required-opps configuration is closely tied to genpd and performance
> states at the moment and it is not very obvious that required-opps can
> live without genpds. Though we don't support configuring required-opps
> for non-genpd cases currently.
>
> This commit aims at separating these parts, where configuring genpds
> would be a special case of configuring the required-opps.
>
> Add a specialized callback, set_required_opps(), to the opp table and
> set it to different callbacks accordingly.
>
> This shouldn't result in any functional changes for now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This looks reasonable to me, but I guess it also depends on whether
you will land patch3 or not?

Nevertheless, feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/opp/core.c | 69 ++++++++++++++++++++++++++++------------------
>  drivers/opp/of.c   |  3 ++
>  drivers/opp/opp.h  |  4 +++
>  3 files changed, 49 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 6d7016ce8c53..954c94865cf5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -935,8 +935,8 @@ static int _set_opp_bw(const struct opp_table *opp_table,
>         return 0;
>  }
>
> -static int _set_required_opp(struct device *dev, struct device *pd_dev,
> -                            struct dev_pm_opp *opp, int i)
> +static int _set_performance_state(struct device *dev, struct device *pd_dev,
> +                                 struct dev_pm_opp *opp, int i)
>  {
>         unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
>         int ret;
> @@ -953,33 +953,20 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
>         return ret;
>  }
>
> -/* This is only called for PM domain for now */
> -static int _set_required_opps(struct device *dev,
> -                             struct opp_table *opp_table,
> -                             struct dev_pm_opp *opp, bool up)
> +static int _opp_set_required_opps_generic(struct device *dev,
> +       struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
> +{
> +       dev_err(dev, "setting required-opps isn't supported for non-genpd devices\n");
> +       return -ENOENT;
> +}
> +
> +static int _opp_set_required_opps_genpd(struct device *dev,
> +       struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
>  {
> -       struct opp_table **required_opp_tables = opp_table->required_opp_tables;
>         struct device **genpd_virt_devs =
>                 opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
>         int i, ret = 0;
>
> -       if (!required_opp_tables)
> -               return 0;
> -
> -       /* required-opps not fully initialized yet */
> -       if (lazy_linking_pending(opp_table))
> -               return -EBUSY;
> -
> -       /*
> -        * We only support genpd's OPPs in the "required-opps" for now, as we
> -        * don't know much about other use cases. Error out if the required OPP
> -        * doesn't belong to a genpd.
> -        */
> -       if (unlikely(!required_opp_tables[0]->is_genpd)) {
> -               dev_err(dev, "required-opps don't belong to a genpd\n");
> -               return -ENOENT;
> -       }
> -
>         /*
>          * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
>          * after it is freed from another thread.
> @@ -987,15 +974,15 @@ static int _set_required_opps(struct device *dev,
>         mutex_lock(&opp_table->genpd_virt_dev_lock);
>
>         /* Scaling up? Set required OPPs in normal order, else reverse */
> -       if (up) {
> +       if (!scaling_down) {
>                 for (i = 0; i < opp_table->required_opp_count; i++) {
> -                       ret = _set_required_opp(dev, genpd_virt_devs[i], opp, i);
> +                       ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
>                         if (ret)
>                                 break;
>                 }
>         } else {
>                 for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
> -                       ret = _set_required_opp(dev, genpd_virt_devs[i], opp, i);
> +                       ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
>                         if (ret)
>                                 break;
>                 }
> @@ -1006,6 +993,34 @@ static int _set_required_opps(struct device *dev,
>         return ret;
>  }
>
> +/* This is only called for PM domain for now */
> +static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> +                             struct dev_pm_opp *opp, bool up)
> +{
> +       /* required-opps not fully initialized yet */
> +       if (lazy_linking_pending(opp_table))
> +               return -EBUSY;
> +
> +       if (opp_table->set_required_opps)
> +               return opp_table->set_required_opps(dev, opp_table, opp, up);
> +
> +       return 0;
> +}
> +
> +/* Update set_required_opps handler */
> +void _update_set_required_opps(struct opp_table *opp_table)
> +{
> +       /* Already set */
> +       if (opp_table->set_required_opps)
> +               return;
> +
> +       /* All required OPPs will belong to genpd or none */
> +       if (opp_table->required_opp_tables[0]->is_genpd)
> +               opp_table->set_required_opps = _opp_set_required_opps_genpd;
> +       else
> +               opp_table->set_required_opps = _opp_set_required_opps_generic;
> +}
> +
>  static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>  {
>         struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e55c6095adf0..93da3c797afc 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -196,6 +196,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>         /* Let's do the linking later on */
>         if (lazy)
>                 list_add(&opp_table->lazy, &lazy_opp_tables);
> +       else
> +               _update_set_required_opps(opp_table);
>
>         goto put_np;
>
> @@ -411,6 +413,7 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
>
>                 /* All required opp-tables found, remove from lazy list */
>                 if (!lazy) {
> +                       _update_set_required_opps(opp_table);
>                         list_del_init(&opp_table->lazy);
>
>                         list_for_each_entry(opp, &opp_table->opp_list, node)
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 3a6e077df386..2a057c42ddf4 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -184,6 +184,7 @@ enum opp_table_access {
>   * @enabled: Set to true if the device's resources are enabled/configured.
>   * @genpd_performance_state: Device's power domain support performance state.
>   * @is_genpd: Marks if the OPP table belongs to a genpd.
> + * @set_required_opps: Helper responsible to set required OPPs.
>   * @dentry:    debugfs dentry pointer of the real device directory (not links).
>   * @dentry_name: Name of the real dentry.
>   *
> @@ -234,6 +235,8 @@ struct opp_table {
>         bool enabled;
>         bool genpd_performance_state;
>         bool is_genpd;
> +       int (*set_required_opps)(struct device *dev,
> +               struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
>
>  #ifdef CONFIG_DEBUG_FS
>         struct dentry *dentry;
> @@ -257,6 +260,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cp
>  struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
>  void _put_opp_list_kref(struct opp_table *opp_table);
>  void _required_opps_available(struct dev_pm_opp *opp, int count);
> +void _update_set_required_opps(struct opp_table *opp_table);
>
>  static inline bool lazy_linking_pending(struct opp_table *opp_table)
>  {
> --
> 2.31.1.272.g89b43f80a514
>
