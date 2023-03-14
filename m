Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EECF6B98E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjCNPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCNPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:23:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DB9CFFE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:23:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id be16so12103226oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678807390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZthyf9O7m+4xnS4ELJlsYXDAkPMiY/lLsht07DclGg=;
        b=i9GIoQK6IG1EhUNatHWrIDXSgiVA6QYilOjlsQcjN6aAjRokymSQMk/MpQVe2k8k3P
         X4+1BRavCnPk3i77vvRPiuAFNpeFa1aqA72h6R9FqtmLQtTnvbGHT77xWXDHOig3gdYh
         apn/OHfsZf0qK/RziVA5noSb3R5Zsb3HI2VNqkC6YkvjCL/Cyq9yHHqas/vAjltC/rYZ
         w8Z4Qmk+H6pSCHNmiNKVtO0nZkuFYvsEOsI5E3wZRRBm6kKQFOuhqdSVRyslrKe+tJAg
         kusYYbrF+vSWYZjkuPGk5XZF7uecTdi3BholAmn/Deatgd45JrwqN/QoSplSc1+CQdS6
         tkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZthyf9O7m+4xnS4ELJlsYXDAkPMiY/lLsht07DclGg=;
        b=5N9TMwiXkJfY/zUykKIj3ZOA4dyRxkB31V54yP+JhsWXVbir2xmH9Pn0qpkdjD8Fy/
         9VYakfeUpd1fwDyrsx05rF744OG++eKuqz/JtQyKPvqjOLgenNIGQZ7N2zZgWgcnHkIg
         v96afUi/HB3hudHky1igqTtdXIYHavVYVzvR+jXY//yGq5D/+hJ5D1oGwB2eVMM/ov+Y
         brr4FIc3HBzJ/trJh9NeUvtbaeI7TMNCD3nKzxBLMyvGBoV7SPIOZ8+Y1pHdQuTckYdg
         zPD8DATVoZbEXeJgBn3Lqy6iHw7lsLRhIOgpj3421RmHM+OalQLYkKeOyFa40c8w4Ieb
         PlBQ==
X-Gm-Message-State: AO0yUKWHCOn629/R7Hh2VtzYNg4ZLKCl+Q+iW8Unn9c+j2OEy7p4Xpe5
        +yLwJ48UCNQXez4E9gSrfBSmOaT5wGAWxRAs3BVgGaKO
X-Google-Smtp-Source: AK7set94v1q4xLwDYtzPczh6Lmqc0MOw4TXfK+D1Yib/S6HGBlKAmKq/i19ZBpZ6z/63O59YIBlMj08NJipEKwDHlRM=
X-Received: by 2002:a05:6808:354:b0:37f:b1b8:4a19 with SMTP id
 j20-20020a056808035400b0037fb1b84a19mr11212188oie.3.1678807390120; Tue, 14
 Mar 2023 08:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230314042605.346458-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230314042605.346458-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 14 Mar 2023 11:22:56 -0400
Message-ID: <CADnq5_OkFhONSKn2DbGhxaXyaSjzu0RBnydd99wgsVudxW3kxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/nv: Apply ASPM quirk on Intel ADL + AMD Navi
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
        dri-devel@lists.freedesktop.org, YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
        Evan Quan <evan.quan@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
        Richard Gong <richard.gong@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        linux-kernel@vger.kernel.org, Leo Liu <leo.liu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:35=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> S2idle resume freeze can be observed on Intel ADL + AMD WX5500. This is
> caused by commit 0064b0ce85bb ("drm/amd/pm: enable ASPM by default").
>
> The root cause is still not clear for now.
>
> So extend and apply the ASPM quirk from commit e02fe3bc7aba
> ("drm/amdgpu: vi: disable ASPM on Intel Alder Lake based systems"), to
> workaround the issue on Navi cards too.
>
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2458
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c            | 15 ---------------
>  4 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 164141bc8b4a..c697580f1ee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1272,6 +1272,7 @@ void amdgpu_device_pci_config_reset(struct amdgpu_d=
evice *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> +bool aspm_support_quirk_check(void);
>
>  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_by=
tes,
>                                   u64 num_vis_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c4a4e2fe6681..c09f19385628 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -80,6 +80,10 @@
>
>  #include <drm/drm_drv.h>
>
> +#if IS_ENABLED(CONFIG_X86)
> +#include <asm/intel-family.h>
> +#endif
> +
>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> @@ -1356,6 +1360,17 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_d=
evice *adev)
>         return pcie_aspm_enabled(adev->pdev);
>  }
>
> +bool aspm_support_quirk_check(void)

For consistency with naming, rename this
amdgpu_device_aspm_support_quirk().  Other than that, looks good to
me.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> +{
> +#if IS_ENABLED(CONFIG_X86)
> +       struct cpuinfo_x86 *c =3D &cpu_data(0);
> +
> +       return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_FAM6_ALDERL=
AKE);
> +#else
> +       return true;
> +#endif
> +}
> +
>  /* if we get transitioned to only one device, take VGA back */
>  /**
>   * amdgpu_device_vga_set_decode - enable/disable vga decode
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 855d390c41de..921adf66e3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -578,7 +578,7 @@ static void nv_pcie_gen3_enable(struct amdgpu_device =
*adev)
>
>  static void nv_program_aspm(struct amdgpu_device *adev)
>  {
> -       if (!amdgpu_device_should_use_aspm(adev))
> +       if (!amdgpu_device_should_use_aspm(adev) || !aspm_support_quirk_c=
heck())
>                 return;
>
>         if (!(adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index 12ef782eb478..e61ae372d674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -81,10 +81,6 @@
>  #include "mxgpu_vi.h"
>  #include "amdgpu_dm.h"
>
> -#if IS_ENABLED(CONFIG_X86)
> -#include <asm/intel-family.h>
> -#endif
> -
>  #define ixPCIE_LC_L1_PM_SUBSTATE       0x100100C6
>  #define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK       0=
x00000001L
>  #define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK   0x0000000=
2L
> @@ -1138,17 +1134,6 @@ static void vi_enable_aspm(struct amdgpu_device *a=
dev)
>                 WREG32_PCIE(ixPCIE_LC_CNTL, data);
>  }
>
> -static bool aspm_support_quirk_check(void)
> -{
> -#if IS_ENABLED(CONFIG_X86)
> -       struct cpuinfo_x86 *c =3D &cpu_data(0);
> -
> -       return !(c->x86 =3D=3D 6 && c->x86_model =3D=3D INTEL_FAM6_ALDERL=
AKE);
> -#else
> -       return true;
> -#endif
> -}
> -
>  static void vi_program_aspm(struct amdgpu_device *adev)
>  {
>         u32 data, data1, orig;
> --
> 2.34.1
>
