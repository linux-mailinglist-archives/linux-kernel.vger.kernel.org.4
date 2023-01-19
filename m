Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D76732F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjASHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjASHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:50:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDEE689FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C8461BA6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94ACC433EF;
        Thu, 19 Jan 2023 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674114493;
        bh=PBE0PpRXIlt2qCDFtsjgADfP4kD6JxkZrkUXxW7Tmuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+9OmwVL6lX48jOEAysQTK3qhLt3mSeXbLlVru28JnzuovuPCuTdiTQtUoSwjB+ps
         Wd56KDxsYagdWgG7gH83veEO34aLJf1+lkkB+UiWSJNfo6/PjRS/8mC2UhNxayL4zd
         IgN54fSBcVNOm9GvIGHQNc93olFcrzVMmY9NNju/K2PCXIGrFao/mbWzEnZNvbYRXx
         sY+bzGVxz6VFYL4ptncHJMFnLQASifnFjX4RfFyNh//oPXdrR75K8pyaFMAcjPHMhb
         MknCw6cEnu9oYlXUsnlFTfWIGVxga+Ni5GgCbBg/Jieh2Q2WpeR7nVxD2m+G0goBIe
         LV5rrCkiwU1bg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] scripts/decodecode: Add support for RISC-V
Date:   Thu, 19 Jan 2023 08:47:38 +0100
Message-Id: <20230119074738.708301-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230119074738.708301-1-bjorn@kernel.org>
References: <20230119074738.708301-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

RISC-V has some GNU disassembly quirks, e.g. it requires '-D' to
properly disassemble .2byte directives similar to Arm [1]. Further,
GNU objdump groups RISC-V instruction by 2 or 4 byte chunks, instead
doing byte-for-byte.

Add the required switches, and translate from short/word to bytes when
ARCH is "riscv".

An example how to invoke decodecode for RISC-V:
  $ echo 'Code: bf45 f793 1007 f7d9 50ef 37af d541 b7d9 7097 00c8 (80e7)
  6140' | AFLAGS="-march=rv64imac_zicbom_zihintpause"  \
  ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- ./scripts/decodecode
  Code: bf45 f793 1007 f7d9 50ef 37af d541 b7d9 7097 00c8 (80e7) 6140
  All code
  ========
     0:   bf45                    c.j     0xffffffffffffffb0
     2:   1007f793                andi    a5,a5,256
     6:   f7d9                    c.bnez  a5,0xffffffffffffff94
     8:   37af50ef                jal     ra,0xf5382
     c:   d541                    c.beqz  a0,0xffffffffffffff94
     e:   b7d9                    c.j     0xffffffffffffffd4
    10:   00c87097                auipc   ra,0xc87
    14:*  614080e7                jalr    ra,1556(ra) # 0xc87624          <-- trapping instruction

  Code starting with the faulting instruction
  ===========================================
     0:   614080e7                jalr    ra,1556(ra)

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=10263

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 scripts/decodecode | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index b28fd2686561..8fe71c292381 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -93,6 +93,11 @@ disas() {
 		${CROSS_COMPILE}strip $t.o
 	fi
 
+	if [ "$ARCH" = "riscv" ]; then
+		OBJDUMPFLAGS="-M no-aliases --section=.text -D"
+		${CROSS_COMPILE}strip $t.o
+	fi
+
 	if [ $pc_sub -ne 0 ]; then
 		if [ $PC ]; then
 			adj_vma=$(( $PC - $pc_sub ))
@@ -126,8 +131,13 @@ get_substr_opcode_bytes_num()
 	do
 		substr+="$opc"
 
+		opcode="$substr"
+		if [ "$ARCH" = "riscv" ]; then
+			opcode=$(echo $opcode | tr ' ' '\n' | tac | tr -d '\n')
+		fi
+
 		# return if opcode bytes do not match @opline anymore
-		if ! echo $opline | grep -q "$substr";
+		if ! echo $opline | grep -q "$opcode";
 		then
 			break
 		fi
-- 
2.37.2

