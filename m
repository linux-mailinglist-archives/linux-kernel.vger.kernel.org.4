Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21E762F2DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiKRKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiKRKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:44:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351D657D3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F10EFB822FF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49D1C433D7;
        Fri, 18 Nov 2022 10:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668768286;
        bh=qC6743542xIKRAllyvxVqizsE1tEzX1YRdfQ4vU+JYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOv+280w2fVSZVzyZ0o2P0ElyXNHGc0WTNYaN6JNcI4R0rr3HXW8KbYMvQ0i+s/mA
         ds1/4ELX0y2QerpqCqeaRIYDNblXC7I0T0mYn53IYx4p+2TmV8nPRdyzFzp7lozQDS
         wIkWDLFmvS6g4KvSriEnPWqZ7WncoWBvBEEKkUJt4t5Qpgq4UBVS41h1cAJRofDrRP
         E3AIFbIqFN9qOyahhlq5vkjmZE5e/iFO1tINE/JVHFeie+zHRMpjDweog7E11xXmOh
         DYIiKlSW+x5Rebstuosq2Hx8W78XS2Y9ezFyW0hpquWnP44DN/yH0+h2ElQ3yPUZ4b
         tThL5vYdXbMJg==
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/3] irqchip/riscv-intc: remove user selectability of RISCV_INTC
Date:   Fri, 18 Nov 2022 10:43:00 +0000
Message-Id: <20221118104300.85016-3-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118104300.85016-1-conor@kernel.org>
References: <20221118104300.85016-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Since commit e71ee06e3ca3 ("RISC-V: Force select RISCV_INTC for
CONFIG_RISCV") the driver has been enabled at the arch level - and is
mandatory anyway. There's no point exposing this as a choice to users,
so stop bothering.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I'd swear I had an interaction with someone a few months ago about the
RISCV_INTC Kconfig options but I cannot for the file of me remember who.
I hope this patch is not be going back on what I said then...
---
 drivers/irqchip/Kconfig | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ecb3e3119d2e..4633a549ebbf 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -538,17 +538,8 @@ config TI_PRUSS_INTC
 	  different processors within the SoC.
 
 config RISCV_INTC
-	bool "RISC-V Local Interrupt Controller"
+	bool
 	depends on RISCV
-	default y
-	help
-	   This enables support for the per-HART local interrupt controller
-	   found in standard RISC-V systems.  The per-HART local interrupt
-	   controller handles timer interrupts, software interrupts, and
-	   hardware interrupts. Without a per-HART local interrupt controller,
-	   a RISC-V system will be unable to handle any interrupts.
-
-	   If you don't know what to do here, say Y.
 
 config SIFIVE_PLIC
 	bool
-- 
2.37.2

