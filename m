Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3771A379
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjFAP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjFAP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:58:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876C1A4;
        Thu,  1 Jun 2023 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685635125; x=1717171125;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=OM1qnKgJzUzSe/UQYGTnWTZvVefRUIqaEANw5UkwEaI=;
  b=I5lsONaD24WFOk56kYwY6RfkBcIgpyWohoOUHssHiw/WW7zjlaPNd8bE
   zcP6t0KII7lThP4e/7Th8WQlcEuMdHvOO6r8nZ3y4w/3S2uiwHxoa1fdZ
   NeuSslJEN0OgzYG/NndIsi6li9yApc68N+xL4zjd32Vvpm1MjXg5/WYi5
   +Iih172IN3Rv6MlvBJKVUqjFwM2HwlVhGLl3uXT8QjL5yjANqzQXQ/DTc
   58femhI+xXSljt9dhN9IG8L8NW+xnsTjMAhb0wJroqSqhBL5iRE6ouWP0
   qJeGuwoF2rJVxYfJdmYwDfFS2XnZzuk/K2tJb8WQruJ0IjwK/BAhsg9ZO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358894777"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358894777"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777258676"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777258676"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2023 08:58:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q4kgp-000SFr-2y;
        Thu, 01 Jun 2023 18:58:15 +0300
Date:   Thu, 1 Jun 2023 18:58:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <ZHjAF6xg1fAaJhQV@smile.fi.intel.com>
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
 <YkRuXtTzd11R9IrY@smile.fi.intel.com>
 <Yo5GO5RkBC3PQLTg@shikoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5GO5RkBC3PQLTg@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 05:07:39PM +0200, Wolfram Sang wrote:
> On Wed, Mar 30, 2022 at 05:51:10PM +0300, Andy Shevchenko wrote:
> > On Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang wrote:
> > > This is a sloppy logic analyzer using GPIOs. It comes with a script to
> > > isolate a CPU for polling. While this is definitely not a production
> > > level analyzer, it can be a helpful first view when remote debugging.
> > > Read the documentation for details.
> > 
> > Good enough I think,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, Andy!
> 
> To GPIO maintainers: can we apply the "new-driver-rule" and still have
> it in 5.19? There can't be any regression and it has all comments
> addressed. Also, I am talking about this project at Kernel Recipes late
> next week and it would be great to say that it is finally merged :)

Year passed. Any news here?

-- 
With Best Regards,
Andy Shevchenko


