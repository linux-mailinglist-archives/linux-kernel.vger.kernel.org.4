Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBB6206D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiKHCb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiKHCbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:31:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96DF140B6;
        Mon,  7 Nov 2022 18:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667874653; x=1699410653;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5JfCjrostcFM57ehzBq1YAw5lngVCrvuFrcq8Fs8LI=;
  b=KPQxqcVwd0zGsSxuMmVIgm9AL5kfdDK+kZ0BCiy1Jpu9e36UHgLb9iyL
   eXH1PoOD/3ueHn1ayOStEu6vuGO6QpIx0BiyVH54jWT/A623FcWVy8CR/
   L7ASyg3ykPX/70E4sp/gkIFXs2ENNQNo+M0Rs2TrMUQVl1mHKzYp8x4o1
   aPek3ES9L9pqoV4fYEuFWGTntF1u6fRs4id0dEbQqfKl3SOvJl9WaiX2j
   /wx8+fQXRGrYVeCiB5eyrdHov1BTWmSrhvDwRPB3P7rhn799vM6jFMFER
   SRkI0gT+hPrtEzalSdkUi5J9u7BqSKa/cnYSm/cS1F65YUrYmz8OJ5QYb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396879231"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396879231"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 18:30:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669373099"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669373099"
Received: from hushengh-mobl.ccr.corp.intel.com ([10.254.212.182])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 18:30:36 -0800
Message-ID: <b369e6d44b01e0ccc653e333bc2def556b17bbb3.camel@intel.com>
Subject: Re: [PATCH v1 1/5] rtc: rtc-cmos: Call cmos_wake_setup() from
 cmos_do_probe()
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue, 08 Nov 2022 10:30:33 +0800
In-Reply-To: <1850290.tdWV9SEqCh@kreacher>
References: <2276401.ElGaqSPkdT@kreacher> <1850290.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-07 at 20:59 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that cmos_wake_setup() is the only user of acpi_rtc_info and
> it
> can operate on the cmos_rtc variable directly, so it need not set the
> platform_data pointer before cmos_do_probe() is called.  Instead, it
> can be called by cmos_do_probe() in the case when the platform_data
> pointer is not set to implement the default behavior (which is to use
> the FADT information as long as ACPI support is enabled).
> 

...

>  
> @@ -827,19 +829,27 @@ cmos_do_probe(struct device *dev, struct
>  		if (info->address_space)
>  			address_space = info->address_space;
>  
> -		if (info->rtc_day_alarm && info->rtc_day_alarm < 128)
> -			cmos_rtc.day_alrm = info->rtc_day_alarm;
> -		if (info->rtc_mon_alarm && info->rtc_mon_alarm < 128)
> -			cmos_rtc.mon_alrm = info->rtc_mon_alarm;
> -		if (info->rtc_century && info->rtc_century < 128)
> -			cmos_rtc.century = info->rtc_century;
> +		cmos_rtc.day_alrm = info->rtc_day_alarm;
> +		cmos_rtc.mon_alrm = info->rtc_mon_alarm;
> +		cmos_rtc.century = info->rtc_century;
>  
>  		if (info->wake_on && info->wake_off) {
>  			cmos_rtc.wake_on = info->wake_on;
>  			cmos_rtc.wake_off = info->wake_off;
>  		}
> +	} else {
> +		cmos_wake_setup(dev);
>  	}
>  
> 

Previously, before commit a474aaedac99 ("rtc-cmos: move wake setup from
ACPI glue into RTC driver"), dev->platform_data is set in
drivers/acpi/glue.c, and the above commit moves it to cmos_wake_setup()
in this file.

Now, with this patch, my understanding is that dev->platform_data is
never set, thus we can remove the 'info' variable and the
	if (info)
check above.

thanks,
rui

