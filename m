Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36CB7372DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjFTR2o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFTR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:28:42 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E27198E;
        Tue, 20 Jun 2023 10:28:20 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98502b12fd4so146808466b.1;
        Tue, 20 Jun 2023 10:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282089; x=1689874089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQlXsYrTkFXO69Z3GZpG+j7FcAnDp1PsJvQS6+DCsQk=;
        b=hXPtMFqZsOxVNZM4/T2eYmSs3B26xoMf6lltnkLTnipeH+/RMklvlhRwQpEIuCoi3x
         JC2jz0L8YIVLtNexuH1+ebiCogy4mm31x5VTfbLaLanDmg4jg+KnatHzMFFwkh/f1Yy2
         0zPFqcyQnD140CmUcowt631+jKee2Rp37YoRgKk7zVPmarg+8/R7Pk3NOJE6ZbRfXEUN
         mxayP36SdtcowGwrWBE/wm+8ZAmFfviJzwbrV6uKC4OfYSTOYmSsVv8OUPIbgCJxiyjF
         QA2pWHmaUsOcE8HvbpC57IEWm09xHFSNg/WihAhNg48R4KkjwHoyHlxSCK4VlFduLTiC
         nILQ==
X-Gm-Message-State: AC+VfDzi71dNuD5+ZzRQRQAGYl5+Y6oU1tkzWMRHXnR0ogy8liMEUn/E
        IFIh5pb6acfAVxU6njEEePRpyohidFkNc83u1kY=
X-Google-Smtp-Source: ACHHUZ6MjozgLXsxnyuXKl480P6hjgcEpRvIYd/fSNe5bzFOhhO62ZowEfAm5Aql3TydPieM4TFRRsT9FXiEDDOJd9s=
X-Received: by 2002:a17:906:7793:b0:974:5de8:b5ce with SMTP id
 s19-20020a170906779300b009745de8b5cemr9175401ejm.2.1687282089288; Tue, 20 Jun
 2023 10:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org> <20230519032719.2581689-6-evalenti@kernel.org>
In-Reply-To: <20230519032719.2581689-6-evalenti@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:27:57 +0200
Message-ID: <CAJZ5v0hho1B6TiwshT4kYhs+Z4Q6xvnbgf8aoEZop=owkJHqxg@mail.gmail.com>
Subject: Re: [PATCH 5/7] thermal: stats: introduce tz time in trip
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
> This patch adds a statistic to report how long
> the thermal zone spent on temperature intervals
> created by each trip point. The first interval
> is the range below the first trip point. All
> subsequent intervals are accounted when temperature
> is above the trip point temperature value.
>
> Samples:
> $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> trip-1  0       0

The above line is confusing.

> trip0   -10000  35188
> trip1   25000   0

And the format violates the "one value per attribute" sysfs rule.

> $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> trip-1  0       0
> trip0   -10000  36901
> trip1   25000   0
> $ echo 25001 > /sys//class/thermal/thermal_zone0/emul_temp
> $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> trip-1  0       0
> trip0   -10000  47810
> trip1   25000   2259
> $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> trip-1  0       0
> trip0   -10000  47810
> trip1   25000   3224
> $ echo 24001 > /sys//class/thermal/thermal_zone0/emul_temp
> $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> trip-1  0       0
> trip0   -10000  48960
> trip1   25000   10080
> $ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
> trip-1  0       0
> trip0   -10000  49844
> trip1   25000   10080
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
> ---
>  .../driver-api/thermal/sysfs-api.rst          |  2 +
>  drivers/thermal/thermal_sysfs.c               | 86 +++++++++++++++++++
>  2 files changed, 88 insertions(+)
>
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index ed5e6ba4e0d7..4a2b92a7488c 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -359,6 +359,8 @@ Thermal zone device sys I/F, created once it's registered::
>      |---stats/reset_tz_stats:  Writes to this file resets the statistics.
>      |---stats/max_gradient:    The maximum recorded dT/dt in uC/ms.
>      |---stats/min_gradient:    The minimum recorded dT/dt in uC/ms.
> +    |---stats/time_in_trip_ms: Time spent on each temperature interval of
> +                               trip points.

I would write "in each temperature interval between consecutive trip points".

Doesn't this assume a specific temperature ordering of trip points?
And so what if they are not ordered?
