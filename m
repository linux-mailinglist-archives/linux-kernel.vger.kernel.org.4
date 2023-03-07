Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF56AE4B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCGPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjCGP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8EBB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mpdpmI7KgcjNXVU4fScFD2Vn3ilLXHnksYiTvVI2i8=;
        b=SF69O6thZlCQEnfO3IR5pfJ3RWLgFwSc0hc4HcITvyu+L3CftuvFE81j5xIgLDFf/9CYaq
        q2t/WZXh9t/2aXPNnuIBMdAzFyf6qLrEHwvRt3461shGDTovvELpLLNwHPOwMb5ZnQqoxn
        KHdXVgBPKdyrxO5D/Pn6drhDGfWs2CA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-swRzDaH6PfmXeu_lYYF2UQ-1; Tue, 07 Mar 2023 10:28:54 -0500
X-MC-Unique: swRzDaH6PfmXeu_lYYF2UQ-1
Received: by mail-lj1-f197.google.com with SMTP id y15-20020a05651c220f00b00295c398ba39so4330522ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mpdpmI7KgcjNXVU4fScFD2Vn3ilLXHnksYiTvVI2i8=;
        b=cyCAXo1z7fZJo9dYc6ZOYDaSBbgJPRFAiyM4fvjO3/tecShoJ5cavxBG7SheRTmnVj
         AYDm2hH7H3RKxxJVejxZygi+QazE3yN2IcSn+rhIhE4OJ7ucuXahMxbz+Xbqwu31LKHR
         jUDS5rcQ2rIlhYpw15w+QkoJ6BmgQgFGwG1WYlrZOkIXH7gkFJnsYYLgbXhAfaFLhdL3
         5B7ROnWcW9IMN3NHg7KPkZ1o04V0Nx9KZ1VBY748vVJxTOFaN1XDElkO0kjqMMwxXZdw
         yXfof0BHTNP3lmkx5fTcPTvF/OF4fcCPVJD292BLzXGHRfbkGMADaYSiqQZ2RRcB95GD
         mOXg==
X-Gm-Message-State: AO0yUKXlAV7uYyvB+DHgTF+luFZBYSm6be0yk16aXmEq2rCgMnms0L/G
        IexriofkB991+wcSD9nniRk8uv0NTRlKu+OKsx0G6Axmt34tsf67Cv9CiZ2TsjN9+Kx3IX39JIR
        8MCg4sTj9xT2L7BUn23X463eknrda+0YnB2LoP2S1
X-Received: by 2002:a2e:8341:0:b0:293:4ba5:f626 with SMTP id l1-20020a2e8341000000b002934ba5f626mr7451540ljh.2.1678202932384;
        Tue, 07 Mar 2023 07:28:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9N5WjGggkPxbsbAgzfNZEHbaEHwXQQjFnG03FVWmAfqGB3+4trqu/vFiXfRDCxwNViYOm3r6wdYBYHckvXM2g=
X-Received: by 2002:a2e:8341:0:b0:293:4ba5:f626 with SMTP id
 l1-20020a2e8341000000b002934ba5f626mr7451530ljh.2.1678202932054; Tue, 07 Mar
 2023 07:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net> <20230307-rust-drm-v1-15-917ff5bc80a8@asahilina.net>
In-Reply-To: <20230307-rust-drm-v1-15-917ff5bc80a8@asahilina.net>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 7 Mar 2023 16:28:39 +0100
Message-ID: <CACO55tu8KZp0M0s5OycRgMjr+Aba=TmNfHfj6H-sOh00QMUuWg@mail.gmail.com>
Subject: Re: [PATCH RFC 15/18] drm/asahi: Add the Asahi driver UAPI [DO NOT MERGE]
To:     Asahi Lina <lina@asahilina.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 3:28=E2=80=AFPM Asahi Lina <lina@asahilina.net> wrot=
e:
>
> Adds the Asahi GPU driver UAPI. Note: this API is not yet stable and
> therefore not ready for merging!
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  include/uapi/drm/asahi_drm.h | 556 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 556 insertions(+)
>
> diff --git a/include/uapi/drm/asahi_drm.h b/include/uapi/drm/asahi_drm.h
> new file mode 100644
> index 000000000000..7b15b486d03d
> --- /dev/null
> +++ b/include/uapi/drm/asahi_drm.h
> @@ -0,0 +1,556 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) The Asahi Linux Contributors
> + *
> + * Heavily inspired by xe_drm.h.
> + */
> +#ifndef _ASAHI_DRM_H_
> +#define _ASAHI_DRM_H_
> +
> +#include "drm.h"
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +#define DRM_ASAHI_UNSTABLE_UABI_VERSION                10006
> +
> +#define DRM_ASAHI_GET_PARAMS                   0x00
> +#define DRM_ASAHI_VM_CREATE                    0x01
> +#define DRM_ASAHI_VM_DESTROY                   0x02
> +#define DRM_ASAHI_GEM_CREATE                   0x03
> +#define DRM_ASAHI_GEM_MMAP_OFFSET              0x04
> +#define DRM_ASAHI_GEM_BIND                     0x05
> +#define DRM_ASAHI_QUEUE_CREATE                 0x06
> +#define DRM_ASAHI_QUEUE_DESTROY                        0x07
> +#define DRM_ASAHI_SUBMIT                       0x08
> +#define DRM_ASAHI_GET_TIME                     0x09
> +
> +#define DRM_ASAHI_MAX_CLUSTERS 32
> +
> +struct drm_asahi_params_global {
> +       __u32 unstable_uabi_version;
> +       __u32 pad0;
> +
> +       __u64 feat_compat;
> +       __u64 feat_incompat;
> +
> +       __u32 gpu_generation;
> +       __u32 gpu_variant;
> +       __u32 gpu_revision;
> +       __u32 chip_id;
> +
> +       __u32 num_dies;
> +       __u32 num_clusters_total;
> +       __u32 num_cores_per_cluster;
> +       __u32 num_frags_per_cluster;
> +       __u32 num_gps_per_cluster;
> +       __u32 num_cores_total_active;
> +       __u64 core_masks[DRM_ASAHI_MAX_CLUSTERS];
> +
> +       __u32 vm_page_size;
> +       __u32 pad1;
> +       __u64 vm_user_start;
> +       __u64 vm_user_end;
> +       __u64 vm_shader_start;
> +       __u64 vm_shader_end;
> +
> +       __u32 max_syncs_per_submission;
> +       __u32 max_commands_per_submission;
> +       __u32 max_commands_in_flight;
> +       __u32 max_attachments;
> +
> +       __u32 timer_frequency_hz;
> +       __u32 min_frequency_khz;
> +       __u32 max_frequency_khz;
> +       __u32 max_power_mw;
> +
> +       __u32 result_render_size;
> +       __u32 result_compute_size;
> +};
> +
> +/*
> +enum drm_asahi_feat_compat {
> +};
> +*/
> +
> +enum drm_asahi_feat_incompat {
> +       DRM_ASAHI_FEAT_MANDATORY_ZS_COMPRESSION =3D (1UL) << 0,
> +};
> +
> +struct drm_asahi_get_params {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @param: Parameter group to fetch (MBZ) */
> +       __u32 param_group;
> +
> +       /** @pad: MBZ */
> +       __u32 pad;
> +
> +       /** @value: User pointer to write parameter struct */
> +       __u64 pointer;
> +
> +       /** @value: Size of user buffer, max size supported on return */
> +       __u64 size;
> +};
> +
> +struct drm_asahi_vm_create {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @value: Returned VM ID */
> +       __u32 vm_id;
> +
> +       /** @pad: MBZ */
> +       __u32 pad;
> +};
> +
> +struct drm_asahi_vm_destroy {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @value: VM ID to be destroyed */
> +       __u32 vm_id;
> +
> +       /** @pad: MBZ */
> +       __u32 pad;
> +};
> +
> +#define ASAHI_GEM_WRITEBACK    (1L << 0)
> +#define ASAHI_GEM_VM_PRIVATE   (1L << 1)
> +
> +struct drm_asahi_gem_create {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @size: Size of the BO */
> +       __u64 size;
> +
> +       /** @flags: BO creation flags */
> +       __u32 flags;
> +
> +       /** @handle: VM ID to assign to the BO, if ASAHI_GEM_VM_PRIVATE i=
s set. */
> +       __u32 vm_id;
> +
> +       /** @handle: Returned GEM handle for the BO */
> +       __u32 handle;
> +};
> +
> +struct drm_asahi_gem_mmap_offset {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @handle: Handle for the object being mapped. */
> +       __u32 handle;
> +
> +       /** @flags: Must be zero */
> +       __u32 flags;
> +
> +       /** @offset: The fake offset to use for subsequent mmap call */
> +       __u64 offset;
> +};
> +
> +enum drm_asahi_bind_op {
> +       ASAHI_BIND_OP_BIND =3D 0,
> +       ASAHI_BIND_OP_UNBIND =3D 1,
> +       ASAHI_BIND_OP_UNBIND_ALL =3D 2,
> +};
> +
> +#define ASAHI_BIND_READ                (1L << 0)
> +#define ASAHI_BIND_WRITE       (1L << 1)
> +
> +struct drm_asahi_gem_bind {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @obj: Bind operation */
> +       __u32 op;
> +
> +       /** @flags: One or more of ASAHI_BIND_* */
> +       __u32 flags;
> +
> +       /** @obj: GEM object to bind */
> +       __u32 handle;
> +
> +       /** @vm_id: The ID of the VM to bind to */
> +       __u32 vm_id;
> +
> +       /** @offset: Offset into the object */
> +       __u64 offset;
> +
> +       /** @range: Number of bytes from the object to bind to addr */
> +       __u64 range;
> +
> +       /** @addr: Address to bind to */
> +       __u64 addr;
> +};
> +
> +enum drm_asahi_cmd_type {
> +       DRM_ASAHI_CMD_RENDER =3D 0,
> +       DRM_ASAHI_CMD_BLIT =3D 1,
> +       DRM_ASAHI_CMD_COMPUTE =3D 2,
> +};
> +
> +/* Note: this is an enum so that it can be resolved by Rust bindgen. */
> +enum drm_asahi_queue_cap {
> +       DRM_ASAHI_QUEUE_CAP_RENDER      =3D (1UL << DRM_ASAHI_CMD_RENDER)=
,
> +       DRM_ASAHI_QUEUE_CAP_BLIT        =3D (1UL << DRM_ASAHI_CMD_BLIT),
> +       DRM_ASAHI_QUEUE_CAP_COMPUTE     =3D (1UL << DRM_ASAHI_CMD_COMPUTE=
),
> +};
> +
> +struct drm_asahi_queue_create {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @flags: MBZ */
> +       __u32 flags;
> +
> +       /** @vm_id: The ID of the VM this queue is bound to */
> +       __u32 vm_id;
> +
> +       /** @type: Bitmask of DRM_ASAHI_QUEUE_CAP_* */
> +       __u32 queue_caps;
> +
> +       /** @priority: Queue priority, 0-3 */
> +       __u32 priority;
> +
> +       /** @queue_id: The returned queue ID */
> +       __u32 queue_id;
> +};
> +
> +struct drm_asahi_queue_destroy {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @queue_id: The queue ID to be destroyed */
> +       __u32 queue_id;
> +};
> +
> +enum drm_asahi_sync_type {
> +       DRM_ASAHI_SYNC_SYNCOBJ =3D 0,
> +       DRM_ASAHI_SYNC_TIMELINE_SYNCOBJ =3D 1,
> +};
> +
> +struct drm_asahi_sync {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @sync_type: One of drm_asahi_sync_type */
> +       __u32 sync_type;
> +
> +       /** @handle: The sync object handle */
> +       __u32 handle;
> +
> +       /** @timeline_value: Timeline value for timeline sync objects */
> +       __u64 timeline_value;
> +};
> +
> +enum drm_asahi_subqueue {
> +       DRM_ASAHI_SUBQUEUE_RENDER =3D 0, /* Also blit */
> +       DRM_ASAHI_SUBQUEUE_COMPUTE =3D 1,
> +       DRM_ASAHI_SUBQUEUE_COUNT =3D 2,
> +};
> +
> +#define DRM_ASAHI_BARRIER_NONE ~(0U)
> +
> +struct drm_asahi_command {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @type: One of drm_asahi_cmd_type */
> +       __u32 cmd_type;
> +
> +       /** @flags: Flags for command submission */
> +       __u32 flags;
> +
> +       /** @cmdbuf: Pointer to the appropriate command buffer structure =
*/
> +       __u64 cmd_buffer;
> +
> +       /** @cmdbuf: Size of the command buffer structure */
> +       __u64 cmd_buffer_size;
> +
> +       /** @cmdbuf: Offset into the result BO to return information abou=
t this command */
> +       __u64 result_offset;
> +
> +       /** @cmdbuf: Size of the result data structure */
> +       __u64 result_size;
> +
> +       /** @barriers: Array of command indices per subqueue to wait on *=
/
> +       __u32 barriers[DRM_ASAHI_SUBQUEUE_COUNT];
> +};
> +
> +struct drm_asahi_submit {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @in_syncs: An optional array of drm_asahi_sync to wait on bef=
ore starting this job. */
> +       __u64 in_syncs;
> +
> +       /** @in_syncs: An optional array of drm_asahi_sync objects to sig=
nal upon completion. */
> +       __u64 out_syncs;
> +
> +       /** @commands: Pointer to the drm_asahi_command array of commands=
 to submit. */
> +       __u64 commands;
> +
> +       /** @flags: Flags for command submission (MBZ) */
> +       __u32 flags;
> +
> +       /** @queue_id: The queue ID to be submitted to */
> +       __u32 queue_id;
> +
> +       /** @result_handle: An optional BO handle to place result data in=
 */
> +       __u32 result_handle;
> +
> +       /** @in_sync_count: Number of sync objects to wait on before star=
ting this job. */
> +       __u32 in_sync_count;
> +
> +       /** @in_sync_count: Number of sync objects to signal upon complet=
ion of this job. */
> +       __u32 out_sync_count;
> +
> +       /** @pad: Number of commands to be submitted */
> +       __u32 command_count;
> +};
> +
> +/* FIXME: This doesn't make any sense, figure out exactly what the attac=
hment flags are */
> +#define ASAHI_ATTACHMENT_C    0
> +#define ASAHI_ATTACHMENT_Z    1
> +#define ASAHI_ATTACHMENT_S    2
> +
> +struct drm_asahi_attachment {
> +       __u32 type;
> +       __u32 size;
> +       __u64 pointer;
> +};
> +
> +#define ASAHI_RENDER_NO_CLEAR_PIPELINE_TEXTURES (1UL << 0)
> +#define ASAHI_RENDER_SET_WHEN_RELOADING_Z_OR_S (1UL << 1)
> +#define ASAHI_RENDER_MEMORYLESS_RTS_USED (1UL << 2) /* Not yet implement=
ed */
> +#define ASAHI_RENDER_PROCESS_EMPTY_TILES (1UL << 3)
> +#define ASAHI_RENDER_NO_VERTEX_CLUSTERING (1UL << 4)
> +
> +struct drm_asahi_cmd_render {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       __u64 flags;
> +
> +       __u64 encoder_ptr;
> +
> +       __u64 attachments;
> +       __u32 attachment_count;
> +       __u32 pad;
> +
> +       __u64 depth_buffer_1;
> +       __u64 depth_buffer_2;
> +       __u64 depth_buffer_3;
> +       __u64 depth_meta_buffer_1;
> +       __u64 depth_meta_buffer_2;
> +       __u64 depth_meta_buffer_3;
> +
> +       __u64 stencil_buffer_1;
> +       __u64 stencil_buffer_2;
> +       __u64 stencil_buffer_3;
> +       __u64 stencil_meta_buffer_1;
> +       __u64 stencil_meta_buffer_2;
> +       __u64 stencil_meta_buffer_3;
> +
> +       __u64 scissor_array;
> +       __u64 depth_bias_array;
> +       __u64 visibility_result_buffer;
> +
> +       __u64 zls_ctrl;
> +       __u64 ppp_multisamplectl;
> +       __u32 ppp_ctrl;
> +
> +       __u32 fb_width;
> +       __u32 fb_height;
> +
> +       __u32 utile_width;
> +       __u32 utile_height;
> +
> +       __u32 samples;
> +       __u32 layers;
> +
> +       __u32 encoder_id;
> +       __u32 cmd_ta_id;
> +       __u32 cmd_3d_id;
> +
> +       __u32 iogpu_unk_49;
> +       __u32 iogpu_unk_212;
> +       __u32 iogpu_unk_214;
> +
> +       __u32 merge_upper_x;
> +       __u32 merge_upper_y;
> +
> +       __u32 load_pipeline;
> +       __u32 load_pipeline_bind;
> +
> +       __u32 store_pipeline;
> +       __u32 store_pipeline_bind;
> +
> +       __u32 partial_reload_pipeline;
> +       __u32 partial_reload_pipeline_bind;
> +
> +       __u32 partial_store_pipeline;
> +       __u32 partial_store_pipeline_bind;
> +
> +       __u32 depth_dimensions;
> +       __u32 isp_bgobjdepth;
> +       __u32 isp_bgobjvals;
> +};
> +
> +struct drm_asahi_cmd_compute {
> +       __u64 flags;
> +
> +       __u64 encoder_ptr;
> +       __u64 encoder_end;
> +
> +       __u64 attachments;
> +       __u32 attachment_count;
> +       __u32 pad;
> +
> +       __u64 buffer_descriptor;
> +
> +       __u32 buffer_descriptor_size; /* ? */
> +       __u32 ctx_switch_prog;
> +
> +       __u32 encoder_id;
> +       __u32 cmd_id;
> +
> +       __u32 iogpu_unk_40;
> +       __u32 iogpu_unk_44;
> +};
> +
> +enum drm_asahi_status {
> +       DRM_ASAHI_STATUS_PENDING =3D 0,
> +       DRM_ASAHI_STATUS_COMPLETE,
> +       DRM_ASAHI_STATUS_UNKNOWN_ERROR,
> +       DRM_ASAHI_STATUS_TIMEOUT,
> +       DRM_ASAHI_STATUS_FAULT,
> +       DRM_ASAHI_STATUS_KILLED,
> +       DRM_ASAHI_STATUS_NO_DEVICE,
> +};
> +
> +enum drm_asahi_fault {
> +       DRM_ASAHI_FAULT_NONE =3D 0,
> +       DRM_ASAHI_FAULT_UNKNOWN,
> +       DRM_ASAHI_FAULT_UNMAPPED,
> +       DRM_ASAHI_FAULT_AF_FAULT,
> +       DRM_ASAHI_FAULT_WRITE_ONLY,
> +       DRM_ASAHI_FAULT_READ_ONLY,
> +       DRM_ASAHI_FAULT_NO_ACCESS,
> +};
> +
> +struct drm_asahi_result_info {
> +       /** @status: One of enum drm_asahi_status */
> +       __u32 status;
> +
> +       /** @reason: One of drm_asahi_fault_type */
> +       __u32 fault_type;
> +
> +       /** @unit: Unit number, hardware dependent */
> +       __u32 unit;
> +
> +       /** @sideband: Sideband information, hardware dependent */
> +       __u32 sideband;
> +
> +       /** @level: Page table level at which the fault occurred, hardwar=
e dependent */
> +       __u8 level;
> +
> +       /** @read: Fault was a read */
> +       __u8 is_read;
> +
> +       /** @pad: MBZ */
> +       __u16 pad;
> +
> +       /** @unk_5: Extra bits, hardware dependent */
> +       __u32 extra;
> +
> +       /** @address: Fault address, cache line aligned */
> +       __u64 address;
> +};
> +
> +#define DRM_ASAHI_RESULT_RENDER_TVB_GROW_OVF (1UL << 0)
> +#define DRM_ASAHI_RESULT_RENDER_TVB_GROW_MIN (1UL << 1)
> +#define DRM_ASAHI_RESULT_RENDER_TVB_OVERFLOWED (1UL << 2)
> +
> +struct drm_asahi_result_render {
> +       /** @address: Common result information */
> +       struct drm_asahi_result_info info;
> +
> +       /** @flags: Zero or more of of DRM_ASAHI_RESULT_RENDER_* */
> +       __u64 flags;
> +
> +       /** @vertex_ts_start: Timestamp of the start of vertex processing=
 */
> +       __u64 vertex_ts_start;
> +
> +       /** @vertex_ts_end: Timestamp of the end of vertex processing */
> +       __u64 vertex_ts_end;
> +
> +       /** @fragment_ts_start: Timestamp of the start of fragment proces=
sing */
> +       __u64 fragment_ts_start;
> +
> +       /** @fragment_ts_end: Timestamp of the end of fragment processing=
 */
> +       __u64 fragment_ts_end;
> +
> +       /** @tvb_size_bytes: TVB size at the start of this render */
> +       __u64 tvb_size_bytes;
> +
> +       /** @tvb_usage_bytes: Total TVB usage in bytes for this render */
> +       __u64 tvb_usage_bytes;
> +
> +       /** @num_tvb_overflows: Number of TVB overflows that occurred for=
 this render */
> +       __u32 num_tvb_overflows;
> +};
> +
> +struct drm_asahi_result_compute {
> +       /** @address: Common result information */
> +       struct drm_asahi_result_info info;
> +
> +       /** @flags: Zero or more of of DRM_ASAHI_RESULT_COMPUTE_* */
> +       __u64 flags;
> +
> +       /** @ts_start: Timestamp of the start of this compute command */
> +       __u64 ts_start;
> +
> +       /** @vertex_ts_end: Timestamp of the end of this compute command =
*/
> +       __u64 ts_end;
> +};
> +
> +struct drm_asahi_get_time {
> +       /** @extensions: Pointer to the first extension struct, if any */
> +       __u64 extensions;
> +
> +       /** @flags: MBZ. */
> +       __u64 flags;
> +
> +       /** @tv_sec: On return, seconds part of a point in time */
> +       __s64 tv_sec;
> +
> +       /** @tv_nsec: On return, nanoseconds part of a point in time */
> +       __s64 tv_nsec;
> +
> +       /** @gpu_timestamp: On return, the GPU timestamp at that point in=
 time */
> +       __u64 gpu_timestamp;
> +};
> +
> +/* Note: this is an enum so that it can be resolved by Rust bindgen. */
> +enum {
> +   DRM_IOCTL_ASAHI_GET_PARAMS       =3D DRM_IOWR(DRM_COMMAND_BASE + DRM_=
ASAHI_GET_PARAMS, struct drm_asahi_get_params),
> +   DRM_IOCTL_ASAHI_VM_CREATE        =3D DRM_IOWR(DRM_COMMAND_BASE + DRM_=
ASAHI_VM_CREATE, struct drm_asahi_vm_create),
> +   DRM_IOCTL_ASAHI_VM_DESTROY       =3D DRM_IOW(DRM_COMMAND_BASE + DRM_A=
SAHI_VM_DESTROY, struct drm_asahi_vm_destroy),
> +   DRM_IOCTL_ASAHI_GEM_CREATE       =3D DRM_IOWR(DRM_COMMAND_BASE + DRM_=
ASAHI_GEM_CREATE, struct drm_asahi_gem_create),
> +   DRM_IOCTL_ASAHI_GEM_MMAP_OFFSET  =3D DRM_IOWR(DRM_COMMAND_BASE + DRM_=
ASAHI_GEM_MMAP_OFFSET, struct drm_asahi_gem_mmap_offset),
> +   DRM_IOCTL_ASAHI_GEM_BIND         =3D DRM_IOW(DRM_COMMAND_BASE + DRM_A=
SAHI_GEM_BIND, struct drm_asahi_gem_bind),
> +   DRM_IOCTL_ASAHI_QUEUE_CREATE     =3D DRM_IOWR(DRM_COMMAND_BASE + DRM_=
ASAHI_QUEUE_CREATE, struct drm_asahi_queue_create),
> +   DRM_IOCTL_ASAHI_QUEUE_DESTROY    =3D DRM_IOW(DRM_COMMAND_BASE + DRM_A=
SAHI_QUEUE_DESTROY, struct drm_asahi_queue_destroy),
> +   DRM_IOCTL_ASAHI_SUBMIT           =3D DRM_IOW(DRM_COMMAND_BASE + DRM_A=
SAHI_SUBMIT, struct drm_asahi_submit),
> +   DRM_IOCTL_ASAHI_GET_TIME         =3D DRM_IOWR(DRM_COMMAND_BASE + DRM_=
ASAHI_GET_TIME, struct drm_asahi_get_time),
> +};

heh.. I had the same issue in mesa and wasn't thinking of doing this instea=
d

> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* _ASAHI_DRM_H_ */
>
> --
> 2.35.1
>

