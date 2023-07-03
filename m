Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6628E746265
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGCSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGCSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3A121
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B2260FFB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BA7C433C7;
        Mon,  3 Jul 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688409095;
        bh=xOd6z6GLzShOy0vSnm82XHqZ/VJeHK3iTQUpUdu1pXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kBgGE0ZKDk2FVPCeBvzCxuOo+OjbOzJobgivXBkW9io+6Zfoa3Vo6Y54wjHjHSq4z
         9SqHoqh/ipjUQhNtVpwRiKmTWNoyUs6iJbvFapn3+dcLDexh0UkFF3TGRuFyK37NZt
         Kmk1jLDRGHPURtXygJTIXuAl4dz/hF0l5OEHdrxEJHrWd0z/TAjNIY8i1B5QBnYgeA
         bi/u2hoNDrIx6EXKsHMQN7W0x06hOcO5t8gppm0ax5CK1z5CkxcLRFmaX50CuxfVMp
         oZVP6MvrKEZti3KsxrFC0r51d5VE9Q/UQ+JNsfIbtk31ZB0lV0VRz8gzYwZ95vCqxU
         kDEcCpnKoaUrA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qGOKi-00AEn7-K8;
        Mon, 03 Jul 2023 19:31:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] risc-v: Fix order of IPI enablement vs RCU startup
Date:   Mon,  3 Jul 2023 19:31:26 +0100
Message-Id: <20230703183126.1567625-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, conor@kernel.org, apatel@ventanamicro.com, palmer@rivosinc.com, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor reports that risc-v tries to enable IPIs before telling the
core code to enable RCU. With the introduction of the mapple tree
as a backing store for the irq descriptors, this results in
a very shouty boot sequence, as RCU is legitimately upset.

Restore some sanity by moving the risc_ipi_enable() call after
notify_cpu_starting(), which explicitly enables RCU on the calling
CPU.

Fixes: 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")
Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230703-dupe-frying-79ae2ccf94eb@spud
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/riscv/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index bb0b76e1a6d4..f4d6acb38dd0 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -238,10 +238,11 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
-	riscv_ipi_enable();
-
 	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
+
+	riscv_ipi_enable();
+
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 	probe_vendor_features(curr_cpuid);
-- 
2.34.1

