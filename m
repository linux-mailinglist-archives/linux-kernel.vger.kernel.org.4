Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5062BA28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiKPKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiKPKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:52:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4092220F6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:41:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE79C150C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:41:55 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BB7C3F663
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:41:49 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:41:41 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3 0/5] drm/arm/malidp: use drm managed
 resources
Message-ID: <Y3S+ZQ9gJVf9YYra@e110455-lin.cambridge.arm.com>
References: <20221026155934.125294-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026155934.125294-1-dakr@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 05:59:29PM +0200, Danilo Krummrich wrote:
> Hi,

Hi Danilo,

Sorry for the additional delay in reviewing and testing this series. I've now managed
to get enough of both to be happy with the series.

For the whole series: Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

I will push the series today to drm-misc-next.

Best regards,
Liviu

> 
> This patch series converts the driver to use drm managed resources to prevent
> potential use-after-free issues on driver unbind/rebind and to get rid of the
> usage of deprecated APIs.
> 
> Changes in v2:
>   - While protecting critical sections with drm_dev_{enter,exit} I forgot to
>     handle alternate return paths within the read-side critical sections, hence
>     fix them.
>   - Add a patch to remove explicit calls to drm_mode_config_cleanup() and switch
>     to drmm_mode_config_init() explicitly.
> 
> Changes in v3:
>   - Remove patches to protect platform device bound resources with
>     drm_dev_{enter,exit}, since this would leave the hardware enabled when
>     regularly unloading the driver e.g. via rmmod.
>     Instead do this in a later series, once we got drm_dev_unplug() in place
>     to deal with a regular driver shutdown.
> 
> Danilo Krummrich (5):
>   drm/arm/malidp: use drmm_* to allocate driver structures
>   drm/arm/malidp: replace drm->dev_private with drm_to_malidp()
>   drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
>   drm/arm/malidp: plane: use drm managed resources
>   drm/arm/malidp: remove calls to drm_mode_config_cleanup()
> 
>  drivers/gpu/drm/arm/malidp_crtc.c   |  7 ++-
>  drivers/gpu/drm/arm/malidp_drv.c    | 69 +++++++++++------------------
>  drivers/gpu/drm/arm/malidp_drv.h    |  2 +
>  drivers/gpu/drm/arm/malidp_hw.c     | 10 ++---
>  drivers/gpu/drm/arm/malidp_mw.c     |  6 +--
>  drivers/gpu/drm/arm/malidp_planes.c | 32 ++++---------
>  6 files changed, 48 insertions(+), 78 deletions(-)
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
