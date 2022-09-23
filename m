Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2155E7DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiIWPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiIWPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:12:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D76E133CB5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663945960; x=1695481960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gT2lgKgu7tDuuy1LRq+WL2FgQyZaVQ0gLjs4MY/RrWM=;
  b=TUDEq4iY7/X+Xf19vD+xxXTZBZCpdbWIv1UzeZO2TCwyQhMeNKorRsPj
   HFHYsLzGO9te6p3zUNncRtyyLuUjlwqymsQqfBli6DRSomzDnDbGxIyQh
   WwkR791sOlBPedQM2jDH83Re2cZptA2f0eEVntcmGD1C5X0+MUP/Cj+sv
   yE8obfUZRGXmItn/qXwvXXsAFBo+7PjVTFETrLGfWymKmHi4jccMPH0o3
   ftCpEVobpTl9iCQ50ItScc05TvHRtTt8SaRsZVaRSbBWw3ghbN005pEJZ
   3wMzIje2gIdSqJl/WhtpPGWVpfrqlz9SCzi8xvwoHLhRjk47a+Gyhfyfe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="302060568"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="302060568"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="571404058"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2022 08:12:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obkM1-006VzX-1C;
        Fri, 23 Sep 2022 18:12:37 +0300
Date:   Fri, 23 Sep 2022 18:12:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <Yy3M5Urqiz8jnIYe@smile.fi.intel.com>
References: <20220923100621.3888015-1-Jason@zx2c4.com>
 <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
 <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
 <CAHmME9p+SKTHzniw=TsC=vnQsyCuBa08+LcK-CsFcjA58K+ifA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p+SKTHzniw=TsC=vnQsyCuBa08+LcK-CsFcjA58K+ifA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:48:48PM +0200, Jason A. Donenfeld wrote:
> On Fri, Sep 23, 2022 at 12:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:

...

> both for the old code and for the new code, the result of lo>hi is
> total nonsense:

Exactly and my point is to add at least compile-time check for constants.

-- 
With Best Regards,
Andy Shevchenko


