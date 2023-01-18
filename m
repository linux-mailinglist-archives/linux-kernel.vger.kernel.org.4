Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04CF671489
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjARGuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjARGZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:25:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDCB367C9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674022427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4Ui7nnL8WMOF/Rh/0KZxy27XuCjk5hBiGqbg/f/QL4=;
        b=aVFzDr4+bT339l0PB/ORcYTqd2pEpCLUgNaD1c/fRZlZMPbfAf8H/eyoFGpzQsbbzfhvgD
        bc/kjk+Zb0iaB+Rx+1CN9ODp+RDKzIRchZeRZNY90Ek4trOacgbid3Egnrl1XH4R4hwfN7
        ocWs2c9KicPFEjZEi6vfR83ZmDdEH9w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-roYCMS9INbOhA5eixBs-UQ-1; Wed, 18 Jan 2023 01:13:46 -0500
X-MC-Unique: roYCMS9INbOhA5eixBs-UQ-1
Received: by mail-ej1-f72.google.com with SMTP id qf20-20020a1709077f1400b0086ec9755517so6399276ejc.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4Ui7nnL8WMOF/Rh/0KZxy27XuCjk5hBiGqbg/f/QL4=;
        b=xkrM5cfMw+2MiJRQDHZuVV8g0094XpDTujrwPz8CLFwl1tvEzSCF20DyjvGlsj2rXB
         9zTpADP6z5r8Yq0Wp9AWAdQOqNQ8Ahas17j4ZxKrqbiz2zW74065rBkznjcUFbMlCTpI
         BOGedhFbYQDIkaDxd3jP6/Svf6xg5KR+Gz19J8KSkHK3OsDA6CMRnt4ypUR7DtUcZejW
         g8dOH3p/9CO39/+nGf1y8gyUTP3adI5X9vPvnxwSLcBgdbxSa4MZpqwh/jaj7j3PfLdh
         I4tLu9L0N9KlFWij8jqE2H3OU0kTfAvXF+MnBr94O3ziyYPAh6XyMK+UcQ1I/eaa7Y/1
         NAcA==
X-Gm-Message-State: AFqh2koS79JO7V1TKEFmyp9Om57DuyUyDJIE51X7mZYHM/bQKUf8EHfo
        O9yw23N98pL41p15p29CL5BzeMN6lk4JPvN910ffZ49ChiI+sgEUhvp2tiGVzlDX86lqPbkNTtf
        kqr3rmruahgpx0S0Bc5MyVNDW
X-Received: by 2002:a17:907:d10:b0:86e:df17:df94 with SMTP id gn16-20020a1709070d1000b0086edf17df94mr7855522ejc.14.1674022424853;
        Tue, 17 Jan 2023 22:13:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtLalrKtABzKPZUUgEeBRrgtdOwhjVQiiPWy6/M2DQlmnO2bBCBuWKs9P/hFsOfwUbCyT3baQ==
X-Received: by 2002:a17:907:d10:b0:86e:df17:df94 with SMTP id gn16-20020a1709070d1000b0086edf17df94mr7855498ejc.14.1674022424598;
        Tue, 17 Jan 2023 22:13:44 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id wi19-20020a170906fd5300b00871075bfcfesm3128359ejb.133.2023.01.17.22.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:13:44 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@redhat.com, christian.koenig@amd.com,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next 05/14] drm/nouveau: new VM_BIND uapi interfaces
Date:   Wed, 18 Jan 2023 07:12:47 +0100
Message-Id: <20230118061256.2689-6-dakr@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061256.2689-1-dakr@redhat.com>
References: <20230118061256.2689-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit provides the interfaces for the new UAPI motivated by the
Vulkan API. It allows user mode drivers (UMDs) to:

1) Initialize a GPU virtual address (VA) space via the new
   DRM_IOCTL_NOUVEAU_VM_INIT ioctl. UMDs can provide a kernel reserved
   VA area.

2) Bind and unbind GPU VA space mappings via the new
   DRM_IOCTL_NOUVEAU_VM_BIND ioctl.

3) Execute push buffers with the new DRM_IOCTL_NOUVEAU_EXEC ioctl.

Both, DRM_IOCTL_NOUVEAU_VM_BIND and DRM_IOCTL_NOUVEAU_EXEC support
asynchronous processing with DRM syncobjs as synchronization mechanism.

The default DRM_IOCTL_NOUVEAU_VM_BIND is synchronous processing,
DRM_IOCTL_NOUVEAU_EXEC supports asynchronous processing only.

Co-authored-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/gpu/driver-uapi.rst |   8 ++
 include/uapi/drm/nouveau_drm.h    | 216 ++++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+)

diff --git a/Documentation/gpu/driver-uapi.rst b/Documentation/gpu/driver-uapi.rst
index 4411e6919a3d..9c7ca6e33a68 100644
--- a/Documentation/gpu/driver-uapi.rst
+++ b/Documentation/gpu/driver-uapi.rst
@@ -6,3 +6,11 @@ drm/i915 uAPI
 =============
 
 .. kernel-doc:: include/uapi/drm/i915_drm.h
+
+drm/nouveau uAPI
+================
+
+VM_BIND / EXEC uAPI
+-------------------
+
+.. kernel-doc:: include/uapi/drm/nouveau_drm.h
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 853a327433d3..f6e7d40201d4 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -126,6 +126,216 @@ struct drm_nouveau_gem_cpu_fini {
 	__u32 handle;
 };
 
+/**
+ * struct drm_nouveau_sync - sync object
+ *
+ * This structure serves as synchronization mechanism for (potentially)
+ * asynchronous operations such as EXEC or VM_BIND.
+ */
+struct drm_nouveau_sync {
+	/**
+	 * @flags: the flags for a sync object
+	 *
+	 * The first 8 bits are used to determine the type of the sync object.
+	 */
+	__u32 flags;
+#define DRM_NOUVEAU_SYNC_SYNCOBJ 0x0
+#define DRM_NOUVEAU_SYNC_TIMELINE_SYNCOBJ 0x1
+#define DRM_NOUVEAU_SYNC_TYPE_MASK 0xf
+	/**
+	 * @handle: the handle of the sync object
+	 */
+	__u32 handle;
+	/**
+	 * @timeline_value:
+	 *
+	 * The timeline point of the sync object in case the syncobj is of
+	 * type DRM_NOUVEAU_SYNC_TIMELINE_SYNCOBJ.
+	 */
+	__u64 timeline_value;
+};
+
+/**
+ * struct drm_nouveau_vm_init - GPU VA space init structure
+ *
+ * Used to initialize the GPU's VA space for a user client, telling the kernel
+ * which portion of the VA space is managed by the UMD and kernel respectively.
+ */
+struct drm_nouveau_vm_init {
+	/**
+	 * @unmanaged_addr: start address of the kernel managed VA space region
+	 */
+	__u64 unmanaged_addr;
+	/**
+	 * @unmanaged_size: size of the kernel managed VA space region in bytes
+	 */
+	__u64 unmanaged_size;
+};
+
+/**
+ * struct drm_nouveau_vm_bind_op - VM_BIND operation
+ *
+ * This structure represents a single VM_BIND operation. UMDs should pass
+ * an array of this structure via struct drm_nouveau_vm_bind's &op_ptr field.
+ */
+struct drm_nouveau_vm_bind_op {
+	/**
+	 * @op: the operation type
+	 */
+	__u32 op;
+/**
+ * @DRM_NOUVEAU_VM_BIND_OP_ALLOC:
+ *
+ * The alloc operation is used to reserve a VA space region within the GPU's VA
+ * space. Optionally, the &DRM_NOUVEAU_VM_BIND_SPARSE flag can be passed to
+ * instruct the kernel to create sparse mappings for the given region.
+ */
+#define DRM_NOUVEAU_VM_BIND_OP_ALLOC 0x0
+/**
+ * @DRM_NOUVEAU_VM_BIND_OP_FREE: Free a reserved VA space region.
+ */
+#define DRM_NOUVEAU_VM_BIND_OP_FREE 0x1
+/**
+ * @DRM_NOUVEAU_VM_BIND_OP_MAP:
+ *
+ * Map a GEM object to the GPU's VA space. The mapping must be fully enclosed by
+ * a previously allocated VA space region. If the region is sparse, existing
+ * sparse mappings are overwritten.
+ */
+#define DRM_NOUVEAU_VM_BIND_OP_MAP 0x2
+/**
+ * @DRM_NOUVEAU_VM_BIND_OP_UNMAP:
+ *
+ * Unmap an existing mapping in the GPU's VA space. If the region the mapping
+ * is located in is a sparse region, new sparse mappings are created where the
+ * unmapped (memory backed) mapping was mapped previously.
+ */
+#define DRM_NOUVEAU_VM_BIND_OP_UNMAP 0x3
+	/**
+	 * @flags: the flags for a &drm_nouveau_vm_bind_op
+	 */
+	__u32 flags;
+/**
+ * @DRM_NOUVEAU_VM_BIND_SPARSE:
+ *
+ * Indicates that an allocated VA space region should be sparse.
+ */
+#define DRM_NOUVEAU_VM_BIND_SPARSE (1 << 8)
+	/**
+	 * @handle: the handle of the DRM GEM object to map
+	 */
+	__u32 handle;
+	/**
+	 * @addr:
+	 *
+	 * the address the VA space region or (memory backed) mapping should be mapped to
+	 */
+	__u64 addr;
+	/**
+	 * @bo_offset: the offset within the BO backing the mapping
+	 */
+	__u64 bo_offset;
+	/**
+	 * @range: the size of the requested mapping in bytes
+	 */
+	__u64 range;
+};
+
+/**
+ * struct drm_nouveau_vm_bind - structure for DRM_IOCTL_NOUVEAU_VM_BIND
+ */
+struct drm_nouveau_vm_bind {
+	/**
+	 * @op_count: the number of &drm_nouveau_vm_bind_op
+	 */
+	__u32 op_count;
+	/**
+	 * @flags: the flags for a &drm_nouveau_vm_bind ioctl
+	 */
+	__u32 flags;
+/**
+ * @DRM_NOUVEAU_VM_BIND_RUN_ASYNC:
+ *
+ * Indicates that the given VM_BIND operation should be executed asynchronously
+ * by the kernel.
+ *
+ * If this flag is not supplied the kernel executes the associated operations
+ * synchronously and doesn't accept any &drm_nouveau_sync objects.
+ */
+#define DRM_NOUVEAU_VM_BIND_RUN_ASYNC 0x1
+	/**
+	 * @wait_count: the number of wait &drm_nouveau_syncs
+	 */
+	__u32 wait_count;
+	/**
+	 * @sig_count: the number of &drm_nouveau_syncs to signal when finished
+	 */
+	__u32 sig_count;
+	/**
+	 * @wait_ptr: pointer to &drm_nouveau_syncs to wait for
+	 */
+	__u64 wait_ptr;
+	/**
+	 * @sig_ptr: pointer to &drm_nouveau_syncs to signal when finished
+	 */
+	__u64 sig_ptr;
+	/**
+	 * @op_ptr: pointer to the &drm_nouveau_vm_bind_ops to execute
+	 */
+	__u64 op_ptr;
+};
+
+/**
+ * struct drm_nouveau_exec_push - EXEC push operation
+ *
+ * This structure represents a single EXEC push operation. UMDs should pass an
+ * array of this structure via struct drm_nouveau_exec's &push_ptr field.
+ */
+struct drm_nouveau_exec_push {
+	/**
+	 * @va: the virtual address of the push buffer mapping
+	 */
+	__u64 va;
+	/**
+	 * @va_len: the length of the push buffer mapping
+	 */
+	__u64 va_len;
+};
+
+/**
+ * struct drm_nouveau_exec - structure for DRM_IOCTL_NOUVEAU_EXEC
+ */
+struct drm_nouveau_exec {
+	/**
+	 * @channel: the channel to execute the push buffer in
+	 */
+	__u32 channel;
+	/**
+	 * @push_count: the number of &drm_nouveau_exec_push ops
+	 */
+	__u32 push_count;
+	/**
+	 * @wait_count: the number of wait &drm_nouveau_syncs
+	 */
+	__u32 wait_count;
+	/**
+	 * @sig_count: the number of &drm_nouveau_syncs to signal when finished
+	 */
+	__u32 sig_count;
+	/**
+	 * @wait_ptr: pointer to &drm_nouveau_syncs to wait for
+	 */
+	__u64 wait_ptr;
+	/**
+	 * @sig_ptr: pointer to &drm_nouveau_syncs to signal when finished
+	 */
+	__u64 sig_ptr;
+	/**
+	 * @push_ptr: pointer to &drm_nouveau_exec_push ops
+	 */
+	__u64 push_ptr;
+};
+
 #define DRM_NOUVEAU_GETPARAM           0x00 /* deprecated */
 #define DRM_NOUVEAU_SETPARAM           0x01 /* deprecated */
 #define DRM_NOUVEAU_CHANNEL_ALLOC      0x02 /* deprecated */
@@ -136,6 +346,9 @@ struct drm_nouveau_gem_cpu_fini {
 #define DRM_NOUVEAU_NVIF               0x07
 #define DRM_NOUVEAU_SVM_INIT           0x08
 #define DRM_NOUVEAU_SVM_BIND           0x09
+#define DRM_NOUVEAU_VM_INIT            0x10
+#define DRM_NOUVEAU_VM_BIND            0x11
+#define DRM_NOUVEAU_EXEC               0x12
 #define DRM_NOUVEAU_GEM_NEW            0x40
 #define DRM_NOUVEAU_GEM_PUSHBUF        0x41
 #define DRM_NOUVEAU_GEM_CPU_PREP       0x42
@@ -197,6 +410,9 @@ struct drm_nouveau_svm_bind {
 #define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
 #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
 
+#define DRM_IOCTL_NOUVEAU_VM_INIT            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_VM_INIT, struct drm_nouveau_vm_init)
+#define DRM_IOCTL_NOUVEAU_VM_BIND            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_VM_BIND, struct drm_nouveau_vm_bind)
+#define DRM_IOCTL_NOUVEAU_EXEC               DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_EXEC, struct drm_nouveau_exec)
 #if defined(__cplusplus)
 }
 #endif
-- 
2.39.0

