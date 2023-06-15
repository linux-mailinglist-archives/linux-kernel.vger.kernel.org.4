Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE43731C20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbjFOPDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjFOPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:03:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C912A297C;
        Thu, 15 Jun 2023 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686841412; x=1718377412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/ltr8yi9n+2m6Jm4+lWnQprQOnZ/BJEBoCQpXdXYMo=;
  b=XBQufKKNYlXhPEijj/q3bG4pnnAv7X8UiJg3vg5cOLKq3mVWfnzAXdr3
   M1B/TMO5ogaWlyFzve1LIb/24Y2rvEcXyKfrlJYFzI/Si0xu/P2j9Creg
   dC3otsiZo5I8dJWldurXnuERhhVljCSdWHIz26feODvO8mzIMngDbnw2U
   8gzzT/K2hRx42X5SjQA2MebGuOM+yYu9epyH0u1bmP5ywQaTnaL7pPmEe
   Ir2ECG5vW/pqjj5IlM40p0bN6Ab2s/xRtZxtz3sQfr3TgU5UW3KOcV6SH
   blOchg4GA3POWtNwqIz+OHxoFQPPhQhVSkdd6aSvGJFKl466Po/Corvx8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339282020"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339282020"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="836651850"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="836651850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2023 08:01:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9oTN-003y5I-0t;
        Thu, 15 Jun 2023 18:01:17 +0300
Date:   Thu, 15 Jun 2023 18:01:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] of/platform: Propagate firmware node by calling
 device_set_node()
Message-ID: <ZIsnvXztBQvtYw9b@smile.fi.intel.com>
References: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
 <ZIsnaE95qIJ2DVzK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIsnaE95qIJ2DVzK@smile.fi.intel.com>
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

On Thu, Jun 15, 2023 at 05:59:52PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 15, 2023 at 05:52:43PM +0300, Andy Shevchenko wrote:
> > Insulate of_device_alloc() and of_amba_device_create() from possible
> > changes to fwnode_handle implementation by using device_set_node()
> > instead of open-coding dev->dev.fwnode assignments.
> 
> Side note. When I preparing this change I have noticed a lot of
> 
> 	dev_set_name(... dev_name())

Plus

	dev_set_name(dev, ...)
	...
	dev_set_name(dev, ...)

on the same device will also give a memory leak.

> in the code which seems to me problematic in two ways:
> 1) (minor) the dev_set_name() may fail, no checks are there;
> 2) (major?) the above construction leaks memory.
> 
> Is it on purpose (esp. second point)? If no, can it be fixed?
> Note, I'm not familiar with OF platform code, so I would help
> reviewing the change, but that's it.

-- 
With Best Regards,
Andy Shevchenko


