Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8745C009F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiIUPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIUPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:01:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1DEE03F;
        Wed, 21 Sep 2022 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663772462; x=1695308462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/rkfDswWDTfUnkPIQd70RxRVXiWpXkOh8LLLnbRgRUA=;
  b=C6FUQzPJGWkX4/e1RqAiVsQUhBatcA9eg7N3o4ox9VV/uMEhTAw6Nyrt
   P0k7Wevfws9CnwZrLlAEIaevQJv2CYAJ5gxNeVBsxTSzN8P3JXjLDqSNV
   m2xmeGM9Z43PewY59F6BHGfJQynoZkJaVEU5rATl5tJGXZqsrRCbeljt2
   FMlMMNmCLYJUM/dWwvWP859YOwJ6cigB+TdG9awrWa50MtHNo2MFRLshm
   KwpODCJKHeAR8J/mt6f80zQCawYWxMQc4KlOsLhxSp3VxacUXxqtj0LE3
   BzIJJMxT6+s8U7U5pJ1BQNY+uf/5HQaDqsbur5WFwboFYHG1IHu7dBcZn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283072737"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="283072737"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948184820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 08:00:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ob1Cm-005bHz-18;
        Wed, 21 Sep 2022 18:00:04 +0300
Date:   Wed, 21 Sep 2022 18:00:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lennert Buytenhek <buytenh@arista.com>
Subject: Re: [PATCH v3 1/1] serial: 8250: Toggle IER bits on only after irq
 has been set up
Message-ID: <Yysm9ALLsXk3oYRt@smile.fi.intel.com>
References: <20220919144057.12241-1-ilpo.jarvinen@linux.intel.com>
 <24ec3f1f-b39c-eeb1-d53-ed97e2ccdb4f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24ec3f1f-b39c-eeb1-d53-ed97e2ccdb4f@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:20:50PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 Sep 2022, Ilpo Järvinen wrote:

...

> > -	retval = up->ops->setup_irq(up);
> > -	if (retval)
> > -		goto out;
> > +	univ8250_setup_timer(up);

> Please scratch this patch. It seems to create a circular dependency issue
> with allmodconfig. I'll send v4 once the problem is sorted out.

In accordance with what you told me privately, I think you will need yet
another ops, i.e. ->setup_timer().

-- 
With Best Regards,
Andy Shevchenko


