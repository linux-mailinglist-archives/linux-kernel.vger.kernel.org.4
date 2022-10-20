Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182860655E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJTQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJTQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:07:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0A1011AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666282018; x=1697818018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8H1XSPG3teHKYUp6wZ4Z92OLMc+S/wpfm0q02AUrZ8=;
  b=lu179EwfcNbWuTBweFu1WrC+VdbLzNBQqs1P/u+9T37sSBko8ixsO8UE
   JPacBgP4LhOr6ZrRslE18UnWM6zRVTT6pI9XQ2NDPKQgCY1VmwiMn2yPx
   1lk3oY2Nr9uZkRmYrl687KlM5Q6Z05seOj7gE+GLmFWA3Ge8xz7Y6A8n9
   5gPOQjhRs2BbsTdroodojczjW1llIQJotJ9LBo5xpIRNXx5yb1At48XFw
   vrcczOmLBYeByhMngV1SL3CB3ziCpfx4EZeMuQ+c7pl7xA1D+EBvVjnMv
   j3L5+xuW9q/RMa/79WH1qJKug6ZFmsjHXWKdPTEct9sGr1QFy9ZKPNjyi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286473183"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="286473183"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="698748301"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="698748301"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2022 09:03:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olY0x-00AcyW-2M;
        Thu, 20 Oct 2022 19:03:23 +0300
Date:   Thu, 20 Oct 2022 19:03:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jane Chu <jane.chu@oracle.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y1FxS30zVENd/1Ap@smile.fi.intel.com>
References: <20221019194159.2923873-1-jane.chu@oracle.com>
 <Y1BfK6LpDJDlUYKp@smile.fi.intel.com>
 <Y1Fgk1iDnhL7VtAl@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Fgk1iDnhL7VtAl@char.us.oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:52:03AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Oct 19, 2022 at 11:33:47PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 19, 2022 at 01:41:59PM -0600, Jane Chu wrote:
> > > Having stepped on a local kernel bug where reading sysfs has led to
> > > out-of-bound pointer dereference by vsprintf() which led to GPF panic.
> > > And the reason for GPF is that the OOB pointer was turned to a
> > > non-canonical address such as 0x7665645f63616465.
> > > 
> > > vsprintf() already has this line of defense
> > > 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > >                 return "(efault)";
> > > Since a non-canonical pointer can be detected by kern_addr_valid()
> > > on architectures that present VM holes as well as meaningful
> > > implementation of kern_addr_valid() that detects the non-canonical
> > > addresses, this patch adds a check on non-canonical string pointer by
> > > kern_addr_valid() and "(efault)" to alert user that something
> > > is wrong instead of unecessarily panic the server.
> > > 
> > > On the other hand, if the non-canonical string pointer is dereferenced
> > > else where in the kernel, by virtue of being non-canonical, a crash
> > > is expected to be immediate.
> > 
> > What if there is no other dereference except the one happened in printf()?
> > 
> > Just to point out here, that I formally NAKed this on the basis that NULL
> > and error pointers are special, for the bogus pointers we need crash ASAP,
> > no matter what the code issues it. I.o.w. printf() is not special for that
> > kind of pointers (i.e. bogus pointers, but not special).
> 
> Hey Andy,
> 
> Do we want to have user space programs crash the kernel?
> 
> This patch leads to making the kernel more harden so that we do
> not crash when there are bugs but continue on.

Fine, how to push a user to report a bug in the kernel if for them
there is no bug?

OK, let's assume user recognizes this as a bug, what should they do in order
to provide a better description of the bug, so developer can easily debug
and fix it?

> Would we not want that experience for users ?

Yes, if it is a bug in the kernel we want to know it with all possible details.
Hiding bugs is a way to nowhere.

-- 
With Best Regards,
Andy Shevchenko


