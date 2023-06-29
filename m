Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71FE7428A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF2OmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjF2OmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:42:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB66B1724
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688049721; x=1719585721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=49jKW1QMOhOfQCsdVQEzVWF88EaDVYoWdRGiLZ7wofY=;
  b=ZCbmHX3N+opqqUU+FR0IJMdiSJQmw+ChsifHbRc/VtGf9u2IjMPy1A10
   kJzepRorU+BwWhT/bFKroTL+MFPcT+bvD2FGDTPSKTZtYtgqXceaJuiG5
   QR/TWvatUG3O+5PiEPEi8+GfUtviTLLvGWME+36galfD5osxZTiomyvr2
   fcutsQGEEFZm8FM7b6F15LWQRd3Nbxw6go+seLgH/Fdkcij0JYN9Ihzy+
   fou6OAQFwEZ+juYARdcOXS5prI9dooaYE070hzW+5iEKVgZgrfx3MKYxF
   b9b67hkfAmjg5erK98fGAZzpBmcmOo7EsUa4UQ+m5C1p64XMDFbNsPc3a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="362161232"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362161232"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 07:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841465734"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="841465734"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2023 07:41:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEsqJ-000sht-0n;
        Thu, 29 Jun 2023 17:41:55 +0300
Date:   Thu, 29 Jun 2023 17:41:55 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Message-ID: <ZJ2YM96/jTi6E4Rk@smile.fi.intel.com>
References: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
 <6b241f45a61f40fe9b221696289fd658@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b241f45a61f40fe9b221696289fd658@AcuMS.aculab.com>
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

On Thu, Jun 29, 2023 at 02:32:13PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 28 June 2023 16:34

...

> >  		/* Strip line number; without filename it's not very helpful. */
> > -		strreplace(token, ':', '\0');
> > +		p[strchrnul(token, ':') - token] = '\0';
> 
> Isn't 'p' undefined here?

Yep, should be token. Not sure what I was thinking about...

-- 
With Best Regards,
Andy Shevchenko


