Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4C70B35D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjEVCwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEVCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:52:11 -0400
X-Greylist: delayed 85 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 May 2023 19:52:03 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37651188
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:52:02 -0700 (PDT)
X-QQ-mid: bizesmtp66t1684723824tixnfbhg
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 May 2023 10:50:23 +0800 (CST)
X-QQ-SSF: 01200000000000204000000A0000000
X-QQ-FEAT: fp7GbACbaw5+/Q/MDriKgD9K7a4eKyWoz7734QLbFWStCUU/K7or6Lv1s5wOQ
        z89TIgb0hFWuT+B13h0yWpejC28/IEq+yFu5lnWDBG//Hf0Vw5LHFNvPNgOi6Bu6SS1MM5A
        mZi57ZiIsGAlPBD7i0UGXyb7AhQf/J2SDcp2KZM8wDWqlBaBjt/Nf2EsPHPCYK4Fpb7Bz0r
        V5SYhnifPJ6awCgeF8okbGEiD4YWUK+R1WCgYPBhYmAINustflXk79e14nHnpLSL6IKbtjH
        7Aw5Ccd02qII2Iv5a6ovTcZtirCSalh//tzOo9q75WEawLfmRA/6/E3YrV+63bo9spXftFG
        brd6ajRUBnvXlVsH0Xvsmt9srrsIY1F6RxRF5aaJgJDz41/PxU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14716206032302420397
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, suagrfillet@gmail.com,
        mason.huo@starfivetech.com, leyfoon.tan@starfivetech.com,
        ajones@ventanamicro.com, jeeheng.sia@starfivetech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V2] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
Date:   Mon, 22 May 2023 10:50:20 +0800
Message-Id: <20230522025020.285042-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspend_restore_csrs is called in both __hibernate_cpu_resume
and the `else` of subsequent swsusp_arch_suspend.

Removing the first call makes both suspend_{save,restore}_csrs
left in swsusp_arch_suspend for clean code.

Fixes: c0317210012e ("RISC-V: Add arch functions to support hibernation/suspend-to-disk")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---

Changes since V1:
https://lore.kernel.org/linux-riscv/20230519102908.253458-1-suagrfillet@gmail.com/
- fix incorrect email in the Author and SoB field
- add Fixes tag

---
 arch/riscv/kernel/hibernate-asm.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
index 5c76671c7e15..d698dd7df637 100644
--- a/arch/riscv/kernel/hibernate-asm.S
+++ b/arch/riscv/kernel/hibernate-asm.S
@@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
 
 	REG_L	a0, hibernate_cpu_context
 
-	suspend_restore_csrs
 	suspend_restore_regs
 
 	/* Return zero value. */
-- 
2.20.1

