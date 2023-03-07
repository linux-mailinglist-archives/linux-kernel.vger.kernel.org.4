Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE26ADE11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCGLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCGLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:55:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6429FD;
        Tue,  7 Mar 2023 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678190152; x=1709726152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6UkVjX3/T8hyZZFcCk/g4dlUAr3SPD/TUsFqHhWwqU0=;
  b=mf87W7k6i7b7iZApp7qVlgtNANnJpexUNIi6pHeb3YSuGbySDd7ljdgA
   /J6vo9gSmayQoxcTCxhnkbX/W0nUGPOf8xmsAQhqRT4P/45MkjoUODLdT
   sN2dxDNveWQV8J2CEQgBA+5SE5fJxXztKHYUjF9ln8xaLQeivufGXxFmZ
   U6RUImKxkItTbKISQ9sU/ZDzF79YIxTKe5C5dpLLNt1j1bZWmOI5mssSk
   7XeZm0UIyFmcq028FVK2mAW0sFqjiZJWGylGTCKzOvjcsTYPAfkygC50t
   lSFFLKHXqMwwSZBUCnJmTJadugNkQ+OOCKI3ExZplfL67G8kKRtVNE0Mw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="315485895"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="315485895"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 03:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745436289"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="745436289"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2023 03:55:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pZVuv-00Gu2v-0q;
        Tue, 07 Mar 2023 13:55:41 +0200
Date:   Tue, 7 Mar 2023 13:55:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
Message-ID: <ZAcmPAbvH2FtyX3E@smile.fi.intel.com>
References: <20230306224752.8417-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306224752.8417-1-afd@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 04:47:52PM -0600, Andrew Davis wrote:
> As a follow up to the series allowing DTB overlays to built from .dtso
> files. Now that all overlays have been renamed, remove the ability to
> build from overlays from .dts files to prevent any files with the old
> name from accidental being added.

Since in the past I had a problem with unnecessary rebuilding, this removes
the rule, so should not bring a similar regression.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thank you.

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  scripts/Makefile.lib | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 100a386fcd71..68d0134bdbf9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -418,9 +418,6 @@ endif
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>  	$(call if_changed_dep,dtb)
>  
> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> -	$(call if_changed_dep,dtc)
> -
>  $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>  	$(call if_changed_dep,dtc)
>  
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


