Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152EB65752B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiL1KKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiL1KJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:09:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA893A450;
        Wed, 28 Dec 2022 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672222137; x=1703758137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlGFk52c6fwenbIHOMMEAFBo447s9Ad2k4HOo/x70Is=;
  b=LkXR1XlqSJyd+xXqoGtRT3Pq23jNp7Hlc7t2IcXC//vzyCZkVVbqOdya
   Ef9gIqG3t5PRwK2O6GimOhqRjAIqfQm+ACD0X5rBcePg+p/HFUZHNPc57
   KMp6lbQI0LUQ6mrOfGin8mz1k6mEcuwCa6v7kH4pIWaEDzC1zCrcAYJNE
   9BXh6j7uPR1QYLyeNnI//D2gzCNpbja6dH74QKnJ7kgol3zutSEF2TAYp
   S6x7DuRC8QBUDUgomMkXTUyyjHZwc9+C3ZtnvXtr/s5HgVftEP5+wQsF9
   I7ONnigHP9eNuFkf9ip4vjx7RpIFAc8jlV7fMgV7IBXzM0cCt3ZTONISb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322079897"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322079897"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 02:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="827362693"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="827362693"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2022 02:08:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pATMj-000Wjp-24;
        Wed, 28 Dec 2022 12:08:53 +0200
Date:   Wed, 28 Dec 2022 12:08:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: Use get_unaligned_beXX()
Message-ID: <Y6wVtZLpNzez4KlI@smile.fi.intel.com>
References: <20221214120202.4658-1-andriy.shevchenko@linux.intel.com>
 <20221223151750.6cb55f12@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223151750.6cb55f12@jic23-huawei>
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

On Fri, Dec 23, 2022 at 03:17:50PM +0000, Jonathan Cameron wrote:
> On Wed, 14 Dec 2022 14:02:01 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > This makes the driver code slightly easier to read.
> > While at it, use GENMASK() as well.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Hi Andy,
> 
> Patch looks good, but it got me thinking.  Why not just flip this driver
> over to using spi_write_then_read().  Would let us drop the DMA safety
> protections and simplify the code + use a __be16 as the read buffer
> and this would then be the slightly nicer aligned form.
> 
> Worth doing whilst you are here?

OK, I will consider when I have time for this.

-- 
With Best Regards,
Andy Shevchenko


