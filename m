Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD2650D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiLSOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiLSOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:42:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5EB1010;
        Mon, 19 Dec 2022 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460965; x=1702996965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=reY9Vdc4PwaQTWcMswFr78LzRbKGIIy2vQCPw5jIr1E=;
  b=LZflXVO/qdiRF+/6ep42pIa4O1+B7Qofe++cvfc6KGWxGjcTWVdts5RK
   hirxhcHEKNV0GkLFf0ale1MytRgSOdi4Mqn+QovBGSP9z2RUvY25VQYjj
   lza2hs+LcO4sizhIN+Vdecx5ZLZjWL/ey4A1ugt+0X+Qj8wYxJXBFNpC5
   tQwBy3y7rOTNRS6m8k/lamcdvAJrpA2Pvn0nYITD6lYriKaycCFq3aJjG
   NCWzXpCBtblvz6ISf2PnNCSRqCI3TujEgGT6X7r1ZoK+ZkzkyhudeIQww
   vMOrVLBiEwZPeScjpjcWwlp5rDWgSFwbCjEYovm1N70pURBUdN658UJ6l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="318048381"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="318048381"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="628318823"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628318823"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 06:42:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7HLl-00CKOZ-2B;
        Mon, 19 Dec 2022 16:42:41 +0200
Date:   Mon, 19 Dec 2022 16:42:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/8] pinctrl: Introduce struct pinfunction and
 PINCTRL_PINFUNCTION() macro
Message-ID: <Y6B4YZZW0GS/2kDV@smile.fi.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:42:33PM +0200, Andy Shevchenko wrote:
> There are many pin control drivers define their own data type for
> pin function representation which is the same or embed the same data
> as newly introduced one. Provide the data type and convenient macro
> for all pin control drivers.

The stats for the entire series:

drivers/pinctrl/intel/pinctrl-baytrail.c   | 10 +++++-----
drivers/pinctrl/intel/pinctrl-cherryview.c |  6 +++---
drivers/pinctrl/intel/pinctrl-intel.c      |  6 +++---
drivers/pinctrl/intel/pinctrl-intel.h      | 16 +++++-----------
drivers/pinctrl/intel/pinctrl-lynxpoint.c  |  8 ++++----
drivers/pinctrl/intel/pinctrl-merrifield.c |  6 +++---
drivers/pinctrl/intel/pinctrl-moorefield.c |  6 +++---
include/linux/pinctrl/pinctrl.h            | 20 ++++++++++++++++++++
8 files changed, 46 insertions(+), 32 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


