Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1786B9A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCNPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCNPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:51:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68B559F7;
        Tue, 14 Mar 2023 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678809059; x=1710345059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9rh2IY+vYwP4lq9gWPzsDnxAgR+opMs+0qLK3Ajep0=;
  b=lXQftJiuaXEKDf0NM8NLntHVRWkpq+0ftfM0R18VJxPOCDeAjxcH3utU
   p1Pm5LUnpIHuln9YVBtJQBPp7dVbE12jvzuDiFU8CJJ1CDpUm/vHkExJA
   A6a2Dviz4jZ8x+DcofZZ+uAzkhbxVZhiRiQlc3CXNQPfc+MbBoa7SfWcW
   knyF6+XpmlvR1H5+Y7Tlc1VrsYwUWr33ff+YuiHkD2wzxYeGun6EwFEuv
   2C0xaeJ8HljwtvxcH0nCtRXXduJq5TfD3wDKMkxBnLKOGpJrulMhEtpEl
   wNJGhTpgNG5p9t1eY8RIhs/gU0fBb7Tj6tWV4EwPKvgos0qiJtS3v56uj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="423739460"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="423739460"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="679154555"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="679154555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2023 08:50:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pc6vC-003Iaa-30;
        Tue, 14 Mar 2023 17:50:42 +0200
Date:   Tue, 14 Mar 2023 17:50:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Message-ID: <ZBCX0iVwYD4uVxwM@smile.fi.intel.com>
References: <20230314152916.185939-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314152916.185939-1-william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:29:16AM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.

...

>  - Utilize watchdog_set_drvdata() and watchdog_get_drvdata()

I'm wondering why you can't use dev_get_regmap() instead.

>  - Map watchdog control registers based on offset 0x1 and adjust regmap
>    configurations accordingly; offset 0x0 is unused in this driver so we
>    should avoid unnecessary exposure of it

I'm wondering what bad could happen if you expose it.

-- 
With Best Regards,
Andy Shevchenko


