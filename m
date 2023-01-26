Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216AA67C830
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjAZKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjAZKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:15:24 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2832E82F;
        Thu, 26 Jan 2023 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674728116; x=1706264116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7/eKBAv/PLaUG5rE5WAQml5SQW9ir/oGhQL6aSA4HJg=;
  b=azwFW0s5IWtIW5O5iZ5rJNhSDjNXRszqxkyonIvrgSFq7A9fU3sPL9RX
   cfkrPTgB5hJxxg9QljiUpDh1HKCHEMH2cpyPNTVFvcWiS3V2tK9EqwVr2
   XkgjHMgqI04AJqcn5aZhUnEwFOCrvo1RJ4wJbS95BYs6JZ0px3/lvcYmk
   swReIEwHG3D/yCQT3r75hO23kokRZ/LfjdgoE7Tq5jewpAIlB2RUiSIbC
   5mpdbnlqKEfCai4c0MXWNORKjVkkRNoxeunECW3m1jO18Ko4F4/j7cigM
   1e4IlScfyd5FyYph1OT3oqMh2CuLP/kg2N/9v7JLmqEA/QFFvZUWXGLFp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326809693"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="326809693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 02:15:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="695037285"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="695037285"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 02:15:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKzHi-00FKsQ-13;
        Thu, 26 Jan 2023 12:15:10 +0200
Date:   Thu, 26 Jan 2023 12:15:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: gadget: Use correct APIs and data types for
 UUID handling
Message-ID: <Y9JSrWafclaTmLwP@smile.fi.intel.com>
References: <20230125143425.85268-1-andriy.shevchenko@linux.intel.com>
 <CAMUOyH2Kc6hL4564sYDZdGRjiJJYmDA5WXEsF92p_xN8iZGMsg@mail.gmail.com>
 <Y9GKje/7t79cxecC@smile.fi.intel.com>
 <CAMUOyH163WY3Csbs8QOy6VssrR9TXZRi6ChnqPn=PO7z12rZOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMUOyH163WY3Csbs8QOy6VssrR9TXZRi6ChnqPn=PO7z12rZOQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:54:58PM +0100, Jó Ágila Bitsch wrote:
> On Wed, Jan 25, 2023 at 9:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jan 25, 2023 at 06:31:36PM +0100, Jó Ágila Bitsch wrote:
> > > On Wed, Jan 25, 2023 at 3:34 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > I compiled and tested your patch in my test setup and it works perfectly.
> >
> > Thanks for the testing. According to Submitting Patches documentation
> > you can provide a formal Tested-by tag.
> 
> Thanks for pointing this out to me.
> 
> I'm not really sure how to do that though.
> On https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statement-of-oversight,
> it says:
> > Both Tested-by and Reviewed-by tags, once received on mailing list from tester or reviewer, should be added by author to the applicable patches when sending next versions.
> 
> So I guess you could do that at your convenience on any next version.

In mine I can only do if you give me that tag. Till this
line the tag is not given, but...

> Or is it already ok, if I just add the following line in my comment?

...this is what is expected to have.

> Tested-By: Jó Ágila Bitsch <jgilab@gmail.com>

And now _if_ I need a new version I will bear this with it. Otherwise
maintainer, who picks up the patch, takes care of gathering these all
together.

> I'm still quite a newbie in the kernel development community, so
> thanks for bearing with my ignorance :-)

So far you are doing good, thanks!

-- 
With Best Regards,
Andy Shevchenko


