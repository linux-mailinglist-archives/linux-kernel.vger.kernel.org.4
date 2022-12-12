Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C2649B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiLLKAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLKAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:00:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF1B64
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670839199; x=1702375199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etMDtDTcQ349mAtBiuyAlfHrquC9Rp1ynKEdG6YSinI=;
  b=jwyJ8ijRFdQaslgAyUrWMhWOGbyKLg5JYrqJQzzfkwPv1O3SML8rX7Qt
   MSfTRezQ5NplWKwK7wWNasLaP++1RSL/0fyfKLibozQyvRDcEBp7w+Z2u
   d4+TlTEZj01ip49mBoZMY8gVccKVQGCOephTnB0SZ2CCLaBR6jGojLevt
   oKlgAoj8ZNPokr0slRDugOrKqg9DidKlrsCEZvuJqIKWOXZTtbz0SYVMr
   vO0eZgX3r+eOmXlAmQd2jfFNqlSu0xpvJ6joiigWK2uauRREizDRzFwgZ
   cx21prMjTepj/t6f0fnaSVNvvK8zFhZxjs9Cj2YVQ7XPNEjYQuV6qzACP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="318957082"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="318957082"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 01:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="893433254"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="893433254"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 12 Dec 2022 01:59:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p4fbH-008Peb-1W;
        Mon, 12 Dec 2022 11:59:55 +0200
Date:   Mon, 12 Dec 2022 11:59:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     ojeda@kernel.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] auxdisplay: hd44780: Fix potential memory leak in
 hd44780_remove()
Message-ID: <Y5b7m/aijyJEuyoI@smile.fi.intel.com>
References: <20221129081542.5890-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129081542.5890-1-niejianglei2021@163.com>
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

On Tue, Nov 29, 2022 at 04:15:42PM +0800, Jianglei Nie wrote:
> hd44780_probe() allocates a memory chunk for hd with kzalloc() and
> makes "lcd->drvdata->hd44780" point to it. When we call hd44780_remove(),
> we should release all relevant memory and resource. But "lcd->drvdata
> ->hd44780" is not released, which will lead to a memory leak.
> 
> We should release the "lcd->drvdata->hd44780" in hd44780_remove() to fix
> the memory leak bug.

Miguel, can this be somehow moved forward?

-- 
With Best Regards,
Andy Shevchenko


