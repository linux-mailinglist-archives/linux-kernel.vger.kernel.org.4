Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB78F609E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJXJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJXJhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:37:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17546626
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666604237; x=1698140237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0MpMGFGpNDYiu9v5+FtkANV82sv0av8n2hfg3WgwSc=;
  b=cAZI+4F0yzfrqSLSn/U3bPIdC+Iy1IDgxoG3UJrctg7uEMbOm9pZX78R
   iO51n3Ctj2ykuZJO9daBUp2ULGRWuYzBXM32xYwLeGkzgd/ojMx65ByYA
   uBGZ+LnlM9v8NZmn2qUVUEPlaIz4yFN484qDjI2kD5XsA/7GFfpX7xD2T
   ubygLT4yuOwjQikMw0gRxn8WB61Fdyt3bvzLRoWKq6sTid82tON200CIf
   Z9oY3q5BIcxAgqueTSgl2Iyux21mAneR0jvkSwWl0iBiIGv61+AWsXnVO
   mql3duAToDNpqNaEe9MrRO3GMXx7uCwDqXfBnGI85C8HlvGkRynHySDOt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="294776855"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="294776855"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 02:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="960362442"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="960362442"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2022 02:37:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omttR-001N5H-0U;
        Mon, 24 Oct 2022 12:37:13 +0300
Date:   Mon, 24 Oct 2022 12:37:12 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1ZcyBd2Yjir/dNO@smile.fi.intel.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <Y1ZQpcdK4sdy+5QZ@kroah.com>
 <Y1ZW2WYli7Bfioxr@paasikivi.fi.intel.com>
 <Y1ZZcL/Q7QJ+YYhJ@smile.fi.intel.com>
 <fbe735d131a44c2a95248cc4ad51485b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe735d131a44c2a95248cc4ad51485b@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:34:42AM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 24 October 2022 10:23

...

> > > > Wait, no one uses this macro, so why not just remove it entirely?
> > >
> > > Good question. It appears to be a (relatively) common pattern to look up
> > > something and the return its containing object if the lookup was
> > > successful. Doing a quick
> > >
> > > 	$ git grep 'container_of.*:' drivers include
> > >
> > > reveals more than 20 instances of the pattern. There are probably more
> > > those that use if for testing for NULL. I guess people don't know about
> > > this macro, apart from the developers of the staging driver it was added
> > > for (commit 05e6557b8ed833546ee2b66ce6b58fecf09f439e).
> > 
> > Maybe we can provide an example to keep this macro in the kernel, meaning
> > convert one of the drivers / subsystem to actually use it?
> 
> Adding _safe() to a function name doesn't actually tell you anything.
> You still need to look up what it is 'safe' against.
> 
> In this case the full code pattern is actually much clearer.
> 
> It is also quite likely that it is followed by an:
> 	if (!ptr)
> 		return xxx;
> You that can/should really be put before the container_of() call.

return statements in macros are no go. Or you meant something else?

-- 
With Best Regards,
Andy Shevchenko


