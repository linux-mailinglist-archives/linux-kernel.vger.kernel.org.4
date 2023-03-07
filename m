Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2056AE1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjCGONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjCGOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:13:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F527E895
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 282C1B818F9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE89AC433D2;
        Tue,  7 Mar 2023 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198125;
        bh=RiTy0vYA92racswYmJC1M4uj15gXwTRNr7hKOo4kKIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHi6giKRrBTBP69pl5D/Ze+suO+NTYUMuAAkvqG+E3EbEgSNRY/WwDhaWs2uKPUnZ
         oQQU1KFNMBUIPklIVCIfsZB23Adk9umPOVHqVb1hThs/suZ0BVi79cjcZMQsVMYDT5
         CA2mZe4OxqRdzMOvM6iA2/g12i1TedUc+jgOZ0UB+LZN4061JpXJmqFsf5uFNxj3z0
         1R+DQHfJOofRBRr5+MQvPBSKJh2Gmrzb9gLdXjyU+gmmLUEAFxK+Jrhq418+Z6dto2
         UqRUsRLju7U+QD/O2WivTgxMbO+/75sfHkQvd+6ZlPxFvrGibbl9ezNpPnCsL37G0p
         pjG9zwq1jEHKw==
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
Subject: [PATCH v3 53/60] arm64: ptdump: Disregard unaddressable VA space
Date:   Tue,  7 Mar 2023 15:05:15 +0100
Message-Id: <20230307140522.2311461-54-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=ardb@kernel.org; h=from:subject; bh=RiTy0vYA92racswYmJC1M4uj15gXwTRNr7hKOo4kKIg=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpfsPQ7PLPGfjNrOZH1MdPO5I7ODnu/6iolxCYGrTm woL1+0dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKb3BgZFtkJLsjQfO3/sduE /xnjqQOc9+Nfz2xfY+J0ruU/w1Phewz/ffe3H7eZc+7Qe/36jy97S785Moq7va2vv78787Pob8Z b/AA=
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

Configurations built with support for 52-bit virtual addressing can also
run on CPUs that only support 48 bits of VA space, in which case only
that part of swapper_pg_dir that represents the 48-bit addressable
region is relevant, and everything else is ignored by the hardware.

Our software pagetable walker has little in the way of input address
validation, and so it will happily start a walk from an address that is
not representable by the number of paging levels that are actually
active, resulting in lots of bogus output from the page table dumper
unless we take care to start at a valid address.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/ptdump.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 8f37d6d8b5216473..8aee5d25f3d8cbe6 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -345,7 +345,7 @@ static void __init ptdump_initialize(void)
 				pg_level[i].mask |= pg_level[i].bits[j].mask;
 }
 
-static struct ptdump_info kernel_ptdump_info = {
+static struct ptdump_info kernel_ptdump_info __ro_after_init = {
 	.mm		= &init_mm,
 	.markers	= address_markers,
 	.base_addr	= PAGE_OFFSET,
@@ -364,7 +364,7 @@ void ptdump_check_wx(void)
 		.ptdump = {
 			.note_page = note_page,
 			.range = (struct ptdump_range[]) {
-				{PAGE_OFFSET, ~0UL},
+				{_PAGE_OFFSET(vabits_actual), ~0UL},
 				{0, 0}
 			}
 		}
@@ -388,8 +388,9 @@ static int __init ptdump_init(void)
 	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
 	ptdump_initialize();
 	if (vabits_actual < VA_BITS) {
+		kernel_ptdump_info.base_addr = _PAGE_OFFSET(vabits_actual);
 		address_markers[VMEMMAP_START_NR].start_address =
-			(unsigned long)virt_to_page(_PAGE_OFFSET(vabits_actual));
+			(unsigned long)virt_to_page(kernel_ptdump_info.base_addr);
 	}
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
 	return 0;
-- 
2.39.2

