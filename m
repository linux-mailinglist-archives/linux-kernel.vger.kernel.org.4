Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8D6BB5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjCOORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjCOOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:16:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713907EE4;
        Wed, 15 Mar 2023 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678889803; x=1710425803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sc6A1XPECWV3FmsUzkcJd9zULJzFyjMi+YEdJi6Dxuw=;
  b=ijkja4THnRQGp0kXQq6DhB7PjyWSPyrnDykBy3mFbgodhqqnUB6PHSDH
   bxGbCqNk+QA460yqcuJ30jm7E9EQ/NWx5NqtFHH4xIvHeZvtjW8bVGwj4
   PzbnwRM1j/QZJiZHxQ8y9sSsjCcVx4pCrtAiPoNLPLZ2z2nxJuC9BV2Fv
   oWXPRcd/0ZK0X+GH3uAbMXLs7DZaKCBz4gjZ49YP4OZd/xdoknyj4Tscj
   ihLIC+DH52WQyCVjya8tCykVuUwxUm6eXxvR+r5KG3PWbCnjEDfiFXA81
   RgBcIHT/1De8CUm4oIKQERknGu0r/kAqLI2kKIMEdmsJl4qekw2O6ke7r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="365395642"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365395642"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672762528"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672762528"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 07:14:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pcRtU-003rWB-19;
        Wed, 15 Mar 2023 16:14:20 +0200
Date:   Wed, 15 Mar 2023 16:14:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        maxime@cerno.tech, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZBHSvBCOmJWAxn0n@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei>
 <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
 <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
 <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
 <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
 <ZBHSa3CU7zGI7qCX@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHSa3CU7zGI7qCX@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:12:59PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 15, 2023 at 12:51:26PM +0200, Matti Vaittinen wrote:

...

> My opinion on that, you should not depend on the others work if they are slow.
> It might take ages for them to finish and upstream that. Why should you wait?
> 
> OTOH you may inform them with your patches that may have a chance to land before
> theirs. It might motivate them to speed up their work and coordinate the outcome
> that all stakeholders will be happy.
> 
> That said, I would choose option 4), i.e. provide a series where you decouple
> thingy from DRM and Cc to Stephen with a cover letter note that explains why
> you chosen this way and what alternatives you are open to.

Ah, and before doing that you actually may ask Stephen on his roadmap about
that. If no answer for a week or so, go with option 4.

-- 
With Best Regards,
Andy Shevchenko


