Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475D56922AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjBJPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:53:43 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC94B749;
        Fri, 10 Feb 2023 07:53:42 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142b72a728fso7156004fac.9;
        Fri, 10 Feb 2023 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSFRNBGbg5RyVjgWiI+7ths83CFO6oNClYx+2xqQNtI=;
        b=OcT4ZGtq/U5q/qWwcF2XlCd9Zdq0FB1Dxiqi/hbC43HgQS0TKqov6/Kfc2E0Qwo8WM
         flozifGrCLGtQcoEWhlje3bH5qUg9ARuzchUATFH3nA8ou0cYru3xPm1jaQPT5iuE/Xg
         MDk5QrF5f4c6NCttHF6q6bikO9CC+tg69Nx0sitFZVjMzKhYEzLjTUgYAOmuoNqwvh20
         Mofgm+6ZPOjHRS9S/gFOvPUYoyWlMBetMJakeypEOSV6qAprF87U58HhpLM8zH1+ThjD
         RDBWaAjaui98pVRdTFldn/yJK2PtZTreBfgG+DBeoAEA+MuQ4q+gjw/WiluXvgdG7SO4
         wm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSFRNBGbg5RyVjgWiI+7ths83CFO6oNClYx+2xqQNtI=;
        b=IKTRShxl0dC49MBSxbhm91FZAQJZlJYVihbbNayYowxCqTBFAB/1hTPWO5sOHzzOxk
         VPoD16Ss9MuuMeRDtTXs/UP3/kmqDFh/kb/dLZ5avgUcxypLta4FEa/a9BIBXJKxImBz
         SXBygNuX+T+uJzBGFdOrs0YH9O9ugGz+QgV1CulJpcNyEHWoSYsKYQLzRk59VTMTMRTV
         JzcFMXRpDh+gh4HP1yi5rs95LOlp9nq+/bQAduZDJPGvTDxI97CLEneZArz52jZbVsgo
         KZW0bqKPTW6b0wtWXUxHGHDQQy+YgW8faCf4qtsWZcuukYJMlw6mRed74p13MRQ1c61T
         9WoQ==
X-Gm-Message-State: AO0yUKX6wFtXm4mwpA82EeYP3JfjbWwgaylzek/s3vbeJWmf42YyyGde
        uchy51g9NMiiQ4LsD3OEw1VvYxK3ndwPB3GT1lw=
X-Google-Smtp-Source: AK7set+qcoWEy9BYLGru9/034H+UQQd/562uEsdB2l51urNRCUIVKIl8Rlv7cIg64dgBI4M0+lgIJ0rB927Y0qI3KvQ=
X-Received: by 2002:a05:6870:13d1:b0:163:a303:fe2f with SMTP id
 17-20020a05687013d100b00163a303fe2fmr1456936oat.96.1676044421471; Fri, 10 Feb
 2023 07:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20230210044826.9834-1-orlandoch.dev@gmail.com> <20230210044826.9834-10-orlandoch.dev@gmail.com>
In-Reply-To: <20230210044826.9834-10-orlandoch.dev@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 10 Feb 2023 10:53:28 -0500
Message-ID: <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client for
 all GPUs that are not thunderbolt attached
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Airlie <airlied@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Evan Quan <evan.quan@amd.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Aditya Garg <gargaditya08@live.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

On Fri, Feb 10, 2023 at 3:04 AM Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
>
> From: Kerem Karabay <kekrby@gmail.com>
>
> Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
> vga_switcheroo") made amdgpu only register a vga_switcheroo client for
> GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
> register, but don't have PX. Instead of AMD's PX, they use apple-gmux.

Is there a way to detect apple-gmux instead?  Otherwise, we register
vga_switcheroo on any system with multiple GPUs which is not what we
want.

Alex

>
> Revert to the old logic of registering for all non-thunderbolt gpus,
> like radeon and nouveau.
>
> Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> [Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit description]
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f28a8c02f64..0bb553a61552 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3919,12 +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>                 vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>
> -       if (amdgpu_device_supports_px(ddev)) {
> -               px = true;
> -               vga_switcheroo_register_client(adev->pdev,
> -                                              &amdgpu_switcheroo_ops, px);
> +       px = amdgpu_device_supports_px(ddev);
> +
> +       if (!pci_is_thunderbolt_attached(adev->pdev))
> +               vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, px);
> +
> +       if (px)
>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
> -       }
>
>         if (adev->gmc.xgmi.pending_reset)
>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
> @@ -4048,10 +4049,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>
>         kfree(adev->bios);
>         adev->bios = NULL;
> -       if (amdgpu_device_supports_px(adev_to_drm(adev))) {
> +
> +       if (!pci_is_thunderbolt_attached(adev->pdev))
>                 vga_switcheroo_unregister_client(adev->pdev);
> +
> +       if (amdgpu_device_supports_px(adev_to_drm(adev)))
>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
> -       }
> +
>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>                 vga_client_unregister(adev->pdev);
>
> --
> 2.39.1
>
