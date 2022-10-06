Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98645F6197
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJFHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJFHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519268E0D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADBF61871
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24A9C433C1;
        Thu,  6 Oct 2022 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040682;
        bh=CDY3LOHif93dA/5GcjxLOgr3s2+BMCkMTymaYNZuiyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRm9LVZBrunvLnYytd4pxa3rFq57nHfJ9HsOwpVTeWPTZL9sFAJFrYSAejIdUkx2+
         +YWVA9Eo3yES9EQw9vR36Re1DZf8dhjtceMd03N6u3RCK+4X2qLONGZEcfnYBLpDKL
         hwPWSOWrkWM9W32TBw54oRrYC8Dk0URo+cdsVvMIqxw3t3RKe5+AQWn+M4rwwHOyS9
         LCNF+pVn+aEpOcKXGNhIhkrtPk6VZs8B8J/PSxyZ/1pv4uwg9411eHxebQnt0XrWbb
         yGu+Tcq7FLQy8KgWezDl4mFSASslMOxJxrPovxMLCwChU97FyjTPIc0grP8kx8o+cM
         BxDCWLzehBhzQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] riscv: remove riscv_isa_ext_keys[] array and related usage
Date:   Thu,  6 Oct 2022 15:08:18 +0800
Message-Id: <20221006070818.3616-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users have switched to riscv_has_extension_*, removed unused
definitions, vars and related setting code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 28 ----------------------------
 arch/riscv/kernel/cpufeature.c |  9 ---------
 2 files changed, 37 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 54b88ee6cae1..f52fbc121ebe 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -62,18 +62,6 @@ enum {
 
 extern unsigned long elf_hwcap;
 
-
-/*
- * This enum represents the logical ID for each RISC-V ISA extension static
- * keys. We can use static key to optimize code path if some ISA extensions
- * are available.
- */
-enum riscv_isa_ext_key {
-	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
-	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
-	RISCV_ISA_EXT_KEY_MAX,
-};
-
 struct riscv_isa_ext_data {
 	/* Name of the extension displayed to userspace via /proc/cpuinfo */
 	char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
@@ -81,22 +69,6 @@ struct riscv_isa_ext_data {
 	unsigned int isa_ext_id;
 };
 
-extern struct static_key_false riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_MAX];
-
-static __always_inline int riscv_isa_ext2key(int num)
-{
-	switch (num) {
-	case RISCV_ISA_EXT_f:
-		return RISCV_ISA_EXT_KEY_FPU;
-	case RISCV_ISA_EXT_d:
-		return RISCV_ISA_EXT_KEY_FPU;
-	case RISCV_ISA_EXT_ZIHINTPAUSE:
-		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
-	default:
-		return -EINVAL;
-	}
-}
-
 static __always_inline bool
 riscv_has_extension_likely(const unsigned long ext)
 {
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2b1f18f97253..6bc3fb749274 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,9 +28,6 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
-DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
-EXPORT_SYMBOL(riscv_isa_ext_keys);
-
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -242,12 +239,6 @@ void __init riscv_fill_hwcap(void)
 		if (elf_hwcap & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
 	pr_info("riscv: ELF capabilities %s\n", print_str);
-
-	for_each_set_bit(i, riscv_isa, RISCV_ISA_EXT_MAX) {
-		j = riscv_isa_ext2key(i);
-		if (j >= 0)
-			static_branch_enable(&riscv_isa_ext_keys[j]);
-	}
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.37.2

