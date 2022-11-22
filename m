Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96A363397E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiKVKPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiKVKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:14:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2C4091A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669112093; x=1700648093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=86po1vYlzKPga3udNVhclmk5bZovkKD7bFTPvYi7fK8=;
  b=bRBqexpfgYDpZgjaqUKLtjCR1saG292xTMxanHxdhrCwH9tCk0d+/59o
   DzWmwGfwGOL0ZfZHxRcH8O+94nb4zVjkQ5+eXNbRZ1fkiQJbyazQ/pTkQ
   QKbWzZQOqL9nvO8PXiKQDuRqW27/nT51ypxFFmpSWOgNnVc8gC/FPsw3X
   O5XbANp0P0gFKdn07XHVfVGXuAc2GCbwCdIhEp/VYhdo6TEk2JKaDClpQ
   SvC7FfODc5VJJ30qUcYLAIx7hV0cIB25tU97b+FCojpVfy4lhH+PUzTLm
   HD4YCfZi8C+totDBR8WV++KdyXj/m57eKKO/oEZ4iMheb4ULtYofpUDs+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311411119"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="311411119"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="710144283"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="710144283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2022 02:14:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxQIf-00Fhtm-2Z;
        Tue, 22 Nov 2022 12:14:45 +0200
Date:   Tue, 22 Nov 2022 12:14:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Message-ID: <Y3yhFWQ7NHMArO74@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
 <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a1b539-bd69-0227-ea93-b90f2e3ef2cd@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:49:04AM +0000, Rahul Tanwar wrote:
> On 22/11/2022 5:18 pm, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 03:39:06PM +0800, Rahul Tanwar wrote:
> > 
> >> Rahul Tanwar (4):
> >>    x86/of: Convert Intel's APIC bindings to YAML schema
> >>    x86/of: Introduce new optional bool property for lapic
> > 
> > You need properly prefix the first two patches. I guess it's something like
> > "dt-bindings: x86: ioapic:".
> > 
> 
> Yes, i just checked the git log of devicetree.c and used same prefixes 
> here. Thanks for correcting it. I will update it.

Moreover the Cc list in those patches is quite wrong.

I recommend to utilize my "smart" script [1] for sending series.
(You may take an idea from it how to prepare the Cc list close to proper one)

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


