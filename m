Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E884C6AE1F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCGON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjCGONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:13:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F28E3F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F73D6143F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF498C433EF;
        Tue,  7 Mar 2023 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198130;
        bh=LnIMWXn/NUQhEHogfVRPC6N8nPTaYTu5SzPxylVFFFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxt7vxDMrMeQJsTf2yCYbSQzPG4oUdjdzgCKdK8cy5uKjVjUBociHes0crp2TZ85Q
         6ytey9H+NGpX2hcoXUItOOkym5riAqUnlaswFY16dhlC1EkretpkYelmEVj+MDsCMD
         L7P7JdIY7GR9Ep9zRDjiTybMUodqoRtw5XzVyBX23bHExKL/xkTcETbJwn7PCEHOvB
         OIcWAOB7MIsigEhku29GgdbFcg7dyBeKsHGwDNpr4Bg3K/q6CCH5QZfEHYYJdrR2ul
         zmUcsDKn3Nd33/ywDSxvs/Zf8X51lfhfiCD9Et5r5TwWMLX50BgOUHteDczk9uFe21
         gIHG3unpgBDfQ==
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
Subject: [PATCH v3 55/60] arm64: kvm: avoid CONFIG_PGTABLE_LEVELS for runtime levels
Date:   Tue,  7 Mar 2023 15:05:17 +0100
Message-Id: <20230307140522.2311461-56-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=ardb@kernel.org; h=from:subject; bh=LnIMWXn/NUQhEHogfVRPC6N8nPTaYTu5SzPxylVFFFA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdZbKb65Y0U7+zrwseKHzQe7TBcakxty1f+VSJoMU8E hURwaIdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLJ+xkZTv7LehPcuoNHgeOb k2HvaRvudrOfKhv0Wju4Hl0R7H9Sz/C/dAHbM9H+BxqrE6eHLjn74nHoO73ctltzrEI3V5yYMfU bMwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_mapping_size() uses vabits_actual and CONFIG_PGTABLE_LEVELS to
provide the starting point for a table walk. This is fine for LVA, as
the number of translation levels is the same regardless of whether LVA
is enabled. However, with LPA2, this will no longer be the case, so
let's derive the number of levels from the number of VA bits directly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d64be7b5f6692e8b..4e7c0f9a9c286c09 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -663,7 +663,7 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
 		.pgd		= (kvm_pteref_t)kvm->mm->pgd,
 		.ia_bits	= vabits_actual,
 		.start_level	= (KVM_PGTABLE_MAX_LEVELS -
-				   CONFIG_PGTABLE_LEVELS),
+				   ARM64_HW_PGTABLE_LEVELS(pgt.ia_bits)),
 		.mm_ops		= &kvm_user_mm_ops,
 	};
 	kvm_pte_t pte = 0;	/* Keep GCC quiet... */
-- 
2.39.2

