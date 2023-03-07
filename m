Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527EA6AE1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCGOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCGOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F0D83143
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05D1BCE1BDF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A4C433A7;
        Tue,  7 Mar 2023 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198003;
        bh=zTJJcfi4SEXlPHHgiZzEiE+Bb8xBDVbYVHpApgM1uRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YG60S4NTJZYgf3VEsEcTvEU1ODazqeuMok+heVfq9BEVOpoLLoRlc+L36ndWed+Vd
         Y/kNnRROpeBA4CAZPt2aPeEnf7Y4IpJ4veTA5A3sb0Ooe9ey1J90gXWhIdK6FBiyHD
         ndoaG1DMjk0mbVAu3oKL8bXI3aPjCvMWiP6amOjD9EdXwwahb+svONi2hfby7rJupk
         m00Mp4wQ6WE3qMqPcAauZnNujdlPUJnuGVA4mgZKkismjjOa+G3aWrGaKxfPtdtL0j
         CJ6VCR1V03Z3EdfcAog4jL4BorLGM0tiu0r1pIi0gyVOFefQk13K1z0R5Ulz/XK/PC
         gPPE/c6iQ0/+w==
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
Subject: [PATCH v3 02/60] arm64: mm: Take potential load offset into account when KASLR is off
Date:   Tue,  7 Mar 2023 15:04:24 +0100
Message-Id: <20230307140522.2311461-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=ardb@kernel.org; h=from:subject; bh=zTJJcfi4SEXlPHHgiZzEiE+Bb8xBDVbYVHpApgM1uRw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhVFh1hf+2B0Xupfde1M390PLw8mn1ebfWHuToyHbc Fq5zt61HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiAnoM/z0bzqXare9T+fh1 5b5a0ZvP995afGTb08qvjU+PhqrP+/OdkaHl1UefP3x2TjnRh8vj1xS7zA3frX5Bc+4bqdrH+t+ s1VgA
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

We enable CONFIG_RELOCATABLE even when CONFIG_RANDOMIZE_BASE is
disabled, and this permits the loader (i.e., EFI) to place the kernel
anywhere in physical memory as long as the base address is 64k aligned.

This means that the 'KASLR' case described in the header that defines
the size of the statically allocated page tables could take effect even
when CONFIG_RANDMIZE_BASE=n. So check for CONFIG_RELOCATABLE instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index fcd14197756f0619..4d13c73171e1e360 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -53,7 +53,7 @@
  * address is just pushed over a boundary and the start address isn't).
  */
 
-#ifdef CONFIG_RANDOMIZE_BASE
+#ifdef CONFIG_RELOCATABLE
 #define EARLY_KASLR	(1)
 #else
 #define EARLY_KASLR	(0)
-- 
2.39.2

