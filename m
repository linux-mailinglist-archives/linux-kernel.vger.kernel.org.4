Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA277265EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFGQ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFGQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8761FEC;
        Wed,  7 Jun 2023 09:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFD46415F;
        Wed,  7 Jun 2023 16:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD5C433EF;
        Wed,  7 Jun 2023 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686155330;
        bh=qhVYY2FmMZrFRsftIUZetCqdFejj1HerZ9DwCRLZCxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JM4c4kh8ZNry5+PjpNC3mhXchJQIlXchKkkbksW3y4vGtvDWXBwLDA8+r03W3aAqY
         OTn5QZnAh1PkstgOXLFhV4DaGIzs4kuiJM7s9gcgYJhV2+lE0kZxDsdON81OJhN1a3
         XatHC3jWdWGULKXBtIbquO5i+KqCyQqcCcLbE3U6/+Tc8nIvRe/wOfWQAAMD/ZomZV
         MLGwYvkA6RmHyL4SKCT76t7B0snL9IgLfPoWJIUx1I6PBDcWKMZJwzGWc8SJ+9QCZ2
         8ysLrF1rxAWuqgqQVGtOFyzMfsm3ZrLGszM/4b3NCnwepl3Y95yOBJ3ZqU64v7QWpV
         QSOVEcr6sJ7ug==
Date:   Wed, 7 Jun 2023 09:28:47 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Valentin, Eduardo" <eduval@amazon.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "evalenti@kernel.org" <evalenti@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZICwP9MqJYwrw0HW@uf8f119305bce5e.ant.amazon.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <27c8bd5ddea62391f9573ea77cfcebb4fa88ff66.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c8bd5ddea62391f9573ea77cfcebb4fa88ff66.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui!

Long time no chatting! In this case, no email exchange. Good to hear from you.

On Wed, Jun 07, 2023 at 06:32:46AM +0000, Zhang, Rui wrote:
> 
> 
> 
> On Tue, 2023-06-06 at 17:37 -0700, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduval@amazon.com>
> >
> > As the thermal zone caches the current and last temperature
> > value, the sysfs interface can use that instead of
> > forcing an actual update or read from the device.
> > This way, if multiple userspace requests are coming
> > in, we avoid storming the device with multiple reads
> > and potentially clogging the timing requirement
> > for the governors.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
> > Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
> > Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
> > Cc: linux-pm@vger.kernel.org (open list:THERMAL)
> > Cc: linux-kernel@vger.kernel.org (open list)
> >
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index b6daea2398da..a240c58d9e08 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -35,12 +35,23 @@ static ssize_t
> >  temp_show(struct device *dev, struct device_attribute *attr, char
> > *buf)
> >  {
> >         struct thermal_zone_device *tz = to_thermal_zone(dev);
> > -       int temperature, ret;
> > -
> > -       ret = thermal_zone_get_temp(tz, &temperature);
> > +       int temperature;
> >
> > -       if (ret)
> > -               return ret;
> > +       /*
> > +        * don't force new update from external reads
> > +        * This way we avoid messing up with time constraints.
> > +        */
> > +       if (tz->mode == THERMAL_DEVICE_DISABLED) {
> > +               int r;
> > +
> > +               r = thermal_zone_get_temp(tz, &temperature); /* holds
> > tz->lock*/
> 
> what is the expected behavior of a disabled zone?
> 
> IMO, the hardware may not be functional at this point, and reading the
> temperature should be avoided, as we do in
> __thermal_zone_device_update().
> 
> should we just return failure in this case?
> 
> userspace should poke the temp attribute for enabled zones only.

While I see your point, My understanding is that thermal zone mode
is either kernel mode or userspace mode, which to my interpretation,
it dictating where the control is, not that there is a malfunction,
necessarily.

Taking that perspective, the expected behavior here is to have a
in userspace control/governor, where it:
1. disables the in kernel control
2. monitors the thermal zone by reading the /temp property
3. Actuates on the assigned cooling devices for the thermal zone.

The above setup works pretty well for non critical control, where
the system design or state does not require an in kernel control.
And for that scenario, the proposed cached value will not be updated
given that the in kernel thread is not collecting/updating temperature
values anymore, therefore, the sysfs entry has to talk to the
driver to get the most current value.

For the failure case you referred to, Rui, This patch will handle it
too. It will talk to the driver, if the device is malfunction, the
driver will return an error which will be reported back
to userspace, as an error code upon read, which is expected behavior
for userspace to know that there is a problem.

> 
> thanks,
> rui
> > +               if (r)
> > +                       return r;
> > +       } else {
> > +               mutex_lock(&tz->lock);
> > +               temperature = tz->temperature;
> > +               mutex_unlock(&tz->lock);
> > +       }
> >
> >         return sprintf(buf, "%d\n", temperature);
> >  }
> 

-- 
All the best,
Eduardo Valentin
