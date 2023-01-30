Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984468162D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjA3QRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjA3QRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:17:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC772726
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:17:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18EBB1EC0645;
        Mon, 30 Jan 2023 17:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675095436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SYkUvMceHmQv4CWJzaHm7dllYvbghnGU+k2S37WGWE=;
        b=PQabSffDgDJpaBVkhERnOz7WPcn3aTjUShARnx32aKil7Q30xd3/zFlTIULwGVFVRWo1RN
        qqgZ+nvPKKszrV0tU9tmMK2RBb7kFz2p1PlfAJy7DNDeQKVZ9frANGhVcV1DcthLo0YHz5
        IFdorUK/5e1zoYiMmJMAtOeyYvrEWOE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] x86/microcode/amd: Remove load_microcode_amd()'s bsp parameter
Date:   Mon, 30 Jan 2023 17:17:06 +0100
Message-Id: <20230130161709.11615-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230130161709.11615-1-bp@alien8.de>
References: <20230130161709.11615-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It is always the BSP.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 56471f750762..f41ea46475ac 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -553,8 +553,7 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 	apply_microcode_early_amd(cpuid_1_eax, cp.data, cp.size, false);
 }
 
-static enum ucode_state
-load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 {
@@ -572,7 +571,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	if (!desc.mc)
 		return -EINVAL;
 
-	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
+	ret = load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
 	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
@@ -850,8 +849,7 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	return UCODE_OK;
 }
 
-static enum ucode_state
-load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
+static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
 	struct ucode_patch *p;
 	enum ucode_state ret;
@@ -875,10 +873,6 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 		ret = UCODE_NEW;
 	}
 
-	/* save BSP's matching patch for early load */
-	if (!save)
-		return ret;
-
 	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
 	memcpy(amd_ucode_patch, p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
 
@@ -905,14 +899,9 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	enum ucode_state ret = UCODE_NFOUND;
 	const struct firmware *fw;
 
-	/* reload ucode container only on the boot cpu */
-	if (!bsp)
-		return UCODE_OK;
-
 	if (c->x86 >= 0x15)
 		snprintf(fw_name, sizeof(fw_name), "amd-ucode/microcode_amd_fam%.2xh.bin", c->x86);
 
@@ -925,7 +914,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
 
-	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(c->x86, fw->data, fw->size);
 
  fw_release:
 	release_firmware(fw);
-- 
2.35.1

