Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A097A61F1ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiKGLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiKGLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:36:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656CD40;
        Mon,  7 Nov 2022 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667820973; x=1699356973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=393q1xge/hpSfeR0+DM7tOgZJx1Cw8lFYQBTUBKQ/Ks=;
  b=iu4fnEQumwfI4ibfRsWpqMsawCGgjyYwrsd29lyn7h29zzGsY0oHQ1mX
   8a4zJNoHi2o09Vp03LOE2i2KAeCaBSv5l+3UMpx3teWuO538qleHw+IrV
   kQRGqO9hQYry4968DR0To7TjcTECxUqNvMF0j0AXhzTO5smIqdOn3MkBj
   Xir7U/avDQhQCdC1dd2+nJsf6dI6xkJT+zBbwTotojoYkQR8DtEsj7pDk
   BQbsET7yzC/xfnitpJ99yHOak/vINqY2J5h4Q88H9zYsk8J/LwS+Zi6/i
   X+Ihuf1rDtVQplqayWeOCke+g+ES6kGBFPezocstCVijSSpaZbbHbK3ec
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="372509727"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="372509727"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="778461123"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="778461123"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2022 03:36:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os0QD-008btW-2u;
        Mon, 07 Nov 2022 13:36:09 +0200
Date:   Mon, 7 Nov 2022 13:36:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>
Subject: Re: [PATCH 2/4] serial: 8250_lpss: Configure DMA also w/o DMA filter
Message-ID: <Y2jtqYCoaB5JQ5f9@smile.fi.intel.com>
References: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
 <20221107110708.58223-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107110708.58223-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:07:06PM +0200, Ilpo Järvinen wrote:
> If the platform doesn't use DMA device filter (as is the case with
> Elkhart Lake), whole lpss8250_dma_setup() setup is skipped. This
> results in skipping also *_maxburst setup which is undesirable.
> Refactor lpss8250_dma_setup() to configure DMA even if filter is not
> setup.

...


> +	if (!lpss->dma_param.dma_dev) {
> +		dma = port->dma;
> +		goto confonly;

Perhaps

		if (dma)
			goto out_configuration_only;

		return 0;

(note the label naming as well).

> +	}

...

> +confonly:

> +	if (dma) {

But you know that previous code has dma != NULL. See above.

> +		dma->rxconf.src_maxburst = lpss->dma_maxburst;
> +		dma->txconf.dst_maxburst = lpss->dma_maxburst;
> +	}

-- 
With Best Regards,
Andy Shevchenko


