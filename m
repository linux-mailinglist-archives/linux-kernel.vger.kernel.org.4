Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E505B3DA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiIIREM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIIREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:04:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6B10C98D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662743040; x=1694279040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nipNB0i+x/zBCdq4Ynhzz+pJsK1m2sb1Tx6FZZqOI+8=;
  b=W5tb27/DA0+rA4MTYEzvghaeC3b3IXIOPCJT4rGjz8RhSR80d1cyW8Mv
   3ymor9eQWmaRwoyusWJkTrkaOg7DEQaQpzDCwi68pTlSzW5Me+3rmMlke
   pUi1SXJ+KLhrZwls4tHCyILOGyoGz/YSO0VNAOPSHBPo0h9pNctBPMu32
   ngigd+J58dWmeNdrkgcy3eV5pEJ1HJMP1T8bX/zSr5JD27EmlxldVj5Bc
   VA2xibG7JpX8I+nA3gXCe82aJUpgfsrz+rJdqBp+do3W0vGva/XMk1Wkv
   Xck4ubeaoRDb1XjTfYn4qsljEIflDNT7dwR0cgWakYO4hZRWIDw+3LUyQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277913721"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="277913721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 10:03:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704466338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 10:03:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWhPn-0004oh-0n;
        Fri, 09 Sep 2022 20:03:39 +0300
Date:   Fri, 9 Sep 2022 20:03:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] lib/find_bit: optimize find_next_bit() functions
Message-ID: <Yxtx674np/Dr3YNg@smile.fi.intel.com>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
 <20220827175807.4017673-4-yury.norov@gmail.com>
 <xhsmhfsh3b15v.mognet@vschneid.remote.csb>
 <YxjNeqLjGgRPIm+y@yury-laptop>
 <yt9dv8pwspkw.fsf@linux.ibm.com>
 <YxtR7tMhXwGEXmbO@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxtR7tMhXwGEXmbO@yury-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:47:10AM -0700, Yury Norov wrote:
> On Fri, Sep 09, 2022 at 02:24:31PM +0200, Sven Schnelle wrote:

...

> I removed the whole series and will resend it with an appropriate fixes
> at the weekend. Hopefully it will disappear in next-20220909 or 10.

Usually there is no Linux Next releases on weekends. So it will be
at best the 20220912 one.

-- 
With Best Regards,
Andy Shevchenko


