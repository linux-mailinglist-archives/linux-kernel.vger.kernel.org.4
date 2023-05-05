Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97D6F8385
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjEENIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjEENIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:08:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C951F4A1;
        Fri,  5 May 2023 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683292107; x=1714828107;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a5vjNKetyD68JgjNa9jzAqF944jr/t4SaeN4ZP5e8sw=;
  b=BETVKqDa2dtvgbLzsEY0j3KK5V+Ik0v0RizvLGPci2zRc3J6hNJM5WSz
   pHWFdF+TBWajIEPh2yYtwMW7m6emOkxoElm4bNzDPdJdCkLChqleopj86
   P98yB5BGahFH1nZqvsylOaZwFR0/cHsSJFSDsZtRsWCdq8NquB44FGYvT
   dpmiq+pN5UWeR7FRnSXoZB5CCpQadK3/We2PejodKT4tDWGv0O4yF7OLR
   TiezWWSVknK/jtBu6x6+Crj+25PFQV+pkAor/DndPapIEhbrsaJG2+3iC
   qbG3aeFW18ddsppMUhN2ckornBRTThOEowrMYvPN0s5I/xT2LWX90jp/A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="377280008"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="377280008"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 06:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841735562"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="841735562"
Received: from etrunovx-mobl.ger.corp.intel.com ([10.252.62.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 06:08:24 -0700
Date:   Fri, 5 May 2023 16:08:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>
cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
In-Reply-To: <20230505043013.2622603-2-luke@ljones.dev>
Message-ID: <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
References: <20230505043013.2622603-1-luke@ljones.dev> <20230505043013.2622603-2-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023, Luke D. Jones wrote:

> Add support for the WMI methods used to turn off and adjust the
> brightness of the secondary "screenpad" device found on some high-end
> ASUS laptops like the GX650P series and others.
> 
> These methods are utilised in a new backlight device named:
> - asus_screenpad
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>  drivers/platform/x86/asus-wmi.c               | 132 ++++++++++++++++++
>  drivers/platform/x86/asus-wmi.h               |   1 +
>  include/linux/platform_data/x86/asus-wmi.h    |   4 +
>  4 files changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index a77a004a1baa..df9817c6233a 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -97,4 +97,4 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Enable an LCD response-time boost to reduce or remove ghosting:
>  			* 0 - Disable,
> -			* 1 - Enable
> +			* 1 - Enable
> \ No newline at end of file

Spurious change?

> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 1038dfdcdd32..0528eef02ef7 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -200,6 +200,7 @@ struct asus_wmi {
>  
>  	struct input_dev *inputdev;
>  	struct backlight_device *backlight_device;
> +	struct backlight_device *screenpad_backlight_device;
>  	struct platform_device *platform_device;
>  
>  	struct led_classdev wlan_led;
> @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>  	return 0;
>  }
>  
> +/* Screenpad backlight */
> +
> +static int read_screenpad_backlight_power(struct asus_wmi *asus)
> +{
> +	int ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);

Please move this to own line because now you have the extra newline 
in between the call and error handling.

> +
> +	if (ret < 0)
> +		return ret;
> +	/* 1 == powered */
> +	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> +}
> +
> +static int read_screenpad_brightness(struct backlight_device *bd)
> +{
> +	struct asus_wmi *asus = bl_get_data(bd);
> +	u32 retval;
> +	int err;
> +
> +	err = read_screenpad_backlight_power(asus);
> +	if (err < 0)
> +		return err;
> +	/* The device brightness can only be read if powered, so return stored */
> +	if (err == FB_BLANK_POWERDOWN)
> +		return asus->driver->screenpad_brightness;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
> +	if (err < 0)
> +		return err;
> +
> +	return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
> +}
> +
> +static int update_screenpad_bl_status(struct backlight_device *bd)
> +{
> +	struct asus_wmi *asus = bl_get_data(bd);
> +	int power, err = 0;
> +	u32 ctrl_param;
> +
> +	power = read_screenpad_backlight_power(asus);
> +	if (power == -ENODEV)
> +		return err;

Just return 0. Or is there perhaps something wrong/missing here?

> +	else if (power < 0)
> +		return power;
> +
> +	if (bd->props.power != power) {
> +		if (power != FB_BLANK_UNBLANK) {
> +			/* Only brightness can power it back on */

Only brightness > 0 can power the screen back on

> +			ctrl_param = asus->driver->screenpad_brightness;

max(1, asus->driver->screenpad_brightness);

Don't forget to add the #include for it.

> +			/* Min 1 or the screen won't turn on */
> +			if (ctrl_param == 0)
> +				ctrl_param = 1;

Drop this.

> +			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
> +							ctrl_param, NULL);

Align param.

> +		} else {
> +			/* Ensure brightness is stored to turn back on with */
> +			asus->driver->screenpad_brightness = bd->props.brightness;
> +			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
> +		}
> +	} else if (power == FB_BLANK_UNBLANK) {
> +		/* Only set brightness if powered on or we get invalid/unsync state */
> +		ctrl_param = bd->props.brightness;
> +		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);

Why not store the brightness if powered off?

> +	}
> +
> +	return err;
> +}
> +
> +static const struct backlight_ops asus_screenpad_bl_ops = {
> +	.get_brightness = read_screenpad_brightness,
> +	.update_status = update_screenpad_bl_status,
> +	.options = BL_CORE_SUSPENDRESUME,
> +};
> +
> +static int asus_screenpad_init(struct asus_wmi *asus)
> +{
> +	struct backlight_device *bd;
> +	struct backlight_properties props;
> +	int power, brightness;
> +
> +	power = read_screenpad_backlight_power(asus);
> +	if (power == -ENODEV)
> +		power = FB_BLANK_UNBLANK;
> +	else if (power < 0)
> +		return power;
> +
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +	props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */
> +	props.max_brightness = 255;
> +	bd = backlight_device_register("asus_screenpad",
> +				       &asus->platform_device->dev, asus,
> +				       &asus_screenpad_bl_ops, &props);
> +	if (IS_ERR(bd)) {
> +		pr_err("Could not register backlight device\n");
> +		return PTR_ERR(bd);
> +	}
> +
> +	asus->screenpad_backlight_device = bd;
> +
> +	brightness = read_screenpad_brightness(bd);
> +	if (brightness < 0)
> +		return brightness;
> +	/*
> +	 * Counter an odd behaviour where default is set to < 13 if it was 0 on boot.
> +	 * 60 is subjective, but accepted as a good compromise to retain visibility.
> +	 */
> +	else if (brightness < 60)

Since the other branch returns, else is unnecessary.

-- 
 i.

> +		brightness = 60;
> +
> +	asus->driver->screenpad_brightness = brightness;
> +	bd->props.brightness = brightness;
> +	bd->props.power = power;
> +	backlight_update_status(bd);
> +
> +	return 0;
> +}
> +
> +static void asus_screenpad_exit(struct asus_wmi *asus)
> +{
> +	backlight_device_unregister(asus->screenpad_backlight_device);
> +
> +	asus->screenpad_backlight_device = NULL;
> +}
> +
>  /* Fn-lock ********************************************************************/
>  
>  static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
> @@ -3823,6 +3947,13 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	} else if (asus->driver->quirks->wmi_backlight_set_devstate)
>  		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT)) {
> +		pr_warn("Begin asus_screenpad_init");
> +		err = asus_screenpad_init(asus);
> +		if (err && err != -ENODEV)
> +			goto fail_backlight;
> +	}
> +
>  	if (asus_wmi_has_fnlock_key(asus)) {
>  		asus->fnlock_locked = fnlock_default;
>  		asus_wmi_fnlock_update(asus);
> @@ -3844,6 +3975,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  
>  fail_wmi_handler:
>  	asus_wmi_backlight_exit(asus);
> +	asus_screenpad_exit(asus);
>  fail_backlight:
>  	asus_wmi_rfkill_exit(asus);
>  fail_rfkill:
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index a478ebfd34df..5fbdd0eafa02 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -57,6 +57,7 @@ struct quirk_entry {
>  struct asus_wmi_driver {
>  	int			brightness;
>  	int			panel_power;
> +	int			screenpad_brightness;
>  	int			wlan_ctrl_by_user;
>  
>  	const char		*name;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 28234dc9fa6a..a2d94adb5c80 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -58,6 +58,10 @@
>  #define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
>  #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
>  #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
> +/* This can only be used to disable the screen, not re-enable */
> +#define ASUS_WMI_DEVID_SCREENPAD_POWER	0x00050031
> +/* Writing a brightness re-enables the screen if disabled */
> +#define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
>  #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
>  #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
>  
> 

