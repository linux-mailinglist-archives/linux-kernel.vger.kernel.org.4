Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA034623597
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiKIVRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKIVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:17:03 -0500
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 13:17:00 PST
Received: from smtp-4.b-tu.de (smtp-4.b-tu.de [141.43.208.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616231221
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:17:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp-4.b-tu.de (Postfix) with ESMTP id 4N6yLV2z53zGsZnW;
        Wed,  9 Nov 2022 22:10:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=b-tu.de; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :x-mailer:message-id:subject:subject:from:from:date:date
        :received:received; s=smtp; t=1668028256; x=1668892257; bh=P4rW3
        JoP+8noNBW4QOWFMnNFqANdUsIam1OlFgKyq+4=; b=pnbckGjVvB0bVgOSZtwK2
        pQIgepZeS9OVLSMdbntzTZtQ/QfigasOtX9u8l0kPcfZNfK+UDjG4X9FEV/7ACul
        pU27rPEeHse03dLaKfAt4HlvxND9u1J2keO3qseGsqH3DEf/Ltu5QV/AbCG4+taY
        6XeyDouEY94Pl+fbsnQaYE=
X-Virus-Scanned: by AMaViS (at smtp-4.b-tu.de)
Received: from smtp-4.b-tu.de ([127.0.0.1])
        by localhost (smtp-4.b-tu.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UcF6QBYdIPq7; Wed,  9 Nov 2022 22:10:56 +0100 (CET)
Received: from rosh (ipsec233.vpn.tu-cottbus.de [141.43.177.233])
        (Authenticated sender: dikarill@b-tu.de)
        by smtp-4.b-tu.de (Postfix) with ESMTPSA id 4N6yLM5xCHzGsZnV;
        Wed,  9 Nov 2022 22:10:51 +0100 (CET)
Date:   Wed, 9 Nov 2022 22:10:49 +0100
From:   Ilya Dikariev <dikarill@b-tu.de>
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] drivers/clocksource/arm_arch_timer: Tighten Allwinner arch
 timer workaround
Message-ID: <20221109221049.4bf3c5bb@rosh>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, the Allwinner A64 SoC has a buggy RCU time unit. The
workaround named UNKNOWN1 was not sufficient to cover some more buggy
bunches of this SoC. This workaround diminish the mask to 8 bits instead
of 9.

An example run of timer test tool https://github.com/smaeul/timer-tools
on PinePhone device (owns the A64 SoC) gives following result on a non
patched kernel (cut off):

Running parallel counter test...
0: Failed after 5507 reads (0.003578 s)
0: 0x0000000c8272cbf1 -> 0x0000000c8272ccff -> 0x0000000c8272cc0e (     0.011 ms)
2: Failed after 14518 reads (0.009248 s)
2: 0x0000000c827513f1 -> 0x0000000c82751300 -> 0x0000000c8275140e (    -0.010 ms)
3: Failed after 14112 reads (0.008730 s)
3: 0x0000000c8274f3f2 -> 0x0000000c8274f300 -> 0x0000000c8274f40d (    -0.010 ms)
1: Failed after 12030 reads (0.008409 s)
1: 0x0000000c8274abf1 -> 0x0000000c8274acff -> 0x0000000c8274ac0f (     0.011 ms)
1: 0x0000000c827759f2 -> 0x0000000c82775aff -> 0x0000000c82775a0e (     0.011 ms)
0: 0x0000000c8277a9f2 -> 0x0000000c8277aaff -> 0x0000000c8277aa0d (     0.011 ms)
2: 0x0000000c8278f3f1 -> 0x0000000c8278f300 -> 0x0000000c8278f40e (    -0.010 ms)
0: 0x0000000c82785ff2 -> 0x0000000c82784300 -> 0x0000000c8278600d (    -0.309 ms)

After the proposed patch applied the test runs
correctly (~2 hours of testing with a tool above without fails)

Signed-off-by: Ilya Dikariev <dikarill@b-tu.de>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a7ff77550e17..3019faa263f5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -371,7 +371,7 @@ static u64 notrace arm64_858921_read_cntvct_el0(void)
 	do {								\
 		_val = read_sysreg(reg);				\
 		_retries--;						\
-	} while (((_val + 1) & GENMASK(8, 0)) <= 1 && _retries);	\
+	} while (((_val + 1) & GENMASK(7, 0)) <= 1 && _retries);	\
 									\
 	WARN_ON_ONCE(!_retries);					\
 	_val;								\
-- 
2.25.1
