Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610717315DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbjFOK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbjFOK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:58:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4451FE4;
        Thu, 15 Jun 2023 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686826701; x=1718362701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlAk0+2pPNPfP2f5gUvJB/uBWEtPFah4b/xBlSuSeI0=;
  b=J1gJiOkI0kJMMU2izJkYDAp7jbyXM9rC5uLSRnQeoUzf13V6iZyuzE19
   A7qLslqLS159FiJyk7DExHjXX3F68CUaLMqPtY4UMmlau+s8l+Pop0dax
   B+v4z/zr0iKzhF0xT0aaq9KXemUg2106Fto4uwD2zjZf0/ylIUAJwSpAH
   2lAtEMSCvYsCwleVodhENHHcPnrxMYohskjcpwIzHj4jnuPiECyk+z93u
   69PW9aHqB0tgE+/rMhMolo3nWZx+5870G9a/evDWcN/7dPHG++f7/3CWz
   DSL8WJ5l9kYbQKKweSYQ5TN5qWUANQXcaUe3LDzYQGJe21Bg6gB6yjiDT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361358839"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="361358839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 03:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="825221195"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="825221195"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 03:58:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9kgD-003vGx-0C;
        Thu, 15 Jun 2023 13:58:17 +0300
Date:   Thu, 15 Jun 2023 13:58:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Message-ID: <ZIruyH5hpyboGwLU@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
 <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
 <20230613212651c8770218@mail.local>
 <ZImvjj34YILrNJU5@smile.fi.intel.com>
 <20230614135036a3e049c4@mail.local>
 <ZInZMEZBZ8Dm2jem@smile.fi.intel.com>
 <bd17c1a4-6102-3d93-5494-89fdb0a346e5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd17c1a4-6102-3d93-5494-89fdb0a346e5@rasmusvillemoes.dk>
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

On Thu, Jun 15, 2023 at 12:53:24PM +0200, Rasmus Villemoes wrote:
> On 14/06/2023 17.13, Andy Shevchenko wrote:
> > When reading such a code the following questions are arisen:
> > 1) Can the positive return value be the case?
> > 2) If so, what is the meaning of a such?
> > 3) Why do we not care about it?
> > 
> > All this can simply gone if we use
> > 
> > 	ret = foo(...);
> > 	if (ret)
> > 		return ret;
> > 
> > As it's clear that whatever is non-zero we accept as something to be promoted
> > to the upper layer. I hope this explains my position.
> 
> But we're in a context (in this case an ->ioctl method) where _our_
> caller expects 0/-ESOMETHING, so returning something positive would be a
> bug - i.e., either way of spelling that if(), the reader must know that
> foo() also has those 0/-ESOMETHING semantics.

I totally understand this. But then it's either problem of regmap API
documentation or API itself. I.o.w. not _your_ problem.

> I honestly didn't think much about it, but looking at the existing code
> and the stuff I add, all other places actually do 'if (ret)', so I've
> updated this site for consistency.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


