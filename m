Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FE72E6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbjFMPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbjFMPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:10:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F84CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669003; x=1718205003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VNtTvHok2wk8XMsvlb+ByHj2zD+MybIHambRtUs2s/I=;
  b=cKhstitUPQsYOX2fL+P/jyKagp7OJV80zLWlZKLwXNRs2HhST9acSUp+
   lzPodZIABYSjnM8Wuy7nw9xq9gJ1/BTsS1mYGlAGlPgng544WwoF/Pd7k
   S2lkSakMd8CZDMJ0egQba5wgtEi5vWxYzm+fXSM9IWFuaUI1Y5MBu5vsK
   U8jELdx+maR+gBRxfTaQ5/OHi/ls1WuN3thoFi7HkFzYSYrla4LF4k3Nq
   R3apmsgO5wdE5DWJIGrc9WUpJu8pB2r/qmunm5lVHDQtQFFAmxIkF3Dwy
   Ix5MD7jQZXyMh74kP83lxxwRobz6mqZCxYU67dNqSx+pXzg9se1jETJv4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386761708"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="386761708"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="801524332"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="801524332"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2023 08:10:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q95ei-003U22-1A;
        Tue, 13 Jun 2023 18:10:00 +0300
Date:   Tue, 13 Jun 2023 18:10:00 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v1 1/1] dm integrity: Use %*ph for printing hexdump of a
 small buffer
Message-ID: <ZIiGyPMMcIxZHH9u@smile.fi.intel.com>
References: <20230612214751.9662-1-andriy.shevchenko@linux.intel.com>
 <516b13b634374885891ac1e808d37ce3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516b13b634374885891ac1e808d37ce3@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:13:54PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 12 June 2023 22:48
> > 
> > The kernel already has a helper to print a hexdump of a small
> > buffer via pointer extension. Use that instead of open coded
> > variant.
> > 
> > In long term it helps to kill pr_cont() or at least narrow down
> > its use.
> > 
> > Note, the format is slightly changed, i.e. the colon is not printed
> > before the buffer dump and the trailing space is always printed.
> > These are not a problem since it's a debug message. Also the IV dump
> > is limited by 64 bytes which seems fine.
> ...
> > +#define DEBUG_bytes(bytes, len, msg, ...)	printk(KERN_DEBUG msg " %*ph\n", ##__VA_ARGS__, len,
> > bytes)
> 
> Using:
> 	printf(KERN_DEBUG msg "%s%*ph\n", ##__VA_ARGS__, len ? ": " : "", len, bytes)
> would add back the optional ':'.

Yes, I considered that and decided to avoid. This is debug and hence the format
may vary anyway. That said, up to maintainers.

-- 
With Best Regards,
Andy Shevchenko


