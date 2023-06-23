Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA42E73B8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFWNoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFWNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:12 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABB52100;
        Fri, 23 Jun 2023 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527849; bh=/Ae3yGesaN7INKQfcIHyYeenAVct9PlZ6PKdEfJO/pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0tcPRjdJAB4zJ1J7o8RgYD67NPg92Lr3puaEW9/IUxDIJMcr/AP3vc9vDt3Q2tse
         36aB9ryT43crdMZ1CIo00Anf2m2yhjx2RkVsE6w1vZ7K6OFzU5NoAk6mdq3rogjXfW
         GG+Jj4X1EURYB3cu6bZ9p+MLHGUf7tXgx4XiQidE=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 95703605DB;
        Fri, 23 Jun 2023 21:44:08 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 2/9] LoongArch: extable: Also recognize ABI names of registers
Date:   Fri, 23 Jun 2023 21:43:44 +0800
Message-Id: <20230623134351.1898379-3-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230623134351.1898379-1-kernel@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Rui <wangrui@loongson.cn>

When the kernel is compiled with LLVM, the register names being handled
during exception fixup building are ABI names instead of bare $rNN
style. Add mapping for the ABI names for LLVM compatibility.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/include/asm/gpr-num.h | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/loongarch/include/asm/gpr-num.h b/arch/loongarch/include/asm/gpr-num.h
index e0941af20c7e..996038da806d 100644
--- a/arch/loongarch/include/asm/gpr-num.h
+++ b/arch/loongarch/include/asm/gpr-num.h
@@ -9,6 +9,22 @@
 	.equ	.L__gpr_num_$r\num, \num
 	.endr
 
+	/* ABI names of registers */
+	.equ	.L__gpr_num_$ra, 1
+	.equ	.L__gpr_num_$tp, 2
+	.equ	.L__gpr_num_$sp, 3
+	.irp	num,0,1,2,3,4,5,6,7
+	.equ	.L__gpr_num_$a\num, 4 + \num
+	.endr
+	.irp	num,0,1,2,3,4,5,6,7,8
+	.equ	.L__gpr_num_$t\num, 12 + \num
+	.endr
+	.equ	.L__gpr_num_$s9, 22
+	.equ	.L__gpr_num_$fp, 22
+	.irp	num,0,1,2,3,4,5,6,7,8
+	.equ	.L__gpr_num_$s\num, 23 + \num
+	.endr
+
 #else /* __ASSEMBLY__ */
 
 #define __DEFINE_ASM_GPR_NUMS					\
@@ -16,6 +32,20 @@
 "	.irp	num,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31\n" \
 "	.equ	.L__gpr_num_$r\\num, \\num\n"			\
 "	.endr\n"						\
+"	.equ	.L__gpr_num_$ra, 1\n"				\
+"	.equ	.L__gpr_num_$tp, 2\n"				\
+"	.equ	.L__gpr_num_$sp, 3\n"				\
+"	.irp	num,0,1,2,3,4,5,6,7\n"				\
+"	.equ	.L__gpr_num_$a\\num, 4 + \\num\n"		\
+"	.endr\n"						\
+"	.irp	num,0,1,2,3,4,5,6,7,8\n"			\
+"	.equ	.L__gpr_num_$t\\num, 12 + \\num\n"		\
+"	.endr\n"						\
+"	.equ	.L__gpr_num_$s9, 22\n"				\
+"	.equ	.L__gpr_num_$fp, 22\n"				\
+"	.irp	num,0,1,2,3,4,5,6,7,8\n"			\
+"	.equ	.L__gpr_num_$s\\num, 23 + \\num\n"		\
+"	.endr\n"						\
 
 #endif /* __ASSEMBLY__ */
 
-- 
2.40.0

