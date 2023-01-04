Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1605365D13E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbjADLQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:16:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190DE1A3A0;
        Wed,  4 Jan 2023 03:16:00 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302283998"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="302283998"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 03:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779184672"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="779184672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 03:15:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pD1kQ-004HN0-1U;
        Wed, 04 Jan 2023 13:15:54 +0200
Date:   Wed, 4 Jan 2023 13:15:54 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp: fix videobuf2 Kconfig depenendency
Message-ID: <Y7Vf6nejMFXs/qAk@smile.fi.intel.com>
References: <20230104082212.3770415-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104082212.3770415-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:21:36AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The recent conversion missed the Kconfig bit, so it can now
> end up in a link error on randconfig builds:
> 
> ld.lld: error: undefined symbol: vb2_vmalloc_memops
> >>> referenced by atomisp_fops.c
> >>>               drivers/staging/media/atomisp/pci/atomisp_fops.o:(atomisp_open) in archive vmlinux.a

Tested-by: Andy Shevchenko <andy@kernel.org>

> Fixes: cb48ae89be3b ("media: atomisp: Convert to videobuf2")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/media/atomisp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
> index 2c8d7fdcc5f7..c9bff98e5309 100644
> --- a/drivers/staging/media/atomisp/Kconfig
> +++ b/drivers/staging/media/atomisp/Kconfig
> @@ -14,7 +14,7 @@ config VIDEO_ATOMISP
>  	depends on VIDEO_DEV && INTEL_ATOMISP
>  	depends on PMIC_OPREGION
>  	select IOSF_MBI
> -	select VIDEOBUF_VMALLOC
> +	select VIDEOBUF2_VMALLOC
>  	select VIDEO_V4L2_SUBDEV_API
>  	help
>  	  Say Y here if your platform supports Intel Atom SoC
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


