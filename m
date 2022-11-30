Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A163D3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiK3Kxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiK3Kxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:53:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BBF1A07C;
        Wed, 30 Nov 2022 02:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669805616; x=1701341616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/e+C3wl8+dzp9JQNwSZ4YJIkBLj4AEr8HBzYx/xDW5g=;
  b=AB4FNNA0TRuu2vWc3vCMfxPEvCzBPNB1rniF9+QmxTXB8luvAbmLDQCO
   TPiWmu2nsbZr9CzCvdglulw9P1hIWm7VWeLAJgkuKRmSCAkiClmYSv1+m
   gnSPZA3EYrPpx8D1GuC48m48FE3ojG/ULSZiG7YcTsuRoF4/Xowk+4OLp
   xjbQbaEO3qpikquD5+Qz3K4aHcLHI6ZKBRsT3Hw4zx12Vj5xqeOldyBpc
   oerYTdiTWvbGV6Y9nindCnNoa3VIE9qOaAuNDkbt1818PmBcFvJvHCeJg
   DZJ1E5knKduaJqI6g7YM9mkou/ihXYrhDSo9jG9+Lm1/TW+ohXo2b5Azv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="302968886"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="302968886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 02:53:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="637951228"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="637951228"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2022 02:53:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0Kia-002DnT-2W;
        Wed, 30 Nov 2022 12:53:32 +0200
Date:   Wed, 30 Nov 2022 12:53:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <Y4c2LF6Tekm/21r9@smile.fi.intel.com>
References: <20221130131854.35b58b16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130131854.35b58b16@canb.auug.org.au>
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

On Wed, Nov 30, 2022 at 01:18:54PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/xen/unpopulated-alloc.c:17:21: error: 'list_count' redeclared as different kind of symbol
>    17 | static unsigned int list_count;
>       |                     ^~~~~~~~~~
> In file included from include/linux/preempt.h:11,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from drivers/xen/unpopulated-alloc.c:3:
> include/linux/list.h:662:22: note: previous definition of 'list_count' with type 'size_t(struct list_head *)' {aka 'long unsigned int(struct list_head *)'}
>   662 | static inline size_t list_count(struct list_head *head)
>       |                      ^~~~~~~~~~
> 
> Caused by commit
> 
>   a9efc04cfd05 ("i915: Move list_count() to list.h for broader use")
> 
> I have used the usb tree from next-20221129 for today.

I will cook the fix ASAP, thanks for the report!


-- 
With Best Regards,
Andy Shevchenko


