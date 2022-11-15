Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F1629A92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiKONdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiKONda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:33:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972952B61F;
        Tue, 15 Nov 2022 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668519167; x=1700055167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JLofccTKq39Y7fAAypNpN5FS3gv++H7NAgQ9jcT2mV8=;
  b=nDhG6Fmf9dV+8X9MiII8nU6+ckodscRLpLhEWfljjb5/Q7o70O9szKG7
   EmUswqVjB6ZEFiErkGmfprAK74TwXXR5gUI9d+paDSxk4FQfewOAKCfeY
   iBdzZikmjvZ4yKAnfVYYy+LB2NcdkHAevEzjcqGVisBm+0rxl4OHbiIqO
   diP83MZvpHDjKXP5gaxOsxf4qx9qFpBPIbo+3H6VFUcIq7Kv+r1R9aGEm
   KpiQHQkS4PWAosTmcvZaQaCR748giAi5JICd+D8pc6BUlNoOa08alcuXL
   FCdRDJ+87duX3NEtBZ8xTtcPKaHnoe51SlxUIrWJdzhmfw424z3qQRxO1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299775524"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="299775524"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 05:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589789750"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="589789750"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 05:32:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouw3O-00Cd6i-1j;
        Tue, 15 Nov 2022 15:32:42 +0200
Date:   Tue, 15 Nov 2022 15:32:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y3OU+o2fkTq2QXQD@smile.fi.intel.com>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
 <20221115073718.2377311-3-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115073718.2377311-3-gerald.loacker@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:37:18AM +0100, Gerald Loacker wrote:
> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.
> 
> Datasheet: https://www.ti.com/lit/gpn/tmag5273

> 

Drop this blank line to make above to be a tag.

> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>

...

> +#define TMAG5273_MANUFACTURER_ID        0x5449

Can you add ASCII comment on that magic value?

...

> +#define TMAG5273_AUTOSLEEP_DELAY	 5000

Units?

> +struct tmag5273_data {
> +	struct device *dev;
> +	unsigned int devid;
> +	unsigned int version;

> +	char name[16];
> +	int conv_avg;
> +	int max_avg;
> +	int range;
> +	u32 angle_en;
> +	struct regmap *map;
> +	struct regulator *vcc;

+ Blank line

> +	/* Locks the sensor for exclusive use during a measurement (which
> +	 * involves several register transactions so the regmap lock is not
> +	 * enough) so that measurements get serialized in a first-come-first-
> +	 * serve manner.
> +	 */

/*
 * Wrong multi-line
 * comment style. Fix
 * it accordingly.
 */

> +	struct mutex lock;
> +};

...

> +static const struct {
> +	int avg;
> +	u8 reg_val;
> +} tmag5273_avg_table[] = {
> +	{ 1, 0x00 }, { 2, 0x01 },  { 4, 0x02 },
> +	{ 8, 0x03 }, { 16, 0x04 }, { 32, 0x05 },

Isn't the second one is just an index?

> +};


...

> +/*
> + * magnetic range in mT for different TMAG5273 versions

Magnetic

> + * only version 1 and 2 are valid, version 0 and 3 are reserved
> + */
> +static const struct {
> +	int range;
> +	u8 reg_val;
> +} tmag5273_range_table[4][2] = {

I believe you can drop 4.

> +	{ { 0, 0 }, { 0, 3 } },
> +	{ { 40, 0 }, { 80, 3 } },
> +	{ { 133, 0 }, { 266, 3 } },
> +	{ { 0, 0 }, { 0, 3 } },
> +};

...

> +/*

Shouldn't it be a kernel doc? Ditto for the rest.

> + * tmag5273_measure() - Make a measure from the hardware
> + * @tmag5273: The device state
> + * @t: the processed temperature measurement
> + * @x: the raw x axis measurement
> + * @y: the raw x axis measurement
> + * @z: the raw x axis measurement
> + * @angle: the calculated angle
> + * @magnitude: the calculated magnitude
> + * @return: 0 on success or error code
> + */

...

> +	/*
> +	 * convert device specific value to millicelsius

Convert

> +	 * use multiply by 16639 and divide by 10000 to achieve divide by 60.1
> +	 *   and convert to millicelsius

One space is enough and missing period.

> +	 */

> +}

...

> +static ssize_t tmag5273_show_conv_avg(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", data->conv_avg);

Must be sysfs_emit().

> +}

...

> +	for (i = 0; i < ARRAY_SIZE(tmag5273_avg_table); i++) {
> +		if (tmag5273_avg_table[i].avg == val)
> +			break;
> +	}

> +

Redundant blank line.

> +	if (i == ARRAY_SIZE(tmag5273_avg_table))
> +		return -EINVAL;

...

> +static IIO_DEVICE_ATTR(conv_avg, 0644, tmag5273_show_conv_avg,
> +		       tmag5273_store_conv_avg, 0);

IIO_DEVICE_ATTR_RW() ?

...

> +	for (i = 0; i < ARRAY_SIZE(tmag5273_avg_table); i++) {
> +		if (tmag5273_avg_table[i].avg > data->max_avg)
> +			break;
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +				 tmag5273_avg_table[i].avg);

sysfs_emit_at()

> +	}
> +	/* replace last space with a newline */
> +	if (len > 0)
> +		buf[len - 1] = '\n';

...

> +static IIO_DEVICE_ATTR(conv_avg_available, 0444, tmag5273_conv_avg_available,
> +		       NULL, 0);

IIO_DEVICE_ATTR_RO()

...

> +	return sprintf(buf, "%d\n", data->range);

sysfs_emit().

...

> +	for (i = 0; i < ARRAY_SIZE(tmag5273_range_table[0]); i++) {
> +		if (tmag5273_range_table[data->version][i].range == val)
> +			break;
> +	}

> +

Redundant blank line.

> +	if (i == ARRAY_SIZE(tmag5273_range_table[0]))
> +		return -EINVAL;

...

> +static ssize_t tmag5273_store_range(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	int range, ret;
> +
> +	ret = kstrtoint(buf, 0, &range);

Here and in the other ->store() do you really have negative values possible?
Can you revisit all those kstrtoX() calls and check the arguments, so you can
narrow down the range of the input where it's appropriate?

> +	if (ret)
> +		return ret;
> +
> +	ret = tmag5273_write_range(data, range);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(range, 0644, tmag5273_show_range,
> +		       tmag5273_store_range, 0);

IIO_DEVICE_ATTR_RW()

> +	for (i = 0; i < ARRAY_SIZE(tmag5273_range_table[0]); i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +				 tmag5273_range_table[data->version][i].range);
> +	}

sysfs_emit();

> +	/* replace last space with a newline */
> +	if (len > 0)
> +		buf[len - 1] = '\n';
> +
> +	return len;
> +}

...

> +static IIO_DEVICE_ATTR(range_available, 0444, tmag5273_range_available, NULL,
> +		       0);

One line.

...

> +static struct attribute *tmag5273_attributes[] = {
> +	&iio_dev_attr_conv_avg.dev_attr.attr,
> +	&iio_dev_attr_conv_avg_available.dev_attr.attr,
> +	&iio_dev_attr_range.dev_attr.attr,
> +	&iio_dev_attr_range_available.dev_attr.attr,

> +	NULL,

No comma in terminator entry.

> +};

> +static const struct attribute_group tmag5273_attrs_group = {
> +	.attrs = tmag5273_attributes,
> +};

...

> +static bool tmag5273_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	return (reg >= TMAG5273_T_MSB_RESULT &&
> +		reg <= TMAG5273_MAGNITUDE_RESULT);

Drop parentheses and make it one line.

> +}

...

> +static int tmag5273_probe(struct i2c_client *i2c,
> +			  const struct i2c_device_id *id)

Why ->probe_new() can't be utilized?

...

> +	struct device_node *node = dev->of_node;

What for? Use device property API (see below).

...

> +	data->map = devm_regmap_init_i2c(i2c, &tmag5273_regmap_config);
> +	if (IS_ERR(data->map)) {

> +		ret = PTR_ERR(data->map);
> +		dev_err_probe(dev, ret, "failed to allocate register map\n");

	ret = dev_err_probe();

But don't you have an ordering issue here?

> +		goto out_disable_vcc;
> +	}

...

> +		strncpy(data->name, "TMAG5273", sizeof(data->name) - 2);
> +		switch (data->version) {
> +		case 1:
> +			strncat(data->name, "x1", 2);
> +			break;
> +		case 2:
> +			strncat(data->name, "x2", 2);
> +			break;
> +		default:
> +			break;
> +		}

This all can be replaced with fewer lines:

		if (data->version < 1 || data->version > 2)
			snprintf(data->name, "TMAG5273", sizeof(data->name));
		else
			snprintf(data->name, "TMAG5273x%.1u", sizeof(data->name), data->version);

...

> +		dev_info(dev, "%s", data->name);

Useless?

...

> +	of_property_read_u32(node, "tmag5273,angle-enable", &data->angle_en);

Missing header for that, but the question is why? What's wrong with device
property API instead?

...

> +static const struct i2c_device_id tmag5273_id[] = {
> +	{
> +		"tmag5273",
> +	},

Can be one line.

> +	{ /* sentinel */ },

No comma for terminator entry.

> +};

...

> +	{ /* sentinel */ },

Ditto.

-- 
With Best Regards,
Andy Shevchenko


