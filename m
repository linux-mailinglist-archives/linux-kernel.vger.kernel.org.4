Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03B612D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ3Vwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3Vwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:52:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA8AE60
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667166750; x=1698702750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yKV0kn7+sNjHxDv1drM+NAfrxBAs+SlnJFwDA8xfygk=;
  b=ZPajshVS5uriUAaYlgXqQEFGBFNhgjm60vBkwtofzOfQoA7SEkny9LhK
   6RDSmsfwgwsUvkAEDEJJ15UtPKEh/xdHLrJ1BC+dUT2erYtRDb4PKBEoI
   VR6wo70QdJDvel6fpY4igZ5x7ndU7dXMO9z+kMaXRBzhJvHs7/3ILpNbt
   G8MgBdLRxrWOV0V8S2k6dbxswczrVrcd6oL01B+CPXxpMniLA3zLqaq1u
   S88IKUoC6UFEp5nQwTCC8UoOVUmZBnkDyQ8GMyy4hhmzlh9cwEi7ADsGT
   laxiNMwU2D1UrZ3WOjqieMLyyzHKdgwNpRWK3sFo9/Y2BQ12nPOEqw0Cy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="309866797"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="309866797"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 14:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584466440"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="584466440"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 14:52:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opGEF-004pPT-0T;
        Sun, 30 Oct 2022 23:52:27 +0200
Date:   Sun, 30 Oct 2022 23:52:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y17yGm93EV1YrjAX@smile.fi.intel.com>
References: <Y1ay8k75fegxTcuG@x99>
 <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
 <Y1bWBedax9lP2E3K@p183>
 <Y1ecOl+UGdBV1ce3@smile.fi.intel.com>
 <Y1z697DtIBdp+Z9C@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1z697DtIBdp+Z9C@p183>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 01:05:43PM +0300, Alexey Dobriyan wrote:
> On Tue, Oct 25, 2022 at 11:20:10AM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 09:14:29PM +0300, Alexey Dobriyan wrote:
> > > On Mon, Oct 24, 2022 at 07:05:18PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Oct 24, 2022 at 06:44:50PM +0300, Alexey Dobriyan wrote:
> > > > > > include/linux/array_size.h | 13 +++++++++++++
> > > > > 
> > > > > All of this is pessimisation unless you're removing
> > > > > 
> > > > > 	+#include <linux/array_size.h>
> > > > > 
> > > > > from kernel.h which you aren't doing.
> > > > > 
> > > > > container_of.h is just as silly.
> > > > > 
> > > > > kernel.h might need _some_ cleanup (like panic and tainted stuff) which
> > > > > is rarely used but ARRAY_SIZE()?
> > > > 
> > > > Are you suggesting to slow down compilation with inclusion of tons of unneeded
> > > > stuff in the zillions of drivers?
> > > > 
> > > > Or you are talking that we need to abandon most of the headers and combine
> > > > everything into kernel.h? I think this is what is silly.
> > > 
> > > It hard to escape kernel.h so you will be including it anyway.
> > 
> > It's very important to not include it in the headers.
> > 
> > And this split helps to it a lot. We have container_of() or array_size() used
> > in macros and/or inliners that are usually appears in the headers. And if you
> > know what dependency hell means, the kernel.h brings to it a huge mess.
> > 
> > So, try to be constructive, okay?
> > 
> > > Unless you delete, say, kstrtox.h from kernel.h, it is pointless busywork.
> 
> I'm very constructive.
> 
> Parsing 1 define is faster than opening/reading/closing a file to parse
> 1 define (it's 2 defines because of header guard).
> 
> Therefore extracting 1 macro into separate file without obvious future
> growth is a pessimisation.

You are looking at it at the wrong side. The opening one file inside a single
file maybe a way to slow down the compilation, but cleaning up the _headers_
from kernel.h and similar mess is a definite win.

Ingo, for example, unwounded the thread coil for the scheduler code with a
significant win. And his work exactly shows why it's right way to go.

> And if you delete #include <array_size.h> from kernel.h and fix all
> compile failures (which you aren't doing apparently) backporters will
> hate you for life.

It would need some time to have kernel.h to be hanging as is before we can
start cleaning the mess our of it. I prefer to kill the whole header or leave
there only really _kernel_ parts.

> I've tried to delete kstrtox.h, and even allnoconfig had dozens of
> failures.

So, help us and fix them!

-- 
With Best Regards,
Andy Shevchenko


