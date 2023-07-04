Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83D746A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGDHUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGDHUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:20:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F9186;
        Tue,  4 Jul 2023 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688455242; x=1719991242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EHfns0z/SkAEaLYtQzwvi2YwXKwLGS9wAfa8FcB+k0=;
  b=L1AoLd45Nm1i3UA9EPW4c6YAmZVtrNYWVT8Ob0aMOZ62Lz/XvQR1iAeE
   j12nvd++pKPLGgJNI/1FB3Jpeobm6XYPYW5InAtKdvCTs04b8u1txPEPq
   wjYUugoPYcBCWrYTgWM01Wr+yUdSmc0zRl3NWw1DVSJ5LUFzoI0Sx28vr
   P974DHYKwdgabkyrxKNSJRLU9r4NxBxYCsvRjaKCR/ALFfvxsgqSOmpi8
   QVIKZYuIH1GmxrGObbr+TN8BRyicTlSkvY65PgUhHWP8zEbpQAsMGWapi
   OHiYlQn0GMwnWblzCsUYJ6XhT6XvQ4f5OG4EL3PQ9J0OVZ/POYj3ma9EL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="365624117"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="365624117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788773010"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="788773010"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2023 00:20:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGaKx-0024FC-0K;
        Tue, 04 Jul 2023 10:20:35 +0300
Date:   Tue, 4 Jul 2023 10:20:34 +0300
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
Message-ID: <ZKPIQngz6WkzASqa@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703230534.997525-5-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 01:05:28AM +0200, Javier Martinez Canillas wrote:
> Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
> drivers are needed (e.g: only to have support for framebuffer consoles).
> 
> The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
> and so it can only be enabled if that dependency is enabled as well.
> 
> That means fbdev drivers have to be explicitly disabled if users want to
> enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
> 
> This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
> enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
> allowing CONFIG_FB to be disabled (and automatically disabling all the
> fbdev drivers).
> 
> Nothing from fb_backlight.o and fbmon.o is used by the DRM fbdev emulation
> layer so these two objects can be compiled out when CONFIG_FB is disabled.

...

Wondering if

  if FB_CORE
  ...
  endif

makes Kconfig looking better instead of replacing all these "depends on" lines.

>  config FB_DEVICE
>  	bool "Provide legacy /dev/fb* device"
> -	depends on FB
> +	depends on FB_CORE
>  	default y

-- 
With Best Regards,
Andy Shevchenko


