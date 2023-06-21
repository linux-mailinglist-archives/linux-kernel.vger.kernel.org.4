Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E0737A61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFUElx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFUEls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D61BFE;
        Tue, 20 Jun 2023 21:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A7B6145F;
        Wed, 21 Jun 2023 04:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860E4C433C8;
        Wed, 21 Jun 2023 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687322461;
        bh=6oRTTtk/IzodiZKEwgwp7SySHcNigQH0hHFSbtcK7u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuZ5vFIxGHcafuljlSX4bk7Y0OTL+7IxbxBYNV6y5S0sj+VGcUNB9XGuXTqetqxmT
         fXDHzqRgmFHPfoe7WGlswixcTtrBy6BUDqMWWFec973jwi/cPo5jV3+I6z1A/krN9C
         zwja7dD4O808jjGhp9N0pD56/RTzIj+266wVZNNRVe51QycP135SkYYLKhlwXgXf89
         0JZZ/UT89dgKjp87TDLK4kB/dgojtGu3fL7ax2EWBmR+M8eB+9ZhBYcdYX7FvQDkIh
         v5GR3c8O/IHU0J9wC52XnHIU6uaSwiZ37JUhN1B9iO4cV8VcN67PHmMKHeoqENj5rs
         rLP84AbKOhaHQ==
Date:   Tue, 20 Jun 2023 21:40:58 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] thermal: stats: track number of change requests due to tz
Message-ID: <ZJJ/Wkao+Z0qTWFE@uf8f119305bce5e.ant.amazon.com>
References: <20230519032719.2581689-1-evalenti@kernel.org>
 <20230519032719.2581689-3-evalenti@kernel.org>
 <CAJZ5v0hqGg9h+iOpKDLr=BXGk3p6sBTMM3nVok97yhRj5EdQ3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hqGg9h+iOpKDLr=BXGk3p6sBTMM3nVok97yhRj5EdQ3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:12:52PM +0200, Rafael J. Wysocki wrote:
> 
> 
> 
> On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
> >
> > From: Eduardo Valentin <eduval@amazon.com>
> >
> > This patch improves the current cooling device
> > statistics by adding a new file under
> > cdev/stats/requests_of_thermal_zone
> >
> > to represent the number of times each thermal zone
> > requested the cooling device to effectively change.
> > If the request associated was not serviced because
> > another thermal zone asked for a higher cooling level,
> > this counter does not increase.
> 
> What if the cdev is associated with two thermal zones asking for the
> same state of it?

same as explained before, there will be always one thermal instance
that is picked. This patch considers that.

> 
> > The file format is:
> > thermal_zone: <type> <count>
> >
> > Samples:
> > $ cat cdev0/stats/requests_of_thermal_zone
> > thermal_zone: amb0      2
> 
> The "one value per attribute" sysfs rule violation.
> 
> >
> > In this example, it means the thermal zone 'amb0' has requested
> > 2 times for cdev0 to change state.
> 
> Like in the previous patch, it would be good to explain the use case.
> 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> > Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> > Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> > Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> > Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> > Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> > Cc: linux-kernel@vger.kernel.org (open list)
> >
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >  .../driver-api/thermal/sysfs-api.rst          |  2 +
> >  drivers/thermal/thermal_core.h                |  1 +
> >  drivers/thermal/thermal_sysfs.c               | 52 +++++++++++++++++++
> >  3 files changed, 55 insertions(+)
> >
> > diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> > index caa50d61a5bc..75309a51d9b3 100644
> > --- a/Documentation/driver-api/thermal/sysfs-api.rst
> > +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> > @@ -369,6 +369,8 @@ Thermal cooling device sys I/F, created once it's registered::
> >      |---stats/trans_table:     Cooling state transition table
> >      |---stats/time_in_thermal_zone_ms: Time that this cooling device was driven
> >                                  each associated thermal zone.
> > +    |---stats/requests_of_thermal_zone:        Total number of times this cooling device
> > +                                changed due to each associated thermal zone.
> 
> The meaning of the above description is not clear to me.
> 
> >
> >
> >  Then next two dynamic attributes are created/removed in pairs. They represent
> > diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> > index 3cce60c6e065..ed6511c3b794 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -103,6 +103,7 @@ struct thermal_instance {
> >         unsigned int weight; /* The weight of the cooling device */
> >         bool upper_no_limit;
> >  #if IS_ENABLED(CONFIG_THERMAL_STATISTICS)
> > +       unsigned long total_requests;
> >         ktime_t time_in; /* time spent in this instance */
> >  #endif
> >  };
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index a3b71f03db75..0bce1415f7e8 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -723,6 +723,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
> >         stats->trans_table[stats->state * (cdev->max_state + 1) + new_state]++;
> >         stats->state = new_state;
> >         stats->total_trans++;
> > +       stats->curr_instance->total_requests++;
> >
> >  unlock:
> >         spin_unlock(&stats->lock);
> > @@ -867,6 +868,54 @@ time_in_thermal_zone_ms_show(struct device *dev, struct device_attribute *attr,
> >         return ret < 0 ? ret : len;
> >  }
> >
> > +static ssize_t
> > +requests_of_thermal_zone_show(struct device *dev, struct device_attribute *attr,
> > +                             char *buf)
> > +{
> > +       LIST_HEAD(cdev_thermal_zone_list);
> > +       struct thermal_cooling_device *cdev = to_cooling_device(dev);
> > +       struct cooling_dev_stats *stats = cdev->stats;
> > +       struct cdev_thermal_zone_residency *res, *next;
> > +       struct thermal_instance *instance;
> > +       ssize_t len = 0, ret = 0;
> > +
> > +       mutex_lock(&cdev->lock);
> > +
> > +       spin_lock(&stats->lock);
> > +       update_time_in_state(stats, stats->curr_instance);
> > +       spin_unlock(&stats->lock);
> > +
> > +       build_cdev_thermal_zone_residency(&cdev_thermal_zone_list, cdev);
> > +
> > +       list_for_each_entry(instance, &cdev->thermal_instances, cdev_node)
> > +               list_for_each_entry(res, &cdev_thermal_zone_list, node)
> > +                       if (strncmp(res->thermal_zone, instance->tz->type,
> > +                                   THERMAL_NAME_LENGTH) == 0)
> > +                               res->counter += instance->total_requests;
> > +
> > +       mutex_unlock(&cdev->lock);
> > +
> > +       list_for_each_entry_safe(res, next, &cdev_thermal_zone_list, node) {
> 
> Why is the _safe variant needed here?
> 
> > +               ret = sprintf(buf + len, "thermal_zone: %s\t%lu\n",
> > +                             res->thermal_zone, res->counter);
> > +
> > +               if (ret == 0)
> > +                       ret = -EOVERFLOW;
> > +
> > +               if (ret < 0)
> > +                       break;
> > +
> > +               len += ret;
> > +       }
> > +
> > +       list_for_each_entry_safe(res, next, &cdev_thermal_zone_list, node) {
> > +               list_del(&res->node);
> > +               kfree(res);
> > +       }
> > +
> > +       return ret < 0 ? ret : len;
> 
> I would prefer
> 
> if (ret < 0)
>         return ret;
> 
> return len;

OK. I will fix this and enhance the explanations.

And the same comments and replies of the previous patch applies here.

> 
> > +}
> > +
> >  static ssize_t
> >  reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
> >             size_t count)
> > @@ -897,6 +946,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
> >
> >         /* Make sure we reset all counters per instance */
> >         list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
> > +               instance->total_requests = 0;
> >                 instance->time_in = ktime_set(0, 0);
> >         }
> >
> > @@ -971,6 +1021,7 @@ static ssize_t trans_table_show(struct device *dev,
> >  static DEVICE_ATTR_RO(total_trans);
> >  static DEVICE_ATTR_RO(time_in_state_ms);
> >  static DEVICE_ATTR_RO(time_in_thermal_zone_ms);
> > +static DEVICE_ATTR_RO(requests_of_thermal_zone);
> >  static DEVICE_ATTR_WO(reset);
> >  static DEVICE_ATTR_RO(trans_table);
> >
> > @@ -978,6 +1029,7 @@ static struct attribute *cooling_device_stats_attrs[] = {
> >         &dev_attr_total_trans.attr,
> >         &dev_attr_time_in_state_ms.attr,
> >         &dev_attr_time_in_thermal_zone_ms.attr,
> > +       &dev_attr_requests_of_thermal_zone.attr,
> >         &dev_attr_reset.attr,
> >         &dev_attr_trans_table.attr,
> >         NULL
> > --

-- 
All the best,
Eduardo Valentin
