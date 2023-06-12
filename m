Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247272D186
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjFLVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbjFLVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:06:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B149DC;
        Mon, 12 Jun 2023 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686603755; x=1718139755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rc4UkzGMrkZyftSTQgNQrNRtiz12rv6dYHUejL8Od28=;
  b=mebkm77wufh/Zb+5B9XFD9dvBFwsCG3vOwoSgFMiUC5X4jdT7+wqz6tc
   z8eY6fmULPVpLeVqCr4T+cNTmtuvfv/Rz2U5YJGIUxiUBfjJt8IExd1/l
   eesbXdJM8hhFUYs2Rb0oZltKhX4vqIuGetr049TfYT5d/5pmXuTYkEFe3
   d08xsn6ng1hDKPVco0gs1Kfj3euXDgVS39ne/n5NvQTzSzrjUhyxY/+9X
   KMJF25ubjTxMa1dOTKixOJLY+m0ag70IOLeiD3Wi3BC+oX10gspxjFWXn
   xGzIoatWKCGr3N1w360CWxLsLcTzCGnze7zgG5J9BMe+uSNZ0FHq7C0Jy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="357046886"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="357046886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661740740"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="661740740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 14:02:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1q8ogD-003Iya-1y;
        Tue, 13 Jun 2023 00:02:25 +0300
Date:   Tue, 13 Jun 2023 00:02:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Message-ID: <ZIeH4e8icEEAD3Gc@smile.fi.intel.com>
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
 <20230612175205.eom2guabgfmnzrce@pali>
 <ZIeFjkAAiS+TMa8g@smile.fi.intel.com>
 <20230612205839.wxo2h2ahqcdo73rc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612205839.wxo2h2ahqcdo73rc@pali>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:58:39PM +0200, Pali Rohár wrote:
> On Monday 12 June 2023 23:52:30 Andy Shevchenko wrote:
> > On Mon, Jun 12, 2023 at 07:52:05PM +0200, Pali Rohár wrote:
> > > On Monday 12 June 2023 12:02:50 Michal Wilczynski wrote:

...

> > > Hello! I'm looking at rbtn_add() function and there is also code:
> > > 
> > > 	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> > > 	if (!rbtn_data)
> > > 		return -ENOMEM;
> > > 
> > > which is called after rbtn_acquire(). So it looks like when kzalloc
> > > fails then there is another leak...
> > 
> > Side note: In that case we would need a devm wrapper on acquire call.
> 
> Does it makes sense to invest time and more resources for these fixes?
> Driver is not used on new Dell machines, so I would not expect new
> users (instead less users, if they start upgrading HW to new Dell
> machines).
> 
> Simple fix for this issue: Just move devm_kzalloc() call before
> rbtn_acquire(true). And call cleanup rbtn_acquire(false) exactly like
> Michal did in this patch.
> 
> I think that this should be enough, should cover all failure paths and
> does not require to introduce new code or new design, which should be
> properly tested for no regression.
> 
> What do you think?

Sounds like a good alternative! Thank you for the review.

-- 
With Best Regards,
Andy Shevchenko


