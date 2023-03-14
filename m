Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14786B8A09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCNFDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 01:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCNFDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:03:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B026BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:03:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 64B7B24E36E;
        Tue, 14 Mar 2023 13:03:28 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 13:03:28 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 14 Mar 2023 13:03:24 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 1/4] RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public function
Date:   Tue, 14 Mar 2023 13:03:13 +0800
Message-ID: <20230314050316.31701-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
References: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently suspend_save_csrs() and suspend_restore_csrs() functions are
statically defined in the suspend.c. Change the function's attribute
to public so that the functions can be used by hibernation as well.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/suspend.h | 3 +++
 arch/riscv/kernel/suspend.c      | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 8be391c2aecb..67e047445662 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -33,4 +33,7 @@ int cpu_suspend(unsigned long arg,
 /* Low-level CPU resume entry function */
 int __cpu_resume_enter(unsigned long hartid, unsigned long context);
 
+/* Used to save and restore the CSRs */
+void suspend_save_csrs(struct suspend_context *context);
+void suspend_restore_csrs(struct suspend_context *context);
 #endif
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 9ba24fb8cc93..3c89b8ec69c4 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -8,7 +8,7 @@
 #include <asm/csr.h>
 #include <asm/suspend.h>
 
-static void suspend_save_csrs(struct suspend_context *context)
+void suspend_save_csrs(struct suspend_context *context)
 {
 	context->scratch = csr_read(CSR_SCRATCH);
 	context->tvec = csr_read(CSR_TVEC);
@@ -29,7 +29,7 @@ static void suspend_save_csrs(struct suspend_context *context)
 #endif
 }
 
-static void suspend_restore_csrs(struct suspend_context *context)
+void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, context->scratch);
 	csr_write(CSR_TVEC, context->tvec);
-- 
2.34.1

