Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1B6AE1E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCGOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCGOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC1888B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C72613CA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E93CC433D2;
        Tue,  7 Mar 2023 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198097;
        bh=KyeVOWyCVtFoTF1LJWtSXOxn+egSaaC3be0AkldlV1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMooe098dHSvS1lQPK7GmT7Datna6P62s4X6DVa9UodJ25o24vy8IvaPovzlhZhgG
         DIeE4wDoRcH6WNduY/7q7KGv8XTiqORo/6W+CHdDx1uxzfmzdpmSv+CdLTAFceAz20
         6tpY1cp4859he3ucXZgwPCMVYwWeZFrnel7Lkefp4Lc1WGwgADULkfgx4VMVW2MhrR
         vdg8ExweFZYZwhCNN0mjkKWfUR+r9xhBYxzvX0scTbnA6NgTWnqAGs0bujVcPQAQco
         CZlrATLopOmqR7jPD4OjQGl2kHgmjZIJppgtTszZJl/giF9ybnm7QQee/ECV1syOwy
         sRAtUk8wQn7dw==
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
Subject: [PATCH v3 41/60] arm64/mm: Add FEAT_LPA2 specific TCR_EL1.DS field
Date:   Tue,  7 Mar 2023 15:05:03 +0100
Message-Id: <20230307140522.2311461-42-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=ardb@kernel.org; h=from:subject; bh=FGpJVT/P4QQvSVy9l1/wAhcmiWJoU30A2wDupoSxpoU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJfvh8eUxgbdFyxc4HVixJr01y795zapFhS8Ckox+s ky5dWRJRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIUhTD/7AN6ZNfPoxb19Pz 7aDW9+ucZb91gw/ze8w6t1jw1N4E5vMM/z32PtH7UHRtf9nVLfOyLrmkMGzes3uN5A3FjP9KLgy hUfwA
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

From: Anshuman Khandual <anshuman.khandual@arm.com>

As per ARM ARM (0487G.A) TCR_EL1.DS fields controls whether 52 bit input
and output address get supported on 4K and 16K page size configuration,
when FEAT_LPA2 is known to have been implemented. This adds TCR_DS field
definition which would be used when FEAT_LPA2 gets enabled.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index f658aafc47dfa29a..c4ad7fbb12c5c07a 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -276,6 +276,7 @@
 #define TCR_E0PD1		(UL(1) << 56)
 #define TCR_TCMA0		(UL(1) << 57)
 #define TCR_TCMA1		(UL(1) << 58)
+#define TCR_DS			(UL(1) << 59)
 
 /*
  * TTBR.
-- 
2.39.2

