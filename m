Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8336568D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiL0J1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0J1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:27:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCC8FE4;
        Tue, 27 Dec 2022 01:27:38 -0800 (PST)
Date:   Tue, 27 Dec 2022 09:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672133256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G45h4mJydrKFB6s8sXYpIuCSVW4EG73G4/kyR75n868=;
        b=3SzKXc4LhqdGwdqkjGyOyxF1MSKtUV4Ysszh/8ig5Xz1WLy6x/rJnk9InINxN1McmI15L3
        boxgqGhksKZiLXjrXZexFWBd7ewCp999KdCVYJDfy7+owPX0SEvs+vVClV/jaQkqDQkFc+
        Yg1wad4YJ1nrhYrE/4mxVn9BlqT9YPe0DiV0giqhcKyrLZrqawIOmyIeA07xGjBK5pHlH3
        9LufzGmTxNGd3QkTmQVtI7FX4xwcyQNHUzkCenKkHhCgf6BBEx415RpQDtIENqp2zTsdnw
        9Fk39WCq7GBQVy3QFlvFf1Ufto535f41hTYVlwhwuSA7ohQ+hFR0AtOUFEVIlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672133256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G45h4mJydrKFB6s8sXYpIuCSVW4EG73G4/kyR75n868=;
        b=CVboox00EBIs6KYnorra7EA+EDYbBVcPqJRrg3zxj8hIc9MB0XkFN80Jci4FvscViv9/Kp
        IkJp+H5XoKoBAqAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Rename a couple of functions
Cc:     Borislav Petkov <bp@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221219210656.5140-1-bp@alien8.de>
References: <20221219210656.5140-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167213325533.4906.16900730747128544891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     61de9b7036f26448a1916291c456f62dd6bf07ea
Gitweb:        https://git.kernel.org/tip/61de9b7036f26448a1916291c456f62dd6bf07ea
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 19 Dec 2022 22:06:55 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 26 Dec 2022 06:30:31 +01:00

x86/microcode/AMD: Rename a couple of functions

- Rename apply_microcode_early_amd() to early_apply_microcode():
simplify the name so that it is clear what it does and when does it do
it.

- Rename __load_ucode_amd() to find_blobs_in_containers(): the new name
actually explains what it does.

Document some.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221219210656.5140-1-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 56471f7..339c966 100644
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
