Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C076C39C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCUTEb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCUTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:04:27 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2D56786;
        Tue, 21 Mar 2023 12:03:47 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id r11so63753054edd.5;
        Tue, 21 Mar 2023 12:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmnmZtVwh0puQIb6yEMmIylWiNGozacRydhBtogRSdg=;
        b=WDuZaYqNVm5Bq0oMiiGuI9EC+FHeecFSd++10ZSKBGuJn1LnZCVyhX8HLM5nde0ixt
         eUl4XTRtKRPmW9khohzn3jHhSq0BZkajET7vNkPY1GI+EaV7VOpEME0b1oPmLoOPaC5e
         5eAYSFu5Xgp7S62CFr3qXFTrgO4L54u6WO2IxQDSmTgJ44Ddugn1bPyXnRAmerbO9gED
         cwAyGqaJpJE1cfeUe9dIBhoViLvlrnQjRsoE4OBWGoFf0wN8TAvy+AxRvpFWMu5iFw6K
         Pp7q83/yc2zKivzxAWvv9g5qpMblLkfkAaSLpLUlTzkaMKrqIPtz+Hu6i6+psoFSUncb
         W+gg==
X-Gm-Message-State: AO0yUKUdQcSgzRC9muIEnt5hJxQ0JgHYitfySWXPzPQE4U9wbHqucqJb
        qcREE9E9teEI6o++MVUJEKlXpoVt8SbHNla8bE0=
X-Google-Smtp-Source: AK7set8yznaAVu5LBKNGeaOw/o8U3N72bmMocsiI13/nwd2tjFyDpcWI62ErxNGyo6BDmaKVoAiZhdHvCAWnyYFV4so=
X-Received: by 2002:a50:cd1d:0:b0:4fc:8749:cd77 with SMTP id
 z29-20020a50cd1d000000b004fc8749cd77mr2277316edi.3.1679425411834; Tue, 21 Mar
 2023 12:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <2678096.mvXUDI8C0e@kreacher> <2878875.e9J7NaK4W3@kreacher> <8f15bc65578f105dfc126569068d8eb1ee12107c.camel@intel.com>
In-Reply-To: <8f15bc65578f105dfc126569068d8eb1ee12107c.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Mar 2023 20:03:20 +0100
Message-ID: <CAJZ5v0jmDZW-maaQRrD-A1D9YXaVtLtM+bJ=Ho7C5vcYunRkjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] thermal: core: Introduce thermal_cooling_device_update()
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:08 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-03-17 at 18:01 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Introduce a core thermal API function,
> > thermal_cooling_device_update(),
> > for updating the max_state value for a cooling device and rearranging
> > its statistics in sysfs after a possible change of its
> > ->get_max_state()
> > callback return value.
> >
> > That callback is now invoked only once, during cooling device
> > registration, to populate the max_state field in the cooling device
> > object, so if its return value changes, it needs to be invoked again
> > and the new return value needs to be stored as max_state.  Moreover,
> > the statistics presented in sysfs need to be rearranged in general,
> > because there may not be enough room in them to store data for all
> > of the possible states (in the case when max_state grows).
> >
> > The new function takes care of that (and some other minor things
> > related to it), but some extra locking and lockdep annotations are
> > added in several places too to protect against crashes in the cases
> > when the statistics are not present or when a stale max_state value
> > might be used by sysfs attributes.
> >
> > Note that the actual user of the new function will be added
> > separately.
> >
> > Link:
> > https://lore.kernel.org/linux-pm/53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Rui, please have a look at this again and give it a go if
> > possible.  It is the
> > only patch in the series changing in v3.
>
> Hi, Rafael,
>
> Thanks for the patch, I can confirm that it works, with ACPI passive
> cooling activated on my side.
>
> Tested-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Thank you!

I'll queue up this series for 6.3-rc4.

> > v2 -> v3:
> >    Make thermal_cooling_device_update() check thermal instances
> > involving the
> >    given thermal device and update the "upper" value for them if
> > necessary (the
> >    "lower" and "target" values may need to be adjusted too in some
> > cases) to avoid
> >    leaving thermal instances with "upper" above the new max_state of
> > the
> >    corresponding cooling device.
> >
> > v1 -> v2:
> >     * Make thermal_cooling_device_update() do the full
> > IS_ERR_OR_NULL() check
> >       on cdev, so that its callers don't need to do it.
> >     * Remove ->set_cur_state() callback invocation from
> >       thermal_cooling_device_update(), because it is redundant (and
> > it doesn't
> >       make sense to pass a state value exceeding max_state to it
> > anyway).
> >
> > ---
> >  drivers/thermal/thermal_core.c  |   83
> > +++++++++++++++++++++++++++++++++++++++-
> >  drivers/thermal/thermal_core.h  |    2
> >  drivers/thermal/thermal_sysfs.c |   72
> > ++++++++++++++++++++++++++++++----
> >  include/linux/thermal.h         |    1
> >  4 files changed, 149 insertions(+), 9 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -613,6 +613,7 @@ int thermal_zone_bind_cooling_device(str
> >       struct thermal_instance *pos;
> >       struct thermal_zone_device *pos1;
> >       struct thermal_cooling_device *pos2;
> > +     bool upper_no_limit;
> >       int result;
> >
> >       if (trip >= tz->num_trips || trip < 0)
> > @@ -632,7 +633,13 @@ int thermal_zone_bind_cooling_device(str
> >
> >       /* lower default 0, upper default max_state */
> >       lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
> > -     upper = upper == THERMAL_NO_LIMIT ? cdev->max_state : upper;
> > +
> > +     if (upper == THERMAL_NO_LIMIT) {
> > +             upper = cdev->max_state;
> > +             upper_no_limit = true;
> > +     } else {
> > +             upper_no_limit = false;
> > +     }
> >
> >       if (lower > upper || upper > cdev->max_state)
> >               return -EINVAL;
> > @@ -644,6 +651,7 @@ int thermal_zone_bind_cooling_device(str
> >       dev->cdev = cdev;
> >       dev->trip = trip;
> >       dev->upper = upper;
> > +     dev->upper_no_limit = upper_no_limit;
> >       dev->lower = lower;
> >       dev->target = THERMAL_NO_TARGET;
> >       dev->weight = weight;
> > @@ -1057,6 +1065,79 @@ static bool thermal_cooling_device_prese
> >       return false;
> >  }
> >
> > +/**
> > + * thermal_cooling_device_update - Update a cooling device object
> > + * @cdev: Target cooling device.
> > + *
> > + * Update @cdev to reflect a change of the underlying hardware or
> > platform.
> > + *
> > + * Must be called when the maximum cooling state of @cdev becomes
> > invalid and so
> > + * its .get_max_state() callback needs to be run to produce the new
> > maximum
> > + * cooling state value.
> > + */
> > +void thermal_cooling_device_update(struct thermal_cooling_device
> > *cdev)
> > +{
> > +     struct thermal_instance *ti;
> > +     unsigned long state;
> > +
> > +     if (IS_ERR_OR_NULL(cdev))
> > +             return;
> > +
> > +     /*
> > +      * Hold thermal_list_lock throughout the update to prevent the
> > device
> > +      * from going away while being updated.
> > +      */
> > +     mutex_lock(&thermal_list_lock);
> > +
> > +     if (!thermal_cooling_device_present(cdev))
> > +             goto unlock_list;
> > +
> > +     /*
> > +      * Update under the cdev lock to prevent the state from being
> > set beyond
> > +      * the new limit concurrently.
> > +      */
> > +     mutex_lock(&cdev->lock);
> > +
> > +     if (cdev->ops->get_max_state(cdev, &cdev->max_state))
> > +             goto unlock;
> > +
> > +     thermal_cooling_device_stats_reinit(cdev);
> > +
> > +     list_for_each_entry(ti, &cdev->thermal_instances, cdev_node) {
> > +             if (ti->upper == cdev->max_state)
> > +                     continue;
> > +
> > +             if (ti->upper < cdev->max_state) {
> > +                     if (ti->upper_no_limit)
> > +                             ti->upper = cdev->max_state;
> > +
> > +                     continue;
> > +             }
> > +
> > +             ti->upper = cdev->max_state;
> > +             if (ti->lower > ti->upper)
> > +                     ti->lower = ti->upper;
> > +
> > +             if (ti->target == THERMAL_NO_TARGET)
> > +                     continue;
> > +
> > +             if (ti->target > ti->upper)
> > +                     ti->target = ti->upper;
> > +     }
> > +
> > +     if (cdev->ops->get_cur_state(cdev, &state) || state > cdev-
> > >max_state)
> > +             goto unlock;
> > +
> > +     thermal_cooling_device_stats_update(cdev, state);
> > +
> > +unlock:
> > +     mutex_unlock(&cdev->lock);
> > +
> > +unlock_list:
> > +     mutex_unlock(&thermal_list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
> > +
> >  static void __unbind(struct thermal_zone_device *tz, int mask,
> >                    struct thermal_cooling_device *cdev)
> >  {
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -685,6 +685,8 @@ void thermal_cooling_device_stats_update
> >  {
> >       struct cooling_dev_stats *stats = cdev->stats;
> >
> > +     lockdep_assert_held(&cdev->lock);
> > +
> >       if (!stats)
> >               return;
> >
> > @@ -706,13 +708,22 @@ static ssize_t total_trans_show(struct d
> >                               struct device_attribute *attr, char
> > *buf)
> >  {
> >       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > -     struct cooling_dev_stats *stats = cdev->stats;
> > +     struct cooling_dev_stats *stats;
> >       int ret;
> >
> > +     mutex_lock(&cdev->lock);
> > +
> > +     stats = cdev->stats;
> > +     if (!stats)
> > +             goto unlock;
> > +
> >       spin_lock(&stats->lock);
> >       ret = sprintf(buf, "%u\n", stats->total_trans);
> >       spin_unlock(&stats->lock);
> >
> > +unlock:
> > +     mutex_unlock(&cdev->lock);
> > +
> >       return ret;
> >  }
> >
> > @@ -721,11 +732,18 @@ time_in_state_ms_show(struct device *dev
> >                     char *buf)
> >  {
> >       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > -     struct cooling_dev_stats *stats = cdev->stats;
> > +     struct cooling_dev_stats *stats;
> >       ssize_t len = 0;
> >       int i;
> >
> > +     mutex_lock(&cdev->lock);
> > +
> > +     stats = cdev->stats;
> > +     if (!stats)
> > +             goto unlock;
> > +
> >       spin_lock(&stats->lock);
> > +
> >       update_time_in_state(stats);
> >
> >       for (i = 0; i <= cdev->max_state; i++) {
> > @@ -734,6 +752,9 @@ time_in_state_ms_show(struct device *dev
> >       }
> >       spin_unlock(&stats->lock);
> >
> > +unlock:
> > +     mutex_unlock(&cdev->lock);
> > +
> >       return len;
> >  }
> >
> > @@ -742,8 +763,16 @@ reset_store(struct device *dev, struct d
> >           size_t count)
> >  {
> >       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > -     struct cooling_dev_stats *stats = cdev->stats;
> > -     int i, states = cdev->max_state + 1;
> > +     struct cooling_dev_stats *stats;
> > +     int i, states;
> > +
> > +     mutex_lock(&cdev->lock);
> > +
> > +     stats = cdev->stats;
> > +     if (!stats)
> > +             goto unlock;
> > +
> > +     states = cdev->max_state + 1;
> >
> >       spin_lock(&stats->lock);
> >
> > @@ -757,6 +786,9 @@ reset_store(struct device *dev, struct d
> >
> >       spin_unlock(&stats->lock);
> >
> > +unlock:
> > +     mutex_unlock(&cdev->lock);
> > +
> >       return count;
> >  }
> >
> > @@ -764,10 +796,18 @@ static ssize_t trans_table_show(struct d
> >                               struct device_attribute *attr, char
> > *buf)
> >  {
> >       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > -     struct cooling_dev_stats *stats = cdev->stats;
> > +     struct cooling_dev_stats *stats;
> >       ssize_t len = 0;
> >       int i, j;
> >
> > +     mutex_lock(&cdev->lock);
> > +
> > +     stats = cdev->stats;
> > +     if (!stats) {
> > +             len = -ENODATA;
> > +             goto unlock;
> > +     }
> > +
> >       len += snprintf(buf + len, PAGE_SIZE - len, "
> > From  :    To\n");
> >       len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
> >       for (i = 0; i <= cdev->max_state; i++) {
> > @@ -775,8 +815,10 @@ static ssize_t trans_table_show(struct d
> >                       break;
> >               len += snprintf(buf + len, PAGE_SIZE - len,
> > "state%2u  ", i);
> >       }
> > -     if (len >= PAGE_SIZE)
> > -             return PAGE_SIZE;
> > +     if (len >= PAGE_SIZE) {
> > +             len = PAGE_SIZE;
> > +             goto unlock;
> > +     }
> >
> >       len += snprintf(buf + len, PAGE_SIZE - len, "\n");
> >
> > @@ -799,8 +841,12 @@ static ssize_t trans_table_show(struct d
> >
> >       if (len >= PAGE_SIZE) {
> >               pr_warn_once("Thermal transition table exceeds
> > PAGE_SIZE. Disabling\n");
> > -             return -EFBIG;
> > +             len = -EFBIG;
> >       }
> > +
> > +unlock:
> > +     mutex_unlock(&cdev->lock);
> > +
> >       return len;
> >  }
> >
> > @@ -830,6 +876,8 @@ static void cooling_device_stats_setup(s
> >       unsigned long states = cdev->max_state + 1;
> >       int var;
> >
> > +     lockdep_assert_held(&cdev->lock);
> > +
> >       var = sizeof(*stats);
> >       var += sizeof(*stats->time_in_state) * states;
> >       var += sizeof(*stats->trans_table) * states * states;
> > @@ -855,6 +903,8 @@ out:
> >
> >  static void cooling_device_stats_destroy(struct
> > thermal_cooling_device *cdev)
> >  {
> > +     lockdep_assert_held(&cdev->lock);
> > +
> >       kfree(cdev->stats);
> >       cdev->stats = NULL;
> >  }
> > @@ -879,6 +929,12 @@ void thermal_cooling_device_destroy_sysf
> >       cooling_device_stats_destroy(cdev);
> >  }
> >
> > +void thermal_cooling_device_stats_reinit(struct
> > thermal_cooling_device *cdev)
> > +{
> > +     cooling_device_stats_destroy(cdev);
> > +     cooling_device_stats_setup(cdev);
> > +}
> > +
> >  /* these helper will be used only at the time of bindig */
> >  ssize_t
> >  trip_point_show(struct device *dev, struct device_attribute *attr,
> > char *buf)
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -101,6 +101,7 @@ struct thermal_instance {
> >       struct list_head tz_node; /* node in tz->thermal_instances */
> >       struct list_head cdev_node; /* node in cdev->thermal_instances
> > */
> >       unsigned int weight; /* The weight of the cooling device */
> > +     bool upper_no_limit;
> >  };
> >
> >  #define to_thermal_zone(_dev) \
> > @@ -127,6 +128,7 @@ int thermal_zone_create_device_groups(st
> >  void thermal_zone_destroy_device_groups(struct thermal_zone_device
> > *);
> >  void thermal_cooling_device_setup_sysfs(struct
> > thermal_cooling_device *);
> >  void thermal_cooling_device_destroy_sysfs(struct
> > thermal_cooling_device *cdev);
> > +void thermal_cooling_device_stats_reinit(struct
> > thermal_cooling_device *cdev);
> >  /* used only at binding time */
> >  ssize_t trip_point_show(struct device *, struct device_attribute *,
> > char *);
> >  ssize_t weight_show(struct device *, struct device_attribute *, char
> > *);
> > Index: linux-pm/include/linux/thermal.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -388,6 +388,7 @@ devm_thermal_of_cooling_device_register(
> >                               struct device_node *np,
> >                               char *type, void *devdata,
> >                               const struct thermal_cooling_device_ops
> > *ops);
> > +void thermal_cooling_device_update(struct thermal_cooling_device *);
> >  void thermal_cooling_device_unregister(struct thermal_cooling_device
> > *);
> >  struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
> > *name);
> >  int thermal_zone_get_temp(struct thermal_zone_device *tz, int
> > *temp);
> >
> >
> >
>
>
