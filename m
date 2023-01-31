Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F86827E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAaJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjAaI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:59:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F84D4A223
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:55:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3641DB81A77
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC052C433D2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675155235;
        bh=JRJCmS7TbfihSxBfK2OlvDfGSJCL2cPfzKd3PSOst4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RybNy8tAs4k2ezl3eng8QvNLNFyszr7QK3GEFhw0PPllGdVe2Ad0wuleHN/euV3Mh
         TLEMXj6QNhgUUSIrydHn2HrVRCmn1DJRpc3Vb6JVBvEKuofh10w0KEDaXtWwSZ8zzE
         Qz9uSxx44FG3lxF5bDRcQSxqrI6kCXC+JSGLHw4+oabAD3NnLVlrGADpWfQ3wc5TMf
         ++QgLawWAZ3unVPuQdYV3JDfeR3luWHwTsFCxvsbGDpUxCUoSIlIsvIFlCYBSKzWJT
         NCV9pHXQkYM2rtpivWhjG71cpS2WRtTRwz9X1BpaeGefxBAQGBXX1zdyxVgO1TiHLp
         0/sj+Whfum8gg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5063029246dso194244177b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:53:55 -0800 (PST)
X-Gm-Message-State: AFqh2koyKmOE9S9AkWUpqpxBQex2RlIb7FTLtXhFsQV8FK9qxzrdtwQa
        ombGxR5yHEFmnw3LnzH95tH01a5DDK4bbenEGVU=
X-Google-Smtp-Source: AMrXdXt9H80BxARzMJJWDaxQGGFOEhNQbEiRDMS6HuGbtD0/x3qYCDvGhyZLLu6Gk5B3Ci3YWGlZ2hpvM4AKOSMrydU=
X-Received: by 2002:a81:14d3:0:b0:459:ef5d:529c with SMTP id
 202-20020a8114d3000000b00459ef5d529cmr8910623ywu.211.1675155234934; Tue, 31
 Jan 2023 00:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20230127221504.2522909-1-arnd@kernel.org>
In-Reply-To: <20230127221504.2522909-1-arnd@kernel.org>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 31 Jan 2023 10:53:28 +0200
X-Gmail-Original-Message-ID: <CAFCwf10RRFUqYEATg7p-LmKSEkFtAhneufJTdezFA7i3HJaDDw@mail.gmail.com>
Message-ID: <CAFCwf10RRFUqYEATg7p-LmKSEkFtAhneufJTdezFA7i3HJaDDw@mail.gmail.com>
Subject: Re: [PATCH] [v2] accel: fix CONFIG_DRM dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dave Airlie <airlied@redhat.com>, Melissa Wen <mwen@igalia.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 12:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
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
>         bool "Compute Acceleration Framework"
> -       depends on DRM
>         help
>           Framework for device drivers of compute acceleration devices, such
>           as, but not limited to, Machine-Learning and Deep-Learning
> @@ -25,3 +26,5 @@ menuconfig DRM_ACCEL
>
>  source "drivers/accel/habanalabs/Kconfig"
>  source "drivers/accel/ivpu/Kconfig"
> +
> +endif
> --
> 2.39.0
>
This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
