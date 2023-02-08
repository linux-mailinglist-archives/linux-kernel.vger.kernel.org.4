Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67968F986
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjBHVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBHVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963562DE79
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675890756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzSKUxDk47sMRBv2cjoG8jtVyH/AAlQtGJYA+OBG4Yw=;
        b=GAVnKHZa666QmvmnydYJqliQ4SIUtz2XuoDJedJEoHoZv/XBJ6ndk4yEcfSdIcc3Z0L1JB
        94CIBJ9AOHLy8k3FioSIkIsY818oPs1FA1HWN43kGU/fQSylnJcMt9PzPOTLNq6fYyrP6w
        jkzGnAI2uTXwp4rVZi0o8GIFgYLGZpY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-f3KspE66NG2cu5Dy_GML1A-1; Wed, 08 Feb 2023 16:12:35 -0500
X-MC-Unique: f3KspE66NG2cu5Dy_GML1A-1
Received: by mail-wm1-f70.google.com with SMTP id bi10-20020a05600c3d8a00b003dd1b5d2a36so1237273wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 13:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzSKUxDk47sMRBv2cjoG8jtVyH/AAlQtGJYA+OBG4Yw=;
        b=IDEUL5QLmeIQul84Dm0HbpvQc9mqryaikqJ1bm6ZWa8ihm4EIktlDibctwmNGscrfw
         k0fpPg4yV8z9280QhvMMCuq7ZHx40NVDDazC535s7L541lqtFmqHPX1Tyqz0yrV75YRc
         2nW6MHor6YB+Xsw7vk+Ni8IRn4de1BR/NI2czmQa/kmu1toLct/RqiTIMsXagBBbdqyc
         eNn9GotHzPgGeWSQCiFAbugt8ZA+W2nl6SARawWQt2qBRcKgjUMuEKwkJZwIzwXbwb8c
         Jx1StTekd2NAfexxx2EFXDzL1PFG+WIpKYsCkqlUdANyVjdkWjuCbUTbg73tXjMUTNg6
         LWdw==
X-Gm-Message-State: AO0yUKXewfThjnxerU9CWzsS4Uj5D3SLgND3HFiRN+wTZ2HsvtLFfe+9
        HI6F6QB2CjEq0pFb9iVKin08My/pK1PJGIMB70FdPg9YjpDD28cdU698VgjpA5zqS/Q480TKsNP
        nQBdnElURdhvk1q9Lr6GdxGmT
X-Received: by 2002:a05:600c:44c9:b0:3df:f9e9:7600 with SMTP id f9-20020a05600c44c900b003dff9e97600mr7887365wmo.25.1675890751710;
        Wed, 08 Feb 2023 13:12:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+JJa7ZzaVQlG40YN/9KE3HEA+hB+TxeuQUH7u7o0taDk52aH0tfqusVydJBEwCDAPaGLz98g==
X-Received: by 2002:a05:600c:44c9:b0:3df:f9e9:7600 with SMTP id f9-20020a05600c44c900b003dff9e97600mr7887353wmo.25.1675890751469;
        Wed, 08 Feb 2023 13:12:31 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id w13-20020a05600c474d00b003e001afa274sm3292429wmo.2.2023.02.08.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:12:30 -0800 (PST)
Date:   Wed, 8 Feb 2023 16:12:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Sergio Lopez <slp@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH RFC 1/7] Revert "x86: don't let decompressed kernel image
 clobber setup_data"
Message-ID: <20230208211212.41951-2-mst@redhat.com>
References: <20230208211212.41951-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208211212.41951-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit eac7a7791bb6d719233deed750034042318ffd56.

Fixes: eac7a7791b ("x86: don't let decompressed kernel image clobber setup_data")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/microvm.h |  5 ++--
 include/hw/nvram/fw_cfg.h |  9 -------
 hw/i386/microvm.c         | 15 ++++-------
 hw/i386/x86.c             | 52 ++++++++++++++++++---------------------
 hw/nvram/fw_cfg.c         |  9 -------
 5 files changed, 31 insertions(+), 59 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index e8af61f194..fad97a891d 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -50,9 +50,8 @@
  */
 
 /* Platform virtio definitions */
-#define VIRTIO_MMIO_BASE                0xfeb00000
-#define VIRTIO_CMDLINE_MAXLEN           64
-#define VIRTIO_CMDLINE_TOTAL_MAX_LEN    ((VIRTIO_CMDLINE_MAXLEN + 1) * 16)
+#define VIRTIO_MMIO_BASE      0xfeb00000
+#define VIRTIO_CMDLINE_MAXLEN 64
 
 #define GED_MMIO_BASE         0xfea00000
 #define GED_MMIO_BASE_MEMHP   (GED_MMIO_BASE + 0x100)
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 990dcdbb2e..2e503904dc 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -139,15 +139,6 @@ void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
                                void *data, size_t len,
                                bool read_only);
 
-/**
- * fw_cfg_read_bytes_ptr:
- * @s: fw_cfg device being modified
- * @key: selector key value for new fw_cfg item
- *
- * Reads an existing fw_cfg data pointer.
- */
-void *fw_cfg_read_bytes_ptr(FWCfgState *s, uint16_t key);
-
 /**
  * fw_cfg_add_string:
  * @s: fw_cfg device being modified
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 29f30dd6d3..170a331e3f 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -378,8 +378,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     BusState *bus;
     BusChild *kid;
-    char *cmdline, *existing_cmdline;
-    size_t len;
+    char *cmdline;
 
     /*
      * Find MMIO transports with attached devices, and add them to the kernel
@@ -388,8 +387,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
      * Yes, this is a hack, but one that heavily improves the UX without
      * introducing any significant issues.
      */
-    existing_cmdline = fw_cfg_read_bytes_ptr(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA);
-    cmdline = g_strdup(existing_cmdline);
+    cmdline = g_strdup(machine->kernel_cmdline);
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev = kid->child;
@@ -413,12 +411,9 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
         }
     }
 
-    len = strlen(cmdline);
-    if (len > VIRTIO_CMDLINE_TOTAL_MAX_LEN + strlen(existing_cmdline)) {
-        fprintf(stderr, "qemu: virtio mmio cmdline too large, skipping\n");
-    } else {
-        memcpy(existing_cmdline, cmdline, len + 1);
-    }
+    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
+    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
+
     g_free(cmdline);
 }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index eaff4227bd..78cc131926 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -50,7 +50,6 @@
 #include "hw/intc/i8259.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "target/i386/sev.h"
-#include "hw/i386/microvm.h"
 
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/irq.h"
@@ -814,18 +813,12 @@ void x86_load_linux(X86MachineState *x86ms,
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     const char *dtb_filename = machine->dtb;
-    char *kernel_cmdline;
+    const char *kernel_cmdline = machine->kernel_cmdline;
     SevKernelLoaderContext sev_load_ctx = {};
     enum { RNG_SEED_LENGTH = 32 };
 
-    /*
-     * Add the NUL terminator, some padding for the microvm cmdline fiddling
-     * hack, and then align to 16 bytes as a paranoia measure
-     */
-    cmdline_size = (strlen(machine->kernel_cmdline) + 1 +
-                    VIRTIO_CMDLINE_TOTAL_MAX_LEN + 16) & ~15;
-    /* Make a copy, since we might append arbitrary bytes to it later. */
-    kernel_cmdline = g_strndup(machine->kernel_cmdline, cmdline_size);
+    /* Align to 16 bytes as a paranoia measure */
+    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
 
     /* load the kernel header */
     f = fopen(kernel_filename, "rb");
@@ -966,6 +959,12 @@ void x86_load_linux(X86MachineState *x86ms,
         initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
     }
 
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
+    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
+    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
+    sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
+
     if (protocol >= 0x202) {
         stl_p(header + 0x228, cmdline_addr);
     } else {
@@ -1092,24 +1091,27 @@ void x86_load_linux(X86MachineState *x86ms,
             exit(1);
         }
 
-        setup_data_offset = cmdline_size;
-        cmdline_size += sizeof(SetupData) + dtb_size;
-        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
-        setup_data = (void *)kernel_cmdline + setup_data_offset;
+        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
+        kernel_size = setup_data_offset + sizeof(SetupData) + dtb_size;
+        kernel = g_realloc(kernel, kernel_size);
+
+
+        setup_data = (SetupData *)(kernel + setup_data_offset);
         setup_data->next = cpu_to_le64(first_setup_data);
-        first_setup_data = cmdline_addr + setup_data_offset;
+        first_setup_data = prot_addr + setup_data_offset;
         setup_data->type = cpu_to_le32(SETUP_DTB);
         setup_data->len = cpu_to_le32(dtb_size);
+
         load_image_size(dtb_filename, setup_data->data, dtb_size);
     }
 
-    if (!legacy_no_rng_seed && protocol >= 0x209) {
-        setup_data_offset = cmdline_size;
-        cmdline_size += sizeof(SetupData) + RNG_SEED_LENGTH;
-        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
-        setup_data = (void *)kernel_cmdline + setup_data_offset;
+    if (!legacy_no_rng_seed) {
+        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
+        kernel_size = setup_data_offset + sizeof(SetupData) + RNG_SEED_LENGTH;
+        kernel = g_realloc(kernel, kernel_size);
+        setup_data = (SetupData *)(kernel + setup_data_offset);
         setup_data->next = cpu_to_le64(first_setup_data);
-        first_setup_data = cmdline_addr + setup_data_offset;
+        first_setup_data = prot_addr + setup_data_offset;
         setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
         setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
         qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
@@ -1120,12 +1122,6 @@ void x86_load_linux(X86MachineState *x86ms,
         fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
     }
 
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, cmdline_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline, cmdline_size);
-    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
-    sev_load_ctx.cmdline_size = cmdline_size;
-
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
     sev_load_ctx.kernel_data = (char *)kernel;
@@ -1138,7 +1134,7 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel on the other side of the fw_cfg interface matches the hash of the
      * file the user passed in.
      */
-    if (!sev_enabled() && first_setup_data) {
+    if (!sev_enabled()) {
         SetupDataFixup *fixup = g_malloc(sizeof(*fixup));
 
         memcpy(setup, header, MIN(sizeof(header), setup_size));
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 432754eda4..a00881bc64 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -741,15 +741,6 @@ void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
     fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true);
 }
 
-void *fw_cfg_read_bytes_ptr(FWCfgState *s, uint16_t key)
-{
-    int arch = !!(key & FW_CFG_ARCH_LOCAL);
-
-    key &= FW_CFG_ENTRY_MASK;
-    assert(key < fw_cfg_max_entry(s));
-    return s->entries[arch][key].data;
-}
-
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
 {
     size_t sz = strlen(value) + 1;
-- 
MST

