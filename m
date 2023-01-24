Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AB467951B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjAXKYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAXKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:24:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762D14487
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674555887; x=1706091887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iwlkw7L6o+xzAtEwrO7cS9B3miPYK4pLVIbkgLNifU0=;
  b=c+hEx8gN3mJExJSmoPOE137FxeDz5tL/a3RaxDqMUe40qHE18CNS1QV8
   nCX5pToJwdlzo1opkGLvZDfLXD/H3UU1QismlS4f1sWtWMUhvt7aGcDPv
   IvcL0VXUy0g8n5F5IbyFOZ7YwiVFf39iGcnM1NWC/+3C/SmCJ602lvM1S
   womzVP0iM7S3edhJcagBRwE4W0ipbN+ScFNUdh5LLDJNXCI+NQV5Sjy2z
   YmZDhiBr443dW3LPRKLGwXHL97YYvfREoo7FLBfjJELZrzI+2c1k9lm0A
   eclF2KJTEBaYFQRZxss2UmHnb2q0JKTHeh8OUVu9xW26CACqFha7DLxrb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314166003"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="314166003"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 02:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="692550180"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="692550180"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2023 02:24:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKGTr-00EHxk-2A;
        Tue, 24 Jan 2023 12:24:43 +0200
Date:   Tue, 24 Jan 2023 12:24:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, shan.gavin@gmail.com
Subject: Re: [PATCH] nodemask: Drop duplicate check in for_each_node_mask()
Message-ID: <Y8+x64IxlP+pfLho@smile.fi.intel.com>
References: <20230124000243.415621-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124000243.415621-1-gshan@redhat.com>
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

On Tue, Jan 24, 2023 at 08:02:43AM +0800, Gavin Shan wrote:
> The return value type is changed from 'int' to 'unsigned int' since
> commit 0dfe54071d7c8 ("nodemask: Fix return values to be unsigned").
> Besides, the conversion between 'int' and 'unsigned int' on the
> parameter @node is guaranteed to be safe due to the limited range of
> MAX_NUMNODES and CONFIG_NODES_SHIFT. By the way, '(node >= 0)' should
> have been '(node) >= 0' actually.
> 
> It's unnecessary to check if their return values are greater or equal
> to 0 in for_each_node_mask(). Remove it.
> 
> No functional change intended.

Agree on the arguments.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/linux/nodemask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index bb0ee80526b2..8d07116caaf1 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -385,7 +385,7 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  #if MAX_NUMNODES > 1
>  #define for_each_node_mask(node, mask)				    \
>  	for ((node) = first_node(mask);				    \
> -	     (node >= 0) && (node) < MAX_NUMNODES;		    \
> +	     (node) < MAX_NUMNODES;				    \
>  	     (node) = next_node((node), (mask)))
>  #else /* MAX_NUMNODES == 1 */
>  #define for_each_node_mask(node, mask)                                  \
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


