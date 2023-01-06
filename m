Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A98660361
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjAFPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjAFPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:37:07 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B773E3A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:37:05 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id o66so1321981oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Lsgx2uhO7z4CHG2k1K2w4zI9yimLeqiU/9EtWNEoo=;
        b=lY6ch6bC/40KLG9mnt+CylGg8Eoz9M5px1aalq63jDvpC6EugfvNgleQwQIWDV22fO
         7skJgcKXhpWIjZMfgwCfMCnwM8lDCZUtamk1nRB6+vspSTyOPYmU0mRneFVxKaJg37Nc
         qVA6vjlJFP9OgFzesD009lwZmUU8adxVpGDgg+5YPByL2IHNTM0aTUGDa54KI20wmI+l
         AOl/LAtA4a9mtclhW2WQgxw9v67hIt4ECtn0IuE14sN0cf8aav93RGRrSLTx/W9S8nQz
         rNTeC8wtsrABwumlZUG6edCyHuJUdFAjrrnzwPfAiR1KmajXFbETGLZVG3J+qs3URWwz
         yqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/Lsgx2uhO7z4CHG2k1K2w4zI9yimLeqiU/9EtWNEoo=;
        b=AyCFmMIvJRbY087OzJGikBZSLrCVhz0LDQJKwLnzDBgxbwLFlRI6ZkdllFHEgaOMUG
         0k+8nzw8eYVbvJ6NVQpyXTi8EQ7J+Kj7QO7wsRm78mwU2Z1ozHCWeEPOMsoZFfiNhLkN
         kN9PsOoLvIel56oh7Cn8925YX/pWjV/pFvN2rRNrblS+s6P64HQHY/rNTJ5i/af9ltW4
         tiS66IPhgXZGduKURVs9sFO4Krze9aEH1kZg5TTNBEsnW2ycBUhLVfdhctSghV5d9c0e
         7CAlv4JKNYFayuCZZijwVL9T02U5chN7T7tNsDEfzXuMe/duHQ1/9EDjgWPlIkCIPGHT
         cOag==
X-Gm-Message-State: AFqh2kqmypszUyWJtsUvanT8A41B25KyBMjCPj+i+7py/k1sixtlNOG9
        Qicd4CHll42wwZIvI6JYVSApTWJOqEpYEY2ZZ9M=
X-Google-Smtp-Source: AMrXdXtmjcKgHjr8tNu+gLgPcd6cIQNYsyzt9AUdpP3VHWJ+8Nge3tJ8QQ84K748sLuDZ8RST6ayQ7S8v6s5tiVNoSM=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr3590248oiw.96.1673019425141; Fri, 06 Jan
 2023 07:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20230106094729.38598-1-liwei.song@windriver.com>
In-Reply-To: <20230106094729.38598-1-liwei.song@windriver.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 Jan 2023 10:36:53 -0500
Message-ID: <CADnq5_Mu-9_HoH9PULANvWS39D0Sra+nxodwFspH-TXX_3GJKA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: free iio for atombios when driver shutdown
To:     Liwei Song <liwei.song@windriver.com>
Cc:     AlexDeucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?ChristianK=C3=B6nig?= <christian.koenig@amd.com>,
        PanXinhui <Xinhui.Pan@amd.com>, DavidAirlie <airlied@gmail.com>,
        DanielVetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jan 6, 2023 at 5:00 AM Liwei Song <liwei.song@windriver.com> wrote:
>
> Fix below kmemleak when unload radeon driver:
>
> unreferenced object 0xffff9f8608ede200 (size 512):
>   comm "systemd-udevd", pid 326, jiffies 4294682822 (age 716.338s)
>   hex dump (first 32 bytes):
>     00 00 00 00 c4 aa ec aa 14 ab 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000062fadebe>] kmem_cache_alloc_trace+0x2f1/0x500
>     [<00000000b6883cea>] atom_parse+0x117/0x230 [radeon]
>     [<00000000158c23fd>] radeon_atombios_init+0xab/0x170 [radeon]
>     [<00000000683f672e>] si_init+0x57/0x750 [radeon]
>     [<00000000566cc31f>] radeon_device_init+0x559/0x9c0 [radeon]
>     [<0000000046efabb3>] radeon_driver_load_kms+0xc1/0x1a0 [radeon]
>     [<00000000b5155064>] drm_dev_register+0xdd/0x1d0
>     [<0000000045fec835>] radeon_pci_probe+0xbd/0x100 [radeon]
>     [<00000000e69ecca3>] pci_device_probe+0xe1/0x160
>     [<0000000019484b76>] really_probe.part.0+0xc1/0x2c0
>     [<000000003f2649da>] __driver_probe_device+0x96/0x130
>     [<00000000231c5bb1>] driver_probe_device+0x24/0xf0
>     [<0000000000a42377>] __driver_attach+0x77/0x190
>     [<00000000d7574da6>] bus_for_each_dev+0x7f/0xd0
>     [<00000000633166d2>] driver_attach+0x1e/0x30
>     [<00000000313b05b8>] bus_add_driver+0x12c/0x1e0
>
> iio was allocated in atom_index_iio() called by atom_parse(),
> but it doesn't got released when the dirver is shutdown.
> Fix this kmemleak by free it in radeon_atombios_fini().
>
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 92905ebb7b45..1c005e0ddd38 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1022,6 +1022,7 @@ void radeon_atombios_fini(struct radeon_device *rdev)
>  {
>         if (rdev->mode_info.atom_context) {
>                 kfree(rdev->mode_info.atom_context->scratch);
> +               kfree(rdev->mode_info.atom_context->iio);
>         }
>         kfree(rdev->mode_info.atom_context);
>         rdev->mode_info.atom_context = NULL;
> --
> 2.33.1
>
