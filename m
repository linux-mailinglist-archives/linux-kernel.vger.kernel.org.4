Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A062C12A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiKPOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKPOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:41:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F22D777;
        Wed, 16 Nov 2022 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668609693; x=1700145693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ycJs6ajpUg38/Rvys2BGxzFtcS8ZL6CaiA8Bd2XGwI0=;
  b=eFfWQYvKwoqoJzMaR/zLpxyn4d+/q6ITwdNIzFqOQCBdra4eZMhTjrIw
   aAWXnMcDw5XbDditog2I1k/l/16FWYBqavkxASqLJrpnn1XnmYlSTUpIc
   Hhy0Vs2NNX1TCON/U6YjF+O8AuDA7osF6sFdZM2YDXJIBXoQcr+sXZKKe
   y+p9zV0g8qVUjK7KRo+n33yotgj5OuLNovDuRygZ76A0dlVTdnZ1hRqwI
   h0NjHVXraOkmhusETOHM1KRbpoYXCEyVBjzHNAnZ+qg/RqQrm7tkl3mOE
   bF4KR+gUWC05Drl60Xetbj+mqPdqC6eWRl2UO3rZAzdFKFTF2oYHCuLpA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295922287"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295922287"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 06:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968446430"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968446430"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2022 06:41:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovJbU-00DALM-3C;
        Wed, 16 Nov 2022 16:41:28 +0200
Date:   Wed, 16 Nov 2022 16:41:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Message-ID: <Y3T2mN1inwsYZWLW@smile.fi.intel.com>
References: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:17:28PM +0200, Andy Shevchenko wrote:
> Some of the functions are using struct fwnode_handle, some struct device
> pointer. In the GPIO library the firmware node of the GPIO device is the
> same as GPIO node of the GPIO chip. Due to this fact we may use former
> to access properties everywhere in the code.

Citing myself from another thread to the topic:

Nevertheless, for of_gpiochip_add()/of_gpiochip_remove() and
of_mm_gpiochip_add_data() I still left use of fwnode, because it feels
the right thing to do: we are taking reference on the input data in
such cases.

-- 
With Best Regards,
Andy Shevchenko


