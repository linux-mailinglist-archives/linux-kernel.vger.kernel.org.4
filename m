Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E572C9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjFLPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjFLPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:19:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC88F;
        Mon, 12 Jun 2023 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686583165; x=1718119165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1sgzFhQxmvhrN3umsru5+GWkNd3ZRhO9C6+hJ6QEhj4=;
  b=jUy7Xb2SRxVS523yNaX7xsIVs5llSZiWEmVrVMdXxCJ/xjbHuJHdeiiC
   MS+WUOpUUxcgOjcSsdzuYSfVN4bm3NMiha9iAHW9AyC1EPnzu2mqt7JOC
   2rbo+vHMTD9F5eYXsZ5EZLMAv/ps1D7zP/IU9rDOM/wHi6sS4EQL9OQq5
   U4jkJ8Zicf2Dwb4G01z6tv0Xl2m7w7RAxM0sjWE7JgXH5T2+yExSPVBM0
   AwI3fNINRvOJAbRXUa5x0GYHNfoZ4BBsTjsmWBY8xMcViWpvaRsLJ4rVA
   iiZE3wJEcBILclnRoYwX0b6+5DwXNAOBqA9yUSO9UHZOsXFV0IwPa2QZF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342758783"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342758783"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885470177"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885470177"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2023 08:17:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jHz-00395g-2D;
        Mon, 12 Jun 2023 18:17:03 +0300
Date:   Mon, 12 Jun 2023 18:17:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jadav, Raag" <raag.jadav@intel.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: Re: [PATCH v2 1/4] pinctrl: intel: refine set_mux hook
Message-ID: <ZIc279PMCz/Pn6fU@smile.fi.intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
 <20230609082539.24311-2-raag.jadav@intel.com>
 <ZINWOWLjyZk2Gj3j@smile.fi.intel.com>
 <DM6PR11MB2779679A4AF6023180B942248C54A@DM6PR11MB2779.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2779679A4AF6023180B942248C54A@DM6PR11MB2779.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:15:59AM +0000, Jadav, Raag wrote:
> > On Fri, Jun 09, 2023 at 01:55:36PM +0530, Raag Jadav wrote:
> > > Utilize a temporary variable for common shift operation inside
> > > ->set_mux() hook and improve readability.
> > 
> > Seems the bloat-o-meter statistics is missing here.
> 
> I changed the commit message as pointed out by Mika in v1.
> Do I change it back?

No back, only forward!

I.e. you need to update Subject to follow the pattern, ->set_mux()
in this case) and add a note that the change makes code smaller.
It will be two selling points.

-- 
With Best Regards,
Andy Shevchenko


