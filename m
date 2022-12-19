Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070C965097A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiLSJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiLSJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:44:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154995A5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671443064; x=1702979064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZPIbaI8Fo25hM21zchenFK+gSCjoAt+0YV2aFj835DI=;
  b=kwcqvRUa9hCxl+MgD2TbxR5vsz7twjvQugElCS4QqpFb1cxYvPn9MZMt
   kGkQ0054qXUHb1HCwzanHl8lxED7dP/lI5s6MPBxa7HTZEY5BZAEoBuj+
   KMtvXSmnCYHtFF2iN7LQs7BoSERVXcekf0ZX5bCTH3YgJrdVlUA4G4ojL
   MAAYT/wUZ37BW1K48P6+VH8g+ZQxWRnA5gVJYGshCFZc/UGLupygqPPqB
   d/oUxZvAM5Bsvf1s8LTM6X12NclC/eMw5kgYKG6T35m0YagQjrROHOVtF
   zM14v5lY7DA7JTtoMeGELcpDBBJ3wrYitNsY2c8Rp8CID1fLvh3OFZtMd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302735799"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302735799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 01:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="643937254"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="643937254"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2022 01:44:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7Cgy-00CDxm-0q;
        Mon, 19 Dec 2022 11:44:16 +0200
Date:   Mon, 19 Dec 2022 11:44:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y6AycLbpjVzXM5I9@smile.fi.intel.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-4-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218101901.373450-4-42.hyeyoo@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 07:19:00PM +0900, Hyeonggon Yoo wrote:
> %pGp format is used to print 'flags' field of struct page.
> As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> are set in page_type field, introduce %pGt format which provides
> human readable output of page_type.
> 
> Note that the sense of bits are different in page_type. if page_type is
> 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
> page_type is 0xffefffff. Clearing a bit means we set the bit.
> 
> Bits in page_type are inverted when printing page type names.

...

> +#define __def_pagetype_names						\
> +	{PG_slab,			"slab"		},		\
> +	{PG_offline,			"offline"	},		\
> +	{PG_guard,			"guard"		},		\
> +	{PG_table,			"table"		},		\
> +	{PG_buddy,			"buddy"		}

Wondering if it will be more robust to define a helper macro

#define DEF_PAGETYPE_NAME(_name)	{ PG_##_name, __stringify(_name) }
...
#undef DEF_PAGETYPE_MASK

In this case it decreases the chances of typo in the strings and flags.

-- 
With Best Regards,
Andy Shevchenko


