Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD5737268
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjFTRNI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFTRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:13:06 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C49C10E2;
        Tue, 20 Jun 2023 10:13:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94ea38c90ccso150016366b.1;
        Tue, 20 Jun 2023 10:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281184; x=1689873184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wpSEuA3rvhtFPmWePbVbFfYSViTlY0ARfPzV78qlSI=;
        b=fGpHMn6gMeGt5GHwp3S7yFkxbGl8RC3lKJL4yaWadkJlSIZ5GEWE/Xpi/C0brDfoVS
         kefo9fTkv2DI65Xc8E0N9jy237cbcFG/WEfu595fPIHjQVXj2tfi18hpRGINnNDyCQFi
         fiHCB2jsKygYHI+xMTnbxqKDavvF2X9/cqxdCNgJIx/oc5P/QTMgcIso11W0Vq3wIvqP
         3wMTGykuNB6zcoyJSzA7G2O62UuA5hr7ZpYavC8ntXExazu907cAt7AbXnHXmINyFw0R
         XeC7qumeJxEwl8Ya+ZPu3FjcW3+pSnz687dTpFUNedi2y0Bp0by6xIuLA/nVkdsuuR3C
         Q0Kw==
X-Gm-Message-State: AC+VfDyvkd5hLlrXdzWVpUxptEV/DCzRdXk5AoCTpIxUjNtv/54I8L13
        Y8JMgLw2baaby+ar+YQh8f1NeAybkgk66v3B8qx7nDi4
X-Google-Smtp-Source: ACHHUZ5Cp5VAoojuV31TdQKDdiFw4tokCaWIr0LxImR2c45d0B43ugelgE4B3SQphadMWv1xWpva89hY+8QNPm4OlTM=
X-Received: by 2002:a17:906:77ca:b0:989:1ed3:d010 with SMTP id
 m10-20020a17090677ca00b009891ed3d010mr2006867ejn.2.1687281183627; Tue, 20 Jun
 2023 10:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org> <20230519032719.2581689-3-evalenti@kernel.org>
In-Reply-To: <20230519032719.2581689-3-evalenti@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:12:52 +0200
Message-ID: <CAJZ5v0hqGg9h+iOpKDLr=BXGk3p6sBTMM3nVok97yhRj5EdQ3g@mail.gmail.com>
Subject: Re: [PATCH 2/7] thermal: stats: track number of change requests due
 to tz
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> From: Eduardo Valentin <eduval@amazon.com>
>
> This patch improves the current cooling device
> statistics by adding a new file under
> cdev/stats/requests_of_thermal_zone
>
> to represent the number of times each thermal zone
> requested the cooling device to effectively change.
> If the request associated was not serviced because
> another thermal zone asked for a higher cooling level,
> this counter does not increase.

What if the cdev is associated with two thermal zones asking for the
same state of it?

> The file format is:
> thermal_zone: <type> <count>
>
> Samples:
> $ cat cdev0/stats/requests_of_thermal_zone
> thermal_zone: amb0      2

The "one value per attribute" sysfs rule violation.

>
> In this example, it means the thermal zone 'amb0' has requested
> 2 times for cdev0 to change state.

Like in the previous patch, it would be good to explain the use case.

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
> ---
>  .../driver-api/thermal/sysfs-api.rst          |  2 +
>  drivers/thermal/thermal_core.h                |  1 +
>  drivers/thermal/thermal_sysfs.c               | 52 +++++++++++++++++++
>  3 files changed, 55 insertions(+)
>
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index caa50d61a5bc..75309a51d9b3 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -369,6 +369,8 @@ Thermal cooling device sys I/F, created once it's registered::
>      |---stats/trans_table:     Cooling state transition table
>      |---stats/time_in_thermal_zone_ms: Time that this cooling device was driven
>                                  each associated thermal zone.
> +    |---stats/requests_of_thermal_zone:        Total number of times this cooling device
> +                                changed due to each associated thermal zone.

The meaning of the above description is not clear to me.

>
>
>  Then next two dynamic attributes are created/removed in pairs. They represent
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 3cce60c6e065..ed6511c3b794 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -103,6 +103,7 @@ struct thermal_instance {
>         unsigned int weight; /* The weight of the cooling device */
>         bool upper_no_limit;
>  #if IS_ENABLED(CONFIG_THERMAL_STATISTICS)
> +       unsigned long total_requests;
>         ktime_t time_in; /* time spent in this instance */
>  #endif
>  };
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index a3b71f03db75..0bce1415f7e8 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -723,6 +723,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>         stats->trans_table[stats->state * (cdev->max_state + 1) + new_state]++;
>         stats->state = new_state;
>         stats->total_trans++;
> +       stats->curr_instance->total_requests++;
>
>  unlock:
>         spin_unlock(&stats->lock);
> @@ -867,6 +868,54 @@ time_in_thermal_zone_ms_show(struct device *dev, struct device_attribute *attr,
>         return ret < 0 ? ret : len;
>  }
>
> +static ssize_t
> +requests_of_thermal_zone_show(struct device *dev, struct device_attribute *attr,
> +                             char *buf)
> +{
> +       LIST_HEAD(cdev_thermal_zone_list);
> +       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> +       struct cooling_dev_stats *stats = cdev->stats;
> +       struct cdev_thermal_zone_residency *res, *next;
> +       struct thermal_instance *instance;
> +       ssize_t len = 0, ret = 0;
> +
> +       mutex_lock(&cdev->lock);
> +
> +       spin_lock(&stats->lock);
> +       update_time_in_state(stats, stats->curr_instance);
> +       spin_unlock(&stats->lock);
> +
> +       build_cdev_thermal_zone_residency(&cdev_thermal_zone_list, cdev);
> +
> +       list_for_each_entry(instance, &cdev->thermal_instances, cdev_node)
> +               list_for_each_entry(res, &cdev_thermal_zone_list, node)
> +                       if (strncmp(res->thermal_zone, instance->tz->type,
> +                                   THERMAL_NAME_LENGTH) == 0)
> +                               res->counter += instance->total_requests;
> +
> +       mutex_unlock(&cdev->lock);
> +
> +       list_for_each_entry_safe(res, next, &cdev_thermal_zone_list, node) {

Why is the _safe variant needed here?

> +               ret = sprintf(buf + len, "thermal_zone: %s\t%lu\n",
> +                             res->thermal_zone, res->counter);
> +
> +               if (ret == 0)
> +                       ret = -EOVERFLOW;
> +
> +               if (ret < 0)
> +                       break;
> +
> +               len += ret;
> +       }
> +
> +       list_for_each_entry_safe(res, next, &cdev_thermal_zone_list, node) {
> +               list_del(&res->node);
> +               kfree(res);
> +       }
> +
> +       return ret < 0 ? ret : len;

I would prefer

if (ret < 0)
        return ret;

return len;

> +}
> +
>  static ssize_t
>  reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
>             size_t count)
> @@ -897,6 +946,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
>
>         /* Make sure we reset all counters per instance */
>         list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
> +               instance->total_requests = 0;
>                 instance->time_in = ktime_set(0, 0);
>         }
>
> @@ -971,6 +1021,7 @@ static ssize_t trans_table_show(struct device *dev,
>  static DEVICE_ATTR_RO(total_trans);
>  static DEVICE_ATTR_RO(time_in_state_ms);
>  static DEVICE_ATTR_RO(time_in_thermal_zone_ms);
> +static DEVICE_ATTR_RO(requests_of_thermal_zone);
>  static DEVICE_ATTR_WO(reset);
>  static DEVICE_ATTR_RO(trans_table);
>
> @@ -978,6 +1029,7 @@ static struct attribute *cooling_device_stats_attrs[] = {
>         &dev_attr_total_trans.attr,
>         &dev_attr_time_in_state_ms.attr,
>         &dev_attr_time_in_thermal_zone_ms.attr,
> +       &dev_attr_requests_of_thermal_zone.attr,
>         &dev_attr_reset.attr,
>         &dev_attr_trans_table.attr,
>         NULL
> --
