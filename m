Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A060B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiJXRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiJXRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:32:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E811E47D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666627649; x=1698163649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DCwyvX3f1HmlVisOuwf6yAKi19JGqQ4PocX/hI8Jd0I=;
  b=ZPQPggjV0zZ6+SWCDn6Tz/ccTLiBwB4/3g35iPYpizYf/KM64tzb5MPc
   RsBvY508N+w402l4X8KNaJur/p2BovGtA5zZyYZlpjZkhyBO9Glb5FtqM
   G3utt+E/h+oYRwUIiOxAazBCy/vfccIMzCUdun1nsUzL2MIo9PZ7V1qYq
   2Ac5Mr5jL34fVxtZXjBDOrdJn8IsW/pJQDEXk0YthPjhD6pt1Cjw0BHfn
   1nJ/rdI57DYpl9ISdExGfR38SxCzLF10/cSawxn9kCpu2ZplcpktCfBJk
   eYjjaqx023P9iA/txPC1/9VjQ1nyxsV6DUwu5D3cPYZ1u/40NaeiDN220
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306190195"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="306190195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756621679"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="756621679"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2022 09:06:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omzyI-001Wxf-1s;
        Mon, 24 Oct 2022 19:06:38 +0300
Date:   Mon, 24 Oct 2022 19:06:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y1a4DlEYlVyrzVVG@smile.fi.intel.com>
References: <Y1ay8k75fegxTcuG@x99>
 <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 07:05:18PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 06:44:50PM +0300, Alexey Dobriyan wrote:
> > > include/linux/array_size.h | 13 +++++++++++++
> > 
> > All of this is pessimisation unless you're removing
> > 
> > 	+#include <linux/array_size.h>
> > 
> > from kernel.h which you aren't doing.
> > 
> > container_of.h is just as silly.
> > 
> > kernel.h might need _some_ cleanup (like panic and tainted stuff) which
> > is rarely used but ARRAY_SIZE()?
> 
> Are you suggesting to slow down compilation with inclusion of tons of unneeded
> stuff in the zillions of drivers?
> 
> Or you are talking that we need to abandon most of the headers and combine
> everything into kernel.h? I think this is what is silly.

Btw, your mail broke the reply chain.

-- 
With Best Regards,
Andy Shevchenko


