Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045876161C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKBL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:29:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F87C29372;
        Wed,  2 Nov 2022 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667388570; x=1698924570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xHltA9cDNqr066zntg/UF56nyb2JOcr0In8V89pVlbU=;
  b=C7SDQU7KHg5XN2Tr0qvT+lrylnk/1Ojd3MkbMOV3EueA5VoV9h1iTH2h
   64rggZwD0fF3tIpXbWaLj9sbM20Y3gan3J1bCkoQiM5IUJOll7soDuvs1
   hatmFMXb4NfNxUGsjFH+UgGDM0cYl+r1mOaoXN6I2MAWlyhh4C2tLveBZ
   xF4bF0/QEiXIlY732ShhBuNDGX72W7fSSRsuWcyyTe2ot/mLwuVOFmR5d
   ap2ns3FVtmLnTm3U6rfr73PPdAusWz4CTkFczRp+XoyPasAuxbTITuGMO
   MtcQ5HpX+1GQw3GpPr2Up7ar30Hv0abJVjYnD+InHhaniBbt+ZIzIdxml
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371474382"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371474382"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="703235434"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="703235434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2022 04:29:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oqBvx-0069TA-1p;
        Wed, 02 Nov 2022 13:29:25 +0200
Date:   Wed, 2 Nov 2022 13:29:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 21/30] mm: Use kstrtobool() instead of strtobool()
Message-ID: <Y2JUlb6qzV/MqxnY@smile.fi.intel.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
 <202211011543.20ACBF9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211011543.20ACBF9@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:47:20PM -0700, Kees Cook wrote:
> On Tue, Nov 01, 2022 at 10:14:09PM +0100, Christophe JAILLET wrote:

...

> This seems in keeping with the removal of the simple_*str*() helpers:
> https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

That piece of the documentation is partially wrong. Nobody will going to remove
simple_strtox() due to their convenience when it's related to parse something
from the stream. Yes, overflow is possible, but here is a trade-off.

Note, kstrtox() may not work at early boot stages when we need to parse stream
(with mixed digits and text and symbols) without acquiring space from the heap,
i.o.w. RO strings.

-- 
With Best Regards,
Andy Shevchenko


