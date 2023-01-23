Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF5677AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjAWMZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjAWMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:25:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70F7ED5;
        Mon, 23 Jan 2023 04:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674476712; x=1706012712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iImm6JHQKgIeZCj3fq8kdp17FmAD/Yf9LjaaakF/0fg=;
  b=M/9UDFd5A1eRSooGcD6yj/lrrk9UdI0QcGXb2qUtOx0YIGMerUXCyBbp
   9rT+kRLj2EO7nCcGQyU95F8eL/KBC1ijwtfI/XL7c6pGtMLJDiiDS51Iq
   SYVEwIocGIwUvzo6PhVk6wRs6Zehk8CnVobZvMervANxA3zEpLKNycT4h
   M8qDEEDa2smkmZjoeLdH4cQMQSH5pHdq/4BgzowIAmB9Q2Ta9grv4UNIO
   xk7We8h/xJJph8hK2/CWqrAc4NG+dLrASjkhnXaqfYDrMSn1VaR1wuhnQ
   wpO+DcyLzO6cycIftBFL75WIfW3BXJ6wHftQ8GnxlWFJM2PrpL4VDpDA8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="328114602"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="328114602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="990389526"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="990389526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jan 2023 04:25:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJvso-00DjJQ-1q;
        Mon, 23 Jan 2023 14:25:06 +0200
Date:   Mon, 23 Jan 2023 14:25:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <luca.ellero@brickedbrain.com>
Cc:     Luca Ellero <l.ellero@asem.it>, dmitry.torokhov@gmail.com,
        daniel@zonque.org, m.felsch@pengutronix.de,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: ads7846 - don't report pressure for ads7845
Message-ID: <Y858otTEDM1ugI0k@smile.fi.intel.com>
References: <20230120124544.5993-1-l.ellero@asem.it>
 <20230120124544.5993-2-l.ellero@asem.it>
 <Y8qwQM2zLbboTeth@smile.fi.intel.com>
 <74c917ce-a67c-7b4a-023b-2f2f4fb365b5@brickedbrain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c917ce-a67c-7b4a-023b-2f2f4fb365b5@brickedbrain.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:27:37AM +0100, Luca Ellero wrote:
> On 20/01/2023 16:16, Andy Shevchenko wrote:
> > On Fri, Jan 20, 2023 at 01:45:42PM +0100, Luca Ellero wrote:
> > > ADS7845 doesn't support pressure.
> > > This patch avoids the following error reported by libinput-list-devices:
> > 
> > s/This patch avoids/Avoid/
> > 
> > (This rule is written in Submitting Patches documentation.)
> > 
> > > "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".
> > 
> > Do you need a Fixes tag?
> > 
> 
> Hi Andy,
> thank you for your reply.
> I haven't found a specific bug report to apply to this patches.
> Could you kindly provide a "Fixes:" tag that I can apply?

The Fixes tag in accordance with the documentation should refer to the commit
in the Git history which brought the problem (regression).

> It's more like this driver has never been tested with ADS7845.
> Maybe the patches should be considered as a new implementation instead than
> a bug fix?

If it's indeed from day 1, then the initial commit can be considered as Fixes
tag, but I leave it to maintainer to decide.

-- 
With Best Regards,
Andy Shevchenko


