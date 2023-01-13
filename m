Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697AA669CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjAMPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAMPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:51:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE476DB86;
        Fri, 13 Jan 2023 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673624644; x=1705160644;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eeC8Qp1u7LEojrvNoltsAmOs/KA9AJndx3JLW1uO7fk=;
  b=fhaidR2rYV81oyqCVbTGuP5zICUFfuWMMiY8OMl6x8iBxbmvphrfcfvR
   uTJKgGWlFbsM7Dg4ZL3LvVvyiQwiZzMzHJat6IbSi2jjmS/wmg9JZMQ4v
   czqbzfn+AbuECfj18vHUbE1sMsOJkaCZZ+w+1rZkIhEzZh8gfswQdfqaK
   2Y8yaCjZf1/SaMwv7IHeZGdvfAX4dzDT41mvKT1QWKJtOWcR0/BQoyKf7
   5bWLic5tbch1w3rB/Ca8CoD0LKZvZJFVweFU3kxUB//rZyDfzCH+uXvlg
   H+2DLY73m3Jbm1QYFf7dBn9Zu5v8FIl0JZmxcEPifEP6lBuFG9SY9zfpH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325276966"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="325276966"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 07:44:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800625048"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800625048"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 07:44:03 -0800
Message-ID: <f797d52138a48d22c789a4b7d156ffbf7795cd4b.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points
 int340x
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Date:   Fri, 13 Jan 2023 07:44:03 -0800
In-Reply-To: <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
         <20230110151745.2546131-4-daniel.lezcano@linaro.org>
         <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-13 at 11:41 +0000, Zhang, Rui wrote:
> On Tue, 2023-01-10 at 16:17 +0100, Daniel Lezcano wrote:
> > The thermal framework gives the possibility to register the trip
> > points with the thermal zone. When that is done, no get_trip_* ops
> > are
> > needed and they can be removed.
> > 
> > Convert the ops content logic into generic trip points and register
> > them with the thermal zone.
> > 
> > In order to consolidate the code, use the ACPI thermal framework
> > API
> > to fill the generic trip point from the ACPI tables.
> > 
> > It has been tested on a Intel i7-8650U - x280 with the INT3400, the
> > PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> > ---
> >    V3:
> >       - The driver Kconfig option selects CONFIG_THERMAL_ACPI
> >       - Change the initialization to use GTSH for the hysteresis on
> >         all the trip points
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
> >  .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++----------
> > ----
> >  .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
> >  3 files changed, 43 insertions(+), 145 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig
> > b/drivers/thermal/intel/int340x_thermal/Kconfig
> > index 5d046de96a5d..b7072d37101d 100644
> > --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> > +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> > @@ -9,6 +9,7 @@ config INT340X_THERMAL
> >         select THERMAL_GOV_USER_SPACE
> >         select ACPI_THERMAL_REL
> >         select ACPI_FAN
> > +       select THERMAL_ACPI
> >         select INTEL_SOC_DTS_IOSF_CORE
> >         select PROC_THERMAL_MMIO_RAPL if POWERCAP
> >         help
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > index 228f44260b27..626b33253153 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > @@ -37,65 +37,6 @@ static int int340x_thermal_get_zone_temp(struct
> > thermal_zone_device *zone,
> >         return 0;
> >  }
> >  
> > -static int int340x_thermal_get_trip_temp(struct
> > thermal_zone_device
> > *zone,
> > -                                        int trip, int *temp)
> > -{
> > -       struct int34x_thermal_zone *d = zone->devdata;
> > -       int i;
> > -
> > -       if (trip < d->aux_trip_nr)
> > -               *temp = d->aux_trips[trip];
> > -       else if (trip == d->crt_trip_id)
> > -               *temp = d->crt_temp;
> > -       else if (trip == d->psv_trip_id)
> > -               *temp = d->psv_temp;
> > -       else if (trip == d->hot_trip_id)
> > -               *temp = d->hot_temp;
> > -       else {
> > -               for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT;
> > i++) {
> > -                       if (d->act_trips[i].valid &&
> > -                           d->act_trips[i].id == trip) {
> > -                               *temp = d->act_trips[i].temp;
> > -                               break;
> > -                       }
> > -               }
> > -               if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
> > -                       return -EINVAL;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -static int int340x_thermal_get_trip_type(struct
> > thermal_zone_device
> > *zone,
> > -                                        int trip,
> > -                                        enum thermal_trip_type
> > *type)
> > -{
> > -       struct int34x_thermal_zone *d = zone->devdata;
> > -       int i;
> > -
> > -       if (trip < d->aux_trip_nr)
> > -               *type = THERMAL_TRIP_PASSIVE;
> > -       else if (trip == d->crt_trip_id)
> > -               *type = THERMAL_TRIP_CRITICAL;
> > -       else if (trip == d->hot_trip_id)
> > -               *type = THERMAL_TRIP_HOT;
> > -       else if (trip == d->psv_trip_id)
> > -               *type = THERMAL_TRIP_PASSIVE;
> > -       else {
> > -               for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT;
> > i++) {
> > -                       if (d->act_trips[i].valid &&
> > -                           d->act_trips[i].id == trip) {
> > -                               *type = THERMAL_TRIP_ACTIVE;
> > -                               break;
> > -                       }
> > -               }
> > -               if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
> > -                       return -EINVAL;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int int340x_thermal_set_trip_temp(struct
> > thermal_zone_device
> > *zone,
> >                                       int trip, int temp)
> >  {
> > @@ -109,25 +50,6 @@ static int int340x_thermal_set_trip_temp(struct
> > thermal_zone_device *zone,
> >         if (ACPI_FAILURE(status))
> >                 return -EIO;
> >  
> > -       d->aux_trips[trip] = temp;
> > -
> > -       return 0;
> > -}
> > -
> > -
> > -static int int340x_thermal_get_trip_hyst(struct
> > thermal_zone_device
> > *zone,
> > -               int trip, int *temp)
> > -{
> > -       struct int34x_thermal_zone *d = zone->devdata;
> > -       acpi_status status;
> > -       unsigned long long hyst;
> > -
> > -       status = acpi_evaluate_integer(d->adev->handle, "GTSH",
> > NULL,
> > &hyst);
> > -       if (ACPI_FAILURE(status))
> > -               *temp = 0;
> > -       else
> > -               *temp = hyst * 100;
> 
> The previous code returns hyst * 100.
> But the new API retuurns hyst directly.
> 
> -/sys/class/thermal/thermal_zone2/trip_point_4_hyst:2000
> +/sys/class/the
> rmal/thermal_zone2/trip_point_4_hyst:20
> 
> Is this done on purpose?
> 
> I think this may break userspace tools like thermald.
> 

It will.

Thanks,
Srinivas


> Srinivas, can you confirm?
> 
> thanks,
> rui
> > -
> >         return 0;
> >  }
> >  
> > @@ -138,58 +60,36 @@ static void int340x_thermal_critical(struct
> > thermal_zone_device *zone)
> >  
> >  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
> >         .get_temp       = int340x_thermal_get_zone_temp,
> > -       .get_trip_temp  = int340x_thermal_get_trip_temp,
> > -       .get_trip_type  = int340x_thermal_get_trip_type,
> >         .set_trip_temp  = int340x_thermal_set_trip_temp,
> > -       .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> >         .critical       = int340x_thermal_critical,
> >  };
> >  
> > -static int int340x_thermal_get_trip_config(acpi_handle handle,
> > char
> > *name,
> > -                                     int *temp)
> > -{
> > -       unsigned long long r;
> > -       acpi_status status;
> > -
> > -       status = acpi_evaluate_integer(handle, name, NULL, &r);
> > -       if (ACPI_FAILURE(status))
> > -               return -EIO;
> > -
> > -       *temp = deci_kelvin_to_millicelsius(r);
> > -
> > -       return 0;
> > -}
> > -
> >  int int340x_thermal_read_trips(struct int34x_thermal_zone
> > *int34x_zone)
> >  {
> > -       int trip_cnt = int34x_zone->aux_trip_nr;
> > -       int i;
> > +       int trip_cnt;
> > +       int i, ret;
> > +
> > +       trip_cnt = int34x_zone->aux_trip_nr;
> >  
> > -       int34x_zone->crt_trip_id = -1;
> > -       if (!int340x_thermal_get_trip_config(int34x_zone->adev-
> > >handle, 
> > "_CRT",
> > -                                            &int34x_zone-
> > >crt_temp))
> > -               int34x_zone->crt_trip_id = trip_cnt++;
> > +       ret = thermal_acpi_trip_crit(int34x_zone->adev,
> > &int34x_zone-
> > > trips[trip_cnt]);
> > +       if (!ret)
> > +               trip_cnt++;
> >  
> > -       int34x_zone->hot_trip_id = -1;
> > -       if (!int340x_thermal_get_trip_config(int34x_zone->adev-
> > >handle, 
> > "_HOT",
> > -                                            &int34x_zone-
> > >hot_temp))
> > -               int34x_zone->hot_trip_id = trip_cnt++;
> > +       ret = thermal_acpi_trip_hot(int34x_zone->adev,
> > &int34x_zone-
> > > trips[trip_cnt]);
> > +       if (!ret)
> > +               trip_cnt++;
> >  
> > -       int34x_zone->psv_trip_id = -1;
> > -       if (!int340x_thermal_get_trip_config(int34x_zone->adev-
> > >handle, 
> > "_PSV",
> > -                                            &int34x_zone-
> > >psv_temp))
> > -               int34x_zone->psv_trip_id = trip_cnt++;
> > +       ret = thermal_acpi_trip_psv(int34x_zone->adev,
> > &int34x_zone-
> > > trips[trip_cnt]);
> > +       if (!ret)
> > +               trip_cnt++;
> >  
> >         for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
> > -               char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
> >  
> > -               if (int340x_thermal_get_trip_config(int34x_zone-
> > >adev-
> > > handle,
> > -                                       name,
> > -                                       &int34x_zone-
> > > act_trips[i].temp))
> > +               ret = thermal_acpi_trip_act(int34x_zone->adev,
> > &int34x_zone->trips[trip_cnt], i);
> > +               if (ret)
> >                         break;
> >  
> > -               int34x_zone->act_trips[i].id = trip_cnt++;
> > -               int34x_zone->act_trips[i].valid = true;
> > +               trip_cnt++;
> >         }
> >  
> >         return trip_cnt;
> > @@ -208,7 +108,7 @@ struct int34x_thermal_zone
> > *int340x_thermal_zone_add(struct acpi_device *adev,
> >         acpi_status status;
> >         unsigned long long trip_cnt;
> >         int trip_mask = 0;
> > -       int ret;
> > +       int i, ret;
> >  
> >         int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
> >                                       GFP_KERNEL);
> > @@ -228,32 +128,35 @@ struct int34x_thermal_zone
> > *int340x_thermal_zone_add(struct acpi_device *adev,
> >                 int34x_thermal_zone->ops->get_temp = get_temp;
> >  
> >         status = acpi_evaluate_integer(adev->handle, "PATC", NULL,
> > &trip_cnt);
> > -       if (ACPI_FAILURE(status))
> > -               trip_cnt = 0;
> > -       else {
> > -               int i;
> > -
> > -               int34x_thermal_zone->aux_trips =
> > -                       kcalloc(trip_cnt,
> > -                               sizeof(*int34x_thermal_zone-
> > > aux_trips),
> > -                               GFP_KERNEL);
> > -               if (!int34x_thermal_zone->aux_trips) {
> > -                       ret = -ENOMEM;
> > -                       goto err_trip_alloc;
> > -               }
> > -               trip_mask = BIT(trip_cnt) - 1;
> > +       if (!ACPI_FAILURE(status)) {
> >                 int34x_thermal_zone->aux_trip_nr = trip_cnt;
> > -               for (i = 0; i < trip_cnt; ++i)
> > -                       int34x_thermal_zone->aux_trips[i] =
> > THERMAL_TEMP_INVALID;
> > +               trip_mask = BIT(trip_cnt) - 1;
> > +       }
> > +
> > +       int34x_thermal_zone->trips =
> > kzalloc(sizeof(*int34x_thermal_zone->trips) *
> > +                                           
> > (INT340X_THERMAL_MAX_TRIP_
> > COUNT + trip_cnt),
> > +                                             GFP_KERNEL);
> > +       if (!int34x_thermal_zone->trips) {
> > +               ret = -ENOMEM;
> > +               goto err_trips_alloc;
> >         }
> >  
> >         trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
> >  
> > +       for (i = 0; i < trip_cnt; ++i)
> > +               int34x_thermal_zone->trips[i].hysteresis =
> > thermal_acpi_trip_gtsh(adev);
> > +
> > +       for (i = 0; i < int34x_thermal_zone->aux_trip_nr; i++) {
> > +               int34x_thermal_zone->trips[i].type =
> > THERMAL_TRIP_PASSIVE;
> > +               int34x_thermal_zone->trips[i].temperature =
> > THERMAL_TEMP_INVALID;
> > +       }
> > +       
> >         int34x_thermal_zone->lpat_table =
> > acpi_lpat_get_conversion_table(
> >                                                                 ade
> > v-
> > > handle);
> >  
> > -       int34x_thermal_zone->zone = thermal_zone_device_register(
> > +       int34x_thermal_zone->zone =
> > thermal_zone_device_register_with_trips(
> >                                                 acpi_device_bid(ade
> > v),
> > +                                               int34x_thermal_zone
> > -
> > > trips,
> >                                                 trip_cnt,
> >                                                 trip_mask,
> > int34x_thermal_zone,
> >                                                 int34x_thermal_zone
> > -
> > > ops,
> > @@ -272,9 +175,9 @@ struct int34x_thermal_zone
> > *int340x_thermal_zone_add(struct acpi_device *adev,
> >  err_enable:
> >         thermal_zone_device_unregister(int34x_thermal_zone->zone);
> >  err_thermal_zone:
> > +       kfree(int34x_thermal_zone->trips);
> >         acpi_lpat_free_conversion_table(int34x_thermal_zone-
> > > lpat_table);
> > -       kfree(int34x_thermal_zone->aux_trips);
> > -err_trip_alloc:
> > +err_trips_alloc:
> >         kfree(int34x_thermal_zone->ops);
> >  err_ops_alloc:
> >         kfree(int34x_thermal_zone);
> > @@ -287,7 +190,7 @@ void int340x_thermal_zone_remove(struct
> > int34x_thermal_zone
> >  {
> >         thermal_zone_device_unregister(int34x_thermal_zone->zone);
> >         acpi_lpat_free_conversion_table(int34x_thermal_zone-
> > > lpat_table);
> > -       kfree(int34x_thermal_zone->aux_trips);
> > +       kfree(int34x_thermal_zone->trips);
> >         kfree(int34x_thermal_zone->ops);
> >         kfree(int34x_thermal_zone);
> >  }
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > index e28ab1ba5e06..0c2c8de92014 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > @@ -10,6 +10,7 @@
> >  #include <acpi/acpi_lpat.h>
> >  
> >  #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT     10
> > +#define INT340X_THERMAL_MAX_TRIP_COUNT
> > INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3
> >  
> >  struct active_trip {
> >         int temp;
> > @@ -19,15 +20,8 @@ struct active_trip {
> >  
> >  struct int34x_thermal_zone {
> >         struct acpi_device *adev;
> > -       struct active_trip
> > act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
> > -       unsigned long *aux_trips;
> > +       struct thermal_trip *trips;
> >         int aux_trip_nr;
> > -       int psv_temp;
> > -       int psv_trip_id;
> > -       int crt_temp;
> > -       int crt_trip_id;
> > -       int hot_temp;
> > -       int hot_trip_id;
> >         struct thermal_zone_device *zone;
> >         struct thermal_zone_device_ops *ops;
> >         void *priv_data;


