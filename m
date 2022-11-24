Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB5637F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKXTT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXTTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:19:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22069AAB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669317563; x=1700853563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nCqV1mFvyRu7XjdUWbRQ79shM3wrEYQXSkya+tsZ/cg=;
  b=TVop2ZZq11XxoU7FDOqq1P0C1xeYCy1wM6h+NUc2gMJDrnYCVEON773M
   zAh+hGZk+sx/QdB0BNwZuYPHbZMB6a52lC0JqGLw8RLNgnH7CWVVlXo6d
   mPufbBa8VubSAEsST4sMklzkNCS0o3w0+1drCYlcpyuXCMFPZRHSVAHc3
   rQNtMMEPc7MnG9HvwnKuFwKIyIzQcuRzURq+YwslSD8yDyd6+w7If/T2S
   23BQq1281iQdziE2QQBZb7okEQUrGMYEhlnRtpiqt2zZNg46qBzeChpsN
   HQQcQl1ISWz8KBXx8OWgTspToAWJiSkyLDEXZ0yJ0iZ3Rc3xh4Y9HwAtb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="313055117"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="313055117"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 11:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="767163501"
X-IronPort-AV: E=Sophos;i="5.96,191,1665471600"; 
   d="scan'208";a="767163501"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2022 11:19:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oyHkl-00GuyM-2a;
        Thu, 24 Nov 2022 21:19:19 +0200
Date:   Thu, 24 Nov 2022 21:19:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: hd44780: Fix potential memory leak in
 hd44780_remove()
Message-ID: <Y3/Dt3f4edPqPFqb@smile.fi.intel.com>
References: <20220907070735.56488-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907070735.56488-1-niejianglei2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:07:35PM +0800, Jianglei Nie wrote:
> hd44780_probe() allocates a memory chunk for hd with kzalloc() and
> makes "lcd->drvdata->hd44780" point to it. When we call hd44780_remove(),
> we should release all relevant memory and resource. But "lcd->drvdata
> ->hd44780" is not released, which will lead to a memory leak.
> 
> We should release the "lcd->drvdata->hd44780" in hd44780_remove() to fix
> the memory leak bug.

It's pity you haven't compiled your stuff, while the analysis seems valid
to me.

What you need to do is:
1) compile on your side _before_ sending and be sure it compiles;
2) in this particular case you need an additional level of typing;
3) add Fixes tag;
4) resubmit as v2 the new version.

-- 
With Best Regards,
Andy Shevchenko


