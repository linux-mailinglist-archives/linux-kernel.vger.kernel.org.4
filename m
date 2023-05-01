Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A56F36C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjEAT1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjEAT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:27:35 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D564172E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:27:13 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-547299bf5d8so1588979eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969233; x=1685561233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhcRiR9DgObJ3GdLW40F4CvWyOT47X9xzO/pYnogYMs=;
        b=F+ArsapDPq5RZ5zvaLU8u/e8hoBxlXH+1e5bvV+7sRKgY2lt+OVswEqd+6+q3vwcMT
         DD1dr/M0LUiTbZ/SXXSrAfWbpT8S9AZhldRaVMGjtnn4oGZxUhEJhhGeIu+2NyIWeibI
         HkX42Ip6LIIO+FwTNPTR8DMs8gndfdHTmCsvtqGCuBO2EiwdBvqqF3K7n6w3/33pi8b2
         PHGud4U1BsLOO772C8Cdr1nnGSzQG13uQOmHeoQCDlsTSImNzoNXicj6JlLbrNm2LR4Y
         N4KzensikeGi+QLHXRQbduF33qAu/HgypysHJLG32i4L/AG4ia24T6JZPAn7u5SZ5k67
         ls+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969233; x=1685561233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhcRiR9DgObJ3GdLW40F4CvWyOT47X9xzO/pYnogYMs=;
        b=cVrhVJL8fNiNuacTKSa4CTZCp8njwpaffP6Bmw/5vorB+Nb4eBbTaOnQH1OefhLhi0
         ryaUgI1j5gcPBymn4xLVZRPFrmWyZz80SZusno9pFeu5gU1dk5YnRf0+mQbWVlY63A0G
         HX5N67R2Ts5O9phFaq6lae15wOg9GgGXELhzcwMQrIUCgRkESpBTD+C/NQYAw0+3dktA
         90/2di1esvQf5lE/xGHyTBMQfXiG/bDyQ08oHBp7UmnbtdKZrIaHYRK7jxB7+xEC2xca
         3acPRTBzWWRTnOYHV4mBWlMAbZuYbo1CKz68lPyhJvOz5iRYnKTDdiYJz5J1Gdqvh9sL
         rSyA==
X-Gm-Message-State: AC+VfDwNuu+ANhU/pIrnkXJlWvxjzOtZjKnDzf+fLKTtJrqs3bRQzZmd
        95nDlwa8vzC4WNzbSwdbNQduYsKTAuiUjniPic4=
X-Google-Smtp-Source: ACHHUZ6xi1EGGZS+pR4jOWXxsMTWfZUKBLyQolBoK28Ao042gAqUYxDmtKJIRBIDUGtitG6OtXEsGEdErhhPmk4Ixfo=
X-Received: by 2002:a05:6808:98c:b0:38b:e6:3d95 with SMTP id
 a12-20020a056808098c00b0038b00e63d95mr6718432oic.40.1682969232681; Mon, 01
 May 2023 12:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230501185747.33519-1-andrealmeid@igalia.com> <20230501185747.33519-2-andrealmeid@igalia.com>
In-Reply-To: <20230501185747.33519-2-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 1 May 2023 15:27:01 -0400
Message-ID: <CADnq5_OBf9W-VikF-Psd87YXxB9=rE5qCnM8FfE13RKkR7Y51A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: Add interface to dump guilty IB on
 GPU hang
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 2:58=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Add an interface to point out to userspace the guilty indirect buffer
> when a GPU reset happens, so the usermode driver can dump just the right
> IB for debug investigation.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  7 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 29 ++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h            |  7 ++++++
>  7 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 02b827785e39..89345e49ba20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1050,6 +1050,9 @@ struct amdgpu_device {
>
>         bool                            job_hang;
>         bool                            dc_enabled;
> +
> +       /* TODO: Maybe this should be a per-ring info */
> +       struct drm_amdgpu_info_guilty_app       info;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b400d598b75a..818bcd2c9b5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -110,9 +110,10 @@
>   *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_in=
fo fields:
>   *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_=
inst_cache_size,
>   *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pi=
pes_mask_hi
> + *   3.53.0 - Add AMDGPU_INFO_GUILTY_APP IOCTL
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       52
> +#define KMS_DRIVER_MINOR       53
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index c3d9d75143f4..a15162f8c812 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -48,6 +48,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)
>                 return DRM_GPU_SCHED_STAT_ENODEV;
>         }
>
> +       if (ring->funcs->get_reset_data)
> +               ring->funcs->get_reset_data(ring, job);
> +
>         memset(&ti, 0, sizeof(struct amdgpu_task_info));
>         adev->job_hang =3D true;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index a5bae7eb993a..dc6cc94b6847 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1149,6 +1149,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                 return copy_to_user(out, max_ibs,
>                                     min((size_t)size, sizeof(max_ibs))) ?=
 -EFAULT : 0;
>         }
> +       case AMDGPU_INFO_GUILTY_APP: {
> +               struct drm_amdgpu_info_guilty_app info;
> +               info.ib_addr =3D adev->info.ib_addr;
> +               info.vmid =3D adev->info.vmid;
> +               info.ib_size =3D adev->info.ib_size;
> +               return copy_to_user(out, &info, min((size_t)size, sizeof(=
info))) ? -EFAULT : 0;
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 8eca6532ed19..0993c7ec74c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -227,6 +227,7 @@ struct amdgpu_ring_funcs {
>         int (*preempt_ib)(struct amdgpu_ring *ring);
>         void (*emit_mem_sync)(struct amdgpu_ring *ring);
>         void (*emit_wave_limit)(struct amdgpu_ring *ring, bool enable);
> +       void (*get_reset_data)(struct amdgpu_ring *ring, struct amdgpu_jo=
b *job);
>  };
>
>  struct amdgpu_ring {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 8bd07ff59671..12763ff8c83c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9226,6 +9226,34 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static void gfx_v10_0_get_reset_data(struct amdgpu_ring *ring,
> +                                    struct amdgpu_job *job)
> +{
> +       int i;
> +
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u64 ib_addr;
> +       u32 ib_addr_lo;
> +
> +       ib_addr =3D RREG32_SOC15(GC, 0, mmCP_IB1_BASE_HI);
> +       ib_addr =3D ib_addr << 32;
> +       ib_addr_lo =3D RREG32_SOC15(GC, 0, mmCP_IB1_BASE_LO);
> +       ib_addr +=3D ib_addr_lo;

You'll need to disable gfxoff when you access these otherwise you can
hang the GPU if you read them when gfx is off.  See
amdgpu_gfx_off_ctrl().

Alex

> +
> +       adev->info.ib_addr =3D ib_addr;
> +       adev->info.vmid =3D job->vmid;
> +
> +       for (i =3D 0; i < job->num_ibs; i++) {
> +               if (lower_32_bits(job->ibs[i].gpu_addr) =3D=3D ib_addr_lo=
) {
> +                       adev->info.ib_size =3D job->ibs[i].length_dw;
> +                       break;
> +               }
> +       }
> +
> +       DRM_INFO("Guilty app info: IB addr 0x%llx IB size 0x%x VM id %u",
> +                 adev->info.ib_addr, adev->info.ib_size, adev->info.vmid=
);
> +}
> +
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
>         .name =3D "gfx_v10_0",
>         .early_init =3D gfx_v10_0_early_init,
> @@ -9297,6 +9325,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
>         .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
> +       .get_reset_data =3D gfx_v10_0_get_reset_data,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute =3D {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 6981e59a9401..4136d04bfb57 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -878,6 +878,7 @@ struct drm_amdgpu_cs_chunk_data {
>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
>  /* Query the max number of IBs per gang per submission */
>  #define AMDGPU_INFO_MAX_IBS                    0x22
> +#define AMDGPU_INFO_GUILTY_APP                 0x23
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1195,6 +1196,12 @@ struct drm_amdgpu_info_video_caps {
>         struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VI=
DEO_CAPS_CODEC_IDX_COUNT];
>  };
>
> +struct drm_amdgpu_info_guilty_app {
> +       __u64 ib_addr;
> +       __u32 ib_size;
> +       __u32 vmid;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.40.1
>
