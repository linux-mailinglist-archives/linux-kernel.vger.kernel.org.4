Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F19E658C18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiL2LNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2LNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:13:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4B12A99;
        Thu, 29 Dec 2022 03:13:48 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:13:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672312426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggG9V250zF7THnyKowlPbOF/35JWH505/2cKT69U4AM=;
        b=HmxhqKQaBBbJjWGVhoyVp6WeA7GwFjnVSBljmy1EMuvoEWGm18wnV136IxnfX6IaOnT9oh
        62LmBDYmxPgfuObgRYBWxuC8SpeobIkyp7SuKKepuzGIMkwq0qL6eP5nUVUC354fKE5mYN
        pGaxImr7pdSanfNgQbMojLBoDqyKdaMafTEt9Ide5+j56NHMn1RhCACUPE0Fntr3r4UvuD
        zCOvjn4DpBgQSr5DTRHQ/ZSby3AZoR3xBA00OzOYUhMAphk1w2LUZjMPE1wGDsKkFeUU6o
        BBcFL3D8nR5pKD/7kabvd5R/Gw+b4OUdjYm+oYyiapEM1f1Kzx5dChFACO+FcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672312426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggG9V250zF7THnyKowlPbOF/35JWH505/2cKT69U4AM=;
        b=KxQw747jdHnzwFkZnXMUJw/iF2CWRUhhoG8S4F7wNXI5oFt3FI+kXN9cIIde8UtV2ifHaV
        qgi+vMyocyQn9JCg==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add support for Extended Physical Address
 MCA changes
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221206173607.1185907-5-yazen.ghannam@amd.com>
References: <20221206173607.1185907-5-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <167231242539.4906.2144083463011188100.tip-bot2@tip-bot2>
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

Commit-ID:     fcd343a285cb41894a7bd02dbd675042d394758d
Gitweb:        https://git.kernel.org/tip/fcd343a285cb41894a7bd02dbd675042d394758d
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Tue, 06 Dec 2022 11:36:07 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Dec 2022 22:37:37 +01:00

x86/mce: Add support for Extended Physical Address MCA changes

Newer AMD CPUs support more physical address bits.

That is, the MCA_ADDR registers on Scalable MCA systems contain the
ErrorAddr in bits [56:0] instead of [55:0]. Hence, the existing LSB field
from bits [61:56] in MCA_ADDR must be moved around to accommodate the
larger ErrorAddr size.

MCA_CONFIG[McaLsbInStatusSupported] indicates this change. If set, the
LSB field will be found in MCA_STATUS rather than MCA_ADDR.

Each logical CPU has unique MCA bank in hardware and is not shared with
other logical CPUs. Additionally, on SMCA systems, each feature bit may
be different for each bank within same logical CPU.

Check for MCA_CONFIG[McaLsbInStatusSupported] for each MCA bank and for
each CPU.

Additionally, all MCA banks do not support maximum ErrorAddr bits in
MCA_ADDR. Some banks might support fewer bits but the remaining bits are
marked as reserved.

  [ Yazen: Rebased and fixed up formatting.
    bp: Massage comments. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221206173607.1185907-5-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c      |  2 ++-
 arch/x86/kernel/cpu/mce/core.c     |  8 +-------
 arch/x86/kernel/cpu/mce/internal.h | 31 ++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c6b1fd5..23c5072 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -306,6 +306,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		if ((low & BIT(5)) && !((high >> 5) & 0x3))
 			high |= BIT(5);
 
+		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
+
 		wrmsr(smca_config, low, high);
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d0ade77..626a1c6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -67,13 +67,7 @@ DEFINE_PER_CPU(unsigned, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-
-	__u64 init			: 1,		/* initialise bank? */
-	      __reserved_1		: 63;
-};
-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
 #define ATTR_LEN               16
 /* One object for each MCE bank, shared by all CPUs */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 6dcb94f..91a4155 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -177,6 +177,24 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
+struct mce_bank {
+	/* subevents to enable */
+	u64			ctl;
+
+	/* initialise bank? */
+	__u64 init		: 1,
+
+	/*
+	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: When set, this bit indicates
+	 * the LSB field is found in MCA_STATUS and not in MCA_ADDR.
+	 */
+	lsb_in_status		: 1,
+
+	__reserved_1		: 62;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
 enum mca_msr {
 	MCA_CTL,
 	MCA_STATUS,
@@ -190,7 +208,10 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 
-/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
+/*
+ * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
+ * [56:0] of MCA_STATUS, else in bits [55:0] of MCA_ADDR.
+ */
 static __always_inline void smca_extract_err_addr(struct mce *m)
 {
 	u8 lsb;
@@ -198,6 +219,14 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	if (!mce_flags.smca)
 		return;
 
+	if (this_cpu_ptr(mce_banks_array)[m->bank].lsb_in_status) {
+		lsb = (m->status >> 24) & 0x3f;
+
+		m->addr &= GENMASK_ULL(56, lsb);
+
+		return;
+	}
+
 	lsb = (m->addr >> 56) & 0x3f;
 
 	m->addr &= GENMASK_ULL(55, lsb);
