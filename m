Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D034625E66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKKPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiKKPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:32:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D2C623A9;
        Fri, 11 Nov 2022 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668180761; x=1699716761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLnnIwLCsZfQrqPlR5NOxylzjIbXc5xOOTELx1TfDW4=;
  b=OWtg1HfXD2TyzflDxh/pwOHn3pRl4QDz53oXnMbWVmw0tWaaSlb13MoU
   OWdFR5eBen/+qLQarMzkJL2BumcChETunqteeex3OzVJB3W+4LciLHg1z
   Y1GXCgz9Ywo1I/nq4JG5gz+l3hCTRsFUmHzCbKs/hOGbOCl6OAOYwQ0U4
   RTIFjKHh95//4fqVnf5kipBRN9fMXK8wV1qYOfHDHeOfLmPHT2c+eGQdv
   1Aur3HnPGN8kr5TruwCuFy4VgeZC2Rp11JwpZ0J16rdwGVjxOjiP0mufY
   UmHXeabbjzcWlEiS7iQFXYcg168QzlY6aqE0IEeBknvWgxCVyjvagMD4d
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="299129767"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="299129767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="615516666"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="615516666"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2022 07:30:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otVys-00Alnp-0F;
        Fri, 11 Nov 2022 17:30:10 +0200
Date:   Fri, 11 Nov 2022 17:30:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 2/8] media: ov2740: Replace voodoo coding with
 understandle flow
Message-ID: <Y25qgYsQNEGVTKeS@smile.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-2-andriy.shevchenko@linux.intel.com>
 <Y25j/rJWSYI1eT1E@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y25j/rJWSYI1eT1E@valkosipuli.retiisi.eu>
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

On Fri, Nov 11, 2022 at 05:02:22PM +0200, Sakari Ailus wrote:
> Hi Andy,
> 
> On Tue, Jul 26, 2022 at 03:05:50PM +0300, Andy Shevchenko wrote:
> > Besides not being understandable at the first glance, the code
> > might provoke a compiler or a static analyser tool to warn about
> > out-of-bound access (when len == 0).
> 
> I've never seen one.
> 
> However the same pattern is repeatedly used by many, many drivers and
> addressing just one doesn't make much sense.
> 
> The proper way to fix this would be to have a set of common CCI (Camera
> Control Interface) functions that all drivers could use, and then switch
> the drivers to use them.
> 
> This isn't currently a great fit for e.g. regmap but perhaps something
> light on top of regmap-i2c could do the trick?

So, then we can skip this one, right?

> The rest of the set seems good to me.

Thank you for the review, can you apply them, or should I send a v2 with
dropped first patch?

-- 
With Best Regards,
Andy Shevchenko


