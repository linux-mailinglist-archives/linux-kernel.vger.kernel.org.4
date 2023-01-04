Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFCE65DB03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjADRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjADRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:16:10 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D52D2EF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:16:09 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so21115591otp.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7KENzpgraJEUniVnBFGmdFZ+oGMoQCkV6H0MhS8ffL4=;
        b=kmc3o1f0rE8CmUIWc/jVXSxNPYJ0O3Rjq8XHVZa6nMeoUFJGrK92Zn2Ayyb8DQQwVu
         ADtJn+MWCfx0KAoP7hzR/BKkrDkplI+VcFK6eTRvzAgWxlhpDoDSI8DmD+Ittx0U6ZhY
         MH8Foc5aNbhjbM0ceIe/yVwAq93yoH3C5wOjEgWfmF/yuEvCk+jUs1svB70dShs5SGFF
         QKoE2xgRo7dWT1p/4NyDl2CsEhye4R+1iA/QMpzVH32ED9uJLMIy2ff04gzioOOufXjy
         /83aKf12NskMriK1XVmnlB31JVX1cVNR4mL62Dne9+a53Xmj5cktSOamx46Y1yXtNGHR
         zICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KENzpgraJEUniVnBFGmdFZ+oGMoQCkV6H0MhS8ffL4=;
        b=rd1xqw0LYWVK3gB+2WswTrHY+Sh9ZMJYeJzaFyerNCn8V2KxEbaGbI0yX8ylaAmyON
         VR4itr+YxWAu0BfPubH9biloCXd0yMRNw3dBZW7PQFUWbwNAQJTVLzwQobwFrziSxw7J
         5qTjyKBys5bgjyOyygyQXng4wWzpl5+uHR0xpFIB29eYHtI4KdetKX3SfpVagfMHdwi5
         gDMEzFdEA99fG+sulth3zA8+c+TOgEtHBt3LETEfngfQAE3NPhDckmsRfSmucz2rel69
         +DkXF8wtecpxxS2EJgc4tZzPyzVeSqGn4PCZDPpyNO8BzPdofsPOoBhiin80j32k3dFd
         glEA==
X-Gm-Message-State: AFqh2kr64hFta6xU0APonL0JAUO55nDT3FVSR/mZ5D8gUnrLG2fXYtf8
        dp/KqGBkb2b0vdbOF1YkNTJwlNOcTqlo/W4MfhFnRu0+
X-Google-Smtp-Source: AMrXdXvzjjQ3mhqe5V0QYzRn1WRByGhfqs+vit71DOT4RswGFghGVTFpFk8hu86YHlo8ux6DHDHF7Xswy/WmYqw2Xc8=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr3036539otq.233.1672852568335; Wed, 04
 Jan 2023 09:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20230104164042.30271-1-mario.limonciello@amd.com> <20230104164042.30271-11-mario.limonciello@amd.com>
In-Reply-To: <20230104164042.30271-11-mario.limonciello@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 Jan 2023 12:15:56 -0500
Message-ID: <CADnq5_PUnPH_WS8RLZwC=8skmp0_6sr8o=rEioiWL=0dVdn-Mg@mail.gmail.com>
Subject: Re: [PATCH v5 10/45] drm/amd: Load VCN microcode during early_init
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lazar Lijo <Lijo.Lazar@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        christian.koenig@amd.com
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

On Wed, Jan 4, 2023 at 11:42 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Simplifies the code so that all VCN versions will get the firmware
> name from `amdgpu_ucode_ip_version_decode` and then use this filename
> to load microcode as part of the early_init process.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 91 +++++++++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
>  7 files changed, 50 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b5692f825589..55bbe4c8ff5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -36,25 +36,25 @@
>  #include "soc15d.h"
>
>  /* Firmware Names */
> -#define FIRMWARE_RAVEN         "amdgpu/raven_vcn.bin"
> -#define FIRMWARE_PICASSO       "amdgpu/picasso_vcn.bin"
> -#define FIRMWARE_RAVEN2                "amdgpu/raven2_vcn.bin"
> -#define FIRMWARE_ARCTURUS      "amdgpu/arcturus_vcn.bin"
> -#define FIRMWARE_RENOIR                "amdgpu/renoir_vcn.bin"
> -#define FIRMWARE_GREEN_SARDINE "amdgpu/green_sardine_vcn.bin"
> -#define FIRMWARE_NAVI10                "amdgpu/navi10_vcn.bin"
> -#define FIRMWARE_NAVI14                "amdgpu/navi14_vcn.bin"
> -#define FIRMWARE_NAVI12                "amdgpu/navi12_vcn.bin"
> -#define FIRMWARE_SIENNA_CICHLID        "amdgpu/sienna_cichlid_vcn.bin"
> -#define FIRMWARE_NAVY_FLOUNDER "amdgpu/navy_flounder_vcn.bin"
> -#define FIRMWARE_VANGOGH       "amdgpu/vangogh_vcn.bin"
> -#define FIRMWARE_DIMGREY_CAVEFISH      "amdgpu/dimgrey_cavefish_vcn.bin"
> -#define FIRMWARE_ALDEBARAN     "amdgpu/aldebaran_vcn.bin"
> -#define FIRMWARE_BEIGE_GOBY    "amdgpu/beige_goby_vcn.bin"
> -#define FIRMWARE_YELLOW_CARP   "amdgpu/yellow_carp_vcn.bin"
> -#define FIRMWARE_VCN_3_1_2     "amdgpu/vcn_3_1_2.bin"
> -#define FIRMWARE_VCN4_0_0      "amdgpu/vcn_4_0_0.bin"
> -#define FIRMWARE_VCN4_0_2      "amdgpu/vcn_4_0_2.bin"
> +#define FIRMWARE_RAVEN         "amdgpu/raven_vcn.bin"
> +#define FIRMWARE_PICASSO       "amdgpu/picasso_vcn.bin"
> +#define FIRMWARE_RAVEN2                "amdgpu/raven2_vcn.bin"
> +#define FIRMWARE_ARCTURUS      "amdgpu/arcturus_vcn.bin"
> +#define FIRMWARE_RENOIR                "amdgpu/renoir_vcn.bin"
> +#define FIRMWARE_GREEN_SARDINE "amdgpu/green_sardine_vcn.bin"
> +#define FIRMWARE_NAVI10                "amdgpu/navi10_vcn.bin"
> +#define FIRMWARE_NAVI14                "amdgpu/navi14_vcn.bin"
> +#define FIRMWARE_NAVI12                "amdgpu/navi12_vcn.bin"
> +#define FIRMWARE_SIENNA_CICHLID        "amdgpu/sienna_cichlid_vcn.bin"
> +#define FIRMWARE_NAVY_FLOUNDER "amdgpu/navy_flounder_vcn.bin"
> +#define FIRMWARE_VANGOGH       "amdgpu/vangogh_vcn.bin"
> +#define FIRMWARE_DIMGREY_CAVEFISH      "amdgpu/dimgrey_cavefish_vcn.bin"
> +#define FIRMWARE_ALDEBARAN     "amdgpu/aldebaran_vcn.bin"
> +#define FIRMWARE_BEIGE_GOBY    "amdgpu/beige_goby_vcn.bin"
> +#define FIRMWARE_YELLOW_CARP   "amdgpu/yellow_carp_vcn.bin"
> +#define FIRMWARE_VCN_3_1_2     "amdgpu/vcn_3_1_2.bin"
> +#define FIRMWARE_VCN4_0_0      "amdgpu/vcn_4_0_0.bin"
> +#define FIRMWARE_VCN4_0_2      "amdgpu/vcn_4_0_2.bin"
>  #define FIRMWARE_VCN4_0_4      "amdgpu/vcn_4_0_4.bin"

Is this just a whitespace change?

Alex

>
>  MODULE_FIRMWARE(FIRMWARE_RAVEN);
> @@ -80,10 +80,24 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
>
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev)
> +{
> +       char ucode_prefix[30];
> +       char fw_name[40];
> +       int r;
> +
> +       amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
> +       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
> +       r = amdgpu_ucode_request(adev, &adev->vcn.fw, fw_name);
> +       if (r)
> +               amdgpu_ucode_release(adev->vcn.fw);
> +
> +       return r;
> +}
> +
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>  {
>         unsigned long bo_size;
> -       const char *fw_name;
>         const struct common_firmware_header *hdr;
>         unsigned char fw_check;
>         unsigned int fw_shared_size, log_offset;
> @@ -99,46 +113,27 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>         switch (adev->ip_versions[UVD_HWIP][0]) {
>         case IP_VERSION(1, 0, 0):
>         case IP_VERSION(1, 0, 1):
> -               if (adev->apu_flags & AMD_APU_IS_RAVEN2)
> -                       fw_name = FIRMWARE_RAVEN2;
> -               else if (adev->apu_flags & AMD_APU_IS_PICASSO)
> -                       fw_name = FIRMWARE_PICASSO;
> -               else
> -                       fw_name = FIRMWARE_RAVEN;
> -               break;
>         case IP_VERSION(2, 5, 0):
> -               fw_name = FIRMWARE_ARCTURUS;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(2, 2, 0):
> -               if (adev->apu_flags & AMD_APU_IS_RENOIR)
> -                       fw_name = FIRMWARE_RENOIR;
> -               else
> -                       fw_name = FIRMWARE_GREEN_SARDINE;
> -
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(2, 6, 0):
> -               fw_name = FIRMWARE_ALDEBARAN;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(2, 0, 0):
> -               fw_name = FIRMWARE_NAVI10;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(2, 0, 2):
> -               if (adev->asic_type == CHIP_NAVI12)
> -                       fw_name = FIRMWARE_NAVI12;
> -               else
> -                       fw_name = FIRMWARE_NAVI14;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
> @@ -146,58 +141,46 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>         case IP_VERSION(3, 0, 0):
>         case IP_VERSION(3, 0, 64):
>         case IP_VERSION(3, 0, 192):
> -               if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
> -                       fw_name = FIRMWARE_SIENNA_CICHLID;
> -               else
> -                       fw_name = FIRMWARE_NAVY_FLOUNDER;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(3, 0, 2):
> -               fw_name = FIRMWARE_VANGOGH;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(3, 0, 16):
> -               fw_name = FIRMWARE_DIMGREY_CAVEFISH;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(3, 0, 33):
> -               fw_name = FIRMWARE_BEIGE_GOBY;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(3, 1, 1):
> -               fw_name = FIRMWARE_YELLOW_CARP;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(3, 1, 2):
> -               fw_name = FIRMWARE_VCN_3_1_2;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(4, 0, 0):
> -               fw_name = FIRMWARE_VCN4_0_0;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                         (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(4, 0, 2):
> -               fw_name = FIRMWARE_VCN4_0_2;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                         (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
>         case IP_VERSION(4, 0, 4):
> -               fw_name = FIRMWARE_VCN4_0_4;
>                 if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>                         (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
> @@ -206,12 +189,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                 return -EINVAL;
>         }
>
> -       r = amdgpu_ucode_request(adev, &adev->vcn.fw, fw_name);
> -       if (r) {
> -               amdgpu_ucode_release(adev->vcn.fw);
> -               return r;
> -       }
> -
>         hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
>         adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index dbb8d68a30c6..d3e2af902907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -369,6 +369,7 @@ enum vcn_ring_type {
>         VCN_UNIFIED_RING,
>  };
>
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev);
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index f0fbcda76f5e..c305b2cb8490 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -57,11 +57,12 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work);
>  static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
>
>  /**
> - * vcn_v1_0_early_init - set function pointers
> + * vcn_v1_0_early_init - set function pointers and load microcode
>   *
>   * @handle: amdgpu_device pointer
>   *
>   * Set ring and irq function pointers
> + * Load microcode from filesystem
>   */
>  static int vcn_v1_0_early_init(void *handle)
>  {
> @@ -75,7 +76,7 @@ static int vcn_v1_0_early_init(void *handle)
>
>         jpeg_v1_0_early_init(handle);
>
> -       return 0;
> +       return amdgpu_vcn_early_init(adev);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 08871bad9994..4b4cd88414e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -62,11 +62,12 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
>                                 int inst_idx, struct dpg_pause_state *new_state);
>  static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
>  /**
> - * vcn_v2_0_early_init - set function pointers
> + * vcn_v2_0_early_init - set function pointers and load microcode
>   *
>   * @handle: amdgpu_device pointer
>   *
>   * Set ring and irq function pointers
> + * Load microcode from filesystem
>   */
>  static int vcn_v2_0_early_init(void *handle)
>  {
> @@ -81,7 +82,7 @@ static int vcn_v2_0_early_init(void *handle)
>         vcn_v2_0_set_enc_ring_funcs(adev);
>         vcn_v2_0_set_irq_funcs(adev);
>
> -       return 0;
> +       return amdgpu_vcn_early_init(adev);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index ec87b00f2e05..b0b0e69c6a94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -71,11 +71,12 @@ static int amdgpu_ih_clientid_vcns[] = {
>  };
>
>  /**
> - * vcn_v2_5_early_init - set function pointers
> + * vcn_v2_5_early_init - set function pointers and load microcode
>   *
>   * @handle: amdgpu_device pointer
>   *
>   * Set ring and irq function pointers
> + * Load microcode from filesystem
>   */
>  static int vcn_v2_5_early_init(void *handle)
>  {
> @@ -107,7 +108,7 @@ static int vcn_v2_5_early_init(void *handle)
>         vcn_v2_5_set_irq_funcs(adev);
>         vcn_v2_5_set_ras_funcs(adev);
>
> -       return 0;
> +       return amdgpu_vcn_early_init(adev);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 9c8b5fd99037..bd228512424a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -78,11 +78,12 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
>  static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>
>  /**
> - * vcn_v3_0_early_init - set function pointers
> + * vcn_v3_0_early_init - set function pointers and load microcode
>   *
>   * @handle: amdgpu_device pointer
>   *
>   * Set ring and irq function pointers
> + * Load microcode from filesystem
>   */
>  static int vcn_v3_0_early_init(void *handle)
>  {
> @@ -109,7 +110,7 @@ static int vcn_v3_0_early_init(void *handle)
>         vcn_v3_0_set_enc_ring_funcs(adev);
>         vcn_v3_0_set_irq_funcs(adev);
>
> -       return 0;
> +       return amdgpu_vcn_early_init(adev);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 1e2b22299975..a79b6088374b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -68,11 +68,12 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>  static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>
>  /**
> - * vcn_v4_0_early_init - set function pointers
> + * vcn_v4_0_early_init - set function pointers and load microcode
>   *
>   * @handle: amdgpu_device pointer
>   *
>   * Set ring and irq function pointers
> + * Load microcode from filesystem
>   */
>  static int vcn_v4_0_early_init(void *handle)
>  {
> @@ -88,7 +89,7 @@ static int vcn_v4_0_early_init(void *handle)
>         vcn_v4_0_set_irq_funcs(adev);
>         vcn_v4_0_set_ras_funcs(adev);
>
> -       return 0;
> +       return amdgpu_vcn_early_init(adev);
>  }
>
>  /**
> --
> 2.34.1
>
