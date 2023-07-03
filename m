Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F835745741
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGCIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGCIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE54BB2;
        Mon,  3 Jul 2023 01:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 473ED60DF7;
        Mon,  3 Jul 2023 08:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561EEC433C7;
        Mon,  3 Jul 2023 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372545;
        bh=VSXlUwwcvEpNuAZDDx5QPmruquJXWTHQzPh6qjfaa3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PigxOmwgDSlkoARPHyomdr8764/wZSTNTJawCRk9IiARKLJxeJnbIMHEy2gD+Bk+C
         zZM46j6DQ79H+Pjdh2UAztwUUytksd1Fbybwb5ZXE9QADiBvLO/bSNV3+grgsGL+k1
         d1Gfmn9yb6+KX3LiG7vctIffvWq0YxKrXBH2QURdb+6gZbFtydwweZi4Jgt4ss291n
         Mn2USW87I8pIWuXZ3M5MrjQ4gKxTGSdArC6eCgOtgUqa1cvDo+7Jn81YPJjKsNvTtR
         gSDcDDElChN2RVxZlKzE35BAP/IyW1XxQD1vlmnGLP/BWQPC2/EJpD4XWgUpRQ8HN1
         Z7o+kjmbNHr+A==
Date:   Mon, 3 Jul 2023 10:22:21 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: steelseries: Add support for Arctis 1 XBox
Message-ID: <77asu2iibozr7azbowphkbnt2ykfreqhxaszmq34cubzd7szuk@lyrik7e3nvre>
References: <20230630131217.51827-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630131217.51827-1-hadess@hadess.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 30 2023, Bastien Nocera wrote:
> 
> Add support for the Steelseries Arctis 1 XBox headset. This driver
> will export the battery information from the headset, as well as the
> "wireless_status" property.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> v3:
> - Dependency is on USB not USB_HID
> 
> v2:
> - Fix missing USB dependency
> - Fix config option description
> 
>  drivers/hid/Kconfig           |   6 +-
>  drivers/hid/hid-steelseries.c | 307 ++++++++++++++++++++++++++++++++--
>  2 files changed, 296 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4ce012f83253..afe1c6070602 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1048,9 +1048,11 @@ config STEAM_FF
>  	Deck.
>  
>  config HID_STEELSERIES
> -	tristate "Steelseries SRW-S1 steering wheel support"
> +	tristate "Steelseries devices support"
> +	depends on USB
>  	help
> -	Support for Steelseries SRW-S1 steering wheel
> +	Support for Steelseries SRW-S1 steering wheel, and the Steelseries
> +	Arctis 1 Wireless for XBox headset.
>  
>  config HID_SUNPLUS
>  	tristate "Sunplus wireless desktop"
> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index aae3afc4107a..a9300a4244aa 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *  HID driver for Steelseries SRW-S1
> + *  HID driver for Steelseries devices
>   *
>   *  Copyright (c) 2013 Simon Wood
> + *  Copyright (c) 2023 Bastien Nocera
>   */
>  
>  /*
> @@ -11,10 +12,28 @@
>  #include <linux/device.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
> +#include <linux/usb.h>
>  #include <linux/leds.h>
>  
>  #include "hid-ids.h"
>  
> +#define STEELSERIES_SRWS1		BIT(0)
> +#define STEELSERIES_ARCTIS_1		BIT(1)
> +
> +struct steelseries_device {
> +	struct hid_device *hdev;
> +	unsigned long quirks;
> +
> +	struct delayed_work battery_work;
> +	spinlock_t lock;
> +	bool removed;
> +
> +	struct power_supply_desc battery_desc;
> +	struct power_supply *battery;
> +	uint8_t battery_capacity;
> +	bool headset_connected;
> +};
> +
>  #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
>      (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
>  #define SRWS1_NUMBER_LEDS 15
> @@ -353,9 +372,208 @@ static void steelseries_srws1_remove(struct hid_device *hdev)
>  }
>  #endif
>  
> +#define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS	3000
> +
> +#define ARCTIS_1_BATTERY_RESPONSE_LEN		8
> +
> +static int steelseries_headset_arctis_1_fetch_battery(struct hid_device *hdev)
> +{
> +	u8 *write_buf;
> +	int ret;
> +	char battery_request[2] = { 0x06, 0x12 };
> +
> +	/* Request battery information */
> +	write_buf = kmemdup(battery_request, sizeof(battery_request), GFP_KERNEL);
> +	if (!write_buf)
> +		return -ENOMEM;
> +
> +	ret = hid_hw_raw_request(hdev, battery_request[0],
> +				 write_buf, sizeof(battery_request),
> +				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> +	if (ret < sizeof(battery_request)) {
> +		hid_err(hdev, "hid_hw_raw_request() failed with %d\n", ret);
> +		ret = -ENODATA;
> +	}
> +	kfree(write_buf);
> +	return ret;
> +}
> +
> +static void steelseries_headset_fetch_battery(struct hid_device *hdev)
> +{
> +	struct steelseries_device *sd = hid_get_drvdata(hdev);
> +	int ret = 0;
> +
> +	if (sd->quirks & STEELSERIES_ARCTIS_1)
> +		ret = steelseries_headset_arctis_1_fetch_battery(hdev);
> +
> +	if (ret < 0)
> +		hid_dbg(hdev,
> +			"Battery query failed (err: %d)\n", ret);
> +}
> +
> +static void steelseries_headset_battery_timer_tick(struct work_struct *work)
> +{
> +	struct steelseries_device *sd = container_of(work,
> +		struct steelseries_device, battery_work.work);
> +	struct hid_device *hdev = sd->hdev;
> +
> +	steelseries_headset_fetch_battery(hdev);
> +}
> +
> +static int steelseries_headset_battery_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct steelseries_device *sd = power_supply_get_drvdata(psy);
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = 1;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval = sd->headset_connected ?
> +			POWER_SUPPLY_STATUS_DISCHARGING :
> +			POWER_SUPPLY_STATUS_UNKNOWN;
> +		break;
> +	case POWER_SUPPLY_PROP_SCOPE:
> +		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval = sd->battery_capacity;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static void
> +steelseries_headset_set_wireless_status(struct hid_device *hdev,
> +					bool connected)
> +{
> +	struct usb_interface *intf;
> +

You need to inset a `if (!hid_is_usb(hdev)) return;` here, so that a uhid
device will not oops the kernel.

> +	intf = to_usb_interface(hdev->dev.parent);
> +	usb_set_wireless_status(intf, connected ?
> +				USB_WIRELESS_STATUS_CONNECTED :
> +				USB_WIRELESS_STATUS_DISCONNECTED);
> +}
> +
> +static enum power_supply_property steelseries_headset_battery_props[] = {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +};
> +
> +static int steelseries_headset_battery_register(struct steelseries_device *sd)
> +{
> +	static atomic_t battery_no = ATOMIC_INIT(0);
> +	struct power_supply_config battery_cfg = { .drv_data = sd, };
> +	unsigned long n;
> +	int ret;
> +
> +	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +	sd->battery_desc.properties = steelseries_headset_battery_props;
> +	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_headset_battery_props);
> +	sd->battery_desc.get_property = steelseries_headset_battery_get_property;
> +	sd->battery_desc.use_for_apm = 0;
> +	n = atomic_inc_return(&battery_no) - 1;
> +	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
> +						    "steelseries_headset_battery_%ld", n);
> +	if (!sd->battery_desc.name)
> +		return -ENOMEM;
> +
> +	/* avoid the warning of 0% battery while waiting for the first info */
> +	steelseries_headset_set_wireless_status(sd->hdev, false);
> +	sd->battery_capacity = 100;
> +
> +	sd->battery = devm_power_supply_register(&sd->hdev->dev,
> +			&sd->battery_desc, &battery_cfg);
> +	if (IS_ERR(sd->battery)) {
> +		ret = PTR_ERR(sd->battery);
> +		hid_err(sd->hdev,
> +				"%s:power_supply_register failed with error %d\n",
> +				__func__, ret);
> +		return ret;
> +	}
> +	power_supply_powers(sd->battery, &sd->hdev->dev);
> +
> +	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_tick);
> +	steelseries_headset_fetch_battery(sd->hdev);
> +
> +	return 0;
> +}
> +
> +static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +	struct steelseries_device *sd;
> +	int ret;
> +
> +	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
> +	if (!sd)
> +		return -ENOMEM;

Nitpick: please add a new-line here

> +	hid_set_drvdata(hdev, sd);
> +	sd->hdev = hdev;
> +	sd->quirks = id->driver_data;
> +
> +	if (sd->quirks & STEELSERIES_SRWS1) {
> +#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> +    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
> +		return steelseries_srws1_probe(hdev, id);
> +#else
> +		return -ENODEV;
> +#endif
> +	}
> +
> +	ret = hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	if (steelseries_headset_battery_register(sd) < 0)
> +		hid_err(sd->hdev,
> +			"Failed to register battery for headset\n");
> +
> +	spin_lock_init(&sd->lock);

I'd say the spin_lock should be initialized before we register the
battery, given that steelseries_headset_battery_register() calls in the
workqueue already. No?

Actually the lock is used in .raw_event, so this should be called before
hid_hw_start()


> +
> +	return ret;
> +}
> +
> +static void steelseries_remove(struct hid_device *hdev)
> +{
> +	struct steelseries_device *sd = hid_get_drvdata(hdev);
> +	unsigned long flags;
> +
> +	if (sd->quirks & STEELSERIES_SRWS1) {
> +#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> +    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
> +		steelseries_srws1_remove(hdev);
> +#endif
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&sd->lock, flags);
> +	sd->removed = true;
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +
> +	cancel_delayed_work_sync(&sd->battery_work);
> +
> +	hid_hw_stop(hdev);
> +}
> +
>  static __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  		unsigned int *rsize)
>  {
> +	if (hdev->vendor != USB_VENDOR_ID_STEELSERIES ||
> +	    hdev->product != USB_DEVICE_ID_STEELSERIES_SRWS1)
> +		return rdesc;
> +
>  	if (*rsize >= 115 && rdesc[11] == 0x02 && rdesc[13] == 0xc8
>  			&& rdesc[29] == 0xbb && rdesc[40] == 0xc5) {
>  		hid_info(hdev, "Fixing up Steelseries SRW-S1 report descriptor\n");
> @@ -365,22 +583,81 @@ static __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev, __u8 *rdesc
>  	return rdesc;
>  }
>  
> -static const struct hid_device_id steelseries_srws1_devices[] = {
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
> +static int steelseries_headset_raw_event(struct hid_device *hdev,
> +					struct hid_report *report, u8 *read_buf,
> +					int size)
> +{
> +	struct steelseries_device *sd = hid_get_drvdata(hdev);
> +	int capacity = sd->battery_capacity;
> +	bool connected = sd->headset_connected;
> +	unsigned long flags;
> +
> +	/* Not a headset */
> +	if (sd->quirks & STEELSERIES_SRWS1)
> +		return 0;
> +
> +	if (sd->quirks & STEELSERIES_ARCTIS_1) {
> +		hid_dbg(sd->hdev,
> +			"Parsing raw event for Arctis 1 headset (len: %d)\n", size);
> +		if (size < 8)
> +			return 0;
> +		if (read_buf[2] == 0x01) {
> +			connected = false;
> +			capacity = 100;
> +		} else {
> +			connected = true;
> +			capacity = read_buf[3];
> +		}
> +	}
> +
> +	if (connected != sd->headset_connected) {
> +		hid_dbg(sd->hdev,
> +			"Connected status changed from %sconnected to %sconnected\n",
> +			sd->headset_connected ? "" : "not ",
> +			connected ? "" : "not ");
> +		sd->headset_connected = connected;
> +		steelseries_headset_set_wireless_status(hdev, connected);
> +	}
> +
> +	if (capacity != sd->battery_capacity) {
> +		hid_dbg(sd->hdev,
> +			"Battery capacity changed from %d%% to %d%%\n",
> +			sd->battery_capacity, capacity);
> +		sd->battery_capacity = capacity;
> +		power_supply_changed(sd->battery);
> +	}
> +
> +	spin_lock_irqsave(&sd->lock, flags);
> +	if (!sd->removed)
> +		schedule_delayed_work(&sd->battery_work,
> +				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
> +	spin_unlock_irqrestore(&sd->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id steelseries_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
> +	  .driver_data = STEELSERIES_SRWS1 },
> +
> +	{ /* SteelSeries Arctis 1 Wireless for XBox */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, 0x12b6),
> +	.driver_data = STEELSERIES_ARCTIS_1 },
> +
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(hid, steelseries_srws1_devices);
> -
> -static struct hid_driver steelseries_srws1_driver = {
> -	.name = "steelseries_srws1",
> -	.id_table = steelseries_srws1_devices,
> -#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> -    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
> -	.probe = steelseries_srws1_probe,
> -	.remove = steelseries_srws1_remove,
> -#endif
> -	.report_fixup = steelseries_srws1_report_fixup
> +MODULE_DEVICE_TABLE(hid, steelseries_devices);
> +
> +static struct hid_driver steelseries_driver = {
> +	.name = "steelseries",
> +	.id_table = steelseries_devices,
> +	.probe = steelseries_probe,
> +	.remove = steelseries_remove,
> +	.report_fixup = steelseries_srws1_report_fixup,
> +	.raw_event = steelseries_headset_raw_event,
>  };
>  
> -module_hid_driver(steelseries_srws1_driver);
> +module_hid_driver(steelseries_driver);
>  MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
> +MODULE_AUTHOR("Simon Wood <simon@mungewell.org>");
> -- 
> 2.41.0
> 

Few nitpicks here and there, but code looks good otherwise.

We are still in the merge window, so no commits targetting v6.6 will be
included until this is over (we should have 6.5-rc1 at the end of the
week IIRC).

Cheers,
Benjamin
