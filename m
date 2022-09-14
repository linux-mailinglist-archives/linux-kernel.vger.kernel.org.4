Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6828E5B851E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiINJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiINJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:35:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7122283;
        Wed, 14 Sep 2022 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663147973; x=1694683973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3COSI+5DkvURhmR3kwSxTX5q54q4f1aW8pTt8mxl1hY=;
  b=QbpF0XiVEpGt6wM31Gn6pf+mThe2GKABohY1BC8j0S+9MCgulV3uTGeb
   fNN75dMaFSMS+NIVCT2RyQaZIYlNYDHwJiamW5H4XjLsGAx+wDSLzjA5S
   yNS37dIIGE92d4auLSd7lURdcZlIc8Dd3p3fb2pyKvoYebc2KPUh1mrA0
   A+FAl/tl8C/2e4vvOrp0qiCyrvi4uYs62YOZD8EeTyBjMdWK9pqSVQK7u
   1JgO9GG+DgLNmSAoWfb1qxEGH0cT94Khkjqj5and9auhwu5s1BjW2jNjl
   soRNhTkOXlytZaTZHCwSFMH2rDkdxv+SwaxO2w+JU2a7AZJs8oCccM7HZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="384676471"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="384676471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 02:32:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720521087"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 02:32:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oYOlD-0028WF-2H;
        Wed, 14 Sep 2022 12:32:47 +0300
Date:   Wed, 14 Sep 2022 12:32:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <YyGfvzlCu9qgtgA0@smile.fi.intel.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
 <YxowTBIODMLjf1Ek@smile.fi.intel.com>
 <581a4a0b-8e0e-b7a2-f873-77ed74b54e96@amazon.com>
 <3b121ab4-dd64-68b3-ee89-8571b5d3651e@amazon.com>
 <YyC3hsNhbQGIlReU@smile.fi.intel.com>
 <bdb73546-f309-60dd-3c40-d749654228fe@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb73546-f309-60dd-3c40-d749654228fe@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:26:36AM +0300, Farber, Eliav wrote:
> On 9/13/2022 8:01 PM, Andy Shevchenko wrote:
> > On Tue, Sep 13, 2022 at 05:40:16PM +0300, Farber, Eliav wrote:
> > > On 9/13/2022 4:06 PM, Farber, Eliav wrote:

...

> > > It seems like debugfs_attr_write() calls simple_attr_write() and it uses
> > > kstrtoull(), which is why it fails when setting a negative value.
> > > This is the same also in v6.0-rc5.
> > > 
> > > debugfs_attr_read() on the other hand does show the correct value also
> > > when j is negative.
> > 
> > Which puzzles me since there is a few drivers that use %lld.
> > Yeah, changing it to
> > 
> >        ret = sscanf(attr->set_buf, attr->fmt, &val);
> >        if (ret != 1)
> >                ret = -EINVAL;
> > 
> > probably can fix that. Dunno if debugfs maintainer is okay with this.
> > 
> > P.S. This needs revisiting all format strings to see if there are no
> > additional
> > characters, otherwise that needs to be addressed first, if feasible.
> 
> I was thinking of making such a correction:
> 
> -       ret = kstrtoull(attr->set_buf, 0, &val);
> +       if (attr->set_buf[0] == '-')
> +               ret = kstrtoll(attr->set_buf, 0, &val);
> +       else
> +               ret = kstrtoull(attr->set_buf, 0, &val);
> 
> and when I tested the change it worked, but then I noticed this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/libfs.c?h=v6.0-rc5&id=488dac0c9237647e9b8f788b6a342595bfa40bda
> 
> According to this, it previously used simple_strtoll() which supports
> negative values, but was changed to use kstrtoull() to deliberately
> return '-EINVAL' if it gets a negative value.
> 
> So I’m not sure debugfs maintainers will be okay with a fix that
> basically reverts the commit I mentioned.
> Hence, what do you suggest to do with my commit?
> Is it ok to leave it as it is today?

Meanwhile asking is not a problem, at least we will know for sure.
And yes, leave it as is, but point to the thread where you asking
the clarification.

-- 
With Best Regards,
Andy Shevchenko


