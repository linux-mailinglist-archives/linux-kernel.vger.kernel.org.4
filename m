Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55C5F3FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJDJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDDFE023;
        Tue,  4 Oct 2022 02:27:22 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iOlIsPvIorkVC3FdK9Ia0W6rjOvLSCjKlnmCC9R/AA=;
        b=fQevhT8WkiW1xZQhKeClHToGEuLoENCoN7Z0bIvtKPKbOevIBJGHOjnSabnNzfJf47uYhn
        f5zVLPkIMvOPPoK1GcE/ATn4ggdP6lp7u7MBXe+xDEYvIjSqLurxZBHlsFC2LZ9AQKunmS
        elo29BAzLVHqlfOJv5DTMgkMV8rl/ppv4lqkU72KrunpayeRTu6njXDvjJNh6kYg22M2GT
        MQiSChIwNvPiZTNtizGfp9/H/Ka0OyemaXZrWkepsM+OHBu2Z2Ubd4J6buJw9sslfcbsMH
        14ZKehyXNJRN8SNY+aBXCCzamrKW6av2ui5s/WJ5r/MBGRy/y5XcFSL/1qOnmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iOlIsPvIorkVC3FdK9Ia0W6rjOvLSCjKlnmCC9R/AA=;
        b=WEPYOOJ//7J7Nh5w34OOzR3u3FovtA7BQ63aJa3sOyDuiOh2WW2Pzw6X4nynV8S3XlVIfS
        PQ/KFRwWYDejmaAg==
From:   "tip-bot2 for Kunkun Jiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Fix handling
 of ARM erratum 858921
Cc:     Kunkun Jiang <jiangkunkun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220914061424.1260-1-jiangkunkun@huawei.com>
References: <20220914061424.1260-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Message-ID: <166487563952.401.8922656872423059068.tip-bot2@tip-bot2>
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

Commit-ID:     6c3b62d93e195f78c1437c8fa7581e9b2f00886e
Gitweb:        https://git.kernel.org/tip/6c3b62d93e195f78c1437c8fa7581e9b2f00886e
Author:        Kunkun Jiang <jiangkunkun@huawei.com>
AuthorDate:    Wed, 14 Sep 2022 14:14:24 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/arm_arch_timer: Fix handling of ARM erratum 858921

The commit a38b71b0833e ("clocksource/drivers/arm_arch_timer:
Move system register timer programming over to CVAL") moves the
programming of the timers from the countdown timer (TVAL) over
to the comparator (CVAL). This makes it necessary to read the
counter when programming next event. However, the workaround of
Cortex-A73 erratum 858921 does not set the corresponding
set_next_event_phys and set_next_event_virt.

Add the appropriate hooks to apply the erratum mitigation when
programming the next timer event.

Fixes: a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL")
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20220914061424.1260-1-jiangkunkun@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9ab8221..ff935ef 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -473,6 +473,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.desc = "ARM erratum 858921",
 		.read_cntpct_el0 = arm64_858921_read_cntpct_el0,
 		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_phys,
+		.set_next_event_virt = erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
