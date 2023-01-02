Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ECB65B4C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjABQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjABQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:08:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D8EB7C2;
        Mon,  2 Jan 2023 08:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7E7C60C2A;
        Mon,  2 Jan 2023 16:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB6CC433EF;
        Mon,  2 Jan 2023 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672675677;
        bh=AO3Ixc0TR11NeS3MBCzLhmAhDwnDKeJ/27og6j1PuYM=;
        h=From:To:Cc:Subject:Date:From;
        b=gDRaFyOHdrdRw8JvQAgaQ3UkwUJGEFtMQyT3fDX9inWxwCXnFxV4Oj35qM87PjeP7
         4IiGHpaOVpM9BRytyMeQeCmn8ybG3xGtVKC2lVBvNiOWqL8Hk3Z/Q8+ESQFcSUO0UG
         dig9tg9miI8hw6mNtsgTDqJMvAA2i2EL+2eZa5UosoQ1wrSKeoMj0NSXFEUFlGSfL4
         MS+Cm3dUcgcOg3FrRf4j4LdNbczf9fHEhxKZ9taF9e0yeVw/D0GtkwNnI+F9KM9Xnt
         Md4VrHmsWfgc4yVmWOVfoKqTwV5bBXp16YEyc1yZL3Ry7uMtLi8Xtx9LIBw/4WrzyC
         QMZYEJmpyH3Hg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] riscv, kprobes: Stricter c.jr/c.jalr decoding
Date:   Mon,  2 Jan 2023 17:07:48 +0100
Message-Id: <20230102160748.1307289-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
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

In the compressed instruction extension, c.jr, c.jalr, c.mv, and c.add
is encoded the following way (each instruction is 16b):

---+-+-----------+-----------+--
100 0 rs1[4:0]!=0       00000 10 : c.jr
100 1 rs1[4:0]!=0       00000 10 : c.jalr
100 0  rd[4:0]!=0 rs2[4:0]!=0 10 : c.mv
100 1  rd[4:0]!=0 rs2[4:0]!=0 10 : c.add

The following logic is used to decode c.jr and c.jalr:

  insn & 0xf007 == 0x8002 => instruction is an c.jr
  insn & 0xf007 == 0x9002 => instruction is an c.jalr

When 0xf007 is used to mask the instruction, c.mv can be incorrectly
decoded as c.jr, and c.add as c.jalr.

Correct the decoding by changing the mask from 0xf007 to 0xf07f.

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/probes/simulate-insn.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index cb6ff7dccb92..de8474146a9b 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -31,9 +31,9 @@ __RISCV_INSN_FUNCS(fence,	0x7f, 0x0f);
 	} while (0)
 
 __RISCV_INSN_FUNCS(c_j,		0xe003, 0xa001);
-__RISCV_INSN_FUNCS(c_jr,	0xf007, 0x8002);
+__RISCV_INSN_FUNCS(c_jr,	0xf07f, 0x8002);
 __RISCV_INSN_FUNCS(c_jal,	0xe003, 0x2001);
-__RISCV_INSN_FUNCS(c_jalr,	0xf007, 0x9002);
+__RISCV_INSN_FUNCS(c_jalr,	0xf07f, 0x9002);
 __RISCV_INSN_FUNCS(c_beqz,	0xe003, 0xc001);
 __RISCV_INSN_FUNCS(c_bnez,	0xe003, 0xe001);
 __RISCV_INSN_FUNCS(c_ebreak,	0xffff, 0x9002);

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.37.2

