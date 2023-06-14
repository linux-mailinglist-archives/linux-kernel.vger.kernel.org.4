Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB37672FED0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbjFNMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbjFNMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:34:40 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117A26A4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:34:15 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-56d1ca11031so6945717b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686746054; x=1689338054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AmaCG8wwkPgqKuy/gWiutPSgcWxKbYO9M1ONN9J1v+g=;
        b=jjd4xAK8n4pf0djwvRf5YCsMafONwk+2eU3ZK0GN+dgzSF9TQ26mCZxJfZuDyrtV+M
         uVw7K369kgZovOdbdkhHiic51pCUBM8kykif3ilDYx9uVdzsty1ovEUClzey5tL17YMF
         lMkntonM4fyD/0MoUkUp4ikKbB+TX1EZPezkQBItp8KojDocR6vpVRmRA8XAL4T7Xb/b
         SmAblZvq6gCKc8AoYUT2m0eUrs74PUizKYlhFlAMon2Zr0l3e4BYvJOQlL8xhM/0+hXc
         BuKXF5p5DYKsUIVL2nqGNrG7RX6KAh8UrCisEHU1XVgGjrajKQsq7AthU+daN2UG1a7l
         6b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746054; x=1689338054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmaCG8wwkPgqKuy/gWiutPSgcWxKbYO9M1ONN9J1v+g=;
        b=MyTRYuitso9sVmEDiQZM5uiELd+TZofg5CKrtU17fe3QKcTIDd95uNsUxcAlT0KNcO
         paf2HOEz1tFzMOSgXJI548onvPWy/7AEfkCm0v81+BMXyrowqh4BOeUmOK3bkP7txW6Z
         qPN284qgCUvl1thjstPP+pl9vjp2UV/O2w40KwOe4Um71HOIVbdFq2lDs+Dfrb0VAAa+
         z6xm5KryVzZC5zABZSWOwbYMBm5/T22USn3X1QZmTwfdct3ItebmiomVSXbnVUu/NnaI
         1gjPQ8c/Z/OtHNWygqzoFcWJYp2pM/yT0WpDuI+6C9ZVn2GwfLMJZING+OzQm3DCB2I1
         WDWw==
X-Gm-Message-State: AC+VfDxWBNEy0lrPQdD1ZY6nXZuPywaoRDzUMnfCbaDHX0LgipEllzcv
        QqhFMCOqLmJFFzRXvPpIVRuOO4VyVWSIaps9/pabEQ==
X-Google-Smtp-Source: ACHHUZ7TowxaGnMjVfEzcInM3wJF5eRSh+d3y888fZ12Kw8EYEVPfJtUseNdJ6ndPtgacp3mgGVHf+9l6hHIfpL5eXE=
X-Received: by 2002:a25:504b:0:b0:b6e:8979:2f58 with SMTP id
 e72-20020a25504b000000b00b6e89792f58mr1760805ybb.63.1686746054071; Wed, 14
 Jun 2023 05:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
In-Reply-To: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 14:33:38 +0200
Message-ID: <CAPDyKFoXW65mzNnuZD+Zcjg6dTdWWNqOO6TB+685EAG1x9P8iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: pstate is only valid for genpd OPP tables
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 at 12:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> It is not very clear right now that the `pstate` field is only valid for
> genpd OPP tables and not consumer tables. And there is no checking for
> the same at various places.
>
> Add checks in place to verify that and make it clear to the reader.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Yes, this makes the code more clear!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/opp/core.c    | 18 ++++++++++++++++--
>  drivers/opp/debugfs.c |  4 +++-
>  drivers/opp/of.c      |  6 ++++++
>  3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7290168ec806..bfb012f5383c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -227,16 +227,24 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
>  unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
>                                             unsigned int index)
>  {
> +       struct opp_table *opp_table = opp->opp_table;
> +
>         if (IS_ERR_OR_NULL(opp) || !opp->available ||
> -           index >= opp->opp_table->required_opp_count) {
> +           index >= opp_table->required_opp_count) {
>                 pr_err("%s: Invalid parameters\n", __func__);
>                 return 0;
>         }
>
>         /* required-opps not fully initialized yet */
> -       if (lazy_linking_pending(opp->opp_table))
> +       if (lazy_linking_pending(opp_table))
>                 return 0;
>
> +       /* The required OPP table must belong to a genpd */
> +       if (unlikely(!opp_table->required_opp_tables[index]->is_genpd)) {
> +               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
> +               return 0;
> +       }
> +
>         return opp->required_opps[index]->pstate;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_required_pstate);
> @@ -2686,6 +2694,12 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         int dest_pstate = -EINVAL;
>         int i;
>
> +       /* Both OPP tables must belong to genpds */
> +       if (unlikely(!src_table->is_genpd || !dst_table->is_genpd)) {
> +               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
> +               return -EINVAL;
> +       }
> +
>         /*
>          * Normally the src_table will have the "required_opps" property set to
>          * point to one of the OPPs in the dst_table, but in some cases the
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 2c7fb683441e..0cc21e2b42ff 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -152,11 +152,13 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>         debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic);
>         debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo);
>         debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
> -       debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
>         debugfs_create_u32("level", S_IRUGO, d, &opp->level);
>         debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
>                              &opp->clock_latency_ns);
>
> +       if (opp_table->is_genpd)
> +               debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
> +
>         opp->of_name = of_node_full_name(opp->np);
>         debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 943c7fb7402b..e23ce6e78eb6 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1392,6 +1392,12 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
>                 goto put_required_np;
>         }
>
> +       /* The OPP tables must belong to a genpd */
> +       if (unlikely(!opp_table->is_genpd)) {
> +               pr_err("%s: Performance state is only valid for genpds.\n", __func__);
> +               goto put_required_np;
> +       }
> +
>         opp = _find_opp_of_np(opp_table, required_np);
>         if (opp) {
>                 pstate = opp->pstate;
> --
> 2.31.1.272.g89b43f80a514
>
