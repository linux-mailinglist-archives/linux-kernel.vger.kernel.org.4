Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0446809CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjA3Jlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjA3Jlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:41:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668E8F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675071683; x=1706607683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYHSKZJr+AsIJfCw75s0NaKF1+VC8e4ck3sYGiSJVxc=;
  b=Gte2i+CYIIZsGFLsW/j7OC8jTM528uiHqMfxiVGOV6m3CRFdyux0JsFM
   qKh1icTnLZgse89DLF5C9GrO5s0p1rU3QTQjStCH8MWqtjVv+gR0W4anE
   F37q9GrkVaZw2cL1+xhoXScSlgIy3tsrgwyfzW5bh+L7IaPtm2//lmtHK
   DqWM9iuAOY+noL7FQaIW8y4kSdmM02SYqEzPvfIEcdjLoNf6WO1kiXgED
   JQQKcHifbUOQ1pgvwrMF8cuHYCZRv1pNjz4SUH0BLgoIEOxMxMEWkdawd
   uie8xdE9fyNAHBRyWR23PerGoBiNN5dJccGsiJaqaKzsvsK998xuKSPVY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="307861652"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="307861652"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 01:41:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="837914234"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="837914234"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 01:41:20 -0800
Date:   Mon, 30 Jan 2023 10:41:18 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Dave Airlie <airlied@redhat.com>,
        Melissa Wen <mwen@igalia.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] [v2] accel: fix CONFIG_DRM dependencies
Message-ID: <20230130094118.GA1627912@linux.intel.com>
References: <20230127221504.2522909-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127221504.2522909-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:14:55PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> At the moment, accel drivers can be built-in even with CONFIG_DRM=m,
> but this causes a link failure:
> 
> x86_64-linux-ld: drivers/accel/ivpu/ivpu_drv.o: in function `ivpu_dev_init':
> ivpu_drv.c:(.text+0x1535): undefined reference to `drmm_kmalloc'
> x86_64-linux-ld: ivpu_drv.c:(.text+0x1562): undefined reference to `drmm_kmalloc'
> x86_64-linux-ld: drivers/accel/ivpu/ivpu_drv.o: in function `ivpu_remove':
> ivpu_drv.c:(.text+0x1faa): undefined reference to `drm_dev_unregister'
> x86_64-linux-ld: drivers/accel/ivpu/ivpu_drv.o: in function `ivpu_probe':
> ivpu_drv.c:(.text+0x1fef): undefined reference to `__devm_drm_dev_alloc'
> 
> The problem is that DRM_ACCEL is a 'bool' symbol symbol, so driver that
> only depend on DRM_ACCEL but not also on DRM do not see the restriction
> to =m configs.
> 
> To ensure that each accel driver has an implied dependency on CONFIG_DRM,
> enclose the entire Kconfig file in an if/endif check.
> 
> Fixes: 8bf4889762a8 ("drivers/accel: define kconfig and register a new major")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
> v2: rearrage the DRM dependency rather than requiring DRM to be built-in
> ---
>  drivers/accel/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> index 834863902e16..c437206aa3f1 100644
> --- a/drivers/accel/Kconfig
> +++ b/drivers/accel/Kconfig
> @@ -6,9 +6,10 @@
>  # as, but not limited to, Machine-Learning and Deep-Learning acceleration
>  # devices
>  #
> +if DRM
> +
>  menuconfig DRM_ACCEL
>  	bool "Compute Acceleration Framework"
> -	depends on DRM
>  	help
>  	  Framework for device drivers of compute acceleration devices, such
>  	  as, but not limited to, Machine-Learning and Deep-Learning
> @@ -25,3 +26,5 @@ menuconfig DRM_ACCEL
>  
>  source "drivers/accel/habanalabs/Kconfig"
>  source "drivers/accel/ivpu/Kconfig"
> +
> +endif
> -- 
> 2.39.0
> 
