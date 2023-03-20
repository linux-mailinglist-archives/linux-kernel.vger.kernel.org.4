Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F16C11C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCTMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjCTMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:22:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616AC2884D;
        Mon, 20 Mar 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679314949; x=1710850949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8SAM708+qCwhV13504dEVrJbXJXUFcMQFWXkSQ7vwC8=;
  b=G7U9Y5as6HkEQS62ZHLMO6VM2G7KBnSuAnQqF6kssxIu3NtDO2GblkHX
   nUul8y3NSaIVa6Ew+ck0KgGPcaZ/UWUhabimuhQABjItWEKxy+uprSHPR
   Q5tT3oCkED38y4xQMCiHPXEHUQv6AZxUco92P4EykMPp83OxZLcoKYUJL
   VIpbjcdDwYpd6A5i1iIzZayS4v9dD130vTgrCihPWN1M8iJ7V7APvYCQR
   +S9+s4R8F5i61F51PN+X8zDDRADniHO+eCyWofomDdiAylMH0jCvRZWfK
   RV8mseSwtpuAwMOMsdUGokJRcQ4YVuHMiOWtBmzRT7x9oyimttNe36b+o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="318296349"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="318296349"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 05:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="855267150"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="855267150"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Mar 2023 05:22:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peEWv-006GMp-1H;
        Mon, 20 Mar 2023 14:22:25 +0200
Date:   Mon, 20 Mar 2023 14:22:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] bitfield: Introduce the FIELD_MODIFY() macro
Message-ID: <ZBhQAdYVBUhr1kzX@smile.fi.intel.com>
References: <cover.1679149542.git.william.gray@linaro.org>
 <1c1492558c1a72b64bb26f7a44c4e69fff0e6b44.1679149543.git.william.gray@linaro.org>
 <7cd746c7b585c5086cfbd9db22414a060356cdd8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd746c7b585c5086cfbd9db22414a060356cdd8.camel@sipsolutions.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:50:35AM +0100, Johannes Berg wrote:
> On Sat, 2023-03-18 at 14:59 +0000, William Breathitt Gray wrote:
> > It is a common code pattern to modify a bitfield by masking the field
> > and performing a bitwise OR with the respective FIELD_PREP. Wrap such a
> > task into a macro by introducing FIELD_MODIFY() which modifies the field
> > specified by a mask from a bitfield by putting a val in the field.
> 
> So I have no objection to adding this and you using FIELD_* macros, but
> just wanted to say that personally I've come to prefer the typed
> versions declared later in the fiel, and there we have
> <type>_replace_bits() already.
> 
> Hmm. And now that I mentioned that, maybe that means FIELD_REPLACE()
> would be nicer as a name?

+1 here with the similar thoughts.

One thing I hate about macros like above mentioned is that Elixir or similar
code browsing tools can't find. In net there are specific #if 0 ... #endif
sections for mitigating that.

Shouldn't we add the similar into bitfield.h?

-- 
With Best Regards,
Andy Shevchenko


