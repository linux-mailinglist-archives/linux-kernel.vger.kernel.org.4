Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5815FAF91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJKJog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJKJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:44:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56B20350
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665481470; x=1697017470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=43Y3aTBatW23+1sm5ZYUL27IXnFExy5x1qIelf/9F/A=;
  b=Aw8A8drs1hvkeeCySeHra4heriMeDjtswYghHlKnRYd43rnlclEZY45F
   tMZt2PbCPY5fb4xmHFC4h+6fntAAaEzOVYIV2FBDl1E6K5YaPEF+Jagxp
   Yfm6WvQBgKGpDzRUGJpe9Avy+g4u+PeicTDAifHJHilL/h6e48IAD4QTP
   vGBt3xm7LGq5PJnm9hQiuQOh+uoRZUBt2DSzdc647qxD02CK7adTXWrZX
   pbbJkXtUn93CHTbQgQX8eEmca1h1JOFfPrZcrbUykowc9u06FUloTVmB/
   Xx4oVkvDxaXYsnjo7zhfExa6R8yep6CxHBR5Z18D0jFqGIY442UbLgMP9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="302069807"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="302069807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 02:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730914797"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="730914797"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2022 02:44:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oiBoJ-005FXx-2C;
        Tue, 11 Oct 2022 12:44:27 +0300
Date:   Tue, 11 Oct 2022 12:44:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     arnd@arndb.de, lee@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y0U6+2PfMrt9mI+L@smile.fi.intel.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008154700.404837-1-Jason@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 09:47:00AM -0600, Jason A. Donenfeld wrote:
> This reverts commit 72a95859728a7866522e6633818bebc1c2519b17. It broke
> reboots on big-endian MIPS and MIPS64 malta QEMU instances, which use
> the syscon driver. Little-endian is not effected, which means likely
> it's important to handle regmap_get_val_endian() in this function after
> all.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

as per discussion and analysis that shows that syscon needs that code because
it calls regmap_init_mmio() with dev == NULL.

> Cc: Lee Jones <lee@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: 72a95859728a ("mfd: syscon: Remove repetition of the regmap_get_val_endian()")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/mfd/syscon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 9489e80e905a..bdb2ce7ff03b 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -66,6 +66,14 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  		goto err_map;
>  	}
>  
> +	/* Parse the device's DT node for an endianness specification */
> +	if (of_property_read_bool(np, "big-endian"))
> +		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
> +	else if (of_property_read_bool(np, "little-endian"))
> +		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
> +	else if (of_property_read_bool(np, "native-endian"))
> +		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
> +
>  	/*
>  	 * search for reg-io-width property in DT. If it is not provided,
>  	 * default to 4 bytes. regmap_init_mmio will return an error if values
> -- 
> 2.37.3
> 
> 

-- 
With Best Regards,
Andy Shevchenko


