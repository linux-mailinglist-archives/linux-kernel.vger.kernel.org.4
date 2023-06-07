Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687872661C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFGQiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFGQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A71FC0;
        Wed,  7 Jun 2023 09:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B1763851;
        Wed,  7 Jun 2023 16:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381ACC433D2;
        Wed,  7 Jun 2023 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686155887;
        bh=Hfb9wB8iH5FYS1FqztE9NGFHXudeNhyrtq27e2tHhA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+ZhSpUt7RKWlwwIsoSu4yB2e/DEOpHfrvszOnJKYXpSqly6BBdjnJvAse/6/W6tf
         baxED2alLIt2DEXNFjXDZbHDZJmfalm3bfAPyZcqSqNNqbeMB4J88jF28UoQ70OeKS
         tDLO/5iRvn4fjhQzULnZCqpdiItysoNSdll9NguETAEafVZJQV3Xr4430hX34IXxoq
         EnBRSQhpYj+V+gfm4wfrXc/Wz1k0h+XtBEUpnPNe+WrL0HGK+3XgxvXvMjbtqvjjJZ
         v5+r+lXXxO5D/uAZZER7kFgSvDJf3ZQjAYiDl4ZphKaeDah+ntzT0AK4VVGxmsv/Ls
         /1SUFFRIyt1IA==
Date:   Wed, 7 Jun 2023 09:38:05 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Daniel,

Thanks for taking the time to read the patch.

On Wed, Jun 07, 2023 at 11:24:21AM +0200, Daniel Lezcano wrote:
> 
> 
> 
> Hi Eduardo,
> 
> On 07/06/2023 02:37, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduval@amazon.com>
> > 
> > As the thermal zone caches the current and last temperature
> > value, the sysfs interface can use that instead of
> > forcing an actual update or read from the device.
> 
> If the read fails, userspace can handle that by using the previous
> value. Do we really want to hide driver dysfunctions?

Good point.

In fact I thought of this exact problem. I sent only this patch,
but it has more changes to come.

The next changes will replicate the current design of
storing last_temperature in the thermal zone to also store
the last return value, success or error, on the thermal zone
too so that we can use here at the front end to report back
to userspace when the reads are failing.

But yes, you are right, we do not want to keep reporting
a successful read when the thermal zone thread has been
failing to update the value, that needs to be reported
up back to userspace.

> 
> > This way, if multiple userspace requests are coming
> > in, we avoid storming the device with multiple reads
> > and potentially clogging the timing requirement
> > for the governors.
> 
> 
> Can you elaborate 'the timing requirement for the governors' ? I'm
> missing the point


The point is to avoid contention on the device update path.
Governor that use differential equations on temperature over time
will be very time sensitive. Step wise, power allocator, or any
PID will be very sensitive to time. So, If userspace is hitting
this API too often we can see cases where the updates needed to
service userspace may defer/delay the execution of the governor
logic.

Despite that, there is really no point to have more updates than
what was configured for the thermal zone to support. Say that
we configure a thermal zone to update itself every 500ms, yet
userspace keeps sending reads every 100ms, we do not need necessarily
to do a trip to the device every single time to update the temperature,
as per the design for the thermal zone.

> 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> > Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> > Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> > Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> > Cc: linux-kernel@vger.kernel.org (open list)
> > 
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >   drivers/thermal/thermal_sysfs.c | 21 ++++++++++++++++-----
> >   1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index b6daea2398da..a240c58d9e08 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -35,12 +35,23 @@ static ssize_t
> >   temp_show(struct device *dev, struct device_attribute *attr, char *buf)
> >   {
> >       struct thermal_zone_device *tz = to_thermal_zone(dev);
> > -     int temperature, ret;
> > -
> > -     ret = thermal_zone_get_temp(tz, &temperature);
> > +     int temperature;
> > 
> > -     if (ret)
> > -             return ret;
> > +     /*
> > +      * don't force new update from external reads
> > +      * This way we avoid messing up with time constraints.
> > +      */
> > +     if (tz->mode == THERMAL_DEVICE_DISABLED) {
> > +             int r;
> > +
> > +             r = thermal_zone_get_temp(tz, &temperature); /* holds tz->lock*/
> > +             if (r)
> > +                     return r;
> > +     } else {
> > +             mutex_lock(&tz->lock);
> > +             temperature = tz->temperature;
> > +             mutex_unlock(&tz->lock);
> > +     }
> 
> No please, we are pushing since several weeks a lot of changes to
> encapsulate the thermal zone device structure and prevent external core
> components to use the internals directly. Even if we can consider the
> thermal_sysfs as part of the core code, that changes is not sysfs related.

Can you clarify your concern, is it the direct access ? The lock ? 
what is the concern?

What is your suggestion here? Do you want me to write a helper
function that gets tz->temperature without doing a ops->get_temp()?


Let me know.

> 
> >       return sprintf(buf, "%d\n", temperature);
> >   }
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
