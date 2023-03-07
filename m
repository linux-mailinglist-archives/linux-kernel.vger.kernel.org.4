Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855BE6AE1B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCGOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCGOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040083890
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B35C16143A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F9C433A1;
        Tue,  7 Mar 2023 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198015;
        bh=DPMsp/QC9zVXvP3OPcvpzDcOxYcfkqxfml7V5i/ONDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugCg8BhB2NxQRFOpkGV3d/8rLVwopqUuCo0pAIsvasbJWio4WyKQ4muCtnCI2cAes
         r6vaMX85+sulFrsENmqvthSjf4MvtbenBosS6ncM9VhhE2/qo1T6DDQzGo3nscEz7O
         xGr33xhaQcKfn1suSW1007w0xDIb5Kz/ImB/rvoRqjXiS/Z+7toIrFTN3l/FOR1kzc
         6wMNiCAVQkc+M2Jp3vWOQW1RmcnLKsoM8pgOK61lTTFU0azTdlZkMfv1F4xDciJtl6
         d/UREpoF/8yToWEbxHPO4TlPF88y+OaH4WBceFB58Bjjynl6EtdL/v+JTlnkr316RQ
         CrSALKjQ01qnA==
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
Subject: [PATCH v3 07/60] arm64: ptdump: Discover start of vmemmap region at runtime
Date:   Tue,  7 Mar 2023 15:04:29 +0100
Message-Id: <20230307140522.2311461-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=ardb@kernel.org; h=from:subject; bh=DPMsp/QC9zVXvP3OPcvpzDcOxYcfkqxfml7V5i/ONDM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhefVN36elVZhTm+/XHq73zDLPZh7jnbAdXPthqkfH nY8t9nYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyTZWRYQs/e/OZQwk6/YxT lj6SyM4IWuTvHnPp8J4w3WOVv9eL2jEy3P9S21mxsO7GocuN0reW3VnT2HIlUEAvJu1P/oHLmde eMgIA
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

We will soon reclaim the part of the vmemmap region that covers VA space
that is not addressable by the hardware. To avoid confusion, ensure that
the 'vmemmap start' marker points at the start of the region that is
actually being used for the struct page array, rather than the start of
the region we set aside for it at build time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/ptdump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 910b35f02280cbdb..8f37d6d8b5216473 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -37,6 +37,7 @@ enum address_markers_idx {
 	MODULES_END_NR,
 	VMALLOC_START_NR,
 	VMALLOC_END_NR,
+	VMEMMAP_START_NR,
 };
 
 static struct addr_marker address_markers[] = {
@@ -386,6 +387,10 @@ static int __init ptdump_init(void)
 #endif
 	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
 	ptdump_initialize();
+	if (vabits_actual < VA_BITS) {
+		address_markers[VMEMMAP_START_NR].start_address =
+			(unsigned long)virt_to_page(_PAGE_OFFSET(vabits_actual));
+	}
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
 	return 0;
 }
-- 
2.39.2

