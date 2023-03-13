Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736136B7E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCMQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCMQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:56:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDBF559CE;
        Mon, 13 Mar 2023 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678726581; x=1710262581;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YG8ab328VKxI7RnIDAuiIqCFxzEn9D3+VAvNv07H3HI=;
  b=XLCfz/4iVdIs3Dv7xSiO35CbI/4CoqllW6xoCjoy9wocdqczL6euqNB1
   GnXCeQR++rDGKarzddzun4dK1/ICrP2hCtbXI5v74LSgvnV8dh32f5VcK
   NXptKHNgWR9pDgHSxgZPvZrel8W62u/aZTYbVITD9zlUFcn/Xz5aXxQRL
   asvbmnQcJRTodrTxKWJZYFlgdz9Ie5IwI6ZTexGBPpFbRTACuS+qkYsJX
   moBKuMX/vR9gEJHVZnheUR4ObSHHnYNKOSebGMaxGb2delKMVvZWUFEiZ
   0U8Takcu1n2jmgGKEHZ0TQ/D2E8Gq/kev4BhIKt96FqmxP1tgCFaGm4ft
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321053880"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="321053880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 09:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822034540"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="822034540"
Received: from igodinez-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.87.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 09:56:19 -0700
Message-ID: <39f2b66cca60d8f0bd4ff6b691b864dff3e449b9.camel@linux.intel.com>
Subject: Re: [PATCH] Fix buffer overrun in HID-SENSOR name.
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Todd Brandt <todd.e.brandt@intel.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     todd.e.brandt@linux.intel.com, jic23@kernel.org, jikos@kernel.org,
        p.jungkamp@gmx.net
Date:   Mon, 13 Mar 2023 09:56:18 -0700
In-Reply-To: <20230310235414.12467-1-todd.e.brandt@intel.com>
References: <20230310235414.12467-1-todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-10 at 15:54 -0800, Todd Brandt wrote:
> Philipp Jungkamp created this fix, I'm simply submitting it. I've
> verified it fixes bugzilla issue 217169.
> 
Not the correct change log. Something like below:

On some platforms there are some platform device is created with
invalid name. For example:
"HID-SENSOR-INT-020b?.39.auto" instead of "HID-SENSOR-INT-020b.39.auto"

This string include some invalid character, hence it will fail to
properly load the driver which will handle this custom sensor. Also
it is a problem for some user space tools, which parses the device
names.

This is because the string real_usage is not NULL terminated and
printed with %s to form device name.

To address this initialize the real_usage string with 0s.

> Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217169



Fixes: 98c062e82451 ("HID: hid-sensor-custom: Allow more custom iio
sensors")

Suggest-by: Philipp Jungkamp p.jungkamp@gmx.net

> Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>

Thanks,
Srinivas

> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 3e3f89e01d81..d85398721659 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -940,7 +940,7 @@ hid_sensor_register_platform_device(struct
> platform_device *pdev,
>                                     struct hid_sensor_hub_device
> *hsdev,
>                                     const struct
> hid_sensor_custom_match *match)
>  {
> -       char real_usage[HID_SENSOR_USAGE_LENGTH];
> +       char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
>         struct platform_device *custom_pdev;
>         const char *dev_name;
>         char *c;

