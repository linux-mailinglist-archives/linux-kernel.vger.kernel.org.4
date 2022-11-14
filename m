Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D0062791A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiKNJhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKNJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:37:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8CCE3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668418669; x=1699954669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1YU916NuN6K+Gk0NikvjfvuiIt86iQy2vpKjRNomKs=;
  b=XhVIDotZ0UXEnIpLXBfqbcNfmuuDARa6e4LOmUqB6VR0JcgDt8Ull+ya
   pepKByECtb9NB+Z8keIlNOLJVxQIcg4LBezpHEd2h32E3E9BLFF+QG1jr
   qnkWQnhA7+EGe/8yn/hB7MOCiyo1RvuWx+1kSWvXAc3qAQAhomvhc2ecq
   G0oypbs1vgwpesIGpbvNelJHul4j1y4fzZNlS7OdI8KkEhUyBzzsjNurU
   45cYPQfNBehWPqD+asj/2W8qY7IEriv5gkxXfFggH3CkcLBeAGJj3P4pk
   /Qigp9PUhfwJZULFJppzrB5F2F+C+zADx4lB3FTlagRQKYzyeZlrOGmHq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="299444102"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="299444102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="589300567"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="589300567"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2022 01:37:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouVuS-00C6Fq-3C;
        Mon, 14 Nov 2022 11:37:44 +0200
Date:   Mon, 14 Nov 2022 11:37:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] mfd: vexpress-sysreg: Fix resource compound
 literal assignments
Message-ID: <Y3IMaHg3Nbp1R5Zi@smile.fi.intel.com>
References: <20221113191027.2327-1-andriy.shevchenko@linux.intel.com>
 <Y3IECjcu4IjHySnA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3IECjcu4IjHySnA@kroah.com>
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

On Mon, Nov 14, 2022 at 10:02:02AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 13, 2022 at 09:10:27PM +0200, Andy Shevchenko wrote:
> > Since DEFINE_RES_*() macros were converted to provide a compound literal
> > the user doesn't need to repeat it. Moreover, it may not be compiled.
> > 
> > Fixes: 9c973ce7f9cf ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> 
> Wrong git id, I have no idea where that came from :(

Pfhh... I think it's my local one since it was never in Linux Next and
I forgot to specify your branch explicitly.

> I'll go fix this up...

Thank you!

-- 
With Best Regards,
Andy Shevchenko


