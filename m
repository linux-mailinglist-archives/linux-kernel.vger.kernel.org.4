Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956762334C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiKITPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKITP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:15:29 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328A1581D;
        Wed,  9 Nov 2022 11:15:29 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id s20so11555209qkg.5;
        Wed, 09 Nov 2022 11:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vH5PyIAlNuh7/zzJt8KiSzR2t2C93ID7RXrLpyPstHE=;
        b=gMqOd/BXNdSPfMnP9Rx5qepP8D5ynYHuaPtVPAfNRZ08ShtWv5/OIs0ddeelSReijP
         cqe4SvgRy89GugEQwOBXbdMIrqVfxSgJJXkDVesj9Z2A/tSbjvGAS1tcQ1Itx8eN8s1E
         DXINQeXcrN2NR4+9V5dzMEf8dQ933oAw2F7aOVfjR5JJzp4RDL+D4iwWtpGw5R6MdYbl
         64ObgR6H/21k8u0s0n0NfoCsengOphoK8kNPt7KC6QJYhnX3ZIA7wIFU3Mv/65wTEPAO
         RtIL13ur9ugD2E/CcSKSO3NrxTENbVqOcq3hsXYiBEb4j9L/9fFKPM0d4/bPnKUS2vYM
         U3cw==
X-Gm-Message-State: ACrzQf2qU+HQ0mg+YkGVM3kYF0P9jAKwWl2nUd0xyl3AnQNzdfsE4jpc
        5NpwgxXcol4/0k7MBt/fuwkXspB9OxV2xFgw1Nw=
X-Google-Smtp-Source: AMsMyM68XnbdgLgEo2bamjCU4xI+xxM7VjEXDet7JmI9KpWZ0rzQZPuPggQxZ2uM6NJ8iVJn+k3NLR6PQVIap3P8CjM=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr43209380qkl.443.1668021328293; Wed, 09
 Nov 2022 11:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-6-linux@roeck-us.net>
In-Reply-To: <20221017130910.2307118-6-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 20:15:17 +0100
Message-ID: <CAJZ5v0hO9_95uD1qY8aBe094JWsxPrba2wk_PchKHmVqRj0CHw@mail.gmail.com>
Subject: Re: [PATCH 5/9] thermal/core: Introduce locked version of thermal_zone_device_update
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> In thermal_zone_device_set_mode(), the thermal zone mutex is released only
> to be reacquired in the subsequent call to thermal_zone_device_update().
>
> Introduce __thermal_zone_device_update() as locked version of

Did you mean "unlocked"?

> thermal_zone_device_update() and call it from
> thermal_zone_device_set_mode() without releasing the lock to avoid
> the extra release/acuire sequence.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_core.c | 57 ++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 562ece8d16aa..9facd9c5b70f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -403,6 +403,34 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
>                 pos->initialized = false;
>  }
>
> +static void __thermal_zone_device_update(struct thermal_zone_device *tz,
> +                                        enum thermal_notify_event event)
> +{
> +       int count;
> +
> +       if (atomic_read(&in_suspend))
> +               return;
> +
> +       if (WARN_ONCE(!tz->ops->get_temp,
> +                     "'%s' must not be called without 'get_temp' ops set\n",
> +                     __func__))
> +               return;
> +
> +       if (!thermal_zone_device_is_enabled(tz))
> +               return;
> +
> +       update_temperature(tz);
> +
> +       __thermal_zone_set_trips(tz);
> +
> +       tz->notify_event = event;
> +
> +       for (count = 0; count < tz->num_trips; count++)
> +               handle_thermal_trip(tz, count);
> +
> +       monitor_thermal_zone(tz);
> +}
> +
>  static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>                                         enum thermal_device_mode mode)
>  {
> @@ -423,9 +451,9 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>         if (!ret)
>                 tz->mode = mode;
>
> -       mutex_unlock(&tz->lock);
> +       __thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> -       thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +       mutex_unlock(&tz->lock);
>
>         if (mode == THERMAL_DEVICE_ENABLED)
>                 thermal_notify_tz_enable(tz->id);
> @@ -457,31 +485,8 @@ int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
>  void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                 enum thermal_notify_event event)
>  {
> -       int count;
> -
> -       if (atomic_read(&in_suspend))
> -               return;
> -
> -       if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
> -                     "'get_temp' ops set\n", __func__))
> -               return;
> -
>         mutex_lock(&tz->lock);
> -
> -       if (!thermal_zone_device_is_enabled(tz))
> -               goto out;
> -
> -       update_temperature(tz);
> -
> -       __thermal_zone_set_trips(tz);
> -
> -       tz->notify_event = event;
> -
> -       for (count = 0; count < tz->num_trips; count++)
> -               handle_thermal_trip(tz, count);
> -
> -       monitor_thermal_zone(tz);
> -out:
> +       __thermal_zone_device_update(tz, event);
>         mutex_unlock(&tz->lock);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_update);
> --
> 2.36.2
>
