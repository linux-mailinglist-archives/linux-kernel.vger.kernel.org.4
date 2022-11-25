Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989763889B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKYLVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKYLVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:21:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4027918
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:21:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g10so3712903plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu6gMWlGL1798v9tVBYC6q+OA3VeKQCQFwAOJPQbKO0=;
        b=To90HQsu+nRhrpBaf8hoVduWXUfZ1tr9GO8p1fFwpVasAb3QZFs9HML/Qrn1vrBE7C
         3vsuD281OG3+H1XN4yvrHCeF683B/dTB9o68D0P0JqmhXXS2OFvmXp/ayHdWWhlLbFA1
         1CD37gIN/DfDUk5meIAc+lAmcFJmB+nbYa+m+YwDLmYAr9PqnpiIWCEXBAe3MZzVSM4H
         6tAdLsJNKS8hamjUTFwrq+Td+h8NOuRo1Z9pgDp60Do59P+x/KYvKWLXjQWiYLdYLzcP
         rtHK1GwJdups2WWAH6HJ4p+1l+tYOGlUGE0dwQI1jI5Y+xS1T3BdF1HEvknSqfc7YIHL
         QyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bu6gMWlGL1798v9tVBYC6q+OA3VeKQCQFwAOJPQbKO0=;
        b=IBtt8Q9DQ/SpPIIF3jAydi0rZRx8D1tRRWwRpC1X6+IERIh56ijvfQ1l4s9sDw0zJh
         Ot70CUhi80ffv517Bk0vGlfv+Ibxocik0319Myre0Unw/h6V5JMbnEtBLpmfS3cjcoyr
         1ivKyngY+hBonqreWZdl0ixwfV1P1uP1ia6FXtUXhTjqAJG76g5y3CIQ+y/Ss/fo5WU/
         HfW1KwncTV7PzN7uOskqoMRvh/gppqKpSOf02MTdjhHPct0o3vBO3cbLrRwcMybxtql8
         5DKJcWog7IjFRnDqassgqHhLmS/MgibHK5EMyV8/kcXTIVFjGBbFW3OzC377h2P3sVqz
         EbnQ==
X-Gm-Message-State: ANoB5pnmwk2YDxYpRYDpDyX1pgO+VmjSlYOaj2TiqPKI0DT6aMzmExFG
        wmAtc+pqfg7eifCOLD23Nj8qGg==
X-Google-Smtp-Source: AA0mqf6g24tHjlg8F5EfnWXfFlEVrgU699VXSpbDgg0ghtBXNTb315U16mtrNFdCP2BZ6q5QaQdR2w==
X-Received: by 2002:a17:90b:1d45:b0:218:6db5:fd98 with SMTP id ok5-20020a17090b1d4500b002186db5fd98mr41313988pjb.164.1669375293993;
        Fri, 25 Nov 2022 03:21:33 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id e66-20020a621e45000000b0057488230704sm2834335pfe.219.2022.11.25.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:21:33 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 1/3] Revert "clocksource/drivers/riscv: Events are stopped during CPU suspend"
Date:   Fri, 25 Nov 2022 16:51:03 +0530
Message-Id: <20221125112105.427045-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125112105.427045-1-apatel@ventanamicro.com>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.

On the subject of suspend, the RISC-V SBI spec states:
> Request the SBI implementation to put the calling hart in a platform
> specific suspend (or low power) state specified by the suspend_type
> parameter. The hart will automatically come out of suspended state and
> resume normal execution when it receives an interrupt or platform
> specific hardware event.

This does not cover whether any given events actually reach the hart or
not, just what the hart will do if it receives an event. On PolarFire
SoC, and potentially other SiFive based implementations, events from the
RISC-V timer do reach a hart during suspend. This is not the case for
the implementation on the Allwinner D1 - there timer events are not
received during suspend.

To fix this, the C3STOP feature was enabled for the timer driver -
but this has broken both RCU stall detection and timers generally on
PolarFire SoC (and potentially other SiFive based implementations).

If an AXI read to the PCIe controller on PolarFire SoC times out, the
system will stall, however, with this patch applied, the system just
locks up without RCU stalling:
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

Similarly issues were reported with clock_nanosleep() - with a test app
that sleeps each cpu for 6, 5, 4, 3 ms respectively, HZ=250 & the blamed
commit in place, the sleep times are rounded up to the next jiffy:

== CPU: 1 ==      == CPU: 2 ==      == CPU: 3 ==      == CPU: 4 ==
Mean: 7.974992    Mean: 7.976534    Mean: 7.962591    Mean: 3.952179
Std Dev: 0.154374 Std Dev: 0.156082 Std Dev: 0.171018 Std Dev: 0.076193
Hi: 9.472000      Hi: 10.495000     Hi: 8.864000      Hi: 4.736000
Lo: 6.087000      Lo: 6.380000      Lo: 4.872000      Lo: 3.403000
Samples: 521      Samples: 521      Samples: 521      Samples: 521

Fortunately, the D1 has a second timer, which is "currently used in
preference to the RISC-V/SBI timer driver" so a revert here does not
hurt operation of D1 in its current form.

Ultimately, a DeviceTree property (or node) will be added to encode the
behaviour of the timers, but until then revert the addition of
CLOCK_EVT_FEAT_C3STOP.

Link: https://lore.kernel.org/linux-riscv/YzYTNQRxLr7Q9JR0@spud/
Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98/
Link: https://lore.kernel.org/linux-riscv/bf6d3b1f-f703-4a25-833e-972a44a04114@sholland.org/
Fixes: 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped during CPU suspend")
CC: Samuel Holland <samuel@sholland.org>
CC: Anup Patel <anup@brainfault.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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
2.34.1

