Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0B6485DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiLIPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiLIPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152DC30578;
        Fri,  9 Dec 2022 07:47:26 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6UfZriK7ryc7OxQIk3jAf9chxTyoygDgagwMczktRM=;
        b=IL1SHomh5R7RzTfwiyU8++kZ4eJxd+9UuI08JF3d08ccnQxL0uHUdbg23s4ZPnQ4wmhD84
        zvR2mISpdJXqGcz2Xyr5p1PWexXGYmf8T6Od50Lkv6RTbF1JB0Lv7IbBPpDeEb0jKnKhEE
        MCIBa/hFzf5oKxqg96/uXGsx3jucz30/DSdQNcZyXVj9m+f3S4Q084Lfzr3MjjajpFBOyS
        BdyK3qPT6YdJZPpdu2uw2eJwQKNjCn0MiwCZsucshU0AQPXhjDQhOxEGhFPID8CycLbnP5
        pa8nTJplW/RbDWL1pKvZJb0/WfLZI9f9EFicKC/GfUydjk3qZ0n2bMnUvxGoaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6UfZriK7ryc7OxQIk3jAf9chxTyoygDgagwMczktRM=;
        b=WfWZ1lIe4aW8ioVfd7WpOLHCs6dQONOD/7SF0jTDKFO3OVxPyKNdw/EKshNwXNfEoxtWZk
        Ao9CYY533rE2lABg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Make timer_get_irq static
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028103604.40385-1-tony@atomide.com>
References: <20221028103604.40385-1-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <167060084293.4906.12524389435777602440.tip-bot2@tip-bot2>
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

Commit-ID:     dedb2aced3e958c6f4811d3e6b392652ff0eea01
Gitweb:        https://git.kernel.org/tip/dedb2aced3e958c6f4811d3e6b392652ff0eea01
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 28 Oct 2022 13:36:04 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 02 Dec 2022 13:16:46 +01:00

clocksource/drivers/timer-ti-dm: Make timer_get_irq static

We can make timer_get_irq() static as noted by Janusz. It is only used by
omap_rproc_get_timer_irq() via platform data.

Reported-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20221028103604.40385-1-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 include/clocksource/timer-ti-dm.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 00af1a8..eeeeb3c 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -643,7 +643,7 @@ static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 	return 0;
 }
 
-int omap_dm_timer_get_irq(struct omap_dm_timer *cookie)
+static int omap_dm_timer_get_irq(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer = to_dmtimer(cookie);
 	if (timer)
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 77eceea..dcc1712 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -62,8 +62,6 @@
 struct omap_dm_timer {
 };
 
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
-
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
 
 /*
