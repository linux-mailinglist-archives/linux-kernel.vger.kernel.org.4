Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B56AE1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCGOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCGOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF57D094
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A760B818FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6162C433A4;
        Tue,  7 Mar 2023 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198060;
        bh=NW0PGhf1i6p2eNdylQMSe2x4+utKDJZCyu+uqyONhAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcUOF+QHEd1jnWMXrZj5R+EYXNfLxD01pxXkwuWjvh839aQfApV8fuJnSxME6zk2l
         oQlxQ2hph0Pzgs6zrd92ynyO/BZvewOzML5BHSR7MJHkYMrQ48dqjA4anyKH/YMVeC
         CIfFy+xzkAeKvyv4J815sjfvnNCux9c86RKfaLG+2oELDINbKSvfs6x2NoxDx9hoew
         cNRZ2FM+8ehzAhU4394rZ3gUmiSFzkhWpCatrow9G4H8+UIVgjzXW3NdkgIHqWdmui
         Sxzh3Q+C1Kw8/MfO+frGDXfPgsGRngKVCJ8I6t0Xd4BgdQKvDobPUu7C0miiOJpk1v
         77L9HNY8ygkxQ==
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
Subject: [PATCH v3 26/60] arm64: Move feature overrides into the BSS section
Date:   Tue,  7 Mar 2023 15:04:48 +0100
Message-Id: <20230307140522.2311461-27-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=ardb@kernel.org; h=from:subject; bh=NW0PGhf1i6p2eNdylQMSe2x4+utKDJZCyu+uqyONhAY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxUHQ01bgxOGkDa94b+7L5XevME6w/Xdn10Mx2flLl 0f3ffnVUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbS68vIcH/DGqU2Fhe7k0Uy hTNeLbwXfnVCZrLi9d2lC52Dv240mszw33/bhvhT204cqGE/Lui3P3mTo96ClP1fWVsaapfejfy 2ghcA
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

In order to allow the CPU feature override detection code to run even
earlier, move the feature override global variables into BSS, which is
the only part of the static kernel image that is mapped read-write in
the initial ID map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 88cec6c14743c4c5..0b16e676b68c6543 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -649,13 +649,13 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 #define ARM64_FTR_REG(id, table)		\
 	__ARM64_FTR_REG_OVERRIDE(#id, id, table, &no_override)
 
-struct arm64_ftr_override __ro_after_init id_aa64mmfr1_override;
-struct arm64_ftr_override __ro_after_init id_aa64pfr0_override;
-struct arm64_ftr_override __ro_after_init id_aa64pfr1_override;
-struct arm64_ftr_override __ro_after_init id_aa64zfr0_override;
-struct arm64_ftr_override __ro_after_init id_aa64smfr0_override;
-struct arm64_ftr_override __ro_after_init id_aa64isar1_override;
-struct arm64_ftr_override __ro_after_init id_aa64isar2_override;
+struct arm64_ftr_override id_aa64mmfr1_override;
+struct arm64_ftr_override id_aa64pfr0_override;
+struct arm64_ftr_override id_aa64pfr1_override;
+struct arm64_ftr_override id_aa64zfr0_override;
+struct arm64_ftr_override id_aa64smfr0_override;
+struct arm64_ftr_override id_aa64isar1_override;
+struct arm64_ftr_override id_aa64isar2_override;
 
 struct arm64_ftr_override arm64_sw_feature_override;
 
-- 
2.39.2

