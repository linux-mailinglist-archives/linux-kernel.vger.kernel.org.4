Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D397451F9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGBUBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjGBT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FE1BFA;
        Sun,  2 Jul 2023 12:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4552E60D29;
        Sun,  2 Jul 2023 19:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10644C433C9;
        Sun,  2 Jul 2023 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327589;
        bh=HsjOsyZpM0XOvf7Yw5OEliG1tMtf61Syx8aBjyVFuTs=;
        h=From:To:Cc:Subject:Date:From;
        b=tqCaR/ZOxU65zgiAhirB2u1HT1q5nQJdy18uVkp9GqoSl3SadVDDD9xAt3/4EMVUA
         mF/SbIpU/rwyvQhdx4YYblJ/y8eySFDVKRTBGKh6V0nieZj5yWiBVCjGSb24Hacrjm
         8jwWSxngd5ATsdyMxFHt7DpfoFEnipeP5Ukaso3cVjWLBzHu8E+hke5r7Q/1kBEkfr
         rzqmTpNfx6Af85CfJMHQ5RLn/Zr9HsX/O2Qo171yn1rEnpGG3i4FrsTWAA4I6PIhW+
         4Z5iDC2DjywQmZz7S/J7Lh/geIvipx5jeWe8zmTppQ9TaNvJ0lwKCsRl06eL7dfgac
         AIJBvJw3SNyJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>, anshuman.khandual@arm.com,
        wangkefeng.wang@huawei.com, quic_zhenhuah@quicinc.com,
        chenfeiyang@loongson.cn, bhe@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4] arm64: mm: fix VA-range sanity check
Date:   Sun,  2 Jul 2023 15:53:02 -0400
Message-Id: <20230702195306.1788976-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.249
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit ab9b4008092c86dc12497af155a0901cc1156999 ]

Both create_mapping_noalloc() and update_mapping_prot() sanity-check
their 'virt' parameter, but the check itself doesn't make much sense.
The condition used today appears to be a historical accident.

The sanity-check condition:

	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
		[ ... warning here ... ]
		return;
	}

... can only be true for the KASAN shadow region or the module region,
and there's no reason to exclude these specifically for creating and
updateing mappings.

When arm64 support was first upstreamed in commit:

  c1cc1552616d0f35 ("arm64: MMU initialisation")

... the condition was:

	if (virt < VMALLOC_START) {
		[ ... warning here ... ]
		return;
	}

At the time, VMALLOC_START was the lowest kernel address, and this was
checking whether 'virt' would be translated via TTBR1.

Subsequently in commit:

  14c127c957c1c607 ("arm64: mm: Flip kernel VA space")

... the condition was changed to:

	if ((virt >= VA_START) && (virt < VMALLOC_START)) {
		[ ... warning here ... ]
		return;
	}

This appear to have been a thinko. The commit moved the linear map to
the bottom of the kernel address space, with VMALLOC_START being at the
halfway point. The old condition would warn for changes to the linear
map below this, and at the time VA_START was the end of the linear map.

Subsequently we cleaned up the naming of VA_START in commit:

  77ad4ce69321abbe ("arm64: memory: rename VA_START to PAGE_END")

... keeping the erroneous condition as:

	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
		[ ... warning here ... ]
		return;
	}

Correct the condition to check against the start of the TTBR1 address
space, which is currently PAGE_OFFSET. This simplifies the logic, and
more clearly matches the "outside kernel range" message in the warning.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20230615102628.1052103-1-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5cf575f23af28..8e934bb44f12e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -399,7 +399,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not creating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
@@ -426,7 +426,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
 				phys_addr_t size, pgprot_t prot)
 {
-	if ((virt >= PAGE_END) && (virt < VMALLOC_START)) {
+	if (virt < PAGE_OFFSET) {
 		pr_warn("BUG: not updating mapping for %pa at 0x%016lx - outside kernel range\n",
 			&phys, virt);
 		return;
-- 
2.39.2

