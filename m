Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4A67CD61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjAZOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjAZOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:16:12 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D64109C;
        Thu, 26 Jan 2023 06:16:11 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id rl14so5454654ejb.2;
        Thu, 26 Jan 2023 06:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afe3c3FZB7RJeEJIEhaJHSck4Xy8uR9qBSE0PIRAeQU=;
        b=tmr3klucKE7kOyN3Ag3dJ9qCTuwhkCqCioyD7/dnaE/W5MVI+vuCDzON57TpJvDKRi
         00Oq9TDiaB9nMNLKbDLge3FaSRJfx8BKyendjARoCUrfrYx8fyIc9e4AzfkRFsY2jWfh
         8LFSqw7lh8owJZvI0zs1eEU5BjAU8Is7xC57MMN2e2mkPn+vEMadb9gsn1IPj6nmziTG
         cMOIkg0q/XbOfl9Hp1XMP+vaGKs9/W8f/uBjBewbUodLzcjNFSlzL1FYuzSX5ZNMOjlm
         OtaP+YELDaLUxsjIKcAo+h5Pt7SRlxzV+OXD12jEIeWj8yQypI5425jA+Rz8cCsdAwD4
         vxuw==
X-Gm-Message-State: AFqh2koFjQLJID4w9TRrk0DszbCUzR6bk8Am3I1shsbGIoDqylrRVxHq
        nEYLAo31Z7hNmsLU2IaanZ2ye1nNTaAqh9dHmHLaTDng
X-Google-Smtp-Source: AMrXdXsNOhijei6u9jBrfj6OKlC4lN2bQdo6do1jqyJ+rbxe/I0uQAOptJRQR74OfQF4tAr7iiRpTgbTDIFWWR7bVwg=
X-Received: by 2002:a17:906:f6cb:b0:870:fef9:9001 with SMTP id
 jo11-20020a170906f6cb00b00870fef99001mr6112056ejb.25.1674742570093; Thu, 26
 Jan 2023 06:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230118181622.33335-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 15:15:58 +0100
Message-ID: <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/drivers/intel: Use generic trip points for quark_dts
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
>
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../thermal/intel/intel_quark_dts_thermal.c   | 56 +++++++++----------
>  1 file changed, 25 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
> index 3eafc6b0e6c3..4e1d1799ec22 100644
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
> @@ -172,7 +174,7 @@ static int soc_dts_disable(struct thermal_zone_device *tzd)
>         return ret;
>  }
>
> -static int _get_trip_temp(int trip, int *temp)
> +static int get_trip_temp(int trip, int *temp)
>  {
>         int status;
>         u32 out;
> @@ -197,17 +199,6 @@ static int _get_trip_temp(int trip, int *temp)
>         return 0;
>  }
>
> -static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
> -                               int trip, int *temp)
> -{
> -       return _get_trip_temp(trip, temp);
> -}
> -
> -static inline int sys_get_crit_temp(struct thermal_zone_device *tzd, int *temp)
> -{
> -       return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
> -}
> -
>  static int update_trip_temp(struct soc_sensor_entry *aux_entry,
>                                 int trip, int temp)
>  {
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
> @@ -344,7 +321,7 @@ static void free_soc_dts(struct soc_sensor_entry *aux_entry)
>  static struct soc_sensor_entry *alloc_soc_dts(void)
>  {
>         struct soc_sensor_entry *aux_entry;
> -       int err;
> +       int err, temperature;
>         u32 out;
>         int wr_mask;
>
> @@ -385,10 +362,27 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
>                         goto err_ret;
>         }
>
> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
> -                       QRK_MAX_DTS_TRIPS,
> -                       wr_mask,
> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
> +       if (err)
> +               goto err_ret;
> +
> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
> +
> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
> +       if (err)
> +               goto err_ret;

If I'm not mistaken, this won't even try to register the thermal zone
if at least one trip cannot be initialized, but previously it was
registered in that case, but the trips that failed to respond were
disabled.

This is a change in behavior that would at least need to be documented
in the changelog, but it isn't.

I'm not sure if it is safe to make even, however.

> +
> +       aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = temperature;
> +       aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
> +
> +       aux_entry->tzone =
> +               thermal_zone_device_register_with_trips("quark_dts",
> +                                                       aux_entry->trips,
> +                                                       QRK_MAX_DTS_TRIPS,
> +                                                       wr_mask,
> +                                                       aux_entry, &tzone_ops,
> +                                                       NULL, 0, polling_delay);
>         if (IS_ERR(aux_entry->tzone)) {
>                 err = PTR_ERR(aux_entry->tzone);
>                 goto err_ret;
> --
> 2.34.1
>
