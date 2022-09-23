Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1D5E787C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiIWKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiIWKgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:36:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D1121645
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663929361; x=1695465361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pM7MFRXJ5rGIPO25x7EB4cIserOlmJI5zWVPWw4O/7I=;
  b=CGFpWL1Xbe4vTSonc3/3zkZRRdKF/W/TB9/u00d7hTXX3X8rXgVOks3j
   URmyVOqLG+tAhQrY9ume99Ag/pO6Jn3PXkqFKlP31ofJ1yL97tL/e6aou
   /LWKjPhPdJ86TNRX5k8tT+IBdRcnUU21Ye4idv0pAk9/7HByr2P+7ISlk
   8WhQ1+SG+p8Lm6Unf0se7AN7Pam0DG0lroPKcHc8yHA9ZreaRPgP3KRci
   XAXhMTfqMro+8sO1Gtr44dMj1Vki2l+KkPBI8DY7vwY4KMKhZevYm7gbC
   BtAlQlHY9s5l4cqLBsMpb3N/pizPpsoy6Q29XAGsrySiUSHhRyT3dthog
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301446786"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301446786"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865253327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2022 03:35:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obg2I-006QH2-0U;
        Fri, 23 Sep 2022 13:35:58 +0300
Date:   Fri, 23 Sep 2022 13:35:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
References: <20220923100621.3888015-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923100621.3888015-1-Jason@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:06:21PM +0200, Jason A. Donenfeld wrote:
> Currently the clamp algorithm does:
> 
> 	if (val > hi)
> 		val = hi;
> 	if (val < lo)
> 		val = lo;
> 
> But since hi > lo by definition, this can be made more efficient with:

It's strongly speaking, but we have to proof that, right?
So, while I haven't checked the code, this change should also
include (does it?) the corresponding compile-time checks (for
constant arguments) in similar way how it's done for GENMASK().

Otherwise I have no objections.

> 	if (val > hi)
> 		val = hi;
> 	else if (val < lo)
> 		val = lo;
> 
> So fix up the clamp and clamp_t functions to do this, adding the same
> argument checking as for min and min_t.

-- 
With Best Regards,
Andy Shevchenko


