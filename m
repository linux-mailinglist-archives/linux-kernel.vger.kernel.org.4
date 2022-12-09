Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88296488AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLIS4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLIS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:56:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7BAD328
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670612193; x=1702148193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7dZHF5ogQEuUsFgvNkNPmDXWvgVaqbn7sp5pbNxA1G0=;
  b=ILNQ/IY7S32a4YT3WM3/KEoXhq20TbaRjDat/J5wkjmKByea6v4lYP5S
   YSRagzKy+amaIKDZEyozISkzwy3ppR+wMdtOwteBLjm+WYigy91tCZsxz
   Qh13GScrJDGvBvexUtpHICPdOUsTJaazdsJoYE/2kCeGhVYr2eeyFQv/j
   7q2qEwRqkpQSUR69gJm4bp05W4QrIUqjUgEA8fGOE/aHBy+ylD6MssJHu
   jNYGseQ6xIe3tO0711QBfyL52QlcunSum+AdPSS2qMSCXxypZVR7oeqq5
   ruI4VvEby6htaVRrO0qN8BiT7ya1K8BOs6m+0wZu0JI6GVMRiRVN3lVmR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403783024"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="403783024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 10:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="789806268"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="789806268"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2022 10:56:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p3iXs-00785H-2t;
        Fri, 09 Dec 2022 20:56:28 +0200
Date:   Fri, 9 Dec 2022 20:56:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] linux/minmax.h: add non-atomic version of xchg
Message-ID: <Y5OE3AX7DS/DfClX@smile.fi.intel.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209154843.4162814-1-andrzej.hajda@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:48:39PM +0100, Andrzej Hajda wrote:
> The pattern of setting variable with new value and returning old
> one is very common in kernel. Usually atomicity of the operation
> is not required, so xchg seems to be suboptimal and confusing in
> such cases. Since name xchg is already in use and __xchg is used
> in architecture code, proposition is to name the macro exchange.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
> Hi,
> 
> I hope there will be place for such tiny helper in kernel.
> Quick cocci analyze shows there is probably few thousands places
> where it could be used, of course I do not intend to do it :).
> 
> I was not sure where to put this macro, I hope near swap definition
> is the most suitable place.

Ah, swap() in this context is not the same. minmax.h hosts it because
it's often related to the swap function in the sort-type algorithms.

> Moreover sorry if to/cc is not correct - get_maintainers.pl was
> more confused than me, to who address this patch.

...

>  include/linux/minmax.h | 14 ++++++++++++++

Does it really suit this header? I would expect something else.
Maybe include/linux/non-atomic/xchg.h, dunno.

Btw, have you looked if Ingo's gigantic series have done anything to cmpxchg.h
and related headers? Maybe some ideas can be taken from there?

-- 
With Best Regards,
Andy Shevchenko


