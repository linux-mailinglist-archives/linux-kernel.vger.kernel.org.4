Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970B75F4A64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJDUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJDUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:37:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5286BCC4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:37:39 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ofofT-0004n6-4O; Tue, 04 Oct 2022 22:37:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor.Dooley@microchip.com, cmuellner@linux.com,
        samuel@sholland.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] RISC-V: Cache SBI vendor values
Date:   Tue,  4 Oct 2022 22:37:23 +0200
Message-Id: <20221004203724.1459763-2-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221004203724.1459763-1-heiko@sntech.de>
References: <20221004203724.1459763-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbi_get_mvendorid(), sbi_get_marchid() and sbi_get_mimpid() might get
called multiple times, though the values of these CSRs should not change
during the runtime of a specific machine.

So cache the values in the functions and prevent multiple ecalls
to read these values.

Suggested-by: Atish Patra <atishp@atishpatra.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/sbi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 775d3322b422..5be8f90f325e 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -625,17 +625,32 @@ static inline long sbi_get_firmware_version(void)
 
 long sbi_get_mvendorid(void)
 {
-	return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
+	static long id = -1;
+
+	if (id < 0)
+		id = __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
+
+	return id;
 }
 
 long sbi_get_marchid(void)
 {
-	return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
+	static long id = -1;
+
+	if (id < 0)
+		id = __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
+
+	return id;
 }
 
 long sbi_get_mimpid(void)
 {
-	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
+	static long id = -1;
+
+	if (id < 0)
+		id = __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
+
+	return id;
 }
 
 static void sbi_send_cpumask_ipi(const struct cpumask *target)
-- 
2.35.1

