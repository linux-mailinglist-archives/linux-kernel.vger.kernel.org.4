Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACE6D76A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjDEIS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjDEIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:18:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135BD1993
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682706; x=1712218706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+gE3xKmjAzbiO9q0nRNCzHxbc8Y1m+1bnOBrQ0u16E=;
  b=OWdbU5WVTpb6XV/zyDK03/2H58LIqZEDUm/VNqlyxY9E+MoPuThaCMvx
   jPyuaZEvM81CB+p2ncg45rIL8ppfav+3Eo2rc2f5vsA7qFf1TJXhePlF2
   aFuGJ4DfynG+8r14RmqHm7ag6J2Vy10E3GIi12LCumqNrqrRQaQK8KKVw
   WFnHubsesvL+pEjiODakaB47dbj8M+AdzZG2SyyL1W0IrTNG6OpAhMrKD
   /wjlBksi0N42HEYhFRoYqULO4mt0uLcRfUKC+W2d1RRPhvkDWQ9Di1XSF
   Q3+2vYe8thuRnvzZVtp14MLS90PmZpT78/karbOG486jqoVfw/pHD6wqy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="322057024"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="322057024"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="860890438"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="860890438"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2023 01:18:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyLW-00CkOe-11;
        Wed, 05 Apr 2023 11:18:22 +0300
Date:   Wed, 5 Apr 2023 11:18:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 14/14] extcon: Use positive conditional in ternary
 operator
Message-ID: <ZC0uzt+8olV4qzEC@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-15-andriy.shevchenko@linux.intel.com>
 <6bb15158-829e-f032-dc10-110e831da8c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb15158-829e-f032-dc10-110e831da8c3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:38:41PM +0900, Chanwoo Choi wrote:
> On 23. 3. 22. 23:40, Andy Shevchenko wrote:
> > It's easier to parse by a human being the positive conditional.

...

> >  const char *extcon_get_edev_name(struct extcon_dev *edev)
> >  {
> > -	return !edev ? NULL : edev->name;
> > +	return edev ? edev->name : NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(extcon_get_edev_name);
> 
> It is not fix-up patch and I'm not sure that it is beneficial patch.
> I will not apply it.

It improves the cognitive perception of the code, but I'm fine with
no patch being applied.

-- 
With Best Regards,
Andy Shevchenko


