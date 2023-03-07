Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EFA6AE1B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCGOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCGOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640C85A59
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51F446145A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16AAC433A7;
        Tue,  7 Mar 2023 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198012;
        bh=owcyJumNf3y3cUM/cEIpL/WydIOtZp+T7x6pIbYv5Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMwvFmNaNLM5W+HA7V2dgWKjjWKcBz/DZvm04RAG5GfmFb6yT1tAmIveKyH1pM2wq
         BL3E8LHRLShEu2ySQqp7GfnYXgCWnk9GSqVxNpeEyIQ58En3oYbQxMS3JYwPiz0Cam
         67R+wYayd/NIgXduNmlfn+0iLBXl1mvRUakys3n/gX/+YMUfk7JFM/GcYjPilL6Amc
         sJGo+d66g8V23Q2RdFHTigfp1UHFr+CZ/l6oL1CECHnKl/eOW9dONRbghBB0xN7AsQ
         8KOgKPDZ5tBrGsHSlVzFbHQF7F7II74rQ8FAzceFvMx2PksCOGq7HA/gLs0rDBQve/
         crgdftJzmEolA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 06/60] arm64: ptdump: Allow VMALLOC_END to be defined at boot
Date:   Tue,  7 Mar 2023 15:04:28 +0100
Message-Id: <20230307140522.2311461-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=ardb@kernel.org; h=from:subject; bh=owcyJumNf3y3cUM/cEIpL/WydIOtZp+T7x6pIbYv5Io=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhSvk+ObO1Ru4vzoqOIfUCvQvbOgJZJkd/jBFb/8tK 8MjjCodpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCK5fAx/hQ8bmR/2SjTx8QyM XJe158Os2D8H/C/dn700REz/JNMKeUaGvfMPuP6NtT92ul/H7NBXeZeQNtmGCK/rLD5XlM9tDN7 ABwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing pattern for populating ptdump marker entries at
boot, and add handling of VMALLOC_END, which will cease to be a compile
time constant for configurations that support 52-bit virtual addressing.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/ptdump.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 76d28056bd14920a..910b35f02280cbdb 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -31,7 +31,12 @@ enum address_markers_idx {
 	PAGE_END_NR,
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	KASAN_START_NR,
+	KASAN_END_NR,
 #endif
+	MODULES_NR,
+	MODULES_END_NR,
+	VMALLOC_START_NR,
+	VMALLOC_END_NR,
 };
 
 static struct addr_marker address_markers[] = {
@@ -44,7 +49,7 @@ static struct addr_marker address_markers[] = {
 	{ MODULES_VADDR,		"Modules start" },
 	{ MODULES_END,			"Modules end" },
 	{ VMALLOC_START,		"vmalloc() area" },
-	{ VMALLOC_END,			"vmalloc() end" },
+	{ 0,				"vmalloc() end" },
 	{ VMEMMAP_START,		"vmemmap start" },
 	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
 	{ PCI_IO_START,			"PCI I/O start" },
@@ -379,6 +384,7 @@ static int __init ptdump_init(void)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
 #endif
+	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
 	return 0;
-- 
2.39.2

