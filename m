Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF06B500C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCJSZg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:25:34 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEBDE04B;
        Fri, 10 Mar 2023 10:25:30 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id o12so24143233edb.9;
        Fri, 10 Mar 2023 10:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678472729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG1S5shHRU4hJRJufiq+SgEdypSebU4oyFIlRHY9nJE=;
        b=47KU7fnuinPg8cCqaL123XQC93fhnuSS3JjIIkgtcLgtl07iD5if5pxNRh0rLAsoX1
         T5ViZYEYAcIXVVZhiPPDylI96OXu8tGsw2BdRAd3jVZLFkaV6S7br06x46z7Evf1Iien
         4OVBZLAJChATkptSTnZZ6DWOIuuFXb+snn0ErUkKSSyavPWQLf+wph8/GGdw+CgViEd9
         ZXduIXlqQU6fmUZw7cTTACs2MLaMp/VSYC0vtzdsizPywidZjeudyryt2RFFxtgtXkwp
         uT/t5G1X6qSHPf8eSbTHT3OWEsqnhZEegAFY62ARD/zZrEEvJ8MWrDV/jgMvzBaKkUYe
         cang==
X-Gm-Message-State: AO0yUKViCG4o2NkDYRIp2Vp1W6kDbkAj4KC7UQvoRshPK9y+Lfdqz8eg
        QLTzoQ8jzdPrarH5cDx29IYgIt/Pg+qQ7lBR/Yw=
X-Google-Smtp-Source: AK7set91PMkzkqh/Oi40/ttvtxsFNo8oxnQSiqhwmHQ+h3Y55VmvSitWzGsehHAfpdYUbLb1YrEcLMHzWgR/LMIwQ3A=
X-Received: by 2002:a50:9f26:0:b0:4c0:1cfa:bfe1 with SMTP id
 b35-20020a509f26000000b004c01cfabfe1mr14795119edf.6.1678472728851; Fri, 10
 Mar 2023 10:25:28 -0800 (PST)
MIME-Version: 1.0
References: <2148907.irdbgypaU6@kreacher> <10247847.nUPlyArG6x@kreacher> <50101e8c7b5215e2da365a815c5764c2598bdc02.camel@intel.com>
In-Reply-To: <50101e8c7b5215e2da365a815c5764c2598bdc02.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Mar 2023 19:25:17 +0100
Message-ID: <CAJZ5v0jpbcoiDZWB2twJsiv1rHrojoe6wOmbSgt8ywP7=QPG5w@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] thermal: core: Introduce thermal_cooling_device_update()
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

On Tue, Mar 7, 2023 at 5:44 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-03-03 at 20:23 +0100, Rafael J. Wysocki wrote:
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
> >  drivers/thermal/thermal_core.c  |   47 ++++++++++++++++++++++++++
> >  drivers/thermal/thermal_core.h  |    1
> >  drivers/thermal/thermal_sysfs.c |   72
> > +++++++++++++++++++++++++++++++++++-----
> >  include/linux/thermal.h         |    1
> >  4 files changed, 113 insertions(+), 8 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1057,6 +1057,53 @@ static bool thermal_cooling_device_prese
> >       return false;
> >  }
> >
> > +void thermal_cooling_device_update(struct thermal_cooling_device
> > *cdev)
> > +{
> > +     unsigned long state;
> > +
> > +     if (!cdev)
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
> > +     if (cdev->ops->get_cur_state(cdev, &state))
> > +             goto unlock;
> > +
> > +     if (state <= cdev->max_state)
> > +             goto update_stats;
> > +
> how could the .get_cur_state() callback returns a value higher than
> .get_max_state()? Isn't this a driver problem?

It is a driver problem, but the check needs to be done here in case
the driver has this problem, because
thermal_cooling_device_stats_update() below might write out of array
bounds otherwise.

> > +     if (cdev->ops->set_cur_state(cdev, state))
> > +             goto unlock;
>
> even if we don't error out, should we reevaluate .get_max_state() and
> update cdev->max_state?

This has just been done and in fact it is not necessary to call the
driver to set the state to the value that has just been returned by
it.  Actually, this particular piece is broken, because passing a
value above max_state to the "set" callback here doesn't make sense.
I'll fix this in v2.

> > +
> > +update_stats:
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
> > @@ -127,6 +127,7 @@ int thermal_zone_create_device_groups(st
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
> > @@ -384,6 +384,7 @@ devm_thermal_of_cooling_device_register(
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
