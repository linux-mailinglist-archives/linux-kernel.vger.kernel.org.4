Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E613620128
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiKGV2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:28:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5746118E03;
        Mon,  7 Nov 2022 13:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667856523; x=1699392523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMhhFWN0tq3l9heiz2390g+NAjEPIpwyv/9Bc22v3Xg=;
  b=EZrjx+/FT6Askg25K7DfXJ+Uua8eu0oyfjEx8Bq12Rq7yt+O3K4ZXdcn
   CFxYUdJfln2q0ybuCzbdLWRye2Oa/C7DKHZTjRN4BQJOmZ2E/p4xZ/kKf
   MTarx+TTBoQvszxzrhNj9ZdflwpI00iloINgdBanqK7tZov0FFgqbmgmt
   RYiw7N44rVNiO6iNmwJ2OGX8psA0BriskYA9YmOZxeSTN3cS4IvIo25Zh
   w8X1s1ijindBtlXvBZVvGHJSsNheZALNwc/23hbclArJzS27guQr2Wj+f
   1hlUUYWOvI1PeKpmJ6s8/KDCSmr65owMNHDnesaYp0xipnxwgCT6UC3n9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310530454"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="310530454"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614022429"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614022429"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2022 13:28:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os9fa-008qG5-1s;
        Mon, 07 Nov 2022 23:28:38 +0200
Date:   Mon, 7 Nov 2022 23:28:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v1 5/5] rtc: rtc-cmos: Disable ACPI RTC event on removal
Message-ID: <Y2l4hmXQTiQZssDK@smile.fi.intel.com>
References: <2276401.ElGaqSPkdT@kreacher>
 <2219830.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2219830.iZASKD2KPV@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:03:06PM +0100, Rafael J. Wysocki wrote:

...

> +static inline void acpi_rtc_event_cleanup(void)
> +{
> +	if (!acpi_disabled)

Btw, other functions look like using

	if (acpi_disabled)
		return;

pattern. Maybe here the same for the sake of consistency?

> +		acpi_remove_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler);
> +}

-- 
With Best Regards,
Andy Shevchenko


