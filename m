Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057B62B490
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiKPIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiKPIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:07:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3CCB6583
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:07:31 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxHLdCmnRjHbIHAA--.10830S3;
        Wed, 16 Nov 2022 16:07:30 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VY6mnRjQ54UAA--.36317S4;
        Wed, 16 Nov 2022 16:07:26 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/9] LoongArch/ftrace: Add recordmcount support
Date:   Wed, 16 Nov 2022 16:07:15 +0800
Message-Id: <20221116080722.4745-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116080722.4745-1-zhangqing@loongson.cn>
References: <20221116080722.4745-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VY6mnRjQ54UAA--.36317S4
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGr4UXFWrZr4xAFy8ury8Zrb_yoW5CrWDpr
        4qvFyrJFs2qryfG3ZIy348ur15Zas7Kr4Svryfta1FyFyDXrZ5Gr47JrnrWFyUCrykJ34x
        WF4F9ry8ua1UJw7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        baxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j8a9-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recordmcount utility under scripts is run, after compiling each object,
to find out all the locations of calling _mcount() and put them into
specific seciton named __mcount_loc.
Then linker collects all such information into a table in the kernel image
(between __start_mcount_loc and __stop_mcount_loc) for later use by ftrace.

This patch adds loongarch specific definitions to identify such locations.
On loongarch, only C version is used to build the kernel now that
CONFIG_HAVE_C_RECORDMCOUNT is on.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig |  2 ++
 scripts/recordmcount.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 92c4ec8c8527..e6b1defca1f1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -86,11 +86,13 @@ config LOONGARCH
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EBPF_JIT
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_VDSO
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index cce12e1971d8..ae42f9c5dc42 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -38,6 +38,13 @@
 #define R_AARCH64_ABS64	257
 #endif
 
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#define R_LARCH_64		2
+#define R_LARCH_MARK_LA			20
+#define R_LARCH_SOP_PUSH_PLT_PCREL	29
+#endif
+
 #define R_ARM_PC24		1
 #define R_ARM_THM_CALL		10
 #define R_ARM_CALL		28
@@ -441,6 +448,17 @@ static int arm64_is_fake_mcount(Elf64_Rel const *rp)
 	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;
 }
 
+static int LARCH64_is_fake_mcount(Elf64_Rel const *rp)
+{
+	switch (ELF64_R_TYPE(w(rp->r_info))) {
+	case R_LARCH_MARK_LA:
+	case R_LARCH_SOP_PUSH_PLT_PCREL:
+		return 0;
+	}
+
+	return 1;
+}
+
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
  * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
  * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.40]
@@ -558,6 +576,7 @@ static int do_file(char const *const fname)
 		break;
 	case EM_IA_64:	reltype = R_IA64_IMM64; break;
 	case EM_MIPS:	/* reltype: e_class    */ break;
+	case EM_LOONGARCH:	/* reltype: e_class    */ break;
 	case EM_PPC:	reltype = R_PPC_ADDR32; break;
 	case EM_PPC64:	reltype = R_PPC64_ADDR64; break;
 	case EM_S390:	/* reltype: e_class    */ break;
@@ -610,6 +629,10 @@ static int do_file(char const *const fname)
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount64 = MIPS64_is_fake_mcount;
 		}
+		if (w2(ghdr->e_machine) == EM_LOONGARCH) {
+			reltype = R_LARCH_64;
+			is_fake_mcount64 = LARCH64_is_fake_mcount;
+		}
 		if (do64(ghdr, fname, reltype) < 0)
 			goto out;
 		break;
-- 
2.36.0

