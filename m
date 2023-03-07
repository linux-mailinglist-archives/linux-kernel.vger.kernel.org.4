Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122E6AE1B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCGOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCGOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B278ABDF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5450F61454
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32E0C4339E;
        Tue,  7 Mar 2023 14:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198024;
        bh=0KQy78BFjE2XXHrdYNysZXORIwBR4S+/FhQgUDVlHf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNSnk087CzN67/StBZFJBuS7EwPop8FwoYrXCt8azLMwSe5R5olrcHbdDsYjs9gQo
         KI+mnuHO6WyqMrnGFmbID6HwJ3E4IOV5BjI11vGiiRRcSK7ZXOiPksVNWXZfZ1oo4T
         Uvudy8YGC6p9R1L380O8Qq1CpSs/G6Uo6Ss2lJ3bsgHjjpmPCCE6SK7vn7q8rjUWTr
         C4Dg+w4mSuJ0X5LP0F3adB5+ws2HXU2xjlSqBS28gdGWiyICI00EWvfFMddnlwzN6l
         bZdFvRnScCGYjs1JBBkDnnk4LPyrSbPlYWDbUVWw+TbFwn4s7sdUBJLv+hply095e6
         KROHmesRFFxDA==
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
Subject: [PATCH v3 11/60] arm64: kaslr: drop special case for ThunderX in kaslr_requires_kpti()
Date:   Tue,  7 Mar 2023 15:04:33 +0100
Message-Id: <20230307140522.2311461-12-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=ardb@kernel.org; h=from:subject; bh=0KQy78BFjE2XXHrdYNysZXORIwBR4S+/FhQgUDVlHf8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdRaSuaYdKGecRnTbZ/aoPbHZMclcWbp1kdumz2eqCC 6f/e3d3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlsncvIcDm1TUglY9JWx6ML b385O7d3eqLEH+4/AXxxfS6Z/xa65jAydK9YMXtCR17AYvM57EpfJO3Z3cxCF/dyTLixLkU4pkG NEQA=
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

ThunderX is an obsolete platform that shipped without support for the
EFI_RNG_PROTOCOL in its firmware. Now that we no longer misidentify
small KASLR offsets as randomization being enabled, we can drop the
explicit check for ThunderX as well, given that KASLR is known to be
unavailable.

Note that we never enable KPTI on these systems, in spite of what this
function returns. However, using non-global mappings for code that is
executable at EL1 is what tickles the erratum on these cores, regardless
of whether KPTI is enabled or not, so non-global mappings should simply
never be used here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/cpu_errata.c |  2 +-
 arch/arm64/kernel/cpufeature.c | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 307faa2b4395ed9f..530bbd6a2f6331fd 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -261,7 +261,7 @@ static const struct midr_range cavium_erratum_23154_cpus[] = {
 #endif
 
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
-const struct midr_range cavium_erratum_27456_cpus[] = {
+static const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 	MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
 	/* Cavium ThunderX, T81 pass 1.0 */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2e3e5513977733b7..e9a138b7e3b22cc7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1621,18 +1621,6 @@ bool kaslr_requires_kpti(void)
 			return false;
 	}
 
-	/*
-	 * Systems affected by Cavium erratum 24756 are incompatible
-	 * with KPTI.
-	 */
-	if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
-		extern const struct midr_range cavium_erratum_27456_cpus[];
-
-		if (is_midr_in_range_list(read_cpuid_id(),
-					  cavium_erratum_27456_cpus))
-			return false;
-	}
-
 	return kaslr_enabled();
 }
 
-- 
2.39.2

