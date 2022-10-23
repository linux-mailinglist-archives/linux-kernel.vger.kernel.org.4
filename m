Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3460958D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJWS2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJWS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:28:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E1904DF2D;
        Sun, 23 Oct 2022 11:27:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39C30ED1;
        Sun, 23 Oct 2022 11:27:53 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27B733F7B4;
        Sun, 23 Oct 2022 11:27:46 -0700 (PDT)
Date:   Sun, 23 Oct 2022 19:27:40 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     daniel.lezcano@linaro.org, linux@roeck-us.net
Cc:     sudeep.holla@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: (bug report) HWMON & Thermal interactions
Message-ID: <Y1WHnJ6h1RSOipV4@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Starting with v6.1-rc1 the SCMI HWMON driver failed probing on my JUNO due
to the fact that no trip points were (ever !) defined in the DT; bisecting it
looks like that after:

https://lore.kernel.org/all/20220804224349.1926752-28-daniel.lezcano@linexp.org/

the presence of the mandatory trips node within thermal zones is now
enforced.

So, this is NOT what this bug report is about (I'll post soon patches for
the JUNO DT missing trips) BUT once this problem was solved in the DT,
another issue appeared:

[    1.921929] hwmon hwmon0: temp2_input not attached to any thermal zone

that despite having now a goodi/valid DT describing 2 sensors and 2 thermal zones
embedding that sensors, only the first one is found as belonging to one ThermZ.
(this happens ALSO with v6.0 once I added the trips...)

Digging deep into this, it turned out that inside the call chain

devm_hwmon_device_register_with_info
  hwmon_device_register_with_info
    __hwmon_device_register
	hwmon_thermal_register_sensors(dev)
		--> hwmon_thermal_add_sensor(dev, j)
			--> devm_thermal_of_zone_register(dev, sensor_id, tdata, )

the HWMON channel index j is passed to the Thermal framework in order to
search and bind sensors with defined thermal zone, but this lead to the
assumption that sequential HWMON channel indexes corresponds one-to-one to the
underlying real sensor IDs that the ThermalFramework uses for matching
within the DT.

On a system like my SCMI-based DT where I have 2 temp-sensors bound to 2
thermal zones like:

thernal_zones {
	pmic {
		...
		thermal-sensors = <&scmi_sensors0 0>;
		...
		trips {
			...
		}
	soc {
		...
		thermal-sensors = <&scmi_sensors0 3>;
		...
		trips {
			...
		}
	}
}

This works fine by chance for the pmic (j=0, sensor_id=0) BUT cannot work for
the soc where J=1 BUT the real sensor ID is 3.

Note that there can be a number of sensors, not all of them of a type handled
by HWMON, and enumerated by SCMI in different ways depending on the
platform.

I suppose this is not an SCMI-only related issue, but maybe in non-SCMI
context, where sensors are purely defined in the DT, the solution can be
more easily attained (i.e. renumber the sensors).

At first I tried to solve this inside scmi-hwmon.c BUT I could not find
a way to present to the HWMON subsystem the list of sensors preserving
the above index/sensor_id matching (not even with a hack like passing
down dummy sensors to the HWMON subsystem to fill the 'holes' in the
numbering)

My tentative solution, which works fine for me in my context, was to add
an optional HWMON hwops, so that the core hwmon can retrieve if needed the
real sensor ID if different from the channel index (using an optional hwops
instead of some static hwinfo var let me avoid to have to patch all the
existent hwmon drivers that happens to just work fine as of today...but
maybe it is not necessarily the proper final solution...)

i.e.

----8<----

Author: Cristian Marussi <cristian.marussi@arm.com>
Date:   Fri Oct 21 17:24:04 2022 +0100

    hwmon: Add new .get_sensor_id hwops
    
    Add a new optional helper which can be defined to allow an hwmon chip to
    provide the logic to map hwmon indexes to the real underlying sensor IDs.
    
    Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 4218750d5a66..45d3d5070cde 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -213,7 +213,8 @@ static void hwmon_thermal_remove_sensor(void *data)
        list_del(data);
 }
 
-static int hwmon_thermal_add_sensor(struct device *dev, int index)
+static int hwmon_thermal_add_sensor(struct device *dev, int index,
7+                                   unsigned int sensor_id)
 {
        struct hwmon_device *hwdev = to_hwmon_device(dev);
        struct hwmon_thermal_data *tdata;
@@ -227,7 +228,7 @@ static int hwmon_thermal_add_sensor(struct device *dev, int index)
        tdata->dev = dev;
        tdata->index = index;
 
-       tzd = devm_thermal_of_zone_register(dev, index, tdata,
+       tzd = devm_thermal_of_zone_register(dev, sensor_id, tdata,
                                            &hwmon_thermal_ops);
        if (IS_ERR(tzd)) {
                if (PTR_ERR(tzd) != -ENODEV)
@@ -264,13 +265,18 @@ static int hwmon_thermal_register_sensors(struct device *dev)
 
                for (j = 0; info[i]->config[j]; j++) {
                        int err;
+                       unsigned int id;
 
                        if (!(info[i]->config[j] & HWMON_T_INPUT) ||
                            !chip->ops->is_visible(drvdata, hwmon_temp,
                                                   hwmon_temp_input, j))
                                continue;
 
-                       err = hwmon_thermal_add_sensor(dev, j);
+                       id = !chip->ops->get_sensor_id ? j :
+                               chip->ops->get_sensor_id(drvdata,
+                                                        hwmon_temp, j);
+
+                       err = hwmon_thermal_add_sensor(dev, j, id);
                        if (err)
                                return err;
                }
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 14325f93c6b2..e5dbab83f4d1 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -396,6 +396,9 @@ enum hwmon_intrusion_attributes {
 struct hwmon_ops {
        umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
                              u32 attr, int channel);
+       unsigned int (*get_sensor_id)(const void *drvdata,
+                                     enum hwmon_sensor_types type,
+                                     int channel);
        int (*read)(struct device *dev, enum hwmon_sensor_types type,
                    u32 attr, int channel, long *val);
        int (*read_string)(struct device *dev, enum hwmon_sensor_types type,


----->8----


... plus obviously the related scmi-hwmon.c patch to make use of this.

Any thought ? Am I missing something ?
(not really an expert on both subsystems really ... :P)

Thanks,
Cristian

