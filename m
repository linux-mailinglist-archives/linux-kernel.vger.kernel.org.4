Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B684B7216E8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFDM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFDM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:27:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AEF83;
        Sun,  4 Jun 2023 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685881623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OrYR5qPyKXvfTrOCl2QZ+y5ZmDrd9I/Nr/7WM1Hie54=;
        b=R+gd789bh+l/TKhakJMMD4gDQF4qUuYwOmR/XtZPBQjJeMsIS9+pbJBsPYLQrc2UXWIhEo
        w1XcH9tRBZP9uReeYljG1XsGO+3lvTMVC+hGws6+Y8j9DP1FoMEvkfb5/hXPZlbl49ZWiL
        uqFhxVc43nKjZWn22iv3NjB+8aWnoLU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Siarhei Volkau <lis8215@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net
Subject: [PATCH 1/4] MIPS: uaccess: emulate Ingenic LXW/LXH/LXHU uaccess
Date:   Sun,  4 Jun 2023 14:26:52 +0200
Message-Id: <20230604122655.69698-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siarhei Volkau <lis8215@gmail.com>

The LXW, LXH, LXHU opcodes are part of the MXU ASE found in Ingenic
XBurst based SoCs.

While technically part of the MXU ASE, they do not touch any of the SIMD
registers, and can be used even when the MXU ASE is disabled.

This patch makes it possible to emulate unaligned access for those
instructions.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/include/uapi/asm/inst.h | 33 +++++++++++++++++++++++++
 arch/mips/kernel/unaligned.c      | 41 +++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 43d1faa02933..c29dbc8c1d49 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -272,6 +272,27 @@ enum lx_func {
 	lbx_op	= 0x16,
 };
 
+/*
+ * func field for special2 MXU opcodes (Ingenic XBurst MXU).
+ */
+enum mxu_func {
+	/* TODO, other MXU funcs */
+	mxu_lx_op = 0x28,
+};
+
+/*
+ * op field for special2 MXU LX opcodes (Ingenic XBurst MXU).
+ */
+enum lx_ingenic_func {
+	mxu_lxb_op,
+	mxu_lxh_op,
+	/* reserved */
+	mxu_lxw_op = 3,
+	mxu_lxbu_op,
+	mxu_lxhu_op,
+	/* more reserved */
+};
+
 /*
  * BSHFL opcodes
  */
@@ -774,6 +795,17 @@ struct dsp_format {		/* SPEC3 DSP format instructions */
 	;))))))
 };
 
+struct mxu_lx_format {		/* SPEC2 MXU LX format instructions */
+	__BITFIELD_FIELD(unsigned int opcode : 6,
+	__BITFIELD_FIELD(unsigned int rs : 5,
+	__BITFIELD_FIELD(unsigned int rt : 5,
+	__BITFIELD_FIELD(unsigned int rd : 5,
+	__BITFIELD_FIELD(unsigned int strd : 2,
+	__BITFIELD_FIELD(unsigned int op : 3,
+	__BITFIELD_FIELD(unsigned int func : 6,
+	;)))))))
+};
+
 struct spec3_format {   /* SPEC3 */
 	__BITFIELD_FIELD(unsigned int opcode:6,
 	__BITFIELD_FIELD(unsigned int rs:5,
@@ -1125,6 +1157,7 @@ union mips_instruction {
 	struct loongson3_lswc2_format loongson3_lswc2_format;
 	struct loongson3_lsdc2_format loongson3_lsdc2_format;
 	struct loongson3_lscsr_format loongson3_lscsr_format;
+	struct mxu_lx_format mxu_lx_format;
 };
 
 union mips16e_instruction {
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 7b5aba5df02e..f4cf94e92ec3 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -160,6 +160,47 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		 * The remaining opcodes are the ones that are really of
 		 * interest.
 		 */
+#ifdef CONFIG_MACH_INGENIC
+	case spec2_op:
+		if (insn.mxu_lx_format.func != mxu_lx_op)
+			goto sigbus; /* other MXU instructions we don't care */
+
+		switch (insn.mxu_lx_format.op) {
+		case mxu_lxw_op:
+			if (user && !access_ok(addr, 4))
+				goto sigbus;
+			LoadW(addr, value, res);
+			if (res)
+				goto fault;
+			compute_return_epc(regs);
+			regs->regs[insn.mxu_lx_format.rd] = value;
+			break;
+		case mxu_lxh_op:
+			if (user && !access_ok(addr, 2))
+				goto sigbus;
+			LoadHW(addr, value, res);
+			if (res)
+				goto fault;
+			compute_return_epc(regs);
+			regs->regs[insn.dsp_format.rd] = value;
+			break;
+		case mxu_lxhu_op:
+			if (user && !access_ok(addr, 2))
+				goto sigbus;
+			LoadHWU(addr, value, res);
+			if (res)
+				goto fault;
+			compute_return_epc(regs);
+			regs->regs[insn.dsp_format.rd] = value;
+			break;
+		case mxu_lxb_op:
+		case mxu_lxbu_op:
+			goto sigbus;
+		default:
+			goto sigill;
+		}
+		break;
+#endif
 	case spec3_op:
 		if (insn.dsp_format.func == lx_op) {
 			switch (insn.dsp_format.op) {
-- 
2.39.2

