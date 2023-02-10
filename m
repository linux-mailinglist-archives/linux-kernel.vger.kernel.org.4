Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFC692410
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjBJRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjBJRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:09:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA461D06;
        Fri, 10 Feb 2023 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676048996; x=1707584996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4df6tkPvZnOhswuUyouIoq1fOXHb7p++8B0BxaCA4E=;
  b=S8BiDeNgg35YlnNtpQlsZqJJSXBKHrpi1gIb5ALGTmKrEmOVUIvLtGVG
   tfjRcyKebLfYsixNzSg20AUiyGeVoijFxF5QuzVLyMMB0BiALsCOx+Xrx
   q99AFu8Bfd7Boyx7F5hBigxO8PUE16SwRtgPaqxA0FeL9Vk3zi65fA4QT
   wpnOISVZHBmtHgj5DUupTYjnwe1GTJ9q2y3kTC5d8dxZEJYWr3UiLg46r
   7TByWlvE7YZ/FNovJS7q5ox8HrW/tMAugU7qjHRTZLHlAiIaJzYcga5xp
   5GDx8hLT0YxeT69VpoFR57oUAFWOwoQfTgpA0I09LRXrB9Ksh7xYQft3T
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328159084"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328159084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="698466916"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="698466916"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 10 Feb 2023 09:06:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pQWr2-0058Sd-1O;
        Fri, 10 Feb 2023 19:06:32 +0200
Date:   Fri, 10 Feb 2023 19:06:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
 <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:35:09AM +0200, Laurent Pinchart wrote:
> On Fri, Feb 10, 2023 at 12:12:05AM +0200, Andy Shevchenko wrote:
> > Since we have a proper endianness converters for LE 24-bit data use them.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thank you for the reviews!

> I assume Sakari will pick both patches.

I also assume the same.

-- 
With Best Regards,
Andy Shevchenko


