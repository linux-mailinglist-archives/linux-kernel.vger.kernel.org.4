Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321E670633F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjEQIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjEQIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:46:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D248B1FFC;
        Wed, 17 May 2023 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684313166; x=1715849166;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Esgsm3RTHSGvonHSP9mXXt4krUC+gmpYyDOTAsvlPgc=;
  b=ffOi8zGm0F33Ba/cJayIRkwnhIXNYCNNN/mtw0a3AWWk8FCuyqPPfRVX
   2hEhxmSrPHkY8Nhs9Zi/+WvwFPaybAZ38XIi/OO1VfEhMhR2HGWb6+1S/
   RZYrr94gmQaFhQupgCbkyWjsh2bM6SsXGfbOltJTIQbiAX5NlolBM6hQ3
   4j2Cam9fTschKfjQWoyq47Ssn7dQ5m5eZv+koo11tLQiaJH+8VV9mTGck
   98kLd89fiY0ysk8xlcPSI9Lkbvu+EzdAmYK88jbo3Zn0IOCJ5cWGeaMSW
   ft0BkUZcXMlb0s06XjQP0gQDU1S3VmRWIaLXUVweNi9HPiuYCTkvCKP1j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379893883"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="379893883"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 01:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="948187140"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="948187140"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.50.207])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 01:46:03 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: i810: include i810_main.h in i810_dvt.c
In-Reply-To: <20230516202814.561262-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230516202814.561262-1-arnd@kernel.org>
Date:   Wed, 17 May 2023 11:46:00 +0300
Message-ID: <87lehngxbr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 16 May 2023, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building with W=1 shows that a header needs to be included to
> make the prototypes visible:
>
> drivers/video/fbdev/i810/i810_dvt.c:194:6: error: no previous prototype for 'round_off_xres' [-Werror=missing-prototypes]
> drivers/video/fbdev/i810/i810_dvt.c:233:6: error: no previous prototype for 'i810fb_encode_registers' [-Werror=missing-prototypes]
> drivers/video/fbdev/i810/i810_dvt.c:245:6: error: no previous prototype for 'i810fb_fill_var_timings' [-Werror=missing-prototypes]
> drivers/video/fbdev/i810/i810_dvt.c:279:5: error: no previous prototype for 'i810_get_watermark' [-Werror=missing-prototypes]
>
> Adding the header leads to another warning from a mismatched
> prototype, so fix this as well:
>
> drivers/video/fbdev/i810/i810_dvt.c:280:5: error: conflicting types for 'i810_get_watermark'; have 'u32(struct fb_var_screeninfo *,

Changes here look fine,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

but I think you should try CONFIG_FB_I810_GTF=y to get the same
mismatched prototype error for i810_get_watermark() in i810_gtf.c, and
add the const there while at it. R-b stands for that addition as well.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/i810/i810_dvt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/i810/i810_dvt.c b/drivers/video/fbdev/i810/i810_dvt.c
> index b4b3670667ab..2082b5c92e8f 100644
> --- a/drivers/video/fbdev/i810/i810_dvt.c
> +++ b/drivers/video/fbdev/i810/i810_dvt.c
> @@ -14,6 +14,7 @@
>  
>  #include "i810_regs.h"
>  #include "i810.h"
> +#include "i810_main.h"
>  
>  struct mode_registers std_modes[] = {
>  	/* 640x480 @ 60Hz */
> @@ -276,7 +277,7 @@ void i810fb_fill_var_timings(struct fb_var_screeninfo *var)
>  	var->upper_margin = total - (yres + var->lower_margin + var->vsync_len);
>  }
>  
> -u32 i810_get_watermark(struct fb_var_screeninfo *var,
> +u32 i810_get_watermark(const struct fb_var_screeninfo *var,
>  		       struct i810fb_par *par)
>  {
>  	struct mode_registers *params = &par->regs;

-- 
Jani Nikula, Intel Open Source Graphics Center
