Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9C6E5A97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDRHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDRHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:38:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA73C1F;
        Tue, 18 Apr 2023 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681803535; x=1713339535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gvo+MqctEL5HSwatCbCQmqOpF34r5sqpuLtBI4pvBpM=;
  b=PrHtmRgBycnx2IPFtzyk4DICop9Hb7AmDhBebiv813P04MjmRLoYfNc7
   gKHa+7lJvwYpwYVV4t7ZGh2bBloTLYJED8XhCxViQwqs/Bs14K1XOSGkI
   bWw3qAtz4gL7O9/JPhCRjMc+z1qNrrU/LWYyLTaWOCcO4r1VdKRbh/3hs
   il0aN73N5UL9FPde2kvEhMhlpntwqGp0Y9sXFn7+kTsFz+nJ6H+3ZO70/
   i1TSAltam/3Gpwo0hFqAerwDb8XtSjYTN5+Roq9+bJzJrkSuVMZ1uv7Ww
   3UEk6gR5ZjZFFTpXETTCDaGPw8nG4YCfeCC7ni1xGJAxK6BS80kRwJkDO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="345099113"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="345099113"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="690984273"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="690984273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2023 00:38:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pofvP-001VdU-1K;
        Tue, 18 Apr 2023 10:38:51 +0300
Date:   Tue, 18 Apr 2023 10:38:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
Message-ID: <ZD5JC7BdN1usn6Kd@smile.fi.intel.com>
References: <20230418052902.1336866-1-joychakr@google.com>
 <20230418052902.1336866-5-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418052902.1336866-5-joychakr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:
> Store address width capabilities of DMA controller during init and check
> the same per transfer to make sure the bits/word requirement can be met.
> 
> Current DW DMA driver requires both tx and rx channel to be configured
> and functional hence a subset of both tx and rx channel address width
> capability is checked with the width requirement(n_bytes) for a
> transfer.

...

> +	/*
> +	 * Assuming both channels belong to the same DMA controller hence the
> +	 * address width capabilities most likely would be the same.
> +	 */

I had a small comment on this In v6 thread.

-- 
With Best Regards,
Andy Shevchenko


