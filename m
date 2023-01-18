Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86392671B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjARLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjARLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:48:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45BEC5CE5F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:09:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E81D1477;
        Wed, 18 Jan 2023 03:10:00 -0800 (PST)
Received: from [10.1.28.26] (e122027.cambridge.arm.com [10.1.28.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60473F445;
        Wed, 18 Jan 2023 03:09:16 -0800 (PST)
Message-ID: <18260f9c-2e2e-1210-7203-ac3b79f7da2a@arm.com>
Date:   Wed, 18 Jan 2023 11:09:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/panfrost: fix GENERIC_ATOMIC64 dependency
To:     Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20230117164456.1591901-1-arnd@kernel.org>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230117164456.1591901-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 16:44, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On ARMv5 and earlier, a randconfig build can still run into
> 
> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM [=y] || ARM64 || COMPILE_TEST [=y]) && !GENERIC_ATOMIC64 [=y]
>   Selected by [y]:
>   - DRM_PANFROST [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARM [=y] || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y]) && MMU [=y]
> 
> Rework the dependencies to always require a working cmpxchg64.
> 
> Fixes: db594ba3fcf9 ("drm/panfrost: depend on !GENERIC_ATOMIC64 when using COMPILE_TEST")

Looking at db594ba3fcf9 - it states:

>     Since panfrost has a 'select' on IOMMU_IO_PGTABLE_LPAE we must depend on
>     the same set of flags. Otherwise IOMMU_IO_PGTABLE_LPAE will be forced on
>     even though it cannot build (no support for cmpxchg64).

And at the time the dependencies on IOMMU_IO_PGTABLE_LPAE were exactly
these.

However d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
(currently in the iommu tree) changed the depends to split the
!GENERIC_ATOMIC64 out. So we could argue that really that's the commit
that should be blamed in the fixes line.

However there's no harm in this being backported further than it
strictly needs to be, and it's clearly better having the
!GENERIC_ATOMIC64 split out. So I'll merge this to drm-misc-fixes.

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks!

Steve

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/panfrost/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/Kconfig b/drivers/gpu/drm/panfrost/Kconfig
> index 079600328be1..e6403a9d66ad 100644
> --- a/drivers/gpu/drm/panfrost/Kconfig
> +++ b/drivers/gpu/drm/panfrost/Kconfig
> @@ -3,7 +3,8 @@
>  config DRM_PANFROST
>  	tristate "Panfrost (DRM support for ARM Mali Midgard/Bifrost GPUs)"
>  	depends on DRM
> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on !GENERIC_ATOMIC64    # for IOMMU_IO_PGTABLE_LPAE
>  	depends on MMU
>  	select DRM_SCHED
>  	select IOMMU_SUPPORT

