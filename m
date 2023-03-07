Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775B56AE1DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCGOLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCGOJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4668888A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2726144B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783E6C4339C;
        Tue,  7 Mar 2023 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198070;
        bh=MgAlosplvEwsGH+1fNbCRsUtWRN8yNAPEnQin/pEaZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRF8W2LQV8FQJYsf48awPPQKBb2WBFb3V8LC3NgRdG6rMtcklRKsz4b3DhAdSx0kB
         UieAWGEFDo/F15RpQrialQSBIZ4A/yFGOmOJm5JakllD6YKbAqsrrLsSZF0XxDbzqW
         h34C0isa4ikt652AMToJIHGXAxYG4gfkj9B6zrMCRUCjHuBXPPWsH+64wuUg/Gfsl2
         v4pwULIaBv/OF80BI+78CMNC2TmMEQZv/EpggJpA73TQPSIlKnB0iZnBYSsOrcHma/
         0Zr82T3auhRB2Hi08WyE8YQsqmvroFGOpkwVOyKzLtYGt/as+Jpb9u/FGnkPRToLtu
         pkYFUxVCAe75A==
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
Subject: [PATCH v3 30/60] arm64: idreg-override: Create a pseudo feature for rodata=off
Date:   Tue,  7 Mar 2023 15:04:52 +0100
Message-Id: <20230307140522.2311461-31-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=ardb@kernel.org; h=from:subject; bh=MgAlosplvEwsGH+1fNbCRsUtWRN8yNAPEnQin/pEaZM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxeubg3x1yZqWt9NVJ1zmKVvi+f2c1RTpQ2lX0l/IZ t/tZhbqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZ/4rhf+b3hX7sqaL/Rb63 9b8I230r59bsmGvaHmvvWyUlx3/OOsjwP4/v38b9G/xuOedYuxTHsAe813efwa0ZviyLPePWw8j 7nAA=
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

Add rodata=off to the set of kernel command line options that is parsed
early using the CPU feature override detection code, so we can easily
refer to it when creating the kernel mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h   | 1 +
 arch/arm64/kernel/pi/idreg-override.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index bc10098901808c00..edc7733aa49846b2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -16,6 +16,7 @@
 #define cpu_feature(x)		KERNEL_HWCAP_ ## x
 
 #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
+#define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF	4
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 4e76db6eb72c2087..6c547cccaf6a9e9c 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -151,6 +151,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
 	.override	= &arm64_sw_feature_override,
 	.fields		= {
 		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
+		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
 		{}
 	},
 };
@@ -183,6 +184,7 @@ static const struct {
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
+	{ "rodata=off",			"arm64_sw.rodataoff=1" },
 };
 
 static int __init parse_hexdigit(const char *p, u64 *v)
-- 
2.39.2

