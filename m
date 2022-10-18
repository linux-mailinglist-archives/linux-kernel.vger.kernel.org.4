Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0287560344F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJRUtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJRUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:49:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD2D2729
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126180; x=1697662180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhtP4L4IziWH+iVHX/zbpE3/ubmrbUo2PAVr5BTmktY=;
  b=UcTgxFYa1vZ0nkeaV87qAdFMYZnCWESvs49EnuEc9NLMcog1xYDKSIhW
   Njup8RZFKmt06dU/orXt0DR6IGeaumRgCbY7mV1VzTKGHqpvvYpBQ6ppi
   7nHDASxz0ge7yWcSqaSk+yxPH5z2tGzHduj6TTneYnfwP2vRnh+u/wn4F
   q/V0pSZlh+MIR7+PCXYV+zC7e6F2mqj52SsmMF4r6aduapk/nw2ebODDy
   xaYusEMo6FmNfNH90iu6ephdmGUGOf3jxGy1Ag0rhxjArRFsHgKxjJ7WC
   E5cmMTb+m+h1G45m378ZlL81tUbJrwJD7vpewrmsHnN5UD8q3t0OliylZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303847755"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="303847755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771412657"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="771412657"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 13:49:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oktWi-009YCi-03;
        Tue, 18 Oct 2022 23:49:28 +0300
Date:   Tue, 18 Oct 2022 23:49:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Message-ID: <Y08RVzvniYr8ycKV@smile.fi.intel.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
 <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 08:30:01PM +0000, Jane Chu wrote:
> On 10/18/2022 1:07 PM, Andy Shevchenko wrote:
> > On Tue, Oct 18, 2022 at 06:56:31PM +0000, Jane Chu wrote:
> >> On 10/18/2022 5:45 AM, Petr Mladek wrote:
> >>> On Mon 2022-10-17 19:31:53, Jane Chu wrote:
> >>>> On 10/17/2022 12:25 PM, Andy Shevchenko wrote:
> >>>>> On Mon, Oct 17, 2022 at 01:16:11PM -0600, Jane Chu wrote:
> >>>>>> While debugging a separate issue, it was found that an invalid string
> >>>>>> pointer could very well contain a non-canical address, such as
> >>>>>> 0x7665645f63616465. In that case, this line of defense isn't enough
> >>>>>> to protect the kernel from crashing due to general protection fault
> >>>>>>
> >>>>>> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> >>>>>>                    return "(efault)";
> >>>>>>
> >>>>>> So instead, use kern_addr_valid() to validate the string pointer.
> >>>>>
> >>>>> How did you check that value of the (invalid string) pointer?
> >>>>>
> >>>>
> >>>> In the bug scenario, the invalid string pointer was an out-of-bound
> >>>> string pointer. While the OOB referencing is fixed,
> >>>
> >>> Could you please provide more details about the fixed OOB?
> >>> What exact vsprintf()/printk() call was broken and eventually
> >>> how it was fixed, please?
> >>
> >> For sensitive reason, I'd like to avoid mentioning the specific name of
> >> the sysfs attribute in the bug, instead, just call it "devX_attrY[]",
> >> and describe the precise nature of the issue.
> >>
> >> devX_attrY[] is a string array, declared and filled at compile time,
> >> like
> >>     const char const devX_attrY[] = {
> >> 	[ATTRY_A] = "Dev X AttributeY A",
> >> 	[ATTRY_B] = "Dev X AttributeY B",
> >> 	...
> >> 	[ATTRY_G] = "Dev X AttributeY G",
> >>     }
> >> such that, when user "cat /sys/devices/systems/.../attry_1",
> >> "Dev X AttributeY B" will show up in the terminal.
> >> That's it, no more reference to the pointer devX_attrY[ATTRY_B] after that.
> >>
> >> The bug was that the index to the array was wrongfully produced,
> >> leading up to OOB, e.g. devX_attrY[11].  The fix was to fix the
> >> calculation and that is not an upstream fix.
> >>
> >>>
> >>>> the lingering issue
> >>>> is that the kernel ought to be able to protect itself, as the pointer
> >>>> contains a non-canonical address.
> >>>
> >>> Was the pointer used only by the vsprintf()?
> >>> Or was it accessed also by another code, please?
> >>
> >> The OOB pointer was used only by vsprintf() for the "cat" sysfs case.
> >> No other code uses the OOB pointer, verified both by code examination
> >> and test.
> > 
> > So, then the vsprintf() is _the_ point to crash and why should we hide that?
> > Because of the crash you found the culprit, right? The efault will hide very
> > important details.
> > 
> > So to me it sounds like I like this change less and less...
> 
> What about the existing check
>   	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>                      return "(efault)";
> ?

Because it's _special_. We know that First page is equivalent to a NULL pointer
and the last one is dedicated for so called error pointers. There are no more
special exceptions to the addresses in the Linux kernel (I don't talk about
alignment requirements by the certain architectures).

> In an experiment just to print the raw OOB pointer values, I saw below
> (the devX attrY stuff are substitutes of the real attributes, other 
> values and strings are verbatim copy from "dmesg"):
> 
> [ 3002.772329] devX_attrY[26]: (ffffffff84d60ad3) Dev X AttributeY E
> [ 3002.772346] devX_attrY[27]: (ffffffff84d60ae4) Dev X AttributeY F
> [ 3002.772347] devX_attrY[28]: (ffffffff84d60aee) Dev X AttributeY G
> [ 3002.772349] devX_attrY[29]: (0) (null)
> [ 3002.772350] devX_attrY[30]: (0) (null)
> [ 3002.772351] devX_attrY[31]: (0) (null)
> [ 3002.772352] devX_attrY[32]: (7665645f63616465) (einval)
> [ 3002.772354] devX_attrY[33]: (646e61685f656369) (einval)
> [ 3002.772355] devX_attrY[34]: (6f635f65755f656c) (einval)
> [ 3002.772355] devX_attrY[35]: (746e75) (einval)
> 
> where starting from index 29 are all OOB pointers.
> 
> As you can see, if the OOBs are NULL, "(null)" was printed due to the 
> existing checking, but when the OOBs are turned to non-canonical which
> is detectable, the fact the pointer value deviates from
>    (ffffffff84d60aee + 4 * sizeof(void *))
> evidently shown that the OOBs are detectable.
> 
> The question then is why should the non-canonical OOBs be treated 
> differently from NULL and ERR_VALUE?

Obviously, to see the crash. And let kernel _to crash_. Isn't it what we need
to see a bug as early as possible?

-- 
With Best Regards,
Andy Shevchenko


