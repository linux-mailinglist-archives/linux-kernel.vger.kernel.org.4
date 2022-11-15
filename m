Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB56297B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiKOLnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKOLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:43:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7CD2529A;
        Tue, 15 Nov 2022 03:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668512628; x=1700048628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JO33YPL4NpCf+QtbSvBLune4D/6KvXp403nfS2tAN/c=;
  b=icX/gImr8kWPZJO6apmqT/0DpRGBYkTIwC8ZYBCIuF4B88ibUMHvXP7s
   PbAuvdNIL3CelM9JOLcidsdKI6t9NjDgI+qFZPxLUzgqFsFxuNAJplpNV
   h8oXxuN3ZgM/CoeZ3wmlWMdeH/ag4AY+M95+dhAboxnlY2bDTtyNPxqoG
   YQDxGtBgLZGXoei90MgswDI6l0ZC0y1LlY6U5xMdWkNhV0y967y5JB3FN
   oMNNpZw/cc4TgZjgRrbYDHSD12NcgzEt1qGt8Qjpf7H0B852vvVKknGhO
   a8OU/ZIwnW+T0fEoPQdQ5VhrRzZnI9hpsWAe3+SShcZrKWCI1DZ3QWdRR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374365168"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="374365168"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 03:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="633206267"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="633206267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2022 03:43:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouuLt-00Cb7Y-03;
        Tue, 15 Nov 2022 13:43:41 +0200
Date:   Tue, 15 Nov 2022 13:43:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Cleanup DT Overlay intermediate files as
 appropriate
Message-ID: <Y3N7bLuSTKJYPcIC@smile.fi.intel.com>
References: <20221114205939.27994-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114205939.27994-1-afd@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 02:59:39PM -0600, Andrew Davis wrote:
> %.dtbo.o and %.dtbo.S files are used to build-in DT Overlay. They should
> should not be removed by Make or the kernel will be needlessly rebuilt.
> 
> These should be removed by "clean" and ignored by git like other
> intermediate files.

Fixes: 941214a512d8 ("kbuild: Allow DTB overlays to built into .dtbo.S files")

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .gitignore             | 1 +
>  Makefile               | 4 +++-
>  scripts/Makefile.build | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 5da004814678d..3ec73ead6757e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -20,6 +20,7 @@
>  *.dtb
>  *.dtbo
>  *.dtb.S
> +*.dtbo.S
>  *.dwo
>  *.elf
>  *.gcno
> diff --git a/Makefile b/Makefile
> index 3735d5996c637..0dd7e8d022289 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2003,7 +2003,9 @@ clean: $(clean-dirs)
>  	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
>  		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
>  		-o -name '*.ko.*' \
> -		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
> +		-o -name '*.dtb' -o -name '*.dtbo' \
> +		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
> +		-o -name '*.dt.yaml' \
>  		-o -name '*.dwo' -o -name '*.lst' \
>  		-o -name '*.su' -o -name '*.mod' -o -name '*.usyms' \
>  		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 41f3602fc8de7..3ceab076127b7 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -468,10 +468,12 @@ intermediate_targets = $(foreach sfx, $(2), \
>  					$(filter %$(strip $(1)), $(targets))))
>  # %.asn1.o <- %.asn1.[ch] <- %.asn1
>  # %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
> +# %.dtbo.o <- %.dtbo.S <- %.dtbo <- %.dtso
>  # %.lex.o <- %.lex.c <- %.l
>  # %.tab.o <- %.tab.[ch] <- %.y
>  targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
>  	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
> +	   $(call intermediate_targets, .dtbo.o, .dtbo.S .dtbo) \
>  	   $(call intermediate_targets, .lex.o, .lex.c) \
>  	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
>  
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


