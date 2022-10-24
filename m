Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F560B445
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiJXRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiJXRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:33:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF91E577F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666627726; x=1698163726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gkzgg9MUnABJ619WRl36h7rWIHsgtStwgEzSjWSBtQw=;
  b=GzH6Bcs5s6fkqXiCRt7mBulHz4z8ivT9BY4LKJRVkcTbgLPfkgtfQkPw
   urejxKORbXepkVDAV5vYAsQNsGOPZs/vJVK8xinBZw+ZvugY0L/aix47V
   HF6PK2hVxqrIPyO9rfSDIGx2e9bewJk1nOI6qScTHu07pAa9jCQmHMBJX
   rVaXgYCdJ92cOsYouKQu40I/0cEL/a+RJWzK6dGj8dDWm+cr2fYHrStdD
   z0Ye2+mPZ+Krbns+xxsUTmULVR5wqpLIY5eEiLX8UvspvPKG6Pxi2wXtW
   woiWhwKUt/UUdVaJ2aCjo3taBIcwmnfWVTrCY+7ZgMtqFfP6LCSF/plwt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309146196"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="309146196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694606791"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="694606791"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Oct 2022 09:05:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omzx0-001Wvc-2d;
        Mon, 24 Oct 2022 19:05:18 +0300
Date:   Mon, 24 Oct 2022 19:05:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
References: <Y1ay8k75fegxTcuG@x99>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ay8k75fegxTcuG@x99>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 06:44:50PM +0300, Alexey Dobriyan wrote:
> > include/linux/array_size.h | 13 +++++++++++++
> 
> All of this is pessimisation unless you're removing
> 
> 	+#include <linux/array_size.h>
> 
> from kernel.h which you aren't doing.
> 
> container_of.h is just as silly.
> 
> kernel.h might need _some_ cleanup (like panic and tainted stuff) which
> is rarely used but ARRAY_SIZE()?

Are you suggesting to slow down compilation with inclusion of tons of unneeded
stuff in the zillions of drivers?

Or you are talking that we need to abandon most of the headers and combine
everything into kernel.h? I think this is what is silly.


-- 
With Best Regards,
Andy Shevchenko


