Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1F5EB11F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIZTQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIZTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:16:42 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F9598C9F;
        Mon, 26 Sep 2022 12:16:42 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id g12so4767442qts.1;
        Mon, 26 Sep 2022 12:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=r/lBYF+GxrGFPkgG3fUr7thtRY0jkylkSgITRGPALVo=;
        b=kT9yvpTfZ9jfOKajbS45EXlB6Je/kHQJ2Jnx9Tyma2Ux+2Cs66N4W5hjYRzIgoDCdd
         VnaHTbMqzsQIQzZsjuXy+U4r+GE5dEaf8yPIn2ajzAX/E0FXEWWza3lzhv5+up9cWABo
         YX5ybCrdY3BvwxvTWV5jRp1I3jKKqc8/cazGbO8Q+bMyIz14JbB344piB5D/hA3p2sQw
         eKzADcBMrFuFqQnwmh6dbnoMjDPM3vXwR0qRwbEyqmQPw5feRDUe3IRngUu79WavnSDz
         bftCMHnnwGFlDCXORmD3F7C/96NK/VMPX88XjLK5p0x7ItOC5zfqxcyFKH8tc9bCGGY1
         CK3A==
X-Gm-Message-State: ACrzQf3xSSLD7vhWcvkO0TgBAv25MtsOV3GvywaF+RBsUDQkowf7s0xN
        Nn+CiJXHIHIoJshwZoWAZ5SIRN7399LbZJZ12hE=
X-Google-Smtp-Source: AMsMyM7kUra5T9BxmDaHdVz7qdxJQtvyxzo1yyQOSOlmfq62Vr0tJ/Rv9Li4kxS/aNsGMQFZX5HehoiX/2K5dvCMO+s=
X-Received: by 2002:a05:622a:1a08:b0:35c:d9b5:144b with SMTP id
 f8-20020a05622a1a0800b0035cd9b5144bmr19435966qtb.27.1664219801273; Mon, 26
 Sep 2022 12:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org> <20220926140604.4173723-3-daniel.lezcano@linaro.org>
In-Reply-To: <20220926140604.4173723-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Sep 2022 21:16:29 +0200
Message-ID: <CAJZ5v0i7oh_rfW5AW_4rsKhWksYssyY2uz=1GUK0sBo2CLT7Pg@mail.gmail.com>
Subject: Re: [PATCH v5 02/30] thermal/sysfs: Do not make get_trip_hyst optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:06 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The get_trip_hyst() ops is optional. It results all around the thermal
> framework code a check against the ops pointer and different action
> adding more complexity and making the code less readable and
> understandable.
>
> A zero hysteresis value is perfectly valid, so instead of adding more
> circumvolutions in the code, create unconditionnaly the hysteresis and
> use the thermal_zone_get_trip() function which returns a zero
> hysteresis if the get_trip_hyst() is not defined.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I would change the subject to something like "thermal/sysfs: Always
expose hysteresis attributes", because that's what the patch does
IIUC.

And in the changelog I would write something like the below:

"Instead of avoiding to expose the hysteresis attributes of a thermal
zone when its get_trip_hyst() operation is not defined, which is
confusing, expose them always and use the default
thermal_zone_get_trip() function returning 0 hysteresis when that
operation is not present.

The hysteresis of 0 is perfectly valid, so this change should not
introduce any backwards compatibility issues."

> ---
>  drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 75f6b151a58b..18cdd7cd0008 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -424,23 +424,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
>                 return -ENOMEM;
>         }
>
> -       if (tz->ops->get_trip_hyst) {
> -               tz->trip_hyst_attrs = kcalloc(tz->num_trips,
> -                                             sizeof(*tz->trip_hyst_attrs),
> -                                             GFP_KERNEL);
> -               if (!tz->trip_hyst_attrs) {
> -                       kfree(tz->trip_type_attrs);
> -                       kfree(tz->trip_temp_attrs);
> -                       return -ENOMEM;
> -               }
> +       tz->trip_hyst_attrs = kcalloc(tz->num_trips,
> +                                     sizeof(*tz->trip_hyst_attrs),
> +                                     GFP_KERNEL);
> +       if (!tz->trip_hyst_attrs) {
> +               kfree(tz->trip_type_attrs);
> +               kfree(tz->trip_temp_attrs);
> +               return -ENOMEM;
>         }
>
>         attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
>         if (!attrs) {
>                 kfree(tz->trip_type_attrs);
>                 kfree(tz->trip_temp_attrs);
> -               if (tz->ops->get_trip_hyst)
> -                       kfree(tz->trip_hyst_attrs);
> +               kfree(tz->trip_hyst_attrs);
>                 return -ENOMEM;
>         }
>
> @@ -473,9 +470,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
>                 }
>                 attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
>
> -               /* create Optional trip hyst attribute */
> -               if (!tz->ops->get_trip_hyst)
> -                       continue;
>                 snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
>                          "trip_point_%d_hyst", indx);
>
> @@ -512,8 +506,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
>
>         kfree(tz->trip_type_attrs);
>         kfree(tz->trip_temp_attrs);
> -       if (tz->ops->get_trip_hyst)
> -               kfree(tz->trip_hyst_attrs);
> +       kfree(tz->trip_hyst_attrs);
>         kfree(tz->trips_attribute_group.attrs);
>  }
>
> --
> 2.34.1
>
