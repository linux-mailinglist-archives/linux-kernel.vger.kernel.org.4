Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031AF61D7CD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 07:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKEGBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 02:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiKEGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 02:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE633054F;
        Fri,  4 Nov 2022 23:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1250660A16;
        Sat,  5 Nov 2022 06:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7920EC43150;
        Sat,  5 Nov 2022 06:01:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orCFg-007OjK-1Y;
        Sat, 05 Nov 2022 02:01:56 -0400
Message-ID: <20221105060156.314289131@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Nov 2022 02:00:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v4a 08/38] timers: ACPI: Use timer_shutdown_sync() before freeing timer
References: <20221105060024.598488967@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, timer_shutdown_sync() must be called.

Link: https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9952f3a792ba..9a0e41c21cf9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1405,7 +1405,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	ghes->flags |= GHES_EXITING;
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
-		del_timer_sync(&ghes->timer);
+		timer_shutdown_sync(&ghes->timer);
 		break;
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 		free_irq(ghes->irq, ghes);
-- 
2.35.1
