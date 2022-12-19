Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239665149D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiLSVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiLSVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:07:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B738658E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:07:05 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B5791EC06BD;
        Mon, 19 Dec 2022 22:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671484024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=MByHgzFX5cGadc/iCmDfTBFOsEvG/OTjvsaoiKY5w5c=;
        b=p6chidnhhfgmd8BMp/hbmwtXq4aCFgP8OdZDwSqaS339dEMOtR/MVXWqkwSGTqh0OZdkZr
        m5GO6CGWBj0GmTNwi7gjLutwML0FU7VCvbko2tOeTLtliYHkLZ/TfoJsi0RXuJZlWvg18h
        cLOE8HnquxRXC2zKYq3O75BGrjs4aUc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/microcode/AMD: Rename a couple of functions
Date:   Mon, 19 Dec 2022 22:06:55 +0100
Message-Id: <20221219210656.5140-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
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

From: Borislav Petkov <bp@suse.de>

- Rename apply_microcode_early_amd() to early_apply_microcode():
simplify the name so that it is clear what it does and when does it do
it.

- Rename __load_ucode_amd() to find_blobs_in_containers(): the new name
actually explains what it does.

Document some.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 56471f750762..339c9666c8bc 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -414,8 +414,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool
-apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
+static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
 {
 	struct cont_desc desc = { 0 };
 	u8 (*patch)[PATCH_MAX_SIZE];
@@ -481,7 +480,7 @@ static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 	return false;
 }
 
-static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
+static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
 {
 	struct ucode_cpu_info *uci;
 	struct cpio_data cp;
@@ -511,11 +510,11 @@ void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
 
-	__load_ucode_amd(cpuid_1_eax, &cp);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return;
 
-	apply_microcode_early_amd(cpuid_1_eax, cp.data, cp.size, true);
+	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, true);
 }
 
 void load_ucode_amd_ap(unsigned int cpuid_1_eax)
@@ -546,11 +545,11 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 		}
 	}
 
-	__load_ucode_amd(cpuid_1_eax, &cp);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return;
 
-	apply_microcode_early_amd(cpuid_1_eax, cp.data, cp.size, false);
+	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, false);
 }
 
 static enum ucode_state
@@ -816,6 +815,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	return 0;
 }
 
+/* Scan the blob in @data and add microcode patches to the cache. */
 static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 					     size_t size)
 {
-- 
2.35.1

