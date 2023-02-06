Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9468BD6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBFNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBFNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:00:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7723326;
        Mon,  6 Feb 2023 05:00:09 -0800 (PST)
Date:   Mon, 06 Feb 2023 13:00:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEIq5IFNtGsUPsG0wsMPoSRidRh0YOa3DY1/lxlVxtk=;
        b=3o010HnIpgHSPzMS+T9SqDuETKyC8Xa5+Odv/qXcs3Cg4l0peCAPe5jArOw8IBkQN94KQh
        +sXfjxuu16OB1fw7z+h3Vy+Hu4mXfZ3hz39x1AjYIH1zNmwC/oMjSevVdps6gWDqfGcd9X
        8GKaS+qcg++fnoclEgoPUPu2Yw5JGivaRwh25M/fkqBtLzwyXVCLyiaTqEArMdGsxvx4F2
        eF/S13ZkFheiVlFd6hGbwyfTMwHaAzF2b7oihoZGvA/KN4f3HjmTemjv9GaKZD5CktBQBe
        KSNiJDqPpe3G/rIfsmJOnLgA0M2Y3Sv27/TEDx/vvnyF42MQivmrW6gduCmhJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEIq5IFNtGsUPsG0wsMPoSRidRh0YOa3DY1/lxlVxtk=;
        b=eeyZPsvXxd4UQajsgwGUkYbPOlINOefaLNmf7BYmVn5K+V2Jb9XB7xJx5E8T/knNlnYnqx
        JX54dhg8sFYOMbDA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Fix mixed steppings support
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230130161709.11615-4-bp@alien8.de>
References: <20230130161709.11615-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167568840579.4906.7552480093445585238.tip-bot2@tip-bot2>
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

Commit-ID:     7ff6edf4fef38ab404ee7861f257e28eaaeed35f
Gitweb:        https://git.kernel.org/tip/7ff6edf4fef38ab404ee7861f257e28eaaeed35f
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 26 Jan 2023 16:26:17 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Feb 2023 13:40:16 +01:00

x86/microcode/AMD: Fix mixed steppings support

The AMD side of the loader has always claimed to support mixed
steppings. But somewhere along the way, it broke that by assuming that
the cached patch blob is a single one instead of it being one per
*node*.

So turn it into a per-node one so that each node can stash the blob
relevant for it.

  [ NB: Fixes tag is not really the exactly correct one but it is good
    enough. ]

Fixes: fe055896c040 ("x86/microcode: Merge the early microcode loader")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org> # 2355370cd941 ("x86/microcode/amd: Remove load_microcode_amd()'s bsp parameter")
Cc: <stable@kernel.org> # a5ad92134bd1 ("x86/microcode/AMD: Add a @cpu parameter to the reloading functions")
Link: https://lore.kernel.org/r/20230130161709.11615-4-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 34 +++++++++++++++++-----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 1023be6..9eb457b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -55,7 +55,9 @@ struct cont_desc {
 };
 
 static u32 ucode_new_rev;
-static u8 amd_ucode_patch[PATCH_MAX_SIZE];
+
+/* One blob per node. */
+static u8 amd_ucode_patch[MAX_NUMNODES][PATCH_MAX_SIZE];
 
 /*
  * Microcode patch container file is prepended to the initrd in cpio
@@ -428,7 +430,7 @@ static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t size, boo
 	patch	= (u8 (*)[PATCH_MAX_SIZE])__pa_nodebug(&amd_ucode_patch);
 #else
 	new_rev = &ucode_new_rev;
-	patch	= &amd_ucode_patch;
+	patch	= &amd_ucode_patch[0];
 #endif
 
 	desc.cpuid_1_eax = cpuid_1_eax;
@@ -580,10 +582,10 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 
 void reload_ucode_amd(unsigned int cpu)
 {
-	struct microcode_amd *mc;
 	u32 rev, dummy __always_unused;
+	struct microcode_amd *mc;
 
-	mc = (struct microcode_amd *)amd_ucode_patch;
+	mc = (struct microcode_amd *)amd_ucode_patch[cpu_to_node(cpu)];
 
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
@@ -852,6 +854,8 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
+	struct cpuinfo_x86 *c;
+	unsigned int nid, cpu;
 	struct ucode_patch *p;
 	enum ucode_state ret;
 
@@ -864,18 +868,22 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 		return ret;
 	}
 
-	p = find_patch(0);
-	if (!p) {
-		return ret;
-	} else {
-		if (boot_cpu_data.microcode >= p->patch_id)
-			return ret;
+	for_each_node(nid) {
+		cpu = cpumask_first(cpumask_of_node(nid));
+		c = &cpu_data(cpu);
+
+		p = find_patch(cpu);
+		if (!p)
+			continue;
+
+		if (c->microcode >= p->patch_id)
+			continue;
 
 		ret = UCODE_NEW;
-	}
 
-	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
-	memcpy(amd_ucode_patch, p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
+		memset(&amd_ucode_patch[nid], 0, PATCH_MAX_SIZE);
+		memcpy(&amd_ucode_patch[nid], p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
+	}
 
 	return ret;
 }
