Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB260FB66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiJ0PKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiJ0PJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB2118E73F;
        Thu, 27 Oct 2022 08:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECCE06236E;
        Thu, 27 Oct 2022 15:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63875C433B5;
        Thu, 27 Oct 2022 15:09:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Va-00BvVQ-1p;
        Thu, 27 Oct 2022 11:09:26 -0400
Message-ID: <20221027150926.394670044@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [RFC][PATCH v2 07/31] timers: PM: Use del_timer_shutdown()
References: <20221027150525.753064657@goodmis.org>
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

Instead of open coding making the timer look like it was not registered by
setting the function pointer to NULL, call del_timer_shutdown() that does
the same thing.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/base/power/wakeup.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7cc0c0cf8eaa..c690f6c0d670 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -202,12 +202,7 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
 
-	del_timer_sync(&ws->timer);
-	/*
-	 * Clear timer.function to make wakeup_source_not_registered() treat
-	 * this wakeup source as not registered.
-	 */
-	ws->timer.function = NULL;
+	del_timer_shutdown(&ws->timer);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
-- 
2.35.1
