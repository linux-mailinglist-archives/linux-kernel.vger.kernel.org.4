Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0D5BC328
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiISGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiISGzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:55:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55C13DDD;
        Sun, 18 Sep 2022 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663570509; x=1695106509;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOF/tVrPEbyx6JpFuiAUdGzRjWw+ufhb/I1351qHpTs=;
  b=OH8hpqGrdrWWeA+bwfpDedUi8ydPr555Lz8uGCKweGjSPjAUBYU8cHED
   PEXdDlFRZi3T0HgMJQuhFFpkbgm98zE65TFJBJTRJ+225HtjactCwK+OQ
   LgnyBUrWa3UMK/MD9S6X9zOSdExpYHPTFaLG/7hwyI6bdvo19ZG9MulOl
   owBn+a9ETVpFWv/C7DCfQ7dDJSp2jAW9k6NHfzFAKA2Xx0ki3eqSH+l87
   /1WsWJPmCw81EkDuUWhpVs91SgDMZnlIujekGcFurYn67F7LuhSxx8f6i
   mYLXwuhJi585RRNWimczZsRDxsO0nEmYPu+6NbhTIsPi3F1zUFcjil28T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="385611386"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="385611386"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:54:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="793744150"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:54:56 -0700
Message-ID: <45a483ff097220ca4bc534ada3c7c5d5fca5b19e.camel@linux.intel.com>
Subject: Re: [PATCH v3 30/30] thermal/drivers/intel: Use generic
 thermal_zone_get_trip() function
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jiang Jian <jiangjian@cdjrlc.com>
Date:   Sun, 18 Sep 2022 23:54:55 -0700
In-Reply-To: <0e986fbb-e76b-9663-26c2-b84d887b4c98@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
         <20220906164720.330701-31-daniel.lezcano@linaro.org>
         <0e986fbb-e76b-9663-26c2-b84d887b4c98@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-16 at 19:06 +0200, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> I've Cc'ed you on this patch in case you have any comment
> 
> Thanks
> 
>    -- D.
> 
> On 06/09/2022 18:47, Daniel Lezcano wrote:
> > The thermal framework gives the possibility to register the trip
> > points with the thermal zone. When that is done, no get_trip_* ops
> > are
> > needed and they can be removed.
> > 
> > Convert ops content logic into generic trip points and register them
> > with the
> > thermal zone.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> > ---
> >   drivers/thermal/intel/x86_pkg_temp_thermal.c | 120 ++++++++++------
> > ---
> >   1 file changed, 66 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > index a0e234fce71a..e7c3b78d959c 100644
> > --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > @@ -53,6 +53,7 @@ struct zone_device {
> >         u32                             msr_pkg_therm_high;
> >         struct delayed_work             work;
> >         struct thermal_zone_device      *tzone;
> > +       struct thermal_trip             *trips;
> >         struct cpumask                  cpumask;
> >   };
> >   
> > @@ -138,40 +139,6 @@ static int sys_get_curr_temp(struct
> > thermal_zone_device *tzd, int *temp)
> >         return -EINVAL;
> >   }
> >   
> > -static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> > -                            int trip, int *temp)
> > -{
> > -       struct zone_device *zonedev = tzd->devdata;
> > -       unsigned long thres_reg_value;
> > -       u32 mask, shift, eax, edx;
> > -       int ret;
> > -
> > -       if (trip >= MAX_NUMBER_OF_TRIPS)
> > -               return -EINVAL;
> > -
> > -       if (trip) {
> > -               mask = THERM_MASK_THRESHOLD1;
> > -               shift = THERM_SHIFT_THRESHOLD1;
> > -       } else {
> > -               mask = THERM_MASK_THRESHOLD0;
> > -               shift = THERM_SHIFT_THRESHOLD0;
> > -       }
> > -
> > -       ret = rdmsr_on_cpu(zonedev->cpu,
> > MSR_IA32_PACKAGE_THERM_INTERRUPT,
> > -                          &eax, &edx);
> > -       if (ret < 0)
> > -               return ret;
> > -
> > -       thres_reg_value = (eax & mask) >> shift;
> > -       if (thres_reg_value)
> > -               *temp = zonedev->tj_max - thres_reg_value * 1000;
> > -       else
> > -               *temp = THERMAL_TEMP_INVALID;
> > -       pr_debug("sys_get_trip_temp %d\n", *temp);
> > -
> > -       return 0;
> > -}
> > -
> >   static int
> >   sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int
> > temp)
> >   {
> > @@ -212,18 +179,9 @@ sys_set_trip_temp(struct thermal_zone_device
> > *tzd, int trip, int temp)
> >                         l, h);
> >   }
> >   
> > -static int sys_get_trip_type(struct thermal_zone_device *thermal,
> > int trip,
> > -                            enum thermal_trip_type *type)
> > -{
> > -       *type = THERMAL_TRIP_PASSIVE;
> > -       return 0;
> > -}
> > -
> >   /* Thermal zone callback registry */
> >   static struct thermal_zone_device_ops tzone_ops = {
> >         .get_temp = sys_get_curr_temp,
> > -       .get_trip_temp = sys_get_trip_temp,
> > -       .get_trip_type = sys_get_trip_type,
> >         .set_trip_temp = sys_set_trip_temp,
> >   };
> >   
> > @@ -328,6 +286,48 @@ static int pkg_thermal_notify(u64 msr_val)
> >         return 0;
> >   }
> >   
> > +static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int
> > tj_max, int num_trips)
> > +{
> > +       struct thermal_trip *trips;
> > +       unsigned long thres_reg_value;
> > +       u32 mask, shift, eax, edx;
> > +       int ret, i;
> > +
> > +       trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
> > +       if (!trips)
> > +               return ERR_PTR(-ENOMEM);
> > +       
> > +       for (i = 0; i < num_trips; i++) {
> > +
> > +               if (i) {
> > +                       mask = THERM_MASK_THRESHOLD1;
> > +                       shift = THERM_SHIFT_THRESHOLD1;
> > +               } else {
> > +                       mask = THERM_MASK_THRESHOLD0;
> > +                       shift = THERM_SHIFT_THRESHOLD0;
> > +               }
> > +
> > +               ret = rdmsr_on_cpu(cpu,
> > MSR_IA32_PACKAGE_THERM_INTERRUPT,
> > +                                  &eax, &edx);
> > +               if (ret < 0) {
> > +                       kfree(trips);
> > +                       return ERR_PTR(ret);
> > +               }
> > +
> > +               thres_reg_value = (eax & mask) >> shift;
> > +
> > +               trips[i].temperature = thres_reg_value ?
> > +                       tj_max - thres_reg_value * 1000 :
> > THERMAL_TEMP_INVALID;
> > +
> > +               trips[i].type = THERMAL_TRIP_PASSIVE;
> > +               
> > +               pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
> > +                        __func__, cpu, i, trips[i].temperature);
> > +       }
> > +
> > +       return trips;
> > +}
> > +
> >   static int pkg_temp_thermal_device_add(unsigned int cpu)
> >   {
> >         int id = topology_logical_die_id(cpu);
> > @@ -353,24 +353,27 @@ static int pkg_temp_thermal_device_add(unsigned
> > int cpu)
> >         if (!zonedev)
> >                 return -ENOMEM;
> >   
> > +       zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max,
> > thres_count);
> > +       if (IS_ERR(zonedev->trips)) {
> > +               err = PTR_ERR(zonedev->trips);
> > +               goto out_kfree_zonedev;
> > +       }
> > +       
> >         INIT_DELAYED_WORK(&zonedev->work,
> > pkg_temp_thermal_threshold_work_fn);
> >         zonedev->cpu = cpu;
> >         zonedev->tj_max = tj_max;
> > -       zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
> > -                       thres_count,
> > +       zonedev->tzone =
> > thermal_zone_device_register_with_trips("x86_pkg_temp",
> > +                       zonedev->trips, thres_count,
> >                         (thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 :
> > 0x01,
> >                         zonedev, &tzone_ops, &pkg_temp_tz_params, 0,
> > 0);
> >         if (IS_ERR(zonedev->tzone)) {
> >                 err = PTR_ERR(zonedev->tzone);
> > -               kfree(zonedev);
> > -               return err;
> > +               goto out_kfree_trips;
> >         }
> >         err = thermal_zone_device_enable(zonedev->tzone);
> > -       if (err) {
> > -               thermal_zone_device_unregister(zonedev->tzone);
> > -               kfree(zonedev);
> > -               return err;
> > -       }
> > +       if (err)
> > +               goto out_unregister_tz;
> > +
> >         /* Store MSR value for package thermal interrupt, to restore
> > at exit */
> >         rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev-
> > >msr_pkg_therm_low,
> >               zonedev->msr_pkg_therm_high);
> > @@ -379,7 +382,14 @@ static int pkg_temp_thermal_device_add(unsigned
> > int cpu)
> >         raw_spin_lock_irq(&pkg_temp_lock);
> >         zones[id] = zonedev;
> >         raw_spin_unlock_irq(&pkg_temp_lock);
> > -       return 0;
> > +
> > +out_unregister_tz:     
> > +       thermal_zone_device_unregister(zonedev->tzone);
> > +out_kfree_trips:
> > +       kfree(zonedev->trips);
> > +out_kfree_zonedev:
> > +       kfree(zonedev);
> > +       return err;
> >   }
> >   
> >   static int pkg_thermal_cpu_offline(unsigned int cpu)
> > @@ -463,8 +473,10 @@ static int pkg_thermal_cpu_offline(unsigned int
> > cpu)
> >         raw_spin_unlock_irq(&pkg_temp_lock);
> >   
> >         /* Final cleanup if this is the last cpu */
> > -       if (lastcpu)
> > +       if (lastcpu) {
> > +               kfree(zonedev->trips);
> >                 kfree(zonedev);
> > +       }
> >         return 0;
> >   }
> >   
> 
> 


