Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7D728680
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjFHRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFHRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B42D42;
        Thu,  8 Jun 2023 10:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A336E64FE7;
        Thu,  8 Jun 2023 17:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B588CC433EF;
        Thu,  8 Jun 2023 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686246246;
        bh=YstqgG53D47PFgySbwoE/KQwDnk0tCtYtYZ0CFGnAGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB2u9MZN916VwO2e0ppWQDmdM6ZL0ZlziPTv2rxAGR6hZg0VaeR/1HNJb+Kd8W/9K
         tMnFyRHuDiu31nSONnHh5n8erTuHqd0TpzRy3UPLCERxxbdYHMLVbPbD6wBNrUCo52
         yu4HF8M4XhGGGu2NG6xvatYhYveh8ACNr/o2TjwOlAGiGUNUAFRnxc63D7FdN3V5Ui
         hJItKNY4npTsBMG/L9pJ9ado01m6uec3LRraiwlgApWyv96uKXTugSdhmfrQhFx5I4
         XyNy3OqC6PanYCKRgC1TUWymgVSlNLHi+bZlh1FjcTgmIUu3WJHrZW3MYaN4bPFw4C
         gmfrKw50zan0w==
Date:   Thu, 8 Jun 2023 10:44:04 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On Wed, Jun 07, 2023 at 08:23:08PM +0200, Daniel Lezcano wrote:
> 
> 
> 
> On 07/06/2023 18:38, Eduardo Valentin wrote:
> > Hey Daniel,
> > 
> > Thanks for taking the time to read the patch.
> > 
> > On Wed, Jun 07, 2023 at 11:24:21AM +0200, Daniel Lezcano wrote:
> > > 
> > > 
> > > 
> > > Hi Eduardo,
> > > 
> > > On 07/06/2023 02:37, Eduardo Valentin wrote:
> > > > From: Eduardo Valentin <eduval@amazon.com>
> > > > 
> > > > As the thermal zone caches the current and last temperature
> > > > value, the sysfs interface can use that instead of
> > > > forcing an actual update or read from the device.
> > > 
> > > If the read fails, userspace can handle that by using the previous
> > > value. Do we really want to hide driver dysfunctions?
> > 
> > Good point.
> > 
> > In fact I thought of this exact problem. I sent only this patch,
> > but it has more changes to come.
> > 
> > The next changes will replicate the current design of
> > storing last_temperature in the thermal zone to also store
> > the last return value, success or error, on the thermal zone
> > too so that we can use here at the front end to report back
> > to userspace when the reads are failing.
> >
> > But yes, you are right, we do not want to keep reporting
> > a successful read when the thermal zone thread has been
> > failing to update the value, that needs to be reported
> > up back to userspace.
> 
> IIUC, you want the temperature to be updated only by the polling thread
> and when the userspace reads the temperature, it reads a cached value,
> is that correct ?

That is correct. I want to minimize the amount of actual driver / device accesses.

> 
> > > > This way, if multiple userspace requests are coming
> > > > in, we avoid storming the device with multiple reads
> > > > and potentially clogging the timing requirement
> > > > for the governors.
> 
> Sorry, I'm not convinced :/
> 
> > > Can you elaborate 'the timing requirement for the governors' ? I'm
> > > missing the point
> > 
> > 
> > The point is to avoid contention on the device update path.
> > Governor that use differential equations on temperature over time
> > will be very time sensitive. Step wise, power allocator, or any
> > PID will be very sensitive to time. So, If userspace is hitting
> > this API too often we can see cases where the updates needed to
> > service userspace may defer/delay the execution of the governor
> > logic.
> 
> AFAIK, reading a temperature value is usually between less than 1us and
> 10us (depending on the sampling configuration in the driver).
> 
> I've done some measurements to read a temperature through sysfs and
> netlink. It is between 2us and 7us on a platforms where reading a 900ns
> latency sensor, sysfs being faster.
> 
> The time sensitive governor is the power allocator and usually, the
> sampling period is between 100ms and 250ms.
> 
> The thermal zones with fast thermal transitions may need faster sampling
> period but the hardware offloads the mitigation in this case by sampling
> every 100*us*, IIRC.
> 
> Given that, I'm not sure we are facing a design issue with thermal
> framework.

The numbers above works well for memory IO devices, like a on DIE bandgap.
In that case, I agree, the concern is less of a factual issue.
The numbers becomes completely different if you have a monitor
based on a I2C that shares a bus with multiple other devices :-)
and you have multiple userspace requests coming in.

In that case there are more than one contention. One is the simple
fact that it is going to contend on thermal zone thread and userspace access.
The other contention is the I2C bus lock itself. All of that adds up.


> 
> Do you have a use case with some measurements to spot an issue or is it
> a potential issue you identified ?


yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
and needs to update the zone every 100ms. Each read in this bus, if done alone
would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
well technically 9, but rounding for the sake of the example, which gets you
50 / 100KHz = 500 us. That is for a single read. You add one single extra 
userspace read triggering an unused device update, that is already a 1ms drift.
Basically you looking at 0.5% for each extra userspace read competing in this
sysfs node. You add extra devices in the same I2C bus, your governor is looking
at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
I did not even include the lock overhead considered for this CPU ;-)

Again, this is not about controlling the DIE temperature of the CPU you
are running the thermal subsystem. This is about controlling
a target device.

> 
> > Despite that, there is really no point to have more updates than
> > what was configured for the thermal zone to support. Say that
> > we configure a thermal zone to update itself every 500ms, yet
> > userspace keeps sending reads every 100ms, we do not need necessarily
> > to do a trip to the device every single time to update the temperature,
> > as per the design for the thermal zone.
> 
> Sorry, I do not agree. The thermal zone is configured with a monitoring
> sampling period to detect trip point crossing and it can be configured
> without sampling period at all, just basing on trip point crossing
> interrupt.

That is right, one can derive a working policy solely based on
IRQ. But not true for all cases is it? The stepwise and power allocator
will need to have intermediate checks before actual trip crossing. 
Specially for the allocator case, which is more time bound. Situation
becomes even more time sensitive when the cooling effect of your
cooling device is on the hundreds of milliseconds to seconds, like a fan,
not on nano or microseconds, like throttling.

> 
> The userspace has the right to read the current temperature it is
> interested in. For instance, the 'thermometer' in
> tools/thermal/thermometer may want to read the temperature at a high
> rate in order to profile the thermal zones with/without the mitigation
> kicking in.
> 
> Caching the values just break the current behavior.

I see your concern here. Yeah, let's make sure we dont break this tool.

Does the tool need to have the thermal zone in kernel mode?

The thermal zone will still behave the same way while reading
/temp after this patch if the thermal zone is set to non kernel mode.


Alternatively we can make the caching behavior non-default/optional too. 

> 
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> > > > Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> > > > Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> > > > Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> > > > Cc: linux-kernel@vger.kernel.org (open list)
> > > > 
> > > > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > > > ---
> > > >    drivers/thermal/thermal_sysfs.c | 21 ++++++++++++++++-----
> > > >    1 file changed, 16 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > > > index b6daea2398da..a240c58d9e08 100644
> > > > --- a/drivers/thermal/thermal_sysfs.c
> > > > +++ b/drivers/thermal/thermal_sysfs.c
> > > > @@ -35,12 +35,23 @@ static ssize_t
> > > >    temp_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > >    {
> > > >        struct thermal_zone_device *tz = to_thermal_zone(dev);
> > > > -     int temperature, ret;
> > > > -
> > > > -     ret = thermal_zone_get_temp(tz, &temperature);
> > > > +     int temperature;
> > > > 
> > > > -     if (ret)
> > > > -             return ret;
> > > > +     /*
> > > > +      * don't force new update from external reads
> > > > +      * This way we avoid messing up with time constraints.
> > > > +      */
> > > > +     if (tz->mode == THERMAL_DEVICE_DISABLED) {
> > > > +             int r;
> > > > +
> > > > +             r = thermal_zone_get_temp(tz, &temperature); /* holds tz->lock*/
> > > > +             if (r)
> > > > +                     return r;
> > > > +     } else {
> > > > +             mutex_lock(&tz->lock);
> > > > +             temperature = tz->temperature;
> > > > +             mutex_unlock(&tz->lock);
> > > > +     }
> > > 
> > > No please, we are pushing since several weeks a lot of changes to
> > > encapsulate the thermal zone device structure and prevent external core
> > > components to use the internals directly. Even if we can consider the
> > > thermal_sysfs as part of the core code, that changes is not sysfs related.
> > 
> > Can you clarify your concern, is it the direct access ? The lock ?
> > what is the concern?
> > 
> > What is your suggestion here? Do you want me to write a helper
> > function that gets tz->temperature without doing a ops->get_temp()?
> 
> The concern is the thermal framework code is not really in a good shape
> and the internals leaked around in the different drivers all around the
> subsystems, that led to drivers tampering with the thermal zone device
> structure data (including taking locks).
> 
> There are ongoing efforts to do some house cleaning around the thermal
> zone device structure encapsulation as well as getting ride of the
> different ops get_trip* by replacing that with a generic trip point
> structure to deal with in the thermal core code.
> 
> Those with the final objective to have the trip points ordered and
> handle the trip point crossing correctly detected (it is currently
> somehow broken).
> 
> Here the code does directly access tz->*.
> 
> Even not being convinced by the change proposal, I would have handle
> this value cache in the thermal_zone_get_temp() function directly in
> order to preserve the code self-encapsulation.

Ok. So, is your proposal to simply get rid of the direct access? So long the
code is kept self encapsulated, this concern would be addressed?

> 
> 
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
All the best,
Eduardo Valentin
