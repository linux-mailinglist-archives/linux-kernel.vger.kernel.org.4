Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CA72F8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbjFNJRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbjFNJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:17:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47281FC8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:17:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bd6446528dcso395879276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686734253; x=1689326253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTBVmOmDMzb6HOpg6itSeV5ALgSNkSQSXEOkc+hECJ8=;
        b=BB9fyBqmXlKZDGNoU7VNBFDrTJ46l95A4aSDynBQlfQwrIIb/XObfpZH8bWZltwpn4
         iCMJWJVPZs0mwYyN1FoOREZr6D4/A0xgewxT/lAACHKWra1NBmZZh32yLyjRDcH/cr6i
         gyj1oRwdQ0qNkQfDrnmputbtxN5selufbM3sR94Jd80HCMlmrAsPjD98hUzNqvCzhyNh
         Z/Ipm/wE7d6HJWGT9cCGgzdWtuyT7zNZDQhdpXGXLIx8xsHqwabioVkU1LD894/rN04p
         Xd0lWbeGaaplMeTLWHGWoLIS2om/niNhaPLsSU7x6w97gPat/IF3U63ltp8b1wf3pblX
         I2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734253; x=1689326253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTBVmOmDMzb6HOpg6itSeV5ALgSNkSQSXEOkc+hECJ8=;
        b=GiRzxhYH5w4cMX47x5w/gctgxwGsM7gS2eLnLcac3CQvt1QoXNYn9mPsp0xYGDhDZX
         juOzR8XIuZ8AXq3U1XmQ+uXKs9SWaep0lyqczNCsPDYyyyUmLKHCBF8qCQkMDNIdSxzP
         dsOx+xpMkTwC5YAEmjLIulc7y800D6veejiqG2ShLYK+3fu12B0JO9XtC1kZQPgl09vC
         ObGBlOnJs61LfNexXl1UNaFR5h5H/JoFjpAOrJgrbzmbGAdy8+yXfWtYvu+uvaDMgoki
         dsgrxxcuIhbqd2qUnTnFhUEidKkEQG6LKw0EsbdN9isWnbXoLKIidFYbjsKP+rHKerin
         Q4Ow==
X-Gm-Message-State: AC+VfDzELFB0bKGD6BbBmRBNskUncTnUGVYgdcSuPoqqjjWsPG/zrP8X
        BZ+Uppxotda+24ifzIyBiu6aYd74fvjiwUBIuFbsCg==
X-Google-Smtp-Source: ACHHUZ5K3Z1ZY2o1DME5MRP1AC+d8PZOTVwaEBC/JSKMbOui3OhK7Bm2pYMA5+S0TcqZAtYuucWIid+8eww9cMezAsc=
X-Received: by 2002:a25:d381:0:b0:bb1:6e29:a84d with SMTP id
 e123-20020a25d381000000b00bb16e29a84dmr1285988ybf.53.1686734253076; Wed, 14
 Jun 2023 02:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <8f4574ab6c334dfe1d76c567062e43d751af2457.1686729428.git.viresh.kumar@linaro.org>
In-Reply-To: <8f4574ab6c334dfe1d76c567062e43d751af2457.1686729428.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 11:16:56 +0200
Message-ID: <CAPDyKFprofLjxuBjF6HG8Ja3tG-d0YtAjFD2rPXEODcWxeX3_A@mail.gmail.com>
Subject: Re: [PATCH] OPP: don't drop performance constraint on OPP table removal
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 at 09:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This code was added (long back) by commit 009acd196fc8 ("PM / OPP:
> Support updating performance state of device's power domain") and at
> that time the `opp->pstate` field was used to store the performance
> state required by a device's OPP.
>
> Over time that changed and the `->pstate` field is now used only for
> genpd devices and consumer devices access that via the required-opps
> instead.
>
> Because of all these changes, _opp_table_kref_release() now drops the
> constraint only when the genpd's OPP table gets freed and not the
> device's. Which is definitely not what we wanted. And dropping the
> constraint doesn't have much meaning as the genpd itself is going away.
>
> Moreover, if we want to drop constraints here, then just dropping the
> performance constraint alone isn't sufficient as there are other
> resource constraints like clk, regulator, etc. too, which must be
> handled.
>
> Probably the right thing to do here is to leave this decision to the
> consumers, which can call `dev_pm_opp_set_rate(dev, 0)` or similar APIs
> to drop all constraints properly. Which many of the consumers already
> do.
>
> Remove the special code, which is broken anyway.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

One good step to clean up the mess. Thanks!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c | 10 +---------
>  drivers/opp/of.c   |  8 --------
>  drivers/opp/opp.h  |  2 --
>  3 files changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9f918077cd62..7290168ec806 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1522,16 +1522,8 @@ static void _opp_table_kref_release(struct kref *kref)
>
>         WARN_ON(!list_empty(&opp_table->opp_list));
>
> -       list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
> -               /*
> -                * The OPP table is getting removed, drop the performance state
> -                * constraints.
> -                */
> -               if (opp_table->genpd_performance_state)
> -                       dev_pm_genpd_set_performance_state((struct device *)(opp_dev->dev), 0);
> -
> +       list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node)
>                 _remove_opp_dev(opp_dev, opp_table);
> -       }
>
>         mutex_destroy(&opp_table->genpd_virt_dev_lock);
>         mutex_destroy(&opp_table->lock);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index ac2179d5da4c..943c7fb7402b 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1034,14 +1034,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>                 goto remove_static_opp;
>         }
>
> -       list_for_each_entry(opp, &opp_table->opp_list, node) {
> -               /* Any non-zero performance state would enable the feature */
> -               if (opp->pstate) {
> -                       opp_table->genpd_performance_state = true;
> -                       break;
> -               }
> -       }
> -
>         lazy_link_required_opp_table(opp_table);
>
>         return 0;
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index eb71385d96c1..3805b92a6100 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -182,7 +182,6 @@ enum opp_table_access {
>   * @paths: Interconnect path handles
>   * @path_count: Number of interconnect paths
>   * @enabled: Set to true if the device's resources are enabled/configured.
> - * @genpd_performance_state: Device's power domain support performance state.
>   * @is_genpd: Marks if the OPP table belongs to a genpd.
>   * @set_required_opps: Helper responsible to set required OPPs.
>   * @dentry:    debugfs dentry pointer of the real device directory (not links).
> @@ -233,7 +232,6 @@ struct opp_table {
>         struct icc_path **paths;
>         unsigned int path_count;
>         bool enabled;
> -       bool genpd_performance_state;
>         bool is_genpd;
>         int (*set_required_opps)(struct device *dev,
>                 struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
> --
> 2.31.1.272.g89b43f80a514
>
