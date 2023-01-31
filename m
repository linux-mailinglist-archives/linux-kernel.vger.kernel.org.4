Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4776820FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAaAse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjAaAsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:48:32 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD872A14B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:48:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id l6-20020a17090a72c600b0022bffd5f3ffso5232119pjk.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKUtIBE/ENkRt4RJuzSzMJ8r5Hrq45eiIYmJfbJ+24Y=;
        b=fN8EIj+8JoBBckZaxE6iEHhLf1kuoFjMyok3nPClcggajWZw3/2O4mVTQM0M1XGmRk
         eDWUBf2JIiP+Qsp0nZXK+hazChMgcFVKjmotnW8P1Pjpiiq2IHYpfHxnSSk8EYJHuauy
         LP9EU2TFSm82hBPv3OSRsF3GBYQUonMd0Ql59kKBKfgOcXEPtDbRjEDTyG5Ajao5Vb1h
         Q/0MJozKoY87SlrzX/6bIotSOCxxyM8i9snC0ZAozfROWeAFSI0+UK7+Zw7a1W8GreWe
         efUYxGyGBVzSORwI+mXbisR1R/SCpQ85UNeusZDx0wY9AQJ0S6Iax8lEm/FR7MkAJ+qK
         qx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKUtIBE/ENkRt4RJuzSzMJ8r5Hrq45eiIYmJfbJ+24Y=;
        b=xtYFjInzLpQKPjGSjBTYE4V5sKsRL/IQ4IjVVYSStBQeIPKy9twXceCyMbdzPQNkGH
         rhpeexRWHDgcEjzAofNj6he2ps7FiycvqawXbolRUXeZPWg8uuj+O6FbPJNwfQmWO/Ce
         D1QbhBKGtexqBiBUm8XV4LbsfzmKwwG+apTz5mEGOH3GJEsKr/j3IjHGrnV/MHPb0xHB
         G9pxBDKdD/KC2dTE8sGpVVYWQjPzU5ywnkV+F9Gv7/mYdDhmWIjy3KRXsWQ0eEIU/Soq
         UPlVGE0uV9HHi98Z7SZR0PAdLOgW9WE9ST2RERtKvC8z0qGU8QLK1UUoTNi3DXWHHkJD
         r7tw==
X-Gm-Message-State: AO0yUKWOd9JRwFKL2CazadVesnAWUaK7QCIsv04lYP0izuxXrzmxBk+h
        GeU07rRQadA7Tks054uXGRbayGKLUg9yxg1xLGXY5BQKW+8xYPksFZqSaTM38su7BrCP/6mA3Nu
        yPb7SHS3vhCqT2GYWH/U6SGqrPMYp63UAvy14nGN0YMKpbbZbgJF3GA3XyMRAmusO3xlB4RfpKz
        Ngi/i1vJQ=
X-Google-Smtp-Source: AK7set+5JVP7ro2YuXE8zZprXiBqj+NTnMQ7KfjXZgshhJRNRTpVuEWdEyCTaIG1XijdszOEdTYwujTJJP90pDjiZw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:41c9:b0:196:77ef:d51f with
 SMTP id u9-20020a17090341c900b0019677efd51fmr1124324ple.19.1675126110077;
 Mon, 30 Jan 2023 16:48:30 -0800 (PST)
Date:   Tue, 31 Jan 2023 00:48:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131004825.153120-1-dionnaglaze@google.com>
Subject: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on Kirill A. Shutemov's series

[PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory

The UEFI v2.9 specification includes a new memory type to be used in
environments where the OS must accept memory that is provided from its
host. Before the introduction of this memory type, all memory was
accepted eagerly in the firmware. In order for the firmware to safely
stop accepting memory on the OS's behalf, the OS must affirmatively
indicate support to the firmware. This is only a problem for AMD
SEV-SNP, since Linux has had support for it since 5.19. The other
technology that can make use of unaccepted memory, Intel TDX, does not
yet have Linux support, so it can strictly require unaccepted memory
support as a dependency of CONFIG_TDX and not require communication with
the firmware.

Enabling unaccepted memory requires calling a 0-argument enablement
protocol before ExitBootServices. This call is only made if the kernel
is compiled with UNACCEPTED_MEMORY=y

This protocol will be removed after the end of life of the first LTS
that includes it, in order to give firmware implementations an
expiration date for it. When the protocol is removed, firmware will
strictly infer that a SEV-SNP VM is running an OS that supports the
unaccepted memory type. At the earliest convenience, when unaccepted
memory support is added to Linux, SEV-SNP may take strict dependence in
it. After the firmware removes support for the protocol, this patch
should be reverted.

Change since v1:
* protocol name, as it is in OVMF
https://github.com/tianocore/edk2/commit/26847fb6be7fff83a834a3154224588afede0073
* protocol typedef moved before struct definition.

Cc: Ard Biescheuvel <ardb@kernel.org>
Cc: "Min M. Xu" <min.m.xu@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Jiewen Yao <jiewen.yao@intel.com>
Cc: Erdem Aktas <erdemaktas@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 37 +++++++++++++++++++++++++
 include/linux/efi.h                     |  4 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba..e4c04444edab 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 
+typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
+union sev_memory_acceptance_protocol {
+	struct {
+		efi_status_t (__efiapi *allow_unaccepted_memory)(
+			sev_memory_acceptance_protocol_t *);
+	};
+	struct {
+		u32 allow_unaccepted_memory;
+	} mixed_mode;
+};
+
 static efi_status_t
 preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
@@ -310,6 +321,30 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 #endif
 }
 
+
+static void setup_unaccepted_memory(void)
+{
+	efi_guid_t mem_acceptance_proto = OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
+	sev_memory_acceptance_protocol_t *proto;
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
+		return;
+
+	/*
+	 * Enable unaccepted memory before calling exit boot services in order
+	 * for the UEFI to not accept all memory on EBS.
+	 */
+	status = efi_bs_call(locate_protocol, &mem_acceptance_proto, NULL,
+			     (void **)&proto);
+	if (status != EFI_SUCCESS)
+		return;
+
+	status = efi_call_proto(proto, allow_unaccepted_memory);
+	if (status != EFI_SUCCESS)
+		efi_err("Memory acceptance protocol failed\n");
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params,
@@ -899,6 +934,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
+	setup_unaccepted_memory();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4b27519143f5..ac812978a03a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -434,6 +434,10 @@ void efi_native_runtime_setup(void);
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
 #define AMD_SEV_MEM_ENCRYPT_GUID		EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
 
+/* OVMF protocol GUIDs */
+#define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
+
+
 typedef struct {
 	efi_guid_t guid;
 	u64 table;
-- 
2.39.1.456.gfc5497dd1b-goog

