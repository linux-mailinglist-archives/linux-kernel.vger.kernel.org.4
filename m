Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F796658C19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiL2LNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiL2LNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:13:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD312A9B;
        Thu, 29 Dec 2022 03:13:48 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:13:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672312426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VnpK1nkYAe3Br6uKqNc2H7ZpVwGG1Y3w1UxSUJcI+oQ=;
        b=BZiot/nV3Jg3RSrJs2J8wQ93DclDbl7A2lwCPfQaptVe8H+ZP9q3mTeuzAZW74L2EQkCTg
        NTUwHipCCELbY3CLzeYhAOdK+U5lCivNO2hTN/O2IRpGo7iP+vu4o0Rh+nTIZEczpNoIBu
        Bc2nTTIWitoQ3U4IXe4hbGt8LrZ/YrL2N6NdlL4qEumPFRY09bZ7bVlC4Tmh8btI+1y7la
        94x/BuWgY3PuZR5jTvzwdlLRyxCwTN//s1fHy348hMuCL2mfZ3FAtrmNdKlDxLxZ1sPE+n
        SpnJng5YaTjwCzjGCDp8LZISvNVkAs6so2AeKAhG00+biymqTBuOqPgnyKHy0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672312426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VnpK1nkYAe3Br6uKqNc2H7ZpVwGG1Y3w1UxSUJcI+oQ=;
        b=qyu8zCZIWCUvrY3YxgL5mTpfIMVlvkfqSzOQXNowd8+29kdJxIClICGkORpgrp9uVH4KJA
        jkYkohQTqoLbCCDQ==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Define a function to extract ErrorAddr from MCA_ADDR
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167231242579.4906.1017232750066168905.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     2117654e806c08c343e3d0567bbedf33eab040c8
Gitweb:        https://git.kernel.org/tip/2117654e806c08c343e3d0567bbedf33eab040c8
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Tue, 06 Dec 2022 11:36:06 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Dec 2022 22:11:48 +01:00

x86/mce: Define a function to extract ErrorAddr from MCA_ADDR

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored to support extended ErrorAddr bits in MCA_ADDR
in newer AMD CPUs.

  [ bp: Massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/all/20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com/
---
 arch/x86/kernel/cpu/mce/amd.c      | 10 +---------
 arch/x86/kernel/cpu/mce/core.c     | 10 +---------
 arch/x86/kernel/cpu/mce/internal.h | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 10fb5b5..c6b1fd5 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -736,15 +736,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (m.status & MCI_STATUS_ADDRV) {
 		m.addr = addr;
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c..d0ade77 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -633,15 +633,7 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 			m->addr <<= shift;
 		}
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 7e03f5b..6dcb94f 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -189,8 +189,23 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+
+/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
+static __always_inline void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb;
+
+	if (!mce_flags.smca)
+		return;
+
+	lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
+static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE
