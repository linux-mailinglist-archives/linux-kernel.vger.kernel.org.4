Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78A6605158
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJSUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJSUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:33:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742791870BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666211632; x=1697747632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kbOO8HXCNH/9sysdQIqYNZClN/RyYEn/FyixWYB4ieM=;
  b=NTW+D72KDBxHpGQnIrmHX41uUIupytipoHMszqECgr0CTaLz/fHDv64Z
   bidK03Sr1su2G6sN6Ro3i+qHWpAU91y/th+AfXguEHrsHScsLFC+NcV92
   roe24G4rKukdt+V03RkLgfPYz0UOahDRm9iqgBBrssFhFRJ061iBelI0t
   rQUli4aE+jrpreG/dKdDsSKT8vLBaTrFG6gIVUqJSXcGhQMNdyFeofhYy
   qV6e5OCwCm54ztcbZVK2IxbbK10P7PeHJVbBgqs/sxpK+0z3Syqp3P7D8
   ck/M3RENwS2OkOHY37ttvabKvEq2nuWk/pDboRKf4+pPDFidG8pFr9RjN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305258806"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305258806"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 13:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="718658950"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="718658950"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2022 13:33:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olFl5-00A7Lo-1i;
        Wed, 19 Oct 2022 23:33:47 +0300
Date:   Wed, 19 Oct 2022 23:33:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        konrad.wilk@oracle.com, haakon.bugge@oracle.com,
        john.haxby@oracle.com
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y1BfK6LpDJDlUYKp@smile.fi.intel.com>
References: <20221019194159.2923873-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019194159.2923873-1-jane.chu@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:41:59PM -0600, Jane Chu wrote:
> Having stepped on a local kernel bug where reading sysfs has led to
> out-of-bound pointer dereference by vsprintf() which led to GPF panic.
> And the reason for GPF is that the OOB pointer was turned to a
> non-canonical address such as 0x7665645f63616465.
> 
> vsprintf() already has this line of defense
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>                 return "(efault)";
> Since a non-canonical pointer can be detected by kern_addr_valid()
> on architectures that present VM holes as well as meaningful
> implementation of kern_addr_valid() that detects the non-canonical
> addresses, this patch adds a check on non-canonical string pointer by
> kern_addr_valid() and "(efault)" to alert user that something
> is wrong instead of unecessarily panic the server.
> 
> On the other hand, if the non-canonical string pointer is dereferenced
> else where in the kernel, by virtue of being non-canonical, a crash
> is expected to be immediate.

What if there is no other dereference except the one happened in printf()?

Just to point out here, that I formally NAKed this on the basis that NULL
and error pointers are special, for the bogus pointers we need crash ASAP,
no matter what the code issues it. I.o.w. printf() is not special for that
kind of pointers (i.e. bogus pointers, but not special).

-- 
With Best Regards,
Andy Shevchenko


