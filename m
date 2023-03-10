Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406B6B4E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCJRXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjCJRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:23:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354811F2C5;
        Fri, 10 Mar 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678468956; x=1710004956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vv7reXo3ux1awlZTxFxFKNXDo2UCBmZAY4mMvIKmEv8=;
  b=DlFToTZXiCOALVaDLcZmcwXOUnRlFsoKykW3OQ8oyis3YTUyRPnq18Vi
   njFxlKAobIDWfVxtDUlLyHqDy2b7PoWVgEzPmxeHsg7W3pgGVp+H0vAKR
   hdvdT91knWdhQ0oys1shZqa6goB8N1K3yk3iJsW9Fa6A52pAf4KpJSjJj
   UUt7kdDlSnHRuXpPo2oxDCRN5vE0FcHjRv/6JYafQSfkfC2hMj+yj34/t
   zXG852kafd1bR1mdIyDLciQ4hreM0/JAIA/1+1Hf8ixIjkEXaBqBuqiFK
   rW6TLMzF/BdIKyy12HYlf6JS1f89EvRxyu9YwZqcM6rgfv7TjUhRHQgOw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334259026"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="334259026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="671151379"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="671151379"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2023 09:21:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pagR7-00131T-0J;
        Fri, 10 Mar 2023 19:21:45 +0200
Date:   Fri, 10 Mar 2023 19:21:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <ZAtnKLKEZXCw/Ezy@smile.fi.intel.com>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
 <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
 <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 07:06:32PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 10, 2023 at 12:35:09AM +0200, Laurent Pinchart wrote:
> > On Fri, Feb 10, 2023 at 12:12:05AM +0200, Andy Shevchenko wrote:
> > > Since we have a proper endianness converters for LE 24-bit data use them.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thank you for the reviews!
> 
> > I assume Sakari will pick both patches.
> 
> I also assume the same.

Sakari, do you have any comments?

-- 
With Best Regards,
Andy Shevchenko


