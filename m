Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF95EDA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiI1Krp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiI1Krk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:47:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817BAAD980;
        Wed, 28 Sep 2022 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664362058; x=1695898058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fhubWlwUsGUzDWRnGfcUX6CVIlztpMxnVINR5fDR++A=;
  b=f9bd60NOBYJl7RfUnmCXImXsQFQeP5zYSjfl05LppRrZGmNbcU4ORxPl
   IbHxaUDGLXJrm1GwPyHo5rvHekZunv38KkdPPfvYiBgpED9KTGnqvpzya
   iQCFZ/x04nLP5rCVGjFdz1yz1zsI/W101lK+I2alyvPCHooa4dIaz9icg
   aJ0lEr4NuUhtSllXPzVlMW8WiZbR4Zjt+DYMARC0FjjwcVPyEc6oMWepn
   NGgYoAHmJJvad8dRwr2fUhT95dyBDy72Hr/h4l5S5Lm9L7+rb2brFWA+T
   wZiDL5q5VKuuIxxw1dDeE5uSgCW1PAKWhuU9ZugxanyJNEAiekzjtzKaL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284701046"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="284701046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="725902045"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="725902045"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2022 03:47:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odUbD-008u6f-2f;
        Wed, 28 Sep 2022 13:47:31 +0300
Date:   Wed, 28 Sep 2022 13:47:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
Message-ID: <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927204521.601887-3-W_Armin@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:
> The dell-wmi-ddv driver adds support for reading
> the current temperature and ePPID of ACPI batteries
> on supported Dell machines.
> 
> Since the WMI interface used by this driver does not
> do any input validation and thus cannot be used for probing,
> the driver depends on the ACPI battery extension machanism
> to discover batteries.
> 
> The driver also supports a debugfs interface for retrieving
> buffers containing fan and thermal sensor information.
> Since the meaing of the content of those buffers is currently
> unknown, the interface is meant for reverse-engineering and
> will likely be replaced with an hwmon interface once the
> meaning has been understood.
> 
> The driver was tested on a Dell Inspiron 3505.

...

> +config DELL_WMI_DDV
> +	tristate "Dell WMI sensors Support"

> +	default m

Why? (Imagine I have Dell, but old machine)

(And yes, I see that other Kconfig options are using it, but we shall avoid
 cargo cult and each default choice like this has to be explained at least.)

...

> + * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell notebooks.

Please, remove file name from the file. This will be an additional burden in
the future in case it will be renamed.

...

> +#include <acpi/battery.h>

Is it required to be the first? Otherwise it seems ACPI specific to me and the
general rule is to put inclusions from generic towards custom. I.o.w. can you
move it after linux/wmi.h with a blank line in between?

> +#include <linux/acpi.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/kstrtox.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/limits.h>
> +#include <linux/power_supply.h>
> +#include <linux/seq_file.h>
> +#include <linux/sysfs.h>
> +#include <linux/wmi.h>

...

> +struct dell_wmi_ddv_data {
> +	struct acpi_battery_hook hook;
> +	struct device_attribute temp_attr, eppid_attr;

It's hard to read and easy to miss that the data type has two members here.
Please, put one member per one line.

> +	struct wmi_device *wdev;
> +};

...

> +	if (obj->type != type) {
> +		kfree(obj);
> +		return -EIO;

EINVAL?

> +	}

...

> +	kfree(obj);

I'm wondering what is the best to use in the drivers:
 1) kfree()
 2) acpi_os_free()
 3) ACPI_FREE()

?

...

> +static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
> +{

> +	const char *uid_str = acpi_device_uid(acpi_dev);
> +
> +	if (!uid_str)
> +		return -ENODEV;

It will be better for maintaining to have

	const char *uid_str...;

	uid_str = ...
	if (!uid_str)
		...

> +	return kstrtou32(uid_str, 10, index);
> +}

...

> +	/* Return 0 instead of error to avoid being unloaded */
> +	ret = dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), &index);
> +	if (ret < 0)
> +		return 0;

How index is used?

...

> +	ret = device_create_file(&battery->dev, &data->temp_attr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = device_create_file(&battery->dev, &data->eppid_attr);
> +	if (ret < 0) {
> +		device_remove_file(&battery->dev, &data->temp_attr);
> +
> +		return ret;
> +	}

Why dev_groups member can't be utilized?

...

> +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)

Strictly speaking this should return int (see below).

> +{
> +	struct dentry *entry;
> +	char name[64];
> +
> +	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
> +	entry = debugfs_create_dir(name, NULL);
> +
> +	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
> +				    dell_wmi_ddv_fan_read);
> +	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", entry,
> +				    dell_wmi_ddv_temp_read);
> +
> +	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry);

return devm...

This is not related to debugfs and there is no rule to avoid checking error
codes from devm_add_action_or_reset().

> +}

...

> +static struct wmi_driver dell_wmi_ddv_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,

I would use explicit literal since this is a (semi-) ABI, and having it as
a define feels not fully right.

> +	},
> +	.id_table = dell_wmi_ddv_id_table,
> +	.probe = dell_wmi_ddv_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko


