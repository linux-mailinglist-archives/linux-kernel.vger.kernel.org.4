Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D560AE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiJXOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiJXOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:49:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D823A102DE6;
        Mon, 24 Oct 2022 06:26:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC62C1042;
        Mon, 24 Oct 2022 05:47:28 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC57A3F7B4;
        Mon, 24 Oct 2022 05:47:21 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:47:11 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (bug report) HWMON & Thermal interactions
Message-ID: <Y1aJTxVdOS6BIVTV@e120937-lin>
References: <Y1WHnJ6h1RSOipV4@e120937-lin>
 <8005acfe-da2d-8d38-0e87-a96c438eeab1@roeck-us.net>
 <93e24737-29e4-6e03-7b47-cd730989047f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93e24737-29e4-6e03-7b47-cd730989047f@roeck-us.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:56:43AM -0700, Guenter Roeck wrote:
> On 10/23/22 14:23, Guenter Roeck wrote:
> > On 10/23/22 11:27, Cristian Marussi wrote:
> > > Hi,
> > > 
> > > Starting with v6.1-rc1 the SCMI HWMON driver failed probing on my JUNO due
> > > to the fact that no trip points were (ever !) defined in the DT; bisecting it
> > > looks like that after:
> > > 
> > > https://lore.kernel.org/all/20220804224349.1926752-28-daniel.lezcano@linexp.org/
> > > 
> > > the presence of the mandatory trips node within thermal zones is now
> > > enforced.
> > > 
> > > So, this is NOT what this bug report is about (I'll post soon patches for
> > > the JUNO DT missing trips) BUT once this problem was solved in the DT,
> > > another issue appeared:
> > > 
> > > [    1.921929] hwmon hwmon0: temp2_input not attached to any thermal zone
> > > 
> > > that despite having now a goodi/valid DT describing 2 sensors and 2 thermal zones
> > > embedding that sensors, only the first one is found as belonging to one ThermZ.
> > > (this happens ALSO with v6.0 once I added the trips...)
> > > 
> > > Digging deep into this, it turned out that inside the call chain
> > > 
> > > devm_hwmon_device_register_with_info
> > >    hwmon_device_register_with_info
> > >      __hwmon_device_register
> > >     hwmon_thermal_register_sensors(dev)
> > >         --> hwmon_thermal_add_sensor(dev, j)
> > >             --> devm_thermal_of_zone_register(dev, sensor_id, tdata, )
> > > 
> > > the HWMON channel index j is passed to the Thermal framework in order to
> > > search and bind sensors with defined thermal zone, but this lead to the
> > > assumption that sequential HWMON channel indexes corresponds one-to-one to the
> > > underlying real sensor IDs that the ThermalFramework uses for matching
> > > within the DT.
> > > 
> > > On a system like my SCMI-based DT where I have 2 temp-sensors bound to 2
> > > thermal zones like:
> > > 
> > > thernal_zones {
> > >     pmic {
> > >         ...
> > >         thermal-sensors = <&scmi_sensors0 0>;
> > >         ...
> > >         trips {
> > >             ...
> > >         }
> > >     soc {
> > >         ...
> > >         thermal-sensors = <&scmi_sensors0 3>;
> > >         ...
> > >         trips {
> > >             ...
> > >         }
> > >     }
> > > }
> > > 
> > > This works fine by chance for the pmic (j=0, sensor_id=0) BUT cannot work for
> > > the soc where J=1 BUT the real sensor ID is 3.
> > > 
> > > Note that there can be a number of sensors, not all of them of a type handled
> > > by HWMON, and enumerated by SCMI in different ways depending on the
> > > platform.
> > > 
> > > I suppose this is not an SCMI-only related issue, but maybe in non-SCMI
> > > context, where sensors are purely defined in the DT, the solution can be
> > > more easily attained (i.e. renumber the sensors).
> > > 
> > > At first I tried to solve this inside scmi-hwmon.c BUT I could not find
> > > a way to present to the HWMON subsystem the list of sensors preserving
> > > the above index/sensor_id matching (not even with a hack like passing
> > > down dummy sensors to the HWMON subsystem to fill the 'holes' in the
> > > numbering)
> > > 
> > > My tentative solution, which works fine for me in my context, was to add
> > > an optional HWMON hwops, so that the core hwmon can retrieve if needed the
> > > real sensor ID if different from the channel index (using an optional hwops
> > > instead of some static hwinfo var let me avoid to have to patch all the
> > > existent hwmon drivers that happens to just work fine as of today...but
> > > maybe it is not necessarily the proper final solution...)
> > > 
> > > i.e.
> > > 
> > > ----8<----
> > > 
> > > Author: Cristian Marussi <cristian.marussi@arm.com>
> > > Date:   Fri Oct 21 17:24:04 2022 +0100
> > > 
> > >      hwmon: Add new .get_sensor_id hwops
> > >      Add a new optional helper which can be defined to allow an hwmon chip to
> > >      provide the logic to map hwmon indexes to the real underlying sensor IDs.
> > 
> > Maybe I am missing something, but ...
> > 
> > The driver isn't supposed to know anything about thermal devices and
> > thermal zones. If that no longer works, and drivers have to know about
> > thermal zones and thermal zone device index values anyway, we might
> > as well pull thermal device support from the hwmon core and implement
> > it in drivers.
> > 
> 
> No, wait: The question is really: Why does the scmi driver present the sensor
> with index 3 to the hwmon subsystem as sensor with index 1 ?
> 
> If the sensor has index 3, and is presented to other entities as sensor
> with index 3, it should be presented to the hwmon subsystem as sensor with
> index 3, not with index 1. If sensors with index 1..2 do not exist,
> the is_visible function should return 0 for those sensors.
> 

My understanding was that the hwmon index is the index of the channel
and hwmon_channel_info struct groups channels by type while the index is
really used as a pointer in the hwmon_channel_info.config field, so in
this case you're saying I should present 4 temp sensors placing a 'hole'
at sensor 1,2 making is_visible return 0 for those channels ?

Basically keeping the channel indexes in sync with the real sensor ID by
the means of some dummy sensor entries in the config field: this could result
potentially in a lot of holes given in SCMI the sensor_id is 16 bits and
I thought that was too hackish but I can try.

In the meantime, I gave it a go at what you suggested early (if I got it
right...) by removing from the scmi-hwmon driver the HWMON_C_REGISTER_TZ
attribute and adding a few explicit calls to devm_thermal_of_zone_register() at
the end of the probe to specifically register the needed temp sensors (and
associated real sensor IDs) with the ThermalFramework without relying on the
HWMON core for Thermal and it works fine indeed.

Thanks,
Cristian

