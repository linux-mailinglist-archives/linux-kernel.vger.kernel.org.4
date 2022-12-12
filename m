Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C666E649BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiLLKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLLKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D4C2D9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H9vo2DtiADdIfw1vXZpWgFmc8ynuZRSwE8Yti4cc1KU=;
        b=4ursBoKgY5M2zpBTlvUvjffA8ut5xn9fUk4NNo7worF8CgCDvv6nyVMIxyB8bZ92rERVUj
        S3fXXECcVKKXID7gFgMMyB4vC2GZAICiFIFlC64FZ9SvgoX5lFbh12Lmb06OHQot8xrI5m
        mnbR+4P/WBKJpAqSoqSLi8oQsMKUvnoM6R/4ejKGcPTcRCExn56ddchRaq6K/5aHsVPCZV
        JgNZ+xdLPoYYk5lIp3awSuZtbeafw1N3R0zFtZxK4+Cu1pKM5y/behEqOR7c8sSw+OzoJ9
        cgrPRStnmkjdgRS1QCdNPjx1O+y9/w+9XW5mfovGmNdolXXNxZknJboIjHgq7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H9vo2DtiADdIfw1vXZpWgFmc8ynuZRSwE8Yti4cc1KU=;
        b=KeZcX3StaZyq33WfX7OqhlQekf2bOg/Aes99MF0lKoE59nKGjO8/RuYx5Syqh+MEBTAEwb
        9uDyLxjEVtkOWNBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.2-rc1
Message-ID: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:08:59 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
12-12

up to:  45be2ad007a9: x86/vdso: Conditionally export __vdso_sgx_enter_enclave=
()

Three small x86 fixes which did not make it into 6.1:

  - Remove a superfluous noinline which prevents GCC-7.3 to optimize a stub
    function away.

  - Allow uprobes on REP NOP and do not treat them like word-sized branch
    instructions.

  - Make the VDSO symbol export of __vdso_sgx_enter_enclave() depend on
    CONFIG_X86_SGX to prevent build fails with newer LLVM versions which
    rightfully detect that there is no function behind the symbol.

Thanks,

	tglx

------------------>
Miaohe Lin (1):
      x86/alternative: Remove noinline from __ibt_endbr_seal[_end]() stubs

Nathan Chancellor (1):
      x86/vdso: Conditionally export __vdso_sgx_enter_enclave()

Oleg Nesterov (1):
      uprobes/x86: Allow to probe a NOP instruction with 0x66 prefix


 arch/x86/entry/vdso/vdso.lds.S | 2 ++
 arch/x86/kernel/alternative.c  | 2 +-
 arch/x86/kernel/uprobes.c      | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 4bf48462fca7..e8c60ae7a7c8 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -27,7 +27,9 @@ VERSION {
 		__vdso_time;
 		clock_getres;
 		__vdso_clock_getres;
+#ifdef CONFIG_X86_SGX
 		__vdso_sgx_enter_enclave;
+#endif
 	local: *;
 	};
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5cadcea035e0..beaf9fc44e2f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start=
, s32 *end)
=20
 #else
=20
-void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
+void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
=20
 #endif /* CONFIG_X86_KERNEL_IBT */
=20
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index b63cf8f7745e..6c07f6daaa22 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -722,8 +722,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *aupro=
be, struct insn *insn)
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
-	case 0x90:	/* prefix* + nop; same as jmp with .offs =3D 0 */
 		break;
+	case 0x90:	/* prefix* + nop; same as jmp with .offs =3D 0 */
+		goto setup;
=20
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);
@@ -753,6 +754,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *aupro=
be, struct insn *insn)
 			return -ENOTSUPP;
 	}
=20
+setup:
 	auprobe->branch.opc1 =3D opc1;
 	auprobe->branch.ilen =3D insn->length;
 	auprobe->branch.offs =3D insn->immediate.value;

