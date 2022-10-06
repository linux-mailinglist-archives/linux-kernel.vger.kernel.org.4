Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8085B5F6194
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJFHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJFHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6338558D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC8361873
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DE2C433C1;
        Thu,  6 Oct 2022 07:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040678;
        bh=0j/uuX0hnVENvwf8/IPzguN2vBgRWGMshLwXisXEuao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcfDM7HVjDRRV6VbrW8vYAwGnIPsyte3CG2IQOLs0wY4UNhARRoIfVWQW/QXvRR3z
         a3tPVfmxBb8fjZZUF20KHJ82JjQYsMJPUss/fBNRqyalsCbfURLJ6b5iSylrkhGx6A
         8UtZxOiX3vZSnuEN92MULOSnNebAW6vemFZreS6MsyBQYMzdSdKaUSwquulALJP7MR
         M8LMKzorcWgq4LcxThpvLOR9wULt3GiqgVqJIgEFYt17xiIClKu5I00F0UwKK+aXWB
         4lvgPQIqyFh8VTR6VEP1j1w3rnV1x2hajobGh4qSFWYNrzpycw77USB05daXBWh8S/
         WOVok9jU7FUVw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] riscv: introduce riscv_has_extension_[un]likely()
Date:   Thu,  6 Oct 2022 15:08:15 +0800
Message-Id: <20221006070818.3616-6-jszhang@kernel.org>
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

Generally, riscv ISA extensions are fixed for any specific hardware
platform, that's to say, the hart features won't change any more
after booting, this chacteristic make it straightforward to use
static branch to check one specific ISA extension is supported or not
to optimize performance.

However, some ISA extensions such as SVPBMT and ZICBOM are handled
via. the alternative sequences.

Basically, for ease of maintenance, we prefer to use static branches
in C code, but recently, Samuel found that the static branch usage in
cpu_relax() breaks building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]. As
Samuel pointed out, "Having a static branch in cpu_relax() is
problematic because that function is widely inlined, including in some
quite complex functions like in the VDSO. A quick measurement shows
this static branch is responsible by itself for around 40% of the jump
table."

Samuel's findings pointed out one of a few downsides of static branches
usage in C code to handle ISA extensions detected at boot time:
static branch's metadata in the __jump_table section, which is not
discarded after ISA extensions are finalized, wastes some space.

I want to try to solve the issue for all possible dynamic handling of
ISA extensions at boot time. Inspired by Mark[2], this patch introduces
riscv_has_extension_*() helpers, which work like static branches but
are patched using alternatives, thus the metadata can be freed after
patching.

[1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
[2]https://lore.kernel.org/linux-arm-kernel/20220912162210.3626215-8-mark.rutland@arm.com/

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 6cf445653911..54b88ee6cae1 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_RISCV_HWCAP_H
 #define _ASM_RISCV_HWCAP_H
 
+#include <asm/alternative-macros.h>
 #include <asm/errno.h>
 #include <linux/bits.h>
 #include <uapi/asm/hwcap.h>
@@ -96,6 +97,42 @@ static __always_inline int riscv_isa_ext2key(int num)
 	}
 }
 
+static __always_inline bool
+riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_ID_MAX,
+			   "ext must be < RISCV_ISA_EXT_ID_MAX");
+
+	asm_volatile_goto(
+	ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
+	:
+	: [ext] "i" (ext)
+	:
+	: l_no);
+
+	return true;
+l_no:
+	return false;
+}
+
+static __always_inline bool
+riscv_has_extension_unlikely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_ID_MAX,
+			   "ext must be < RISCV_ISA_EXT_ID_MAX");
+
+	asm_volatile_goto(
+	ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
+	:
+	: [ext] "i" (ext)
+	:
+	: l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
 #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
-- 
2.37.2

