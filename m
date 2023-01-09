Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F88662426
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbjAILX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjAILXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:23:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C50C183B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673263425; x=1704799425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9gowqygYGDzqp90nSSibk1ac34lVOOMu4128ilX28Mc=;
  b=RbWuARBbNX2nDWFvRnmEH8xT1Ddwdzro+Ky2udFewXlAkwGz+GkYohOL
   3kFU/FZXT3+afdz+K/eQyappX78hj/fmHOti1ODjbW4QKgF4xy1Clxppc
   pkjG5Ecw9eaSziVL/i7DJgZoHOFtAqITqboDX/KHgObhpsBDJm7eeP8Kq
   ploaPq2Blms/4JWiErjBiFoC7fpom+44b/dZBAl/IzqJBlVVHEJ16d8dG
   /h89oN8uNmlGIgJjLMDWILQFZ5H13tvOJgcQmmZbMIgVDJfmiP93hCjj+
   iIA65ipsQUvCc1YOM19+ajU9/YgGLmHBzdV18sbRg8oHFzmQBNK7kaU1V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="350063288"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="350063288"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="658562782"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="658562782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2023 03:23:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEqFg-006Mal-2A;
        Mon, 09 Jan 2023 13:23:40 +0200
Date:   Mon, 9 Jan 2023 13:23:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
Message-ID: <Y7v5PEcP3LAcfTdk@smile.fi.intel.com>
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:16:31AM +0300, Sergey Shtylyov wrote:
> In vsnprintf() etc, C99 allows the 'buf' argument to be NULL when the
> 'size' argument equals 0.  Let us treat NULL passed as if the 'buf'
> argument pointed to a 0-sized buffer, so that we can avoid a NULL pointer
> dereference and still return the # of characters that would be written if
> 'buf' pointed to a valid buffer...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.

...

> +	/*
> +	 * C99 allows @buf to be NULL when @size is 0. We treat such NULL as if
> +	 * @buf pointed to 0-sized buffer, so we can both avoid a NULL pointer
> +	 * dereference and still return # of characters that would be written
> +	 * if @buf pointed to a valid buffer...
> +	 */
> +	if (!buf)
> +		size = 0;

Do we have test cases for that?

And what's wrong to print "(null)" ? Have you checked if your patch makes any
regressions to those cases?

-- 
With Best Regards,
Andy Shevchenko


