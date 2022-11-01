Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52D614CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiKAOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiKAOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:46:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F772175B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667313993; x=1698849993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9r7bV7THRZ3zvbuzv5WUUyGnoPxnVYn+rhpH3ErFd/c=;
  b=mdbZfsF0LYgL7fmG+sfgijsTBHAPBGUyvUHI+uyvMJlWL3w/zHX2/JPz
   RCdTyexnRql5EFh420nx5KmV5Nxp0s/NBSXK0/F1lYTrXTdo8ep7z6eAb
   OaNx6p/SUnuR5YYxhEH9Fcv6sh7FsYSMAECQQWK+KYXT3Ruz1wZ2jJ/2j
   s7hJmf5bKBsKZEFzT2b90K8+8swZmlCe4NwHoBIghXLNoH+QmdnG2nfda
   YJR26z/hoIYqkh6k6D1w0Xpf3XNakjxXF/AoZ3OrvpOhqwHfhIzzyu2Im
   VMG9BZ1xnDq9t8G+JYU7zzLS9yJD7lHDBs2Q2w5HXtbNYKkFr72dTKC5A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395460865"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395460865"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 07:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="759193494"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="759193494"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2022 07:40:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opsRS-005dFp-0o;
        Tue, 01 Nov 2022 16:40:38 +0200
Date:   Tue, 1 Nov 2022 16:40:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] test_printf: Refactor fwnode_pointer() to make it
 more readable
Message-ID: <Y2Ev5RgFvw8WyM6g@smile.fi.intel.com>
References: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
 <Yw9tTD1Qt6LG25bX@smile.fi.intel.com>
 <Y2EYrIHe8sQwT4ko@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2EYrIHe8sQwT4ko@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:01:32PM +0100, Petr Mladek wrote:
> On Wed 2022-08-31 17:16:44, Andy Shevchenko wrote:
> > On Wed, Aug 24, 2022 at 08:05:42PM +0300, Andy Shevchenko wrote:
> > > Converting fwnode_pointer() to use better swnode API allows to
> > > make code more readable.
> > > 
> > > While at it, rename full_name to full_name_third to show exact
> > > relation in the hierarchy.
> > 
> > Any comments?
> > 
> > Note, I would like to reduce exported swnode APIs and this will
> > help to do so.
> 
> JFYI, I have just pushed the patch into printk/linux.git, branch
> for-6.2.

Thank you!

> I am sorry that it took so long. I have got a long backlog of mails
> to proceed.

No problem.

-- 
With Best Regards,
Andy Shevchenko


