Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B36574D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiL1Jm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiL1Jm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:42:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746636264;
        Wed, 28 Dec 2022 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672220547; x=1703756547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5G01XmqXrUM+91mhB3Vz/c4W/zaLMjFyi5lKjPbwk0Y=;
  b=jTJFXm5Feg4SudhYO2OQDMYawdmmtmWb4qJjhBeO2oSVLAPtteaaefRy
   yAeDGcEoSJkmash8AA7yWtT9Cwm2aAX0PoaqCKGXPIPA5ymDOpTyuU52a
   Azeuz681gt+T1Wj0PSOmcD7LB3ANCynXZcxTGhuGpyGsrlaVkGqoQzdKy
   5aZHzmsz1/yT/FUFgslW351k+43ugwauyz/XqeaSFxOvNkQ8vivBpfP/g
   dL2oDz4xW2AiHWCB9oSRgEI1b6MW3Bb/BJpVJPJOm0t2JSHR7iUhs0ymB
   EIzcYdX7s7Zw3y4bKCvhJR/33Y4SheXXHpt0mkqaEvDUosMoRIF7b6tyA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="385265823"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="385265823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="603289869"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="603289869"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2022 01:42:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pASx5-000W7H-0C;
        Wed, 28 Dec 2022 11:42:23 +0200
Date:   Wed, 28 Dec 2022 11:42:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/5] rtc: isl12022: Get rid of unneeded private struct
 isl12022
Message-ID: <Y6wPfnRC3YeFxs3S@smile.fi.intel.com>
References: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
 <a004a051-2f63-b5a4-bf7b-925850f1f718@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a004a051-2f63-b5a4-bf7b-925850f1f718@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 03:10:00PM +0100, Rasmus Villemoes wrote:
> On 26/11/2022 15.18, Andy Shevchenko wrote:
> > First of all, the struct rtc_device pointer is kept in the managed
> > resources, no need to keep it outside (no users in the driver).
> > 
> > Second, replace private struct isl12022 with a regmap.
> 
> Nice simplification.
> 
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thank you!

Alexandre, do you have any comments on this series?
If no, can it be applied now?


-- 
With Best Regards,
Andy Shevchenko


