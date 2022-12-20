Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B93651F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLTK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiLTK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:59:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3349D92
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671533946; x=1703069946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEelLQDmgnv5MCyyCw3Z0H5qP7W6fG9yaOAKTHeKJ3E=;
  b=CGK/si3Qf5K9peBthVmJkOZ3eJ8fdHCF3IyZvx85m5NR9KQHStOTtCOU
   qXoKhR0FfY3zIgUJuNoL5JHU0qiibz/vJpF4A7v1a1u3Xkr/z7KhEjsIH
   zb/15AWTUNQ5S5FCSY9YQmyPssz4+jqPwqfgGxlbXOyobOLuRYJ92w1a2
   Yxx+R4hCLX6ZlzJb3bTVYQWTO7tyOB0nZZCf/5u4utTjiOVmvu7/NswvW
   uAw0Dfw6FlmESyvt3bQCEhwFjQvYQKgOhhoIJULuRr5myMVStGWmjCMt4
   HjzymDz4UHoEyzvQYAatqzWBdrFGqVWzOcQdk1huA2f3tjtDvkjBOw6Ax
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="383931988"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="383931988"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 02:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="653059539"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="653059539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 20 Dec 2022 02:58:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7aKj-00CpiB-2v;
        Tue, 20 Dec 2022 12:58:53 +0200
Date:   Tue, 20 Dec 2022 12:58:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y6GVbeB8Onzlcb8c@smile.fi.intel.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-4-42.hyeyoo@gmail.com>
 <Y6AycLbpjVzXM5I9@smile.fi.intel.com>
 <82feabee-0446-b913-adbb-0e96ecb10c94@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82feabee-0446-b913-adbb-0e96ecb10c94@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:35:38AM -0800, Randy Dunlap wrote:
> On 12/19/22 01:44, Andy Shevchenko wrote:
> > On Sun, Dec 18, 2022 at 07:19:00PM +0900, Hyeonggon Yoo wrote:

...

> > #define DEF_PAGETYPE_NAME(_name)	{ PG_##_name, __stringify(_name) }
> > ...
> > #undef DEF_PAGETYPE_MASK
> > 
> > In this case it decreases the chances of typo in the strings and flags.
> 
> I'd say Yes.  (and #undef DEF_PAGETYPE_NAME methinks; or change both to _MASK)

Ah, it's me who used two different names for the same macro :-)

-- 
With Best Regards,
Andy Shevchenko


