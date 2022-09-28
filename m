Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFF5EDE03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiI1Nn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiI1NnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:43:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8699B62;
        Wed, 28 Sep 2022 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664372600; x=1695908600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9LQdEru0PYlG2TQfhhZT1PNcyVyVp/h39DuwkHJvKpI=;
  b=g1voqlQ7qt3xHhc/B6kG1khIynQSo2PaUnciZx1eDPpe1oCyc71D5PhF
   pXsRsDfBOkUSTNr+RQpcK7aMQ6sqkIkdfdz060c1tUAqWEV+F7pc8wslj
   ll1qrtzj/av3H0lSNQQ/5hrE9GNfpCkEbex1W9ZsSEhVdVhnQiQmqFElJ
   ujZ3kYrPhPpxyEcQ8FuFFBn8WST/RizbSkZ0rDbrgo9I7ZASKo+ztI50J
   yRBuJI7RnOgPqkn8PpCE56GYh3c8OzNaSjsxaRgRoyVJB3u4saGQ4q/Dc
   lN43npMQjK8ot9zz5n2PFcXFP2OrZcZRtAkKCVQluQ4qAWBOCIhHNOwFv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="303087164"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="303087164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 06:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="655134405"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="655134405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2022 06:43:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odXLJ-008x3c-2S;
        Wed, 28 Sep 2022 16:43:17 +0300
Date:   Wed, 28 Sep 2022 16:43:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/4] pwm: sysfs: Return directly from the for-loop in
 PM callbacks
Message-ID: <YzRPdfC/2AdeMXtu@smile.fi.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-2-andriy.shevchenko@linux.intel.com>
 <YzQ+m3jjh6tOyXmS@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQ+m3jjh6tOyXmS@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:31:23PM +0200, Thierry Reding wrote:
> On Fri, Aug 26, 2022 at 08:07:14PM +0300, Andy Shevchenko wrote:
> > There is no need to assign ret to 0 and then break the loop just
> > for returning the error to the caller. Instead, return directly
> > from the for-loop, and 0 otherwise.

> I fail to see how this is an improvement. The outcome is exactly the
> same and this doesn't even make the code shorter. Why bother?

The improvement is in maintenance. It's proven that assignments in the
definition block might lead to the subtle mistakes when it's not close
enough to the actual use. That said, this is an improvement from
maintaining and developing perspectives.

-- 
With Best Regards,
Andy Shevchenko


