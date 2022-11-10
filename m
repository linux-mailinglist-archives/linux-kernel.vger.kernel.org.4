Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8168B624413
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKJOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKJOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:16:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9E7833C;
        Thu, 10 Nov 2022 06:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668089767; x=1699625767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KBYszAOzdmRi0kxUltvHbNHN8tp2cigSnsqbcqgvMaA=;
  b=evwhRF5JhGBO8NfQVno46u2ocqZxYsTN8NJz4ze5vZpwf1lp+uLp6Ta9
   BQe156GWHmv+dkkDMw4/A+Chry1na39/rnypTKddHwr120pHgTaxSUpmF
   xLqMl0cFvhAZHeRiEnx2kdXhL+JKeJ/ziKNNNoLI9c51XLotfZ6c/bhne
   AFJbCXwLN/NWPH75+Vcn138RVHsBHAIOokVZDtnaupAHjnqlY+hLgfefy
   /Q70Glj0ZeQo4t1A4m2e2cuAQQA2YSbPumh853moAbIyVLwQDirGyHpjM
   YgEG0fE+tptGzqsX/PIsVvQP51hAiFB14pKubH5YdTr64aLkwSQgt8u+q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291712885"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="291712885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 06:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="779786485"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="779786485"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2022 06:16:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot8Lc-00ABER-0l;
        Thu, 10 Nov 2022 16:16:04 +0200
Date:   Thu, 10 Nov 2022 16:16:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for software nodes to gpiolib
Message-ID: <Y20Ho88s2H/PWd7M@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <Y2uPJfkYpuI/uHeQ@smile.fi.intel.com>
 <Y2wAT3LOytr9AfZt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2wAT3LOytr9AfZt@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:32:31AM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 09, 2022 at 01:29:41PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 08, 2022 at 04:26:45PM -0800, Dmitry Torokhov wrote:

...

> > Thank for an update!
> > 
> > I have almost nothing serious except two nit-picks I think we can address:
> > - dropping const qualifier for no (?) reason
> > - having a superfluous check and extra dev_dbg()
> > 
> > If you are are going to address them, feel free to add my Rb tag to
> > the patches 5 & 6.
> 
> Thank you for the reviews. I addressed most of your comments, but
> because I still left the check you were concerned about in I'd like an
> explicit reviewed-by on the v3 if you OK giving it.

I gave for patch 6 and for patch 5 I still think we can get rid of the check.

-- 
With Best Regards,
Andy Shevchenko


