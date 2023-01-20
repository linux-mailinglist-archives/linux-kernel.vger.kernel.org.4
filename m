Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2386753CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjATLtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjATLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:49:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4602BCE1B;
        Fri, 20 Jan 2023 03:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674215341; x=1705751341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRJcmngDNyEidEMz1acSip8OP7b9pBjE9syj19aPrF4=;
  b=oC2DYuFpnnMMIyn6rYPC8iH4JvB5JHdDIVGzaqJ8ypuxfGRZ96F3enci
   /T3iWwi+DMSdZGVUuPdHjjGTA25LhUhwSNN9lG5hTWtvBZWQMl5M1j4Hm
   2QI10qNojAs8YNRB3OIk3hTS68FsBhkmdTP8hPW+fm/jUKkUkkAp0IbNa
   TOfoFj0KgCbbTE/ChiaAEdoL5zgIB0sDoxA6Dfo0M/ce32Bcjkvc12iZQ
   pZ9lGwozBU3B8Tc2ZF3Som04X86f1YlEkMJzmDajIcqtXl4MZ9I3VxPQX
   x3ii9bZ0BbOdUIRA7UKu0XuHtG4Z+Uhlz4Qg4Ts8xDei6MUc/x/MuVUqD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325598659"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="325598659"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 03:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610458510"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="610458510"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2023 03:47:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIps7-00CB0b-0P;
        Fri, 20 Jan 2023 13:47:51 +0200
Date:   Fri, 20 Jan 2023 13:47:50 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/9] pktcdvd: replace sscanf() by kstrtoul()
Message-ID: <Y8p/Zh22evztnaEj@smile.fi.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-2-andriy.shevchenko@linux.intel.com>
 <4f4c89f2c0924f05a894a1457c63ee4c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4c89f2c0924f05a894a1457c63ee4c@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:40:12PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 19 January 2023 22:08

...

> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret)
> > +		return ret;

> These don't look directly equivalent.
> The sscanf() version silently ignores trailing characters.
> I think kstrtoint() will generate an error.

Yes, kstrtoint() is stricter than sscanf(), but I believe
that user space not so abusive. We may always return to
sscanf(), which I don't think would be good idea rather
than fixing the user space. But let's see...

> Have you actually checked that the caller allows for
> an error return.

_s_size_t somehow hints us about :-)

-- 
With Best Regards,
Andy Shevchenko


