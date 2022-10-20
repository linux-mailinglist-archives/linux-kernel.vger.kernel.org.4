Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F06058E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiJTHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJTHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:44:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2B43E65
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:44:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 79B8122742;
        Thu, 20 Oct 2022 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666251846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHbTH5UTb1JUbjbs4/Uk2iEdLfxd/Mdx2hxMut+87SI=;
        b=ARfcZvKchIuDTmGoZMMunuibRIM4HBBe1DsWTo3JFC2BlwbOS3HKEyNmtAfX3dqVVsEMoj
        FJdvT3NZ9tN4K73xaeNk2NjBwjhhJ/ABnuXjnOMyz5h53DaWi8ZtII+1r+b+DecuypvNMZ
        N+IBiNlfeSJjWGNfeTtMRL6Oa5KBWfw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1F5E52C153;
        Thu, 20 Oct 2022 07:44:06 +0000 (UTC)
Date:   Thu, 20 Oct 2022 09:44:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Message-ID: <Y1D8RfpkyLa4FU7r@alley>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
 <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
 <Y08RVzvniYr8ycKV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08RVzvniYr8ycKV@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-10-18 23:49:27, Andy Shevchenko wrote:
> On Tue, Oct 18, 2022 at 08:30:01PM +0000, Jane Chu wrote:
> > On 10/18/2022 1:07 PM, Andy Shevchenko wrote:
> > > On Tue, Oct 18, 2022 at 06:56:31PM +0000, Jane Chu wrote:
> > >> On 10/18/2022 5:45 AM, Petr Mladek wrote:
> > >>> On Mon 2022-10-17 19:31:53, Jane Chu wrote:
> > >>>> On 10/17/2022 12:25 PM, Andy Shevchenko wrote:
> > >>>>> On Mon, Oct 17, 2022 at 01:16:11PM -0600, Jane Chu wrote:
> > >>>>>> While debugging a separate issue, it was found that an invalid string
> > >>>>>> pointer could very well contain a non-canical address, such as
> > >>>>>> 0x7665645f63616465. In that case, this line of defense isn't enough
> > >>>>>> to protect the kernel from crashing due to general protection fault
> > >>>>>>
> > >>>>>> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > >>>>>>                    return "(efault)";
> > >>>>>>
> > >>>>>> So instead, use kern_addr_valid() to validate the string pointer.
> > >>>>>
> > >>>>> How did you check that value of the (invalid string) pointer?
> > >>>>>
> > >>>>
> > >>>> In the bug scenario, the invalid string pointer was an out-of-bound
> > >>>> string pointer. While the OOB referencing is fixed,
> > >>>
> > >>> Could you please provide more details about the fixed OOB?
> > >>> What exact vsprintf()/printk() call was broken and eventually
> > >>> how it was fixed, please?
> > >>
> > >> For sensitive reason, I'd like to avoid mentioning the specific name of
> > >> the sysfs attribute in the bug, instead, just call it "devX_attrY[]",
> > >> and describe the precise nature of the issue.
> > >>
> > >> devX_attrY[] is a string array, declared and filled at compile time,
> > >> like
> > >>     const char const devX_attrY[] = {
> > >> 	[ATTRY_A] = "Dev X AttributeY A",
> > >> 	[ATTRY_B] = "Dev X AttributeY B",
> > >> 	...
> > >> 	[ATTRY_G] = "Dev X AttributeY G",
> > >>     }
> > >> such that, when user "cat /sys/devices/systems/.../attry_1",
> > >> "Dev X AttributeY B" will show up in the terminal.
> > >> That's it, no more reference to the pointer devX_attrY[ATTRY_B] after that.
> > >>
> > >> The bug was that the index to the array was wrongfully produced,
> > >> leading up to OOB, e.g. devX_attrY[11].  The fix was to fix the
> > >> calculation and that is not an upstream fix.

I see. printk()/vsprintf() is the only code that accesses this pointer.
If vsprintf() survives than the system survives.

> > As you can see, if the OOBs are NULL, "(null)" was printed due to the 
> > existing checking, but when the OOBs are turned to non-canonical which
> > is detectable, the fact the pointer value deviates from
> >    (ffffffff84d60aee + 4 * sizeof(void *))
> > evidently shown that the OOBs are detectable.
> > 
> > The question then is why should the non-canonical OOBs be treated 
> > differently from NULL and ERR_VALUE?
> 
> Obviously, to see the crash. And let kernel _to crash_. Isn't it what we need
> to see a bug as early as possible?

I do not agree here. Kernel tries to survive many situations when
thighs does not work as expected. It prints a warning so that
users/developers are aware of the problem and could fix it.

In our case, the crash happened when reading a sysfs file.
IMHO, it is much better to show (-EINVAL) than crash. The bug
when accessing devX_attrY[] does not affect the stability of
the system at all.

And the broken string might be passed in a very rare case,
e.g. in an error path. So that it might be hard to catch
when testing.

Best Regards,
Petr
