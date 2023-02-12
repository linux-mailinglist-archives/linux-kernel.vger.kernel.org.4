Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5556936FA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBLLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:18:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F0125BB;
        Sun, 12 Feb 2023 03:18:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="328407157"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="328407157"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 03:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="737191266"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="737191266"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2023 03:18:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@infradead.org>)
        id 1pRANN-005q8a-2w;
        Sun, 12 Feb 2023 13:18:33 +0200
Date:   Sun, 12 Feb 2023 13:18:33 +0200
From:   Andy Shevchenko <andy@infradead.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <Y+jLCebet+aekGRv@smile.fi.intel.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
 <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:45:15AM +0000, Aditya Garg wrote:
> From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> 
> This driver adds support for the keyboard backlight on Intel T2 Macs
> with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)

...

> +#include <linux/hid.h>
> +#include <linux/usb.h>

Seems lack of some header inclusions, e.g. where struct led_classdev is defined
or -ERRNO codes.

> +#include "hid-ids.h"

...

> +static void apple_magic_backlight_power_set(struct apple_magic_backlight *backlight,
> +					   char power, char rate)

char is a beast, can we use u8 here and in similar cases?

...

> +	/* Ensure this usb endpoint is for the keyboard backlight, not touchbar
> +	 * backlight.
> +	 */

/*
 * Multi-line comment style
 * goes like this.
 */

...

> +	backlight = devm_kzalloc(&hdev->dev, sizeof(*backlight), GFP_KERNEL);

> +

Redundant blank line.

> +	if (!backlight)
> +		return -ENOMEM;

...

> +static struct hid_driver apple_magic_backlight_hid_driver = {
> +	.name = "apple-magic-backlight",
> +	.id_table = apple_magic_backlight_hid_ids,
> +	.probe = apple_magic_backlight_probe,
> +	.remove = apple_magic_backlight_remove,
> +};

> +

Redundant blank line.

> +module_hid_driver(apple_magic_backlight_hid_driver);

-- 
With Best Regards,
Andy Shevchenko


