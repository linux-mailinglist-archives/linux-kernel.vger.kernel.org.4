Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5466920D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBJOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjBJOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:30:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9AC171;
        Fri, 10 Feb 2023 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676039442; x=1707575442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7XMHFQXK9G3Muvx/469KqpQHDQXl3YKtOQ6XFrhwNf4=;
  b=gpcgm0I1Ms6aTZ+a8oyUNJtkvf3jaaMqLFqmxvwqKT2r13+6z7RDulA6
   B9TwfusCzxx2QqK9gHW0nEyL/yBxwDtPtAXkncnZ4+sbA+D05GEtKx9KD
   ZJbDXarDoQcMatpnjofHoR+CKKjgd+LhJM65Kn47Lf2dUOGymYNoiN79d
   hWeMEoxBYXZ8zfkSGeayBWa8z+f2K638uq6w405IfgpdCjHcgRg24Cp+b
   3YrqtFgBjwtordW/x9oVh5z2ugcURXC2n+EX3RDInL5uq/jgy0eddA2nO
   /xZQlqyn7Uc5hrm8iraGWg9ILZKpRfmb4OEjgenWTfHBqGx58YjG+jswI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310061596"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310061596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:30:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700491142"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700491142"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2023 06:30:31 -0800
Message-ID: <89ee5d02-5421-a6bd-0920-c531f0d57448@linux.intel.com>
Date:   Fri, 10 Feb 2023 16:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/7] xhci: mem: Short cleanup series
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.2.2023 17.11, Andy Shevchenko wrote:
> Clean up xhci-mem.c a bit using latest and greatest Linux kernel
> features.
> 
> Changelog v2:
> - used dma_pool_zalloc() instead of open coding it (Mathias)
> 
> Andy Shevchenko (7):
>    xhci: mem: Carefully calculate size for memory allocations
>    xhci: mem: Use dma_poll_zalloc() instead of explicit memset()
>    xhci: mem: Get rid of redundant 'else'
>    xhci: mem: Drop useless return:s
>    xhci: mem: Use while (i--) pattern to clean up
>    xhci: mem: Replace explicit castings with appropriate specifiers
>    xhci: mem: Join string literals back
> 
>   drivers/usb/host/xhci-mem.c | 83 +++++++++++++++----------------------
>   1 file changed, 33 insertions(+), 50 deletions(-)
> 

Added to queue, thanks

-Mathias
