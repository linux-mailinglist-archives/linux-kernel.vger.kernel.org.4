Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047E63E5A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiK3XmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiK3XmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:42:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A094AF03;
        Wed, 30 Nov 2022 15:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0835061E50;
        Wed, 30 Nov 2022 23:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4780C43146;
        Wed, 30 Nov 2022 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669851722;
        bh=B0la+6RJs6jm7uimz2FZajJBMnUH9FoBQuI76+kXtl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtBDJB10K9UQhIScS5VPIjV21O/fMZFvs8VBNbVsqhX03H25iyKCeM7s3i+NZFjAU
         bmbBBqWZ0zzQ+v9UA7nXQIbkOkrj+2CijSK8khQ4qHE1WnXwOxLFI2pASuSSr9mMHc
         2QRNvyEyJBEr+uOzLcB+JEJ+hsTHyv4uJmhOQdI3B7vyY3v1aZARRIMs98/CL1bGaq
         Qd4NKWdsQid2GnrZM6wI1uqUqlw2b97ljZHi/IrpCaj/Ikd1ItLa/YdR8TjcTu8Qh7
         Ev128+zppZt3D/f8xCzCJ5gvumY6KavECn1g5T9kuh4fCxR/m9lEf6dvxJ4+dRsQK6
         eezkFeuVMyLHQ==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, conor@kernel.org, corbet@lwn.net,
        guoren@kernel.org, heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Date:   Wed, 30 Nov 2022 23:41:25 +0000
Message-Id: <20221130234125.2722364-3-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130234125.2722364-1-conor@kernel.org>
References: <20221130234125.2722364-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

Ordering between each and every list of extensions is wildly
inconsistent. Per discussion on the lists pick the following policy:

- The array defining order in /proc/cpuinfo follows a narrow
  interpretation of the ISA specifications, described in a comment
  immediately presiding it.

- All other lists of extensions are sorted alphabetically.

This will hopefully allow for easier review & future additions, and
reduce conflicts between patchsets as the number of extensions grows.

Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I could not decide between adding an alphabetical comment to each
alphabetical site or not. I did it anyway. Scream if you hate it!

I also moved a static branch thingy in this version, but that should not
matter, right? riightt?
---
 arch/riscv/include/asm/hwcap.h | 12 +++++++-----
 arch/riscv/kernel/cpu.c        |  4 ++--
 arch/riscv/kernel/cpufeature.c |  6 ++++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b22525290073..ce522aad641a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,14 +51,15 @@ extern unsigned long elf_hwcap;
  * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
  * extensions while all the multi-letter extensions should define the next
  * available logical extension id.
+ * Entries are sorted alphabetically.
  */
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_SSTC,
+	RISCV_ISA_EXT_SVINVAL,
 	RISCV_ISA_EXT_SVPBMT,
 	RISCV_ISA_EXT_ZICBOM,
 	RISCV_ISA_EXT_ZIHINTPAUSE,
-	RISCV_ISA_EXT_SSTC,
-	RISCV_ISA_EXT_SVINVAL,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
@@ -66,11 +67,12 @@ enum riscv_isa_ext_id {
  * This enum represents the logical ID for each RISC-V ISA extension static
  * keys. We can use static key to optimize code path if some ISA extensions
  * are available.
+ * Entries are sorted alphabetically.
  */
 enum riscv_isa_ext_key {
 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
-	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_SVINVAL,
+	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_MAX,
 };
 
@@ -90,10 +92,10 @@ static __always_inline int riscv_isa_ext2key(int num)
 		return RISCV_ISA_EXT_KEY_FPU;
 	case RISCV_ISA_EXT_d:
 		return RISCV_ISA_EXT_KEY_FPU;
-	case RISCV_ISA_EXT_ZIHINTPAUSE:
-		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	case RISCV_ISA_EXT_SVINVAL:
 		return RISCV_ISA_EXT_KEY_SVINVAL;
+	case RISCV_ISA_EXT_ZIHINTPAUSE:
+		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 68b2bd0cc3bc..686d41b14206 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -161,12 +161,12 @@ device_initcall(riscv_cpuinfo_init);
  * New entries to this struct should follow the ordering rules described above.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
+	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
-	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
-	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..8a76a6ce70cf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -199,12 +199,13 @@ void __init riscv_fill_hwcap(void)
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				set_bit(*ext - 'a', this_isa);
 			} else {
+				/* sorted alphabetically */
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
+				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
-				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
-				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -284,6 +285,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
  * This code may also be executed before kernel relocation, so we cannot use
  * addresses generated by the address-of operator as they won't be valid in
  * this context.
+ * Tests, unless otherwise required, are to be added in alphabetical order.
  */
 static u32 __init_or_module cpufeature_probe(unsigned int stage)
 {
-- 
2.38.1

