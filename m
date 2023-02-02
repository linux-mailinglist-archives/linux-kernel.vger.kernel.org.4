Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9D6884DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjBBQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjBBQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:53:49 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805276F735;
        Thu,  2 Feb 2023 08:53:47 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id ml19so7905053ejb.0;
        Thu, 02 Feb 2023 08:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkAFVysRmrk4KIVV03lhSp9/r+uaaj15Nxb8wMUj+w4=;
        b=WkAEC5bC1TI6u0lXl4/53xohtSseufXMwBi+oCgcyEHq0q07a6vrE3gSbcinC+0/Xo
         9F39hTlT6f7w8i5oOvdb88MkmgqvlTFNfvq9YAVdw54ons/UmxVIj/zZluU2pA3G/HTi
         uPtZbbeog+riEs4c35lxSIPtT1duzL1DXZGMGzyD/VzxWnltFEZCLC55kSsAsaEmXNdj
         PWnccUZnCWYmegLVwklNhOOA7WG2uAlnGX+NKSCJcVXGT5PRV4CbYc4lswO/2sXEiCPU
         kfFs2kpaMkgphFpqgN4UbcSvgaKLFAysUxFvUv/97D9wkRuWZbpat0sSoSrlcP0qIe9k
         CPUQ==
X-Gm-Message-State: AO0yUKVyOZelSmkMa8PSKFui0LMrHEQ0/EIpwgl/v3bud6584nYJ59uU
        pCptNzCEekbn+BGYS6oMRnSOpaAZTYb7NsciKX3+B3AY
X-Google-Smtp-Source: AK7set9AdALOM3LcUlN3WH7cJYW7DNlfJzBEKbLKBUhyB7UyoyJEbselkHd4QCj19yLeghDijQxInKGg8RGP4kfdSR8=
X-Received: by 2002:a17:906:9bd4:b0:87f:575a:9b67 with SMTP id
 de20-20020a1709069bd400b0087f575a9b67mr2214925ejc.274.1675356826032; Thu, 02
 Feb 2023 08:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20230201223617.1306964-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230201223617.1306964-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 17:53:34 +0100
Message-ID: <CAJZ5v0iGf-12iqqkK-JMzzg9CcQ_MtKxapb20zLYZAh1BaUMxQ@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/intel: Use generic trip points for quark_dts
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
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

On Wed, Feb 1, 2023 at 11:36 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
>
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> ---
>
> This patch applies on top of linux-pm/linux-next
>
>  V2:
>    - Changed get_trip_temp() to return THERMAL_TEMP_INVALID
>    - Register unconditonnaly the thermal trips
>    - Fixed thermal_zone_device_register() call replaced by the
>      _with_trips() version
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../thermal/intel/intel_quark_dts_thermal.c   | 55 +++++++------------
>  1 file changed, 20 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
> index 3eafc6b0e6c3..97b843fa7568 100644
> --- a/drivers/thermal/intel/intel_quark_dts_thermal.c
> +++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
> @@ -84,6 +84,7 @@
>  #define QRK_DTS_MASK_TP_THRES          0xFF
>  #define QRK_DTS_SHIFT_TP               8
>  #define QRK_DTS_ID_TP_CRITICAL         0
> +#define QRK_DTS_ID_TP_HOT              1
>  #define QRK_DTS_SAFE_TP_THRES          105
>
>  /* Thermal Sensor Register Lock */
> @@ -104,6 +105,7 @@ struct soc_sensor_entry {
>         u32 store_ptps;
>         u32 store_dts_enable;
>         struct thermal_zone_device *tzone;
> +       struct thermal_trip trips[QRK_MAX_DTS_TRIPS];
>  };
>
>  static struct soc_sensor_entry *soc_dts;
> @@ -172,9 +174,9 @@ static int soc_dts_disable(struct thermal_zone_device *tzd)
>         return ret;
>  }
>
> -static int _get_trip_temp(int trip, int *temp)
> +static int get_trip_temp(int trip)
>  {
> -       int status;
> +       int status, temp;
>         u32 out;
>
>         mutex_lock(&dts_update_mutex);
> @@ -183,7 +185,7 @@ static int _get_trip_temp(int trip, int *temp)
>         mutex_unlock(&dts_update_mutex);
>
>         if (status)
> -               return status;
> +               return THERMAL_TEMP_INVALID;
>
>         /*
>          * Thermal Sensor Programmable Trip Point Register has 8-bit
> @@ -191,21 +193,10 @@ static int _get_trip_temp(int trip, int *temp)
>          * thresholds. The threshold value is always offset by its
>          * temperature base (50 degree Celsius).
>          */
> -       *temp = (out >> (trip * QRK_DTS_SHIFT_TP)) & QRK_DTS_MASK_TP_THRES;
> -       *temp -= QRK_DTS_TEMP_BASE;
> +       temp = (out >> (trip * QRK_DTS_SHIFT_TP)) & QRK_DTS_MASK_TP_THRES;
> +       temp -= QRK_DTS_TEMP_BASE;
>
> -       return 0;
> -}
> -
> -static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
> -                               int trip, int *temp)
> -{
> -       return _get_trip_temp(trip, temp);
> -}
> -
> -static inline int sys_get_crit_temp(struct thermal_zone_device *tzd, int *temp)
> -{
> -       return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
> +       return temp;
>  }
>
>  static int update_trip_temp(struct soc_sensor_entry *aux_entry,
> @@ -262,17 +253,6 @@ static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
>         return update_trip_temp(tzd->devdata, trip, temp);
>  }
>
> -static int sys_get_trip_type(struct thermal_zone_device *thermal,
> -               int trip, enum thermal_trip_type *type)
> -{
> -       if (trip)
> -               *type = THERMAL_TRIP_HOT;
> -       else
> -               *type = THERMAL_TRIP_CRITICAL;
> -
> -       return 0;
> -}
> -
>  static int sys_get_curr_temp(struct thermal_zone_device *tzd,
>                                 int *temp)
>  {
> @@ -315,10 +295,7 @@ static int sys_change_mode(struct thermal_zone_device *tzd,
>
>  static struct thermal_zone_device_ops tzone_ops = {
>         .get_temp = sys_get_curr_temp,
> -       .get_trip_temp = sys_get_trip_temp,
> -       .get_trip_type = sys_get_trip_type,
>         .set_trip_temp = sys_set_trip_temp,
> -       .get_crit_temp = sys_get_crit_temp,
>         .change_mode = sys_change_mode,
>  };
>
> @@ -385,10 +362,18 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
>                         goto err_ret;
>         }
>
> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
> -                       QRK_MAX_DTS_TRIPS,
> -                       wr_mask,
> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = get_trip_temp(QRK_DTS_ID_TP_CRITICAL);
> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
> +
> +       aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
> +       aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
> +
> +       aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
> +                                                                  aux_entry->trips,
> +                                                                  QRK_MAX_DTS_TRIPS,
> +                                                                  wr_mask,
> +                                                                  aux_entry, &tzone_ops,
> +                                                                  NULL, 0, polling_delay);
>         if (IS_ERR(aux_entry->tzone)) {
>                 err = PTR_ERR(aux_entry->tzone);
>                 goto err_ret;
> --

Applied as 6.3 material with edited subject and changelog, thanks!
