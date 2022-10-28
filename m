Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD846115F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJ1Pf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJ1PfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FA615D72E;
        Fri, 28 Oct 2022 08:35:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 112181FB;
        Fri, 28 Oct 2022 08:35:26 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28323F534;
        Fri, 28 Oct 2022 08:35:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:35:12 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
Message-ID: <Y1v2ozURFdIk1PfU@e120937-lin>
References: <20221028140833.280091-1-cristian.marussi@arm.com>
 <20221028140833.280091-7-cristian.marussi@arm.com>
 <b914ea25-a9a8-f443-2ba0-615bdd6cc04f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b914ea25-a9a8-f443-2ba0-615bdd6cc04f@roeck-us.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:11:59AM -0700, Guenter Roeck wrote:
> On 10/28/22 07:08, Cristian Marussi wrote:
> > Available sensors are enumerated and reported by the SCMI platform server
> > using a 16bit identification number; not all such sensors are of a type
> > supported by hwmon subsystem and, among the supported ones, only a subset
> > could be temperature sensors that have to be registered with the Thermal
> > Framework.
> > Potential clashes between hwmon channels indexes and the underlying real
> > sensors IDs do not play well with the hwmon<-->thermal bridge automatic
> > registration routines and could need a sensible number of fake dummy
> > sensors to be made up in order to keep indexes and IDs in sync.
> > 
> > Avoid to use the hwmon<-->thermal bridge dropping the HWMON_C_REGISTER_TZ
> > attribute and instead explicit register temperature sensors directly with
> > the Thermal Framework.
> > 
> 
> 
> For my reference:
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> $subject says "patch 7/8". Patches 1-6 are firmware patches. Does this patch
> depend on the other patches of the series or can I apply it on its own ?

Thanks for having a look first of all !

This patch can be applied on its own...it's just that I have bundled
together a bunch of fixes (... this being probably a bit too big really it
should have been on its own, sorry for that...)

> 
> Additional comment inline below.
> 
> Thanks,
> Guenter
> 
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >   drivers/hwmon/scmi-hwmon.c | 115 ++++++++++++++++++++++++++++++++-----
> >   1 file changed, 102 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> > index b1329a58ce40..124fe8ee1b9b 100644
> > --- a/drivers/hwmon/scmi-hwmon.c
> > +++ b/drivers/hwmon/scmi-hwmon.c
> > @@ -20,6 +20,11 @@ struct scmi_sensors {
> >   	const struct scmi_sensor_info **info[hwmon_max];
> >   };
> > +struct scmi_thermal_sensor {
> > +	const struct scmi_protocol_handle *ph;
> > +	const struct scmi_sensor_info *info;
> > +};
> > +
> >   static inline u64 __pow10(u8 x)
> >   {
> >   	u64 r = 1;
> > @@ -64,16 +69,14 @@ static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> >   	return 0;
> >   }
> > -static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > -			   u32 attr, int channel, long *val)
> > +static int scmi_hwmon_read_scaled_value(const struct scmi_protocol_handle *ph,
> > +					const struct scmi_sensor_info *sensor,
> > +					long *val)
> >   {
> >   	int ret;
> >   	u64 value;
> > -	const struct scmi_sensor_info *sensor;
> > -	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
> > -	sensor = *(scmi_sensors->info[type] + channel);
> > -	ret = sensor_ops->reading_get(scmi_sensors->ph, sensor->id, &value);
> > +	ret = sensor_ops->reading_get(ph, sensor->id, &value);
> >   	if (ret)
> >   		return ret;
> > @@ -84,6 +87,17 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> >   	return ret;
> >   }
> > +static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, long *val)
> > +{
> > +	const struct scmi_sensor_info *sensor;
> > +	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
> > +
> > +	sensor = *(scmi_sensors->info[type] + channel);
> > +
> > +	return scmi_hwmon_read_scaled_value(scmi_sensors->ph, sensor, val);
> > +}
> > +
> >   static int
> >   scmi_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> >   		       u32 attr, int channel, const char **str)
> > @@ -122,6 +136,25 @@ static struct hwmon_chip_info scmi_chip_info = {
> >   	.info = NULL,
> >   };
> > +static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
> > +				       int *temp)
> > +{
> > +	int ret;
> > +	long value;
> > +	struct scmi_thermal_sensor *th_sensor = tz->devdata;
> > +
> > +	ret = scmi_hwmon_read_scaled_value(th_sensor->ph, th_sensor->info,
> > +					   &value);
> > +	if (!ret)
> > +		*temp = value;
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
> > +	.get_temp = scmi_hwmon_thermal_get_temp,
> > +};
> > +
> >   static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
> >   				    struct device *dev, int num,
> >   				    enum hwmon_sensor_types type, u32 config)
> > @@ -149,7 +182,6 @@ static enum hwmon_sensor_types scmi_types[] = {
> >   };
> >   static u32 hwmon_attributes[hwmon_max] = {
> > -	[hwmon_chip] = HWMON_C_REGISTER_TZ,
> >   	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
> >   	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
> >   	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
> > @@ -157,6 +189,43 @@ static u32 hwmon_attributes[hwmon_max] = {
> >   	[hwmon_energy] = HWMON_E_INPUT | HWMON_E_LABEL,
> >   };
> > +static int scmi_thermal_sensor_register(struct device *dev,
> > +					const struct scmi_protocol_handle *ph,
> > +					const struct scmi_sensor_info *sensor)
> > +{
> > +	struct scmi_thermal_sensor *th_sensor;
> > +	struct thermal_zone_device *tzd;
> > +
> > +	th_sensor = devm_kzalloc(dev, sizeof(*th_sensor), GFP_KERNEL);
> > +	if (!th_sensor)
> > +		return -ENOMEM;
> > +
> > +	th_sensor->ph = ph;
> > +	th_sensor->info = sensor;
> > +
> > +	/*
> > +	 * Try to register a temperature sensor with the Thermal Framework:
> > +	 * skip sensors not defined as part of any thermal zone (-ENODEV) but
> > +	 * report any other errors related to misconfigured zones/sensors.
> > +	 */
> > +	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
> > +					    &scmi_hwmon_thermal_ops);
> > +	if (IS_ERR(tzd)) {
> > +		devm_kfree(dev, th_sensor);
> > +
> > +		if (PTR_ERR(tzd) != -ENODEV)
> > +			return PTR_ERR(tzd);
> > +
> > +		dev_info(dev, "Sensor '%s' not attached to any thermal zone.\n",
> > +			 sensor->name);
> 
> There were complaints about this message as it is noisy. If you send
> another version, please drop it unless attaching each sensor to a thermal
> zone is strongly expected. If you don't send another version, I'll drop it
> while applying.
> 

Ok fine for me. I am waiting to have some feedback from Sudeep too, but
I do not have plan for another version as of now.

As a side note, though, I understand the 'noisiness' argument, but,
sincerely this same message in the original HWMON code was the only
reason why I spotted that something was wrong with the SCMI/HWMON
interactions and discovered the indexes/ids mismatch...if not for
that it would have gone un-noticed that a perfectly configured
ThermalZone/Sensor was not working properly...
(un-noticed at least until something would have been burnt to fire
 in my house .. joking :P)

Thanks,
Cristian

