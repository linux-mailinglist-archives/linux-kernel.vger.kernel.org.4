Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC07C67E159
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjA0KR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjA0KRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:17:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1154134016
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674814637; x=1706350637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=55TvKFgIeJ9Ccx613u9iCST4aYVD68p4Vcl3AOnOUm8=;
  b=VsmSZlqWcUxZDE2BvDMUeHPlC8adRTlIbYN0KKVpMz6qYsgLxE7Wqjjd
   pyafs8pFw05caHluDOJFAWVnkBEwmXdAZMXBRrwdOEyHcjEbhuCYqFklg
   YOmzl/5Lv/dtxmgq6CrE4D725lyiT/QQUwr2zNAnZt0ZIZpgJxdbHAVuz
   IfFpbL0NYn1xcXdgFB1Wfh/wVT1CLQNtew+JFWisuLwPse7D/q8CdOkNF
   43LwdBnxnyqWZSmaUPwKKQjDBeodDxG6MT484I9mpNrvpNH67RAObHi0S
   Lic+uJUWc6TE2+3hyVgwrvtek4LHgssdxUaCoxJL5Rc1hq3GidS63DbBk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329184899"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="329184899"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:17:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="663213467"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="663213467"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:17:03 -0800
Date:   Fri, 27 Jan 2023 11:17:01 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Melissa Wen <mwen@igalia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel: work around DRM_ACCEL dependencies
Message-ID: <20230127101701.GA1416485@linux.intel.com>
References: <20230127093631.2132187-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127093631.2132187-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Jan 27, 2023 at 10:36:20AM +0100, Arnd Bergmann wrote:
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

Ehh, this should not happen.

> This could be avoided by making DRM_ACCEL a tristate symbol, which
> would mean that every ACCEL driver is guarantee to be able to link
> against DRM as well. However, having both as =m causes another link
> failure because the DRM core code also links against the accel driver:
>
> x86_64-linux-ld: drivers/gpu/drm/drm_drv.o: in function `drm_minor_register':
> drm_drv.c:(.text+0x259): undefined reference to `accel_debugfs_init'
> x86_64-linux-ld: drm_drv.c:(.text+0x298): undefined reference to `accel_minor_replace'
> 
> I think it will be necessary to establish a link hierarchy between drm.ko
> and drm_accel.ko to avoid circular dependencies like this, but until then
> the only way that both can be used is to have both subsystems built into
> the kernel. Enforce this using a Kconfig dependency.

Hmm, it was discussed a bit before and conclusion was that accel will be
compiled in drm.ko to avoid circular dependencies. There should be
no drm_accel.ko module.

> Fixes: 8bf4889762a8 ("drivers/accel: define kconfig and register a new major")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/accel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> index 834863902e16..dd18d3b2028c 100644
> --- a/drivers/accel/Kconfig
> +++ b/drivers/accel/Kconfig
> @@ -8,7 +8,7 @@
>  #
>  menuconfig DRM_ACCEL
>  	bool "Compute Acceleration Framework"
> -	depends on DRM
> +	depends on DRM=y

Would making ivpu Kconfig:

depends on DRM
select DRM_ACCEL

solve the problem and still allow to drm to be build as module ? 

Regards
Stanislaw

