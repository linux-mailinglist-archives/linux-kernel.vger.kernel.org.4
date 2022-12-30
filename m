Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E164659CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 23:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiL3WHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 17:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiL3WHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:07:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6980E1CFFB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 14:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF30BB81A16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8737FC433EF;
        Fri, 30 Dec 2022 22:07:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l5NDwUOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672438053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SHBajvlhm55EzhRHsAJiD2PeR7ppGaR58X4jfiqchQ=;
        b=l5NDwUOxy/bvN3H8UKozBxefy6P2oYofRqjGFBA5YclKVvF4twvgr72arrTtrtx2Z0FBpo
        qnF5ypIJap3dsRQQZnY5FDMLWURKb3GXMduKiTFFZe/2dmkouw4qKUsAjgkxnenPJfrn39
        +vxvbPeHo2UbZqXyNzOQkXYCJ88We3o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ebed5c14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 22:07:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, hpa@zytor.com, bp@alien8.de,
        philmd@linaro.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH qemu v3] x86: don't let decompressed kernel image clobber setup_data
Date:   Fri, 30 Dec 2022 23:07:25 +0100
Message-Id: <20221230220725.618763-1-Jason@zx2c4.com>
In-Reply-To: <Y69fUstLKNv/RLd7@zx2c4.com>
References: <Y69fUstLKNv/RLd7@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_data links are appended to the compressed kernel image. Since
the kernel image is typically loaded at 0x100000, setup_data lives at
`0x100000 + compressed_size`, which does not get relocated during the
kernel's boot process.

The kernel typically decompresses the image starting at address
0x1000000 (note: there's one more zero there than the compressed image
above). This usually is fine for most kernels.

However, if the compressed image is actually quite large, then
setup_data will live at a `0x100000 + compressed_size` that extends into
the decompressed zone at 0x1000000. In other words, if compressed_size
is larger than `0x1000000 - 0x100000`, then the decompression step will
clobber setup_data, resulting in crashes.

Visually, what happens now is that QEMU appends setup_data to the kernel
image:

          kernel image            setup_data
   |--------------------------||----------------|
0x100000                  0x100000+l1     0x100000+l1+l2

The problem is that this decompresses to 0x1000000 (one more zero). So
if l1 is > (0x1000000-0x100000), then this winds up looking like:

          kernel image            setup_data
   |--------------------------||----------------|
0x100000                  0x100000+l1     0x100000+l1+l2

                                 d e c o m p r e s s e d   k e r n e l
                     |-------------------------------------------------------------|
                0x1000000                                                     0x1000000+l3

The decompressed kernel seemingly overwriting the compressed kernel
image isn't a problem, because that gets relocated to a higher address
early on in the boot process, at the end of startup_64. setup_data,
however, stays in the same place, since those links are self referential
and nothing fixes them up.  So the decompressed kernel clobbers it.

Fix this by appending setup_data to the cmdline blob rather than the
kernel image blob, which remains at a lower address that won't get
clobbered.

This could have been done by overwriting the initrd blob instead, but
that poses big difficulties, such as no longer being able to use memory
mapped files for initrd, hurting performance, and, more importantly, the
initrd address calculation is hard coded in qboot, and it always grows
down rather than up, which means lots of brittle semantics would have to
be changed around, incurring more complexity. In contrast, using cmdline
is simple and doesn't interfere with anything.

The microvm machine has a gross hack where it fiddles with fw_cfg data
after the fact. So this hack is updated to account for this appending,
by reserving some bytes.

Cc: x86@kernel.org
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v2->v3:
- Fix mistakes in string handling.
Changes v1->v2:
- Append setup_data to cmdline instead of kernel image.

 hw/i386/microvm.c         | 13 ++++++----
 hw/i386/x86.c             | 50 +++++++++++++++++++--------------------
 hw/nvram/fw_cfg.c         |  9 +++++++
 include/hw/i386/microvm.h |  5 ++--
 include/hw/nvram/fw_cfg.h |  9 +++++++
 5 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 170a331e3f..1b19d28c02 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -378,7 +378,8 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     BusState *bus;
     BusChild *kid;
-    char *cmdline;
+    char *cmdline, *existing_cmdline = fw_cfg_read_bytes_ptr(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA);
+    size_t len;
 
     /*
      * Find MMIO transports with attached devices, and add them to the kernel
@@ -387,7 +388,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
      * Yes, this is a hack, but one that heavily improves the UX without
      * introducing any significant issues.
      */
-    cmdline = g_strdup(machine->kernel_cmdline);
+    cmdline = g_strdup(existing_cmdline);
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev = kid->child;
@@ -411,9 +412,11 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
         }
     }
 
-    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
-    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
-
+    len = strlen(cmdline);
+    if (len > VIRTIO_CMDLINE_TOTAL_MAX_LEN + strlen(existing_cmdline))
+        fprintf(stderr, "qemu: virtio mmio cmdline too large, skipping\n");
+    else
+        memcpy(existing_cmdline, cmdline, len + 1);
     g_free(cmdline);
 }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 78cc131926..b57a993596 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -50,6 +50,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "target/i386/sev.h"
+#include "hw/i386/microvm.h"
 
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/irq.h"
@@ -802,7 +803,7 @@ void x86_load_linux(X86MachineState *x86ms,
     bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
-    int dtb_size, setup_data_offset;
+    int dtb_size;
     uint32_t initrd_max;
     uint8_t header[8192], *setup, *kernel;
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
@@ -813,12 +814,16 @@ void x86_load_linux(X86MachineState *x86ms,
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     const char *dtb_filename = machine->dtb;
-    const char *kernel_cmdline = machine->kernel_cmdline;
+    char *kernel_cmdline;
     SevKernelLoaderContext sev_load_ctx = {};
     enum { RNG_SEED_LENGTH = 32 };
 
-    /* Align to 16 bytes as a paranoia measure */
-    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
+    /* Add the NUL terminator, some padding for the microvm cmdline fiddling
+     * hack, and then align to 16 bytes as a paranoia measure */
+    cmdline_size = (strlen(machine->kernel_cmdline) + 1 +
+                    VIRTIO_CMDLINE_TOTAL_MAX_LEN + 16) & ~15;
+    /* Make a copy, since we might append arbitrary bytes to it later. */
+    kernel_cmdline = g_strndup(machine->kernel_cmdline, cmdline_size);
 
     /* load the kernel header */
     f = fopen(kernel_filename, "rb");
@@ -959,12 +964,6 @@ void x86_load_linux(X86MachineState *x86ms,
         initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
     }
 
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
-    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
-    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
-    sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
-
     if (protocol >= 0x202) {
         stl_p(header + 0x228, cmdline_addr);
     } else {
@@ -1091,27 +1090,22 @@ void x86_load_linux(X86MachineState *x86ms,
             exit(1);
         }
 
-        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(SetupData) + dtb_size;
-        kernel = g_realloc(kernel, kernel_size);
-
-
-        setup_data = (SetupData *)(kernel + setup_data_offset);
+        cmdline_size += sizeof(SetupData) + dtb_size;
+        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
+        setup_data = (void *)kernel_cmdline + cmdline_size - (sizeof(SetupData) + dtb_size);
         setup_data->next = cpu_to_le64(first_setup_data);
-        first_setup_data = prot_addr + setup_data_offset;
+        first_setup_data = cmdline_addr + ((void *)setup_data - (void *)kernel_cmdline);
         setup_data->type = cpu_to_le32(SETUP_DTB);
         setup_data->len = cpu_to_le32(dtb_size);
-
         load_image_size(dtb_filename, setup_data->data, dtb_size);
     }
 
-    if (!legacy_no_rng_seed) {
-        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(SetupData) + RNG_SEED_LENGTH;
-        kernel = g_realloc(kernel, kernel_size);
-        setup_data = (SetupData *)(kernel + setup_data_offset);
+    if (!legacy_no_rng_seed && protocol >= 0x209) {
+        cmdline_size += sizeof(SetupData) + RNG_SEED_LENGTH;
+        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
+        setup_data = (void *)kernel_cmdline + cmdline_size - (sizeof(SetupData) + RNG_SEED_LENGTH);
         setup_data->next = cpu_to_le64(first_setup_data);
-        first_setup_data = prot_addr + setup_data_offset;
+        first_setup_data = cmdline_addr + ((void *)setup_data - (void *)kernel_cmdline);
         setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
         setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
         qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
@@ -1122,6 +1116,12 @@ void x86_load_linux(X86MachineState *x86ms,
         fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
     }
 
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, cmdline_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline, cmdline_size);
+    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
+    sev_load_ctx.cmdline_size = cmdline_size;
+
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
     sev_load_ctx.kernel_data = (char *)kernel;
@@ -1134,7 +1134,7 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel on the other side of the fw_cfg interface matches the hash of the
      * file the user passed in.
      */
-    if (!sev_enabled()) {
+    if (!sev_enabled() && first_setup_data) {
         SetupDataFixup *fixup = g_malloc(sizeof(*fixup));
 
         memcpy(setup, header, MIN(sizeof(header), setup_size));
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index a00881bc64..432754eda4 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -741,6 +741,15 @@ void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
     fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true);
 }
 
+void *fw_cfg_read_bytes_ptr(FWCfgState *s, uint16_t key)
+{
+    int arch = !!(key & FW_CFG_ARCH_LOCAL);
+
+    key &= FW_CFG_ENTRY_MASK;
+    assert(key < fw_cfg_max_entry(s));
+    return s->entries[arch][key].data;
+}
+
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
 {
     size_t sz = strlen(value) + 1;
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index fad97a891d..e8af61f194 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -50,8 +50,9 @@
  */
 
 /* Platform virtio definitions */
-#define VIRTIO_MMIO_BASE      0xfeb00000
-#define VIRTIO_CMDLINE_MAXLEN 64
+#define VIRTIO_MMIO_BASE                0xfeb00000
+#define VIRTIO_CMDLINE_MAXLEN           64
+#define VIRTIO_CMDLINE_TOTAL_MAX_LEN    ((VIRTIO_CMDLINE_MAXLEN + 1) * 16)
 
 #define GED_MMIO_BASE         0xfea00000
 #define GED_MMIO_BASE_MEMHP   (GED_MMIO_BASE + 0x100)
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 2e503904dc..990dcdbb2e 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -139,6 +139,15 @@ void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
                                void *data, size_t len,
                                bool read_only);
 
+/**
+ * fw_cfg_read_bytes_ptr:
+ * @s: fw_cfg device being modified
+ * @key: selector key value for new fw_cfg item
+ *
+ * Reads an existing fw_cfg data pointer.
+ */
+void *fw_cfg_read_bytes_ptr(FWCfgState *s, uint16_t key);
+
 /**
  * fw_cfg_add_string:
  * @s: fw_cfg device being modified
-- 
2.39.0

