Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4191A669B29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjAMO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjAMO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:58:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21E77AE8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97EB61FC3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B87C433D2;
        Fri, 13 Jan 2023 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673621173;
        bh=uVNiYN015zOKGYAR63hxg0e1aLPV1U+u9Ab5GMB5AGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNB4FYpN1R5PNtOd0/xoHymyzhJfoSvNDyhNH6pomXpBHz6C5FA5rYzkMEgM2qolb
         PP3FcgRXKYfCReSGva3gI983FKqej3Y3C16Lq71ULLpXFZTqds0vPVPwckIp/oGRC/
         Tc06UIHS4zVhWoWLu/oZ1ppLnvAISGUdi1rNvJ4aK4XKKAa+r8+SWg9TaQx7ZFg789
         QWagfHjInlSw+xruSyI9Fsfdo0uVi/99jSR+yJDgTtEsWeLh4Z67btkwlapRRZlx9X
         i4WEam9AWc6O79NFg+yi9QpxuCXSt8gefltBDwjxl37y4sLrQiq2yTGL5pjykZRNkZ
         DspERoJ/E7rqw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts/decodecode: Add support for RISC-V
Date:   Fri, 13 Jan 2023 15:45:52 +0100
Message-Id: <20230113144552.138081-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113144552.138081-1-bjorn@kernel.org>
References: <20230113144552.138081-1-bjorn@kernel.org>
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
properly disassemble .byte directives similar to Arm [1]. Further, GNU
objdump groups RISC-V instruction by 2 or 4 byte chunks, instead doing
byte-for-byte.

Add the required switches, and translate from short/word to bytes when
ARCH is "riscv".

An example how to invoke decodecode for RISC-V:
  $ echo 'Code: 64 c9 29 a0 17 d4 1f 01 13 04 44
  b8 93 92 38 00 16 94 00 60 <02> 94 aa e8' |  \
  AFLAGS="-march=rv64imac_zicbom_zihintpause"  \
  ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- ./scripts/decodecode
  Code: 64 c9 29 a0 17 d4 1f 01 13 04 44 b8 93 92 38 00 16 94 00 60 <02> 94 aa e8
  All code
  ========
     0:   c964                    c.sw    s1,84(a0)
     2:   a029                    c.j     c <.text+0xc>
     4:   011fd417                auipc   s0,0x11fd
     8:   b8440413                addi    s0,s0,-1148 # 11fcb88 <.text+0x11fcb88>
     c:   00389293                slli    t0,a7,0x3
    10:   9416                    c.add   s0,t0
    12:   6000                    c.ld    s0,0(s0)
    14:*  9402                    c.jalr  s0              <-- trapping instruction
    16:   e8aa                    c.sdsp  a0,80(sp)

  Code starting with the faulting instruction
  ===========================================
     0:   9402                    c.jalr  s0
     2:   e8aa                    c.sdsp  a0,80(sp)

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

