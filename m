Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E60746A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGDHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGDHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:17:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805961A2;
        Tue,  4 Jul 2023 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688455070; x=1719991070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E5NBCKClhK46jwcevA3AhRLGaK+1QlR+RReRt1xL4Mo=;
  b=g3kWCbfa8nFH3NMXV6AFjPRLQOAaELDbaEzmApZRYLkChO8QVElZ1HQ5
   x77JR4OWNesOwqXjth2BIM6cCTj+LwE1cG++/epIQMMRlTBG9UhHTnDxE
   G2IgJYRUAROWWHkIQ+p3nkZFo7EDfkvx8256OOMgpkYD2HowROls72JKm
   VcknwniwBq0kCkwoo0C6KWOwLkdyjAYZCnIcZLFP1JgiVOMi2nnigVvF0
   piZ3Z+UuUh088n+TfaRteMNtO+qv66sJNs5F44mlmkFFztU5lMfFlwANn
   peF+pkIHu3T1CIbJfEylM34AMAGdyc3Vlr12Dcc7DzbIY0DLRkzavtyWF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="342646999"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="342646999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="842900336"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="842900336"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 04 Jul 2023 00:17:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGaIC-0024DD-2J;
        Tue, 04 Jul 2023 10:17:44 +0300
Date:   Tue, 4 Jul 2023 10:17:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/5] fbdev: Move core fbdev symbols to a separate
 Kconfig file
Message-ID: <ZKPHmJDsUtG7nROo@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703230534.997525-3-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 01:05:26AM +0200, Javier Martinez Canillas wrote:
> The drivers/video/fbdev/Kconfig defines both symbols for fbdev drivers and
> core fbdev symbols, that can be enabled independently of the fbdev drivers.
> 
> Split the Kconfig in two, one that only has the symbols for fbdev drivers
> and another one that contains the fbdev core symbols.

...

>  source "drivers/video/fbdev/omap/Kconfig"
>  source "drivers/video/fbdev/omap2/Kconfig"
>  source "drivers/video/fbdev/mmp/Kconfig"
> +
> +source "drivers/video/fbdev/core/Kconfig"

Hmm... Shan't we start Kconfig from core options?

-- 
With Best Regards,
Andy Shevchenko


