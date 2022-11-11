Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B464625A38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiKKMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiKKMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:06:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4145FAD;
        Fri, 11 Nov 2022 04:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668168357; x=1699704357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pI88ZoSjx1hCjSkxKLobYq2bfOrmMtrqowkx00L8oYs=;
  b=hr70QJR2oJIAVyCWPXjGgeMRIM/ZRw1EZNIh3aMvR8/E4yvBOjl7Cpz7
   1liqpYFRFiVM7wOEoLpA6/rosOlarewh6azRhImh/GF5SVhfHwf7KC0wz
   U+YshKiNwgIi+G2tkPfO/5/x3prYxQJpykLCDHcWfpv2c45bg5eqyzEbG
   OiFR8DtCFD3ShBaDOdgrPhRrp5AcJeVqmX1MwhZECDMryWEY0mU4fmWVa
   tiToD2vkzIsFuYRNNE4rOC2Zg6uOfGY9z7oWlCHdCS4iC5nwDGPoGUZuj
   7SPL3McJHEiD0rKeyaqkEpF/dLg1o14r9Xlxn5RZkMuOpe92CO5XnVduf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309211181"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309211181"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780159429"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="780159429"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2022 04:05:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otSmv-00AgYO-1T;
        Fri, 11 Nov 2022 14:05:37 +0200
Date:   Fri, 11 Nov 2022 14:05:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in
 struct nvm_data
Message-ID: <Y246keIq4a541ooO@smile.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <YwTf22gkWxeyNKlR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwTf22gkWxeyNKlR@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:10:35PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 26, 2022 at 03:05:49PM +0300, Andy Shevchenko wrote:
> > The struct i2c_client pointer is used only to get driver data,
> > associated with a struct device or print messages on behalf.
> > Moreover, the very same pointer to a struct device is already
> > assigned by a regmap and can be retrieved from there.
> > No need to keep a duplicative pointer.
> 
> Thanks, Bungbu, for the review. Can it be now applied?

Don't see this being applied or commented why not...

Mauro? Or who is taking care of this driver nowadays?

-- 
With Best Regards,
Andy Shevchenko


