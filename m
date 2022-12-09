Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9876485DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiLIPrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLIPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633EF379FE;
        Fri,  9 Dec 2022 07:47:24 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptf5JucJI9u3RmOJs1YiPXVOdJFaBXojrhh5idR/RN4=;
        b=bNfTGrjGpgkCApaF4NH9BaFg3su2rFHipR6iohAGgm6UmH+BRGk/aY1huwkRLnZRqWDhug
        TFy+Zgt7vf7bSL2eIiypFh7+QN/v1nDxKydYeVmrGBCXcivUbsFUkG/99sxsT9VeDU2kWJ
        Qy82GwznWCHzaiUtZ4IW/GY+TkQ5ZMXT5CEc++x0cJqxIvpnW6oqbAaRNybD1gq83FGKyB
        ZsUAnu0Cz2ZfBflDJvhRQVuZQ/PUYHgCUguq7Y7EMCR4FXE0cntgotzjxzwMwUt4yO14PQ
        r6ds4EjuIN+/wwMkeoJtNCol7Mi+juO4auY17+zY0+mkuhERnbyVW0ZAZagJcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptf5JucJI9u3RmOJs1YiPXVOdJFaBXojrhh5idR/RN4=;
        b=/Iq8f1Ok6sfvVh3kkkkI7Bl+kwkHWdVqzy/rta3ImM9ka5FTp0vlqcanrWHr+N1kRC5rsU
        UfH1J7Xnt+k7BGAA==
From:   "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix missing
 clk_disable_unprepare in dmtimer_systimer_init_clock()
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221029114427.946520-1-yangyingliang@huawei.com>
References: <20221029114427.946520-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <167060084258.4906.16638898488037471774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     180d35a7c05d520314a590c99ad8643d0213f28b
Gitweb:        https://git.kernel.org/tip/180d35a7c05d520314a590c99ad8643d0213f28b
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Sat, 29 Oct 2022 19:44:27 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:16:46 +01:00

clocksource/drivers/timer-ti-dm: Fix missing clk_disable_unprepare in dmtimer_systimer_init_clock()

If clk_get_rate() fails which is called after clk_prepare_enable(),
clk_disable_unprepare() need be called in error path to disable the
clock in dmtimer_systimer_init_clock().

Fixes: 52762fbd1c47 ("clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20221029114427.946520-1-yangyingliang@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 2737407..632523c 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -345,8 +345,10 @@ static int __init dmtimer_systimer_init_clock(struct dmtimer_systimer *t,
 		return error;
 
 	r = clk_get_rate(clock);
-	if (!r)
+	if (!r) {
+		clk_disable_unprepare(clock);
 		return -ENODEV;
+	}
 
 	if (is_ick)
 		t->ick = clock;
