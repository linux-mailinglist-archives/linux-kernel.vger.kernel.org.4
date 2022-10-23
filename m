Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B76095B6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJWSzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJWSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F536DDF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A922EB80D90
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86E8C433D6;
        Sun, 23 Oct 2022 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666551309;
        bh=b1OgIjfo/vN3Wzi1YZhctjiBYrxk8+3C/gbHYBJY808=;
        h=From:To:Cc:Subject:Date:From;
        b=QfBjm4lHPb4x8RrylH9Jgg4rhZi6CVodwyBLeUo1tSsU6v9D9ruBRJGNdKWCyyoXD
         C1OPkW/WZTBgkz77qmI1xzKUFVh0GjwMXNGrd6f9ypF9rXwk5WbTiZFRGu9NYP8s73
         sjw+wvVM3a2p0xOILeA4C42ZplfMB+gUWnlKkkq6x3EvTCcCMeQxeW+STbgRyNe34p
         4iHGAc6lfrWQpJQ3O/cgoS7gSmOj/7NWoB8APxdmfZY/L+SQsuMd6T6q8hFxbROAMl
         /HNzZzxjYlrKtSKzu5dfldfYNaLQ6RnIdrgnOigOQvcG4/6DaSAOu81rEWejrSO2Fy
         5guuKCk5zctjQ==
From:   Conor Dooley <conor@kernel.org>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     Conor Dooley <conor.dooley@microchip.com>, samuel@sholland.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [PATCH] Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend"
Date:   Sun, 23 Oct 2022 19:54:44 +0100
Message-Id: <20221023185444.678573-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.
If an AXI read to the PCIe controller on PolarFire SoC times out, the
system will stall, with an expected:
	 io scheduler mq-deadline registered
	 io scheduler kyber registered
	 microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
	 microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: axi read request error
	 microchip-pcie 2000000000.pcie: axi read timeout
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 Freeing initrd memory: 7336K
	 mc_event_handler: 667402 callbacks suppressed
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 mc_event_handler: 666588 callbacks suppressed
<truncated>
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	mc_event_handler: 666748 callbacks suppressed
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	rcu: 	0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002 softirq=34/36 fqs=2626
		(detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
	Task dump for CPU 0:
	task:swapper/0       state:R  running task     stack:    0 pid:    1 ppid:     0 flags:0x00000008
	Call Trace:
	mc_event_handler: 666648 callbacks suppressed

 With this patch applied, the system just locks up without RCU stalling:
	io scheduler mq-deadline registered
	io scheduler kyber registered
	microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
	microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: axi read request error
	microchip-pcie 2000000000.pcie: axi read timeout
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	Freeing initrd memory: 7332K

Link: https://lore.kernel.org/linux-riscv/YzYTNQRxLr7Q9JR0@spud/
Fixes: 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped during CPU suspend")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I don't really want to post a revert, but it's been nearly a month since
I posted about my issue initially & 2 weeks without a reply to Palmer's
comments.
CC: samuel@sholland.org
CC: aou@eecs.berkeley.edu
CC: atishp@atishpatra.org
CC: daniel.lezcano@linaro.org
CC: dmitriy@oss-tech.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: palmer@dabbelt.com
CC: paul.walmsley@sifive.com
CC: tglx@linutronix.de
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 969a552da8d2..a0d66fabf073 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -51,7 +51,7 @@ static int riscv_clock_next_event(unsigned long delta,
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 };
-- 
2.38.0

