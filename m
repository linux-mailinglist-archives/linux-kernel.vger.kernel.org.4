Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951AC628491
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiKNQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiKNQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:03:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAF5657F;
        Mon, 14 Nov 2022 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668441817; x=1699977817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5AaiXYz+1RmM1Bf9NQ6qqraB4/QAJtAVIge5ln1rEd0=;
  b=S1ekmnVt8P7b0ccg7GqlI9SF/shuOesKIe516upJ5UkbCSpFy1FQwbT8
   N0LUN+Pu0CvTn8pJbO7cClsgHuVE6AE4n2o+rA+bLjPqrOhAtkKCzWfnl
   pVz5jfcfAG32V9zz1z3QFRjuXMgiTmgeV5Zw6tI1k7vwY5VLxw6ZIHzTS
   PGrPPKhoRxl80rS+YZbr2Ul2EoirVUuX1A19v++YDajlS9tp2L5q0ecKE
   TfxQrW4cZQ82CNHE5pU4TBD4v3oaFZDGW5rFTNOHScOuTFg+Oq3scdmW0
   D45cLnJpYH/U+TQW5XD5JXEebujtTJhxBTa+7ZGBhnSnoXjsoPJMH1AFd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313153252"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313153252"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763532024"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="763532024"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2022 08:03:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oubvI-00CEus-2T;
        Mon, 14 Nov 2022 18:03:00 +0200
Date:   Mon, 14 Nov 2022 18:03:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Kevin Cernekee <cernekee@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/4] list: Introduce list_count() to count existing
 nodes
Message-ID: <Y3JmtNExJulq2CEE@smile.fi.intel.com>
References: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
 <202211142350.i0ngTfIl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211142350.i0ngTfIl-lkp@intel.com>
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

On Mon, Nov 14, 2022 at 11:38:04PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on usb/usb-testing]
> [also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.1-rc5 next-20221114]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/list-Introduce-list_count-to-count-existing-nodes/20221114-193023
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> patch link:    https://lore.kernel.org/r/20221114112842.38565-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/4] list: Introduce list_count() to count existing nodes
> config: x86_64-rhel-8.3-func
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/124813c325e31e99580c2aaef85bb3943e55c36e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/list-Introduce-list_count-to-count-existing-nodes/20221114-193023
>         git checkout 124813c325e31e99580c2aaef85bb3943e55c36e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Oh, nice! I will fix this for v2.

-- 
With Best Regards,
Andy Shevchenko


