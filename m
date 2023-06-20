Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B078173728C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFTRR3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjFTRRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:17:25 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777E1710;
        Tue, 20 Jun 2023 10:17:22 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-987f13f8d21so106901966b.0;
        Tue, 20 Jun 2023 10:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281440; x=1689873440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCU3E02m6ju/0TXJ6baw1sJty3puMTXr+sZagM9mSPU=;
        b=hA3s7NUXyX2T1a5g49xLCh6vkHJyqL9oK3UXSdVIXOQqcr8IxWR2qCgUO2Mi5qBsf0
         m5zneaJkCSjPrL4c4fFb2FGCdb32UyuTekazzxEYhKcARX4uO1RnG1XI8C+fYEx+yzms
         GbqKo4HD4pxrU6UvP8DjwFJgVakfEMCQRM2ULZK7VVMnrUiSLpFMQjRfHCdct4wtebcT
         n3qItkGsuq+YMaOlz/cjLRSjX8PUT1j9anKLwuXxxFEb8hveaR1JcIwDhnKxXVD0NaPr
         N9gdwymS5llS720jMNdK9ci43WYSypdZksVaG9H2524e/AUCdL1z/2C9XqCFG58hAr2U
         f05g==
X-Gm-Message-State: AC+VfDziUo+EKesPZ7jPLYq1hfbAvxU8W6ivbVOonR3igXTqZMWWQYQf
        9nSMYW4T2UmkgcwA2UPDc8u27Ou7ZWnI4m8InAQ=
X-Google-Smtp-Source: ACHHUZ7Er9JkdZMGk9wrHGUnyshKtbpIg5WLO6EtfUQI2HZ/BkLmDgcCZNRPgohpa+k9Zi/YlpOaEkQU8ICt6ZP+Fbo=
X-Received: by 2002:a17:906:7a52:b0:988:9dea:ab9c with SMTP id
 i18-20020a1709067a5200b009889deaab9cmr4817988ejo.1.1687281440413; Tue, 20 Jun
 2023 10:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org> <20230519032719.2581689-5-evalenti@kernel.org>
In-Reply-To: <20230519032719.2581689-5-evalenti@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:17:09 +0200
Message-ID: <CAJZ5v0iSgC4LQMX6XsquaVbFX30SArfWGYtNGXsLaet00kzknw@mail.gmail.com>
Subject: Re: [PATCH 4/7] thermal: stats: introduce thermal zone stats/min_gradient
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> From: Eduardo Valentin <eduval@amazon.com>
>
> The patch adds a statistic to track
> the minimum gradient (dT/dt) to the thermal zone
> stats/ folder.
>
> Samples:
>
> $ echo 1000 > emul_temp
> $ cat stats/min_gradient
> 0
> $ echo 2000 > emul_temp
> $ echo 1000 > emul_temp
> $ cat stats/min_gradient
> -3460
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> Cc: linux-kernel@vger.kernel.org (open list)
>
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>

This can be easily folded into the previous patch IMO.

> ---
>  .../driver-api/thermal/sysfs-api.rst          |  1 +
>  drivers/thermal/thermal_sysfs.c               | 23 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index 18140dbb1ce1..ed5e6ba4e0d7 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -358,6 +358,7 @@ Thermal zone device sys I/F, created once it's registered::
>      |---stats:                 Directory containing thermal zone device's stats
>      |---stats/reset_tz_stats:  Writes to this file resets the statistics.
>      |---stats/max_gradient:    The maximum recorded dT/dt in uC/ms.
> +    |---stats/min_gradient:    The minimum recorded dT/dt in uC/ms.
>
>  Thermal cooling device sys I/F, created once it's registered::
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa28c1cae916..f89ec9a7e8c8 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -542,6 +542,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
>  struct thermal_zone_device_stats {
>         spinlock_t lock; /* protects this struct */
>         s64 max_gradient;
> +       s64 min_gradient;
>         ktime_t last_time;
>  };
>
> @@ -569,6 +570,10 @@ static void temperature_stats_update(struct thermal_zone_device *tz)
>         /* update fastest temperature rise from our perspective */
>         if (cur_gradient > stats->max_gradient)
>                 stats->max_gradient = cur_gradient;
> +
> +       /* update fastest temperature decay from our perspective */
> +       if (cur_gradient < stats->min_gradient)
> +               stats->min_gradient = cur_gradient;
>  }
>
>  void thermal_zone_device_stats_update(struct thermal_zone_device *tz)
> @@ -595,6 +600,21 @@ static ssize_t max_gradient_show(struct device *dev,
>         return ret;
>  }
>
> +static ssize_t min_gradient_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
> +{
> +       struct thermal_zone_device *tz = to_thermal_zone(dev);
> +       struct thermal_zone_device_stats *stats = tz->stats;
> +       int ret;
> +
> +       spin_lock(&stats->lock);
> +       temperature_stats_update(tz);
> +       ret = snprintf(buf, PAGE_SIZE, "%lld\n", stats->min_gradient);
> +       spin_unlock(&stats->lock);
> +
> +       return ret;
> +}
> +
>  static ssize_t
>  reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
>                      const char *buf, size_t count)
> @@ -604,6 +624,7 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
>
>         spin_lock(&stats->lock);
>
> +       stats->min_gradient = 0;
>         stats->max_gradient = 0;
>         stats->last_time = ktime_get();
>
> @@ -612,10 +633,12 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
>         return count;
>  }
>
> +static DEVICE_ATTR_RO(min_gradient);
>  static DEVICE_ATTR_RO(max_gradient);
>  static DEVICE_ATTR_WO(reset_tz_stats);
>
>  static struct attribute *thermal_zone_device_stats_attrs[] = {
> +       &dev_attr_min_gradient.attr,
>         &dev_attr_max_gradient.attr,
>         &dev_attr_reset_tz_stats.attr,
>         NULL
> --
> 2.34.1
>
