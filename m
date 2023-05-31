Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C47718E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjEaWOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEaWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBDE5A;
        Wed, 31 May 2023 15:13:50 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9gPpVY6uFe9zQYYB935R56xd8npqMVa5jD3LWmJEDr4=;
        b=OGoVl+dTMoYp60F1IcVSmgU8xNfjrNzyDIBtvgGs61diPKm0eOwLl6MmdaKTHjZHmWjWlq
        lp5pvp8bUmnduy6ik80zz0eHL/Huuluewy4vs1d2ID6IBiNwacR9wRkemUVT6z6mxEco/z
        BHukA3Y4Kr5Yq9Isk2++Wh3UFnYUgIH3xeo8oXmtSFHEubiLSE4fo+DxlyLdxZTmFgrgpR
        MmJzsX78Kf0tzbi75z2IL39EFlok1t2lxDg8cvAxUHTGtpWlU5Aq7IdYoytqydhWn9AV9q
        ugaylbioImkQLZbJBy6QIQ43hqRdQcnqlr5dbQ7fZEJtYirSJ751kGc/YMSs+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9gPpVY6uFe9zQYYB935R56xd8npqMVa5jD3LWmJEDr4=;
        b=iXi59UlvWmCp4u0PcHc7APUV9lJuLgPUA/DE/fzZ3IPnPsF3GhzsPfXC/UhkvO10BrTelp
        9QSu4cH+O6Yr9KDQ==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update UV[23] platform code for SNC
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121408.404.10546775442593930020.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     73b3108dfd9d53ea565c0777a27007c1c621467d
Gitweb:        https://git.kernel.org/tip/73b3108dfd9d53ea565c0777a27007c1c621467d
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:52 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:35:00 -07:00

x86/platform/uv: Update UV[23] platform code for SNC

Previous Sub-NUMA Clustering changes need not just a count of blades
present, but a count that includes any missing ids for blades not
present; in other words, the range from lowest to highest blade id.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-9-steve.wahl%40hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 42 ++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1836330..d9384d5 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1462,11 +1462,37 @@ static int __init decode_uv_systab(void)
 	return 0;
 }
 
+/*
+ * Given a bitmask 'bits' representing presnt blades, numbered
+ * starting at 'base', masking off unused high bits of blade number
+ * with 'mask', update the minimum and maximum blade numbers that we
+ * have found.  (Masking with 'mask' necessary because of BIOS
+ * treatment of system partitioning when creating this table we are
+ * interpreting.)
+ */
+static inline void blade_update_min_max(unsigned long bits, int base, int mask, int *min, int *max)
+{
+	int first, last;
+
+	if (!bits)
+		return;
+	first = (base + __ffs(bits)) & mask;
+	last =  (base + __fls(bits)) & mask;
+
+	if (*min > first)
+		*min = first;
+	if (*max < last)
+		*max = last;
+}
+
 /* Set up physical blade translations from UVH_NODE_PRESENT_TABLE */
 static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 {
 	unsigned long np;
 	int i, uv_pb = 0;
+	int sock_min = INT_MAX, sock_max = -1, s_mask;
+
+	s_mask = (1 << uv_cpuid.n_skt) - 1;
 
 	if (UVH_NODE_PRESENT_TABLE) {
 		pr_info("UV: NODE_PRESENT_DEPTH = %d\n",
@@ -1474,23 +1500,31 @@ static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 		for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
 			np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
 			pr_info("UV: NODE_PRESENT(%d) = 0x%016lx\n", i, np);
-			uv_pb += hweight64(np);
+			blade_update_min_max(np, i * 64, s_mask, &sock_min, &sock_max);
 		}
 	}
 	if (UVH_NODE_PRESENT_0) {
 		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
 		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
-		uv_pb += hweight64(np);
+		blade_update_min_max(np, 0, s_mask, &sock_min, &sock_max);
 	}
 	if (UVH_NODE_PRESENT_1) {
 		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
 		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
-		uv_pb += hweight64(np);
+		blade_update_min_max(np, 64, s_mask, &sock_min, &sock_max);
+	}
+
+	/* Only update if we actually found some bits indicating blades present */
+	if (sock_max >= sock_min) {
+		_min_socket = sock_min;
+		_max_socket = sock_max;
+		uv_pb = sock_max - sock_min + 1;
 	}
 	if (uv_possible_blades != uv_pb)
 		uv_possible_blades = uv_pb;
 
-	pr_info("UV: number nodes/possible blades %d\n", uv_pb);
+	pr_info("UV: number nodes/possible blades %d (%d - %d)\n",
+		uv_pb, sock_min, sock_max);
 }
 
 static int __init alloc_conv_table(int num_elem, unsigned short **table)
