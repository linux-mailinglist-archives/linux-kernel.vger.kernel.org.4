Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C59F6FAFBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjEHMQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjEHMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:16:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6E37C4C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683548202; x=1715084202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1TRcGmemRzctXjRrFvBetfH0znJQWjfV8lCXlG5tDDQ=;
  b=UZyVFuCVZWRCK/cC68QjNf3N19tQswu+mIcQf8r6yoV7vsSxHi5MmYM6
   ytcLnaLynZsamBW7Hv71hlSL/PIATH8JYpODzY76mOqJvobzIh5MPXHzi
   0TARZzpWs17i9l+2qB+KdCWpSK9C2Y8HH2DZ9fRm4QHft4HQTZWgSIoj5
   Xh3C1SdMjoVxyDRm5CDPzP3zakCz0bCjZ1ZFb1G1igEDLmUzy+ROJdX4V
   9UNKOCo7M0srsq5IgH6qCKZafDua+BZ0l4h+x9Ue6utns0YafNntDL7r+
   igC7JMVtLENeOB3MGhBxa7ef4ejeJN0bgxV5piQBqpiKR3HVNw8P2wvhM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349660209"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349660209"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 05:16:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="788075011"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="788075011"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 05:16:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pvznC-00Aqvh-1e;
        Mon, 08 May 2023 15:16:38 +0300
Date:   Mon, 8 May 2023 15:16:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: Re: [RFC PATCH 05/13] list.h: Fix parentheses around macro pointer
 parameter use
Message-ID: <ZFjoJqbDn/BL1GQT@smile.fi.intel.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-6-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504200527.1935944-6-mathieu.desnoyers@efficios.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:05:19PM -0400, Mathieu Desnoyers wrote:
> Add missing parentheses around use of macro argument "pos" in those
> patterns to ensure operator precedence behaves as expected:
> 
> - typeof(*pos)
> - pos->member
> - "x = y" is changed for "x = (y)", because "y" can be an expression
>   containing a comma if it is the result of the expansion of a macro such
>   as #define eval(...) __VA_ARGS__, which would cause unexpected operator
>   precedence. This use-case is far-fetched, but we have to choose one
>   way or the other (with or without parentheses) for consistency,
> - x && y is changed for (x) && (y).
> 
> Remove useless parentheses around use of macro parameter (head) in the
> following pattern:
> 
> - list_is_head(pos, (head))
> 
> Because comma is the lowest priority operator already, so the extra pair
> of parentheses is redundant.

But strictly speaking it might be something like

	list_...(..., (a, b))

where (a, b) is the head. No?

> This corrects the following usage pattern where operator precedence is
> unexpected:
> 
>   LIST_HEAD(testlist);
> 
>   struct test {
>           struct list_head node;
>           int a;
>   };
> 
>   // pos->member issue
>   void f(void)
>   {
>           struct test *t1;
>           struct test **t2 = &t1;
> 
>           list_for_each_entry((*t2), &testlist, node) {   /* works */
>                   //...
>           }
>           list_for_each_entry(*t2, &testlist, node) {     /* broken */
>                   //...

Me still in doubt. But it's up to maintainers.

>           }
>   }
> 
>   // typeof(*pos) issue
>   void f2(void)
>   {
>           struct test *t1 = NULL, *t2;
> 
>           t2 = list_prepare_entry((0 + t1), &testlist, node);     /* works */
>           t2 = list_prepare_entry(0 + t1, &testlist, node);       /* broken */
>   }
> 
> Note that the macros in which "pos" is also used as an lvalue probably
> don't suffer from the lack of parentheses around "pos" in typeof(*pos),
> but add those nevertheless to keep everything consistent.

-- 
With Best Regards,
Andy Shevchenko


