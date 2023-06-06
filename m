Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A85724D55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbjFFTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbjFFTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF810FB;
        Tue,  6 Jun 2023 12:42:38 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5R2sL6rKsk29qzEv5zQGnq6eOM/ZoNfbjetALpWF/A=;
        b=ZGqLOq/6wFR4YOecZJuBk1Kt0Cyoj7YaDNUn5kH6Xi+gsMcihpBtvggfDsGvQoTF18PEkg
        hXgkKSwOi9/WT4zbyOlZhDlRQtFKIfUvDhNDpECTyaszz6Vw3Nlzjr3IcYaXy1Jy0fRhRG
        9Li5qaYeVnc+Di3+928FfnHNn3ia0Z/T2HsWGUq8QXz/C3AeyNGdjAs50ja75EgH5gow+E
        C436OrBGHqRgg96g+fCLNijyQffe/NIojS16W0sQvKOQRtFtZYSCxX/Hf3DIRwTOn/et40
        o/VXdwcnnO4O38+n/TupVFCAX6120gIXnEFjdkprKEHxG3VaCBR2T5JU5IAT0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5R2sL6rKsk29qzEv5zQGnq6eOM/ZoNfbjetALpWF/A=;
        b=KFxUMXXxu3vPCog24k9p3CA2msRAbtZlaSkT99NFPgcnSyLbLK0ZR+kZ1VJCn0z/ivFsT3
        rZzd0k/FcBKsd4BQ==
From:   "tip-bot2 for Dionna Glaze" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/efi: Safely enable unaccepted memory in UEFI
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0d5f3d9a20b5cf361945b7ab1263c36586a78a42=2E16860?=
 =?utf-8?q?63086=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C0d5f3d9a20b5cf361945b7ab1263c36586a78a42=2E168606?=
 =?utf-8?q?3086=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168608055573.404.11417198471686782791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     c0461bd16666351f0de11578b1e02dcdae4db736
Gitweb:        https://git.kernel.org/tip/c0461bd16666351f0de11578b1e02dcdae4db736
Author:        Dionna Glaze <dionnaglaze@google.com>
AuthorDate:    Tue, 06 Jun 2023 09:51:27 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 18:32:59 +02:00

x86/efi: Safely enable unaccepted memory in UEFI

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
it. After the firmware removes support for the protocol, this should be
reverted.

  [tl: address some checkscript warnings]

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/0d5f3d9a20b5cf361945b7ab1263c36586a78a42.1686063086.git.thomas.lendacky@amd.com
---
 drivers/firmware/efi/libstub/x86-stub.c | 36 ++++++++++++++++++++++++-
 include/linux/efi.h                     |  3 ++-
 2 files changed, 39 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3cc7faa..220be75 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
 u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 
+typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
+union sev_memory_acceptance_protocol {
+	struct {
+		efi_status_t (__efiapi * allow_unaccepted_memory)(
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
@@ -310,6 +321,29 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 #endif
 }
 
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
@@ -908,6 +942,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 
 	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
 
+	setup_unaccepted_memory();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 67cb72d..18d83a6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -437,6 +437,9 @@ void efi_native_runtime_setup(void);
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
 #define AMD_SEV_MEM_ENCRYPT_GUID		EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
 
+/* OVMF protocol GUIDs */
+#define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
+
 typedef struct {
 	efi_guid_t guid;
 	u64 table;
