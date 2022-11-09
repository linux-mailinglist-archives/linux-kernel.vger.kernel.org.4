Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059F622A77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKIL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiKIL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:26:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C882AC57;
        Wed,  9 Nov 2022 03:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667993210; x=1699529210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8fR1PP3piRuXUs8iAY6HPxHQkMepQgMDmtZV4slwnA=;
  b=PzNdbzNXngAzhdtYhra5RD3hGu74VlNK7sEhxFrYjDCvLfZnwmb8VPZt
   zreq6tCGXSOctiPud1hgC+KbG8/OXrc3Iij7YZeydIX6A8ZFrfHyDundE
   mgu2spCeSeP/WOogSknT20oZzWSZc9I5F8clvW0+9IwHe6xFWFegYXyPp
   1MMPRTTIIF4YAPMX+ctSW5P0aiOg4ZkDdSdAIZbyTeE5HRQI24fWQo5hu
   R1NLpIJfiHpV0TaraaChtZG0RamUuDEogUYRFYZHUpxToS4yn7WhoNmsK
   ENUCS2vSiyNGbIU79yA+mVFCW8LgKUBmz7VuXZ80rCMYJ5nKYyTt1ZKwW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290670409"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="290670409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:26:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="965959344"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="965959344"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 09 Nov 2022 03:26:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osjEF-009iXF-17;
        Wed, 09 Nov 2022 13:26:47 +0200
Date:   Wed, 9 Nov 2022 13:26:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] resource: Replace printk(KERN_WARNING) by
 pr_warn()
Message-ID: <Y2uOd+mCwmh4qdm8@smile.fi.intel.com>
References: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gxM80EKiiMJKkN6t1CVgf1=6yYA3D4=TfOHVh1chaJuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gxM80EKiiMJKkN6t1CVgf1=6yYA3D4=TfOHVh1chaJuw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:12:03PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 9, 2022 at 11:51 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Replace printk(KERN_WARNING) by pr_warn().
> >
> > While at it, use %pa for the resource_size_t variables.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This is Greg's stuff I think.

OK.

...

> > +       resource_size_t end = addr + size - 1;
> 
> And this change could be mentioned in the changelog too.

And it's (indirectly). This is to have a variable to be consistent in the
print. But I can add more explicit mention.

Thank you for a review!

-- 
With Best Regards,
Andy Shevchenko


