Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54850619FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKDSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiKDSUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:20:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 487E610C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:20:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3D51FB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:20:49 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6982F3F5A1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:20:43 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:20:36 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v4 0/4] drm/arm/hdlcd: use drm managed
 resources
Message-ID: <Y2VX9Egvh91/u9es@e110455-lin.cambridge.arm.com>
References: <20221026153431.72033-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026153431.72033-1-dakr@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 05:34:27PM +0200, Danilo Krummrich wrote:
> Hi,

Hi Danilo,

> 
> This patch series converts the driver to use drm managed resources to prevent
> potential use-after-free issues on driver unbind/rebind and to get rid of the
> usage of deprecated APIs.
> 
> Changes in v2:
>   - drop patch "drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()"
> 
> Changes in v3:
>   - Fix alternate return paths in srcu read-side critical sections causing a
>     stall when unregistering the driver.
>   - Fix potential null pointer dereference in hdlcd_crtc_cleanup() introduced
>     dropping the patch in v2.
>   - Add a patch to remove explicit calls to drm_mode_config_cleanup().
> 
> Changes in v4:
>   - Remove patches to protect platform device bound resources with
>     drm_dev_{enter,exit}, since this would leave the hardware enabled when
>     regularly unloading the driver e.g. via rmmod.
>     Instead do this in a later series, once we got drm_dev_unplug() in place
>     to deal with a regular driver shutdown.

This series is in a much better shape compared to the existing status quo. rmmod
works without any issue and I can re-insmod the driver again.

The only issue that I'm seeing that is not critical is that at reboot/shutdown time
I'm getting an "Unexpected global fault, this could be serious" from the smmu:

[ 6893.467910] arm-smmu 7fb30000.iommu: disabling translation
[ 6893.473550] ohci-platform 7ffb0000.usb: Removing from iommu group 1
[ 6893.479909] ehci-platform 7ffc0000.usb: Removing from iommu group 1
[ 6893.486931] arm-smmu 7fb10000.iommu: disabling translation
[ 6893.492521] hdlcd 7ff50000.hdlcd: Removing from iommu group 3
[ 6893.492650] arm-smmu 7fb10000.iommu: Unexpected global fault, this could be serious
[ 6893.505959] arm-smmu 7fb10000.iommu:         GFSR 0x80000001, GFSYNR0 0x00000000, GFSYNR1 0x00000000, GFSYNR2 0x00000000
[ 6893.516511] arm-smmu 7fb00000.iommu: disabling translation
[ 6893.522195] dma-pl330 7ff00000.dma-controller: Removing from iommu group 2
[ 6893.529607] arm-smmu 2b500000.iommu: disabling translation
[ 6893.535221] pcieport 0000:00:00.0: Removing from iommu group 0
[ 6893.541135] pci 0000:01:00.0: Removing from iommu group 0
[ 6893.546604] pcieport 0000:02:01.0: Removing from iommu group 0
[ 6893.552511] pcieport 0000:02:02.0: Removing from iommu group 0
[ 6893.558418] pcieport 0000:02:03.0: Removing from iommu group 0
[ 6893.564329] pcieport 0000:02:0c.0: Removing from iommu group 0
[ 6893.570393] pcieport 0000:02:10.0: Removing from iommu group 0
[ 6893.576314] pcieport 0000:02:1f.0: Removing from iommu group 0
[ 6893.582214] sata_sil24 0000:03:00.0: Removing from iommu group 0
[ 6893.588270] sky2 0000:08:00.0: Removing from iommu group 0
[ 6893.594616] reboot: Power down


The reboot/shutdown succeeds, so I'm not too worried about it for now, but hope that
this is something you'll keep in mind in the later series when you do drm_dev_unplug().

With that, for the whole series:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patience and going through the series iterations with me.

I can pull this series into drm-misc-next on Monday if you don't have any other plans.

Best regards,
Liviu

> 
> Danilo Krummrich (4):
>   drm/arm/hdlcd: use drmm_* to allocate driver structures
>   drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
>   drm/arm/hdlcd: plane: use drm managed resources
>   drm/arm/hdlcd: remove calls to drm_mode_config_cleanup()
> 
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 24 +++++++------------
>  drivers/gpu/drm/arm/hdlcd_drv.c  | 41 ++++++++++++++++----------------
>  drivers/gpu/drm/arm/hdlcd_drv.h  |  2 ++
>  3 files changed, 32 insertions(+), 35 deletions(-)
> 
> 
> base-commit: e1e7bc481d49c3e3ada11029ce0d9b85a0a539d7
> -- 
> 2.37.3
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
