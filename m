Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC654731EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbjFOROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbjFORN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:13:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB639271E;
        Thu, 15 Jun 2023 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686849234; x=1718385234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1pnqf2dI79kNwwsCa+qiYs+3l/PZJLIYcgGI5ZcsQIs=;
  b=XxJiR8+YnWAP2khz4IkuPPvjKoUx9jwCrHLQqYn4Mc0Nwrj/idaga0x/
   Gu+sV7ln5Z8MDIPUKdi2UfALxSZT9+2+MfcZFnJ4T8OMMW3LDy1bvFQdJ
   +gZmjM7/Xnox4s/nk6fDGe0baingVOx8NTVNe6/a+Dk2+Wuz/Gbc2916r
   I+qCsgAuTUKxTNduchDRkoRQPDQKaDxLRhKoay1jIcaL2gFZ+taQjlXT+
   /GxVMZJ+dzYm8HBrH5Xzpa1JvRd9MnkEaweuG8H6vUj+UG/A0rsFfkR/L
   WvTPICPZPHuN0LN6Vlg77+rUu8A66KWiRlazm8YqnymKuKpIUnbXQv2i7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387525336"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387525336"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:13:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715691966"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715691966"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 10:13:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9qXg-003zld-02;
        Thu, 15 Jun 2023 20:13:52 +0300
Date:   Thu, 15 Jun 2023 20:13:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] of/platform: Propagate firmware node by calling
 device_set_node()
Message-ID: <ZItGzw5HO/GFoRAD@smile.fi.intel.com>
References: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
 <ZIsnaE95qIJ2DVzK@smile.fi.intel.com>
 <ZIsnvXztBQvtYw9b@smile.fi.intel.com>
 <ZIsoWBxb8aGdJ4ja@smile.fi.intel.com>
 <20230615164452.GA1166619-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615164452.GA1166619-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:44:52AM -0600, Rob Herring wrote:
> On Thu, Jun 15, 2023 at 06:03:52PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 15, 2023 at 06:01:17PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 15, 2023 at 05:59:52PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jun 15, 2023 at 05:52:43PM +0300, Andy Shevchenko wrote:

...

> > > > in the code which seems to me problematic in two ways:
> > > > 1) (minor) the dev_set_name() may fail, no checks are there;
> 
> Is there anything besides a memory alloc failure? What will print a
> message already. Wouldn't we fail a bit later on when adding the
> device anyways?

I don't see how we fail. Any pointers?

> In a rough count, 92 out of 500 cases check the return of
> dev_set_name().

Yeah, because it was new finding about that. Some static analyzers complain
nowadays about this.

-- 
With Best Regards,
Andy Shevchenko


