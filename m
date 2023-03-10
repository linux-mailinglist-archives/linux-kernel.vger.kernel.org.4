Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04526B3E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCJLhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCJLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:37:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B912CC6;
        Fri, 10 Mar 2023 03:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678448248; x=1709984248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+FGv2pcznGRNheMrPcKncacw+ECWtPpW7JlV7epav5s=;
  b=ldHClnWH18yoiHrcMs9nkP+u8kGhBWlhseKYrXO2iZB0Mmtx38X6NgSo
   bzkNkOK80lLZRRVgt9T0TDhFA61EGuY6vZfB+gfCKNoG+COZAcUzpGEc7
   CxpXkEnt27wrZSKEmTDDMEorOCwDRhvztgX9pJDEzanS1VnV6/FLhw/j2
   Dc4djW0s4T1vWZripfTeE7bw7EDkcmTmk7IToLWjda999UWjTy/3Lvvi6
   q/rsxax1uXxBoT3gzNzlmWAOhqgNd2aUeE18krKsF1urTyCjH4XKNjYRn
   OfqTeQMB3Cu+UQ0eXXoK28kudKHqnxKTTBpC36lHaTLnU/GoYooT9Bqi1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338262887"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="338262887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="627782038"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="627782038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2023 03:37:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pab3r-000qNU-2p;
        Fri, 10 Mar 2023 13:37:23 +0200
Date:   Fri, 10 Mar 2023 13:37:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <ZAsWc8nL6Pp5ffv2@smile.fi.intel.com>
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
 <ZAnnJpdtlEOS4tiS@smile.fi.intel.com>
 <ZAnxgooAixXAJvDn@smile.fi.intel.com>
 <20230310064308.GW62143@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310064308.GW62143@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:43:08AM +0200, Mika Westerberg wrote:
> On Thu, Mar 09, 2023 at 04:47:30PM +0200, Andy Shevchenko wrote:

...

> Agree with the patch. We should be using whatever the gc->fwnode points
> to.

Thank you for looking into it, can you provide a formal tag?

-- 
With Best Regards,
Andy Shevchenko


