Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD5260AE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiJXPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiJXPCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:02:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C58614080
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666618773; x=1698154773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wiyL2LwtApEGjq+jVyXmvOIij+KLZlgpbNyS0mpR3bQ=;
  b=L4dYwOlvc4TaCZFQ6Dlw3aQzX5vqxg1TEs+mBjQLOeuDXtQPOEMiiBHV
   aoLhi9wyhMpQSYdGrUgqhHN/oRmxxLe/OvSJtCyHFiTZALmhd3M7i3/46
   vhJLxlxkmmF+BBtnxKjqnytoZx+8JxAtZJUIwD0InZ2DPJM8H0VT2PtJG
   LaCcucB3VeNOqs3GO2qkBR2qSMEdfRP20tAveETPSLujs2+Es1FZC++gk
   buYwg3K6y7Lo4lpS3IY50erO9vDwkfhkpEFsX2bRZA7V4/WzwUInIZ/+B
   t1d4ddvIwsTQ04TKSnNSeuksSVytTki40fDh67HiwZ1DuQvWvKfq2SzWV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="294812443"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="294812443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 06:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609188617"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="609188617"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2022 06:22:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omxPn-001SFs-1y;
        Mon, 24 Oct 2022 16:22:51 +0300
Date:   Mon, 24 Oct 2022 16:22:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1aRq0stHSY3zDDM@smile.fi.intel.com>
References: <20221024111627.75183-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024111627.75183-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:16:27PM +0300, Sakari Ailus wrote:
> container_of() casts the original type to another which leads to the loss
> of the const qualifier if it is not specified in the caller-provided type.
> This easily leads to container_of() returning a non-const pointer to a
> const struct which the C compiler does not warn about.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/container_of.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 2f4944b791b81..591db643269aa 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -13,6 +13,7 @@
>   * @type:	the type of the container struct this is embedded in.
>   * @member:	the name of the member within the struct.
>   *
> + * WARNING: any const qualifier of @ptr is lost.
>   */
>  #define container_of(ptr, type, member) ({				\
>  	void *__mptr = (void *)(ptr);					\
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


