Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0966F6493
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 07:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEDFz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 01:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEDFz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 01:55:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51741734
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683179725; x=1714715725;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GJ7npMkrZC3VgYCLwPe2w+fovFm3a6wbE2l0VX7wdn8=;
  b=PecTUlN4MVzhPHniHi+KMkjW7UC9FCdImxAgyq3ftwDxPyPhOMbD0soN
   MbHqYMszFUJr39im1xGT7oeEInQgXBOHSf9Pk4u76wk6jVMiq1fBHAlGB
   sNPNl7xUHVh2XDwPq/wcQsciNFDr587sAPdmNnNjNWTcVbZ9GyStMpxD1
   ib5Weoo+TlNCyLKkI3otxf0d/qDfUG2ke3fLT9u19C1tsW1v07c9+nUjD
   RNnZQfeWhMwlEwKy2Fla7O8+WIkQKPdfaqHw7L8bzajCsbDNOG/Z7j33w
   RsFpI/LiOqhKV4UJO4MhqD3ZV/lvo2mZJcAaIoCu39CUKLt+8S9jv6GPz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348884157"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348884157"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 22:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="943192813"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="943192813"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 22:55:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
        <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
Date:   Thu, 04 May 2023 13:54:14 +0800
In-Reply-To: <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 3 May 2023 21:29:14 -0400")
Message-ID: <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mathieu,

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> Add missing parentheses around use of macro argument "pos" in those
> patterns to ensure operator precedence behaves as expected:
>
> - typeof(*pos)
> - pos->member
>
> The typeof(*pos) lack of parentheses around "pos" is not an issue per se
> in the specific macros modified here because "pos" is used as an lvalue,
> which should prevent use of any operator causing issue. Still add the
> extra parentheses for consistency.

I don't think it's necessary to add parentheses here.  As you said,
"pos" is used as an lvalue.

> Remove useless parentheses around use of macro parameter (node) in the
> following pattern:
>
>   llist_entry((node), typeof(*pos), member)
>
> Because comma is the lowest priority operator already, so the extra pair
> of parentheses is redundant.

This change looks good for me.

Best Regards,
Huang, Ying

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/llist.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 85bda2d02d65..45d358c15d0d 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -173,9 +173,9 @@ static inline void init_llist_head(struct llist_head *list)
>   * reverse the order by yourself before traversing.
>   */
>  #define llist_for_each_entry_safe(pos, n, node, member)			       \
> -	for (pos = llist_entry((node), typeof(*pos), member);		       \
> +	for (pos = llist_entry(node, typeof(*(pos)), member);		       \
>  	     member_address_is_nonnull(pos, member) &&			       \
> -	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
> +		(n = llist_entry((pos)->member.next, typeof(*(n)), member), true); \
>  	     pos = n)
>  
>  /**
