Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532E4746A80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGDHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:21:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5010186;
        Tue,  4 Jul 2023 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688455299; x=1719991299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmMqRubBY7jl+nvFgHg9YoaIiWyudbhqZ/7je2LSMIU=;
  b=ZxmfyoqIrD1Q5aIqfMGssKtNobL7mxEutnz996A3pkTdnlgoQAOcjoej
   OYIpCgt3AZfx80Z5kkS4K0XefqewL0xhuPyoVQmzOUb44XckrciSwTr+3
   mgOmsYIQBeoS/ktFxObdw3JpSKfB993QWGthOxadi0mn2tfSPe6BI4uUR
   HdL9MqJ14qPIgezFztNLOlQyfk6M0swduB6c+JtgpwzYteYtIGAjLwSHf
   i84LsoJ1NBKKIZxoQBs75bVRskdlsSCfMXoGV4cGouG7DpphzHxIsE6wl
   PAIjnS2sB/UOvrGQx4z5p/huvLXKbaN7F4s4En0tPoRYP1dfV2Pp94HaZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426740879"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="426740879"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753975095"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="753975095"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2023 00:21:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGaLr-0024Fd-2I;
        Tue, 04 Jul 2023 10:21:31 +0300
Date:   Tue, 4 Jul 2023 10:21:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v4 4/5] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
Message-ID: <ZKPIezsC1zhKRrGU@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-5-javierm@redhat.com>
 <ZKPIQngz6WkzASqa@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKPIQngz6WkzASqa@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 10:20:35AM +0300, Andy Shevchenko wrote:
> On Tue, Jul 04, 2023 at 01:05:28AM +0200, Javier Martinez Canillas wrote:

...

> Wondering if
> 
>   if FB_CORE
>   ...
>   endif
> 
> makes Kconfig looking better instead of replacing all these "depends on" lines.

I meant user visible effect (via `make *config` and in the source code.

> >  config FB_DEVICE
> >  	bool "Provide legacy /dev/fb* device"
> > -	depends on FB
> > +	depends on FB_CORE
> >  	default y

-- 
With Best Regards,
Andy Shevchenko


