Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04133727D54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjFHK4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjFHK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:56:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949B1BFF;
        Thu,  8 Jun 2023 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686221790; x=1717757790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QY68UhVojg/n24EJbyIWtO91dnT6UOWGdHx4mttA7ks=;
  b=QvasMTqVt8t5ALQ7l+UUwXFAzpkRJ6fekhtb9z1k3iaq3mQIkYQhZucU
   rDH7b3dFHqBFQS4+tVEKJJVbfQp3nVTEVC27xvFXCzydVYnY0u61a0SB6
   sSr5qorQmyw4FjOLwmUW4lTllQ/T1Yuc2ywBumi3oXj0zHATSxnXn8Rgn
   8P8O1VH2eVVYcou6lzOuoqO6eUzSOU/6WOAVTwXPFOfpK8J7lCJ1VbMKh
   4c/uBO6t2XdK6d5ZhF445MNjXTm56zxqsZgsq1hUUNwSpWYNnhbBOgB5p
   FIIZb+7Xus3HaCZbPTj+l3Ny+psQZibS0PersBpVnOaGdChH0Z7jRkJ4b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443643429"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="443643429"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 03:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="660340981"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="660340981"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2023 03:56:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4279834F; Thu,  8 Jun 2023 13:56:34 +0300 (EEST)
Date:   Thu, 8 Jun 2023 13:56:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Jadav, Raag" <raag.jadav@intel.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v1 1/4] pinctrl: intel: optimize set_mux hook
Message-ID: <20230608105634.GL45886@black.fi.intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
 <20230608070017.28072-2-raag.jadav@intel.com>
 <20230608080821.GF45886@black.fi.intel.com>
 <DM6PR11MB2779B6863DA4A390EC68F4978C50A@DM6PR11MB2779.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2779B6863DA4A390EC68F4978C50A@DM6PR11MB2779.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:20:58AM +0000, Jadav, Raag wrote:
> > On Thu, Jun 08, 2023 at 12:30:14PM +0530, Raag Jadav wrote:
> > > Utilize a temporary variable for common shift operation inside
> > > ->set_mux() hook and save a few bytes.
> > >
> > > add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-3 (-3)
> > > Function                                     old     new   delta
> > > intel_pinmux_set_mux                         245     242      -3
> > > Total: Before=10472, After=10469, chg -0.03%
> > 
> > Shouldn't the compiler be able to optimize this if you ask with the -Ox
> > options?
> 
> Forgot to add. This is with default -O2.
> Is it a good idea to mention it?

Yes, I think it is.
