Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF0C609ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJXKSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJXKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:18:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5068CC6;
        Mon, 24 Oct 2022 03:18:08 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1omuWy-0000PJ-Jf; Mon, 24 Oct 2022 12:18:04 +0200
Message-ID: <b0bf779e-6195-4fad-377a-ba1e63419c5d@leemhuis.info>
Date:   Mon, 24 Oct 2022 12:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: (bug report) HWMON & Thermal interactions #forregzbot
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y1WHnJ6h1RSOipV4@e120937-lin>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y1WHnJ6h1RSOipV4@e120937-lin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666606688;e2c2e9da;
X-HE-SMSGID: 1omuWy-0000PJ-Jf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 23.10.22 20:27, Cristian Marussi wrote:
> 
> Starting with v6.1-rc1 the SCMI HWMON driver failed probing on my JUNO due
> to the fact that no trip points were (ever !) defined in the DT; bisecting it
> looks like that after:

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced e51813313
#regzbot title SCMI HWMON driver failed probing on JUNO
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> https://lore.kernel.org/all/20220804224349.1926752-28-daniel.lezcano@linexp.org/
> 
> the presence of the mandatory trips node within thermal zones is now
> enforced.
> 
> So, this is NOT what this bug report is about (I'll post soon patches for
> the JUNO DT missing trips) BUT once this problem was solved in the DT,
> another issue appeared:
> 
> [    1.921929] hwmon hwmon0: temp2_input not attached to any thermal zone
> 
> that despite having now a goodi/valid DT describing 2 sensors and 2 thermal zones
> embedding that sensors, only the first one is found as belonging to one ThermZ.
> (this happens ALSO with v6.0 once I added the trips...)
> 
> Digging deep into this, it turned out that inside the call chain
> 
> devm_hwmon_device_register_with_info
>   hwmon_device_register_with_info
>     __hwmon_device_register
> 	hwmon_thermal_register_sensors(dev)
> 		--> hwmon_thermal_add_sensor(dev, j)
> 			--> devm_thermal_of_zone_register(dev, sensor_id, tdata, )
> 
> the HWMON channel index j is passed to the Thermal framework in order to
> search and bind sensors with defined thermal zone, but this lead to the
> assumption that sequential HWMON channel indexes corresponds one-to-one to the
> underlying real sensor IDs that the ThermalFramework uses for matching
> within the DT.
> 
> On a system like my SCMI-based DT where I have 2 temp-sensors bound to 2
> thermal zones like:
> 
> thernal_zones {
> 	pmic {
> 		...
> 		thermal-sensors = <&scmi_sensors0 0>;
> 		...
> 		trips {
> 			...
> 		}
> 	soc {
> 		...
> 		thermal-sensors = <&scmi_sensors0 3>;
> 		...
> 		trips {
> 			...
> 		}
> 	}
> }
> 
> This works fine by chance for the pmic (j=0, sensor_id=0) BUT cannot work for
> the soc where J=1 BUT the real sensor ID is 3.
> 
> Note that there can be a number of sensors, not all of them of a type handled
> by HWMON, and enumerated by SCMI in different ways depending on the
> platform.
> 
> I suppose this is not an SCMI-only related issue, but maybe in non-SCMI
> context, where sensors are purely defined in the DT, the solution can be
> more easily attained (i.e. renumber the sensors).
> 
> At first I tried to solve this inside scmi-hwmon.c BUT I could not find
> a way to present to the HWMON subsystem the list of sensors preserving
> the above index/sensor_id matching (not even with a hack like passing
> down dummy sensors to the HWMON subsystem to fill the 'holes' in the
> numbering)
> 
> My tentative solution, which works fine for me in my context, was to add
> an optional HWMON hwops, so that the core hwmon can retrieve if needed the
> real sensor ID if different from the channel index (using an optional hwops
> instead of some static hwinfo var let me avoid to have to patch all the
> existent hwmon drivers that happens to just work fine as of today...but
> maybe it is not necessarily the proper final solution...)
> 
> i.e.
> 
> ----8<----
> 
> Author: Cristian Marussi <cristian.marussi@arm.com>
> Date:   Fri Oct 21 17:24:04 2022 +0100
> 
>     hwmon: Add new .get_sensor_id hwops
>     
>     Add a new optional helper which can be defined to allow an hwmon chip to
>     provide the logic to map hwmon indexes to the real underlying sensor IDs.
>     
>     Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 4218750d5a66..45d3d5070cde 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -213,7 +213,8 @@ static void hwmon_thermal_remove_sensor(void *data)
>         list_del(data);
>  }
>  
> -static int hwmon_thermal_add_sensor(struct device *dev, int index)
> +static int hwmon_thermal_add_sensor(struct device *dev, int index,
> 7+                                   unsigned int sensor_id)
>  {
>         struct hwmon_device *hwdev = to_hwmon_device(dev);
>         struct hwmon_thermal_data *tdata;
> @@ -227,7 +228,7 @@ static int hwmon_thermal_add_sensor(struct device *dev, int index)
>         tdata->dev = dev;
>         tdata->index = index;
>  
> -       tzd = devm_thermal_of_zone_register(dev, index, tdata,
> +       tzd = devm_thermal_of_zone_register(dev, sensor_id, tdata,
>                                             &hwmon_thermal_ops);
>         if (IS_ERR(tzd)) {
>                 if (PTR_ERR(tzd) != -ENODEV)
> @@ -264,13 +265,18 @@ static int hwmon_thermal_register_sensors(struct device *dev)
>  
>                 for (j = 0; info[i]->config[j]; j++) {
>                         int err;
> +                       unsigned int id;
>  
>                         if (!(info[i]->config[j] & HWMON_T_INPUT) ||
>                             !chip->ops->is_visible(drvdata, hwmon_temp,
>                                                    hwmon_temp_input, j))
>                                 continue;
>  
> -                       err = hwmon_thermal_add_sensor(dev, j);
> +                       id = !chip->ops->get_sensor_id ? j :
> +                               chip->ops->get_sensor_id(drvdata,
> +                                                        hwmon_temp, j);
> +
> +                       err = hwmon_thermal_add_sensor(dev, j, id);
>                         if (err)
>                                 return err;
>                 }
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 14325f93c6b2..e5dbab83f4d1 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -396,6 +396,9 @@ enum hwmon_intrusion_attributes {
>  struct hwmon_ops {
>         umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
>                               u32 attr, int channel);
> +       unsigned int (*get_sensor_id)(const void *drvdata,
> +                                     enum hwmon_sensor_types type,
> +                                     int channel);
>         int (*read)(struct device *dev, enum hwmon_sensor_types type,
>                     u32 attr, int channel, long *val);
>         int (*read_string)(struct device *dev, enum hwmon_sensor_types type,
> 
> 
> ----->8----
> 
> 
> ... plus obviously the related scmi-hwmon.c patch to make use of this.
> 
> Any thought ? Am I missing something ?
> (not really an expert on both subsystems really ... :P)
> 
> Thanks,
> Cristian
> 
