Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF276F8A7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjEEU7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjEEU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:59:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1EF44EE1;
        Fri,  5 May 2023 13:59:04 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 00CEF20EA205;
        Fri,  5 May 2023 13:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00CEF20EA205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683320344;
        bh=Sy+d1mqucnUH/6CC12rPWwsujA9U/FCYF4OoGbHtNc0=;
        h=From:To:Cc:Subject:Date:From;
        b=kqbbjL167LT11+ZWPWWZ8LrgjqgxyKUm0TBDZBDHDeDEg+ZFonBELkxv3OKKaHCUV
         vxiICGhP8bjW7aY2DU0lTw3gu3CMBvw7mHKpXhQ1MAjMLERihdMf9hWPlonFm1i5I2
         SKTcxR8gGr/4WR6SR2oRkNrZ9XmcN2PyppJ/wWVY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        dan.carpenter@linaro.org
Subject: [PATCH] tracing/user_events: Use long vs int for atomic bit ops
Date:   Fri,  5 May 2023 13:58:55 -0700
Message-Id: <20230505205855.6407-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each event stores a int to track which bit to set/clear when enablement
changes. On big endian 64-bit configurations, it's possible this could
cause memory corruption when it's used for atomic bit operations.

Use unsigned long for enablement values to ensure any possible
corruption cannot occur. Downcast to int after mask for the bit target.

Link: https://lore.kernel.org/all/6f758683-4e5e-41c3-9b05-9efc703e827c@kili.mountain/

Fixes: dcb8177c1395 ("tracing/user_events: Add ioctl for disabling addresses")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..e37c7f168c44 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -101,7 +101,7 @@ struct user_event_enabler {
 	unsigned long		addr;
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
-	unsigned int		values;
+	unsigned long		values;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -116,7 +116,9 @@ struct user_event_enabler {
 /* Only duplicate the bit value */
 #define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
 
-#define ENABLE_BITOPS(e) ((unsigned long *)&(e)->values)
+#define ENABLE_BITOPS(e) (&(e)->values)
+
+#define ENABLE_BIT(e) ((int)((e)->values & ENABLE_VAL_BIT_MASK))
 
 /* Used for asynchronous faulting in of pages */
 struct user_event_enabler_fault {
@@ -423,9 +425,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
+		set_bit(ENABLE_BIT(enabler), ptr);
 	else
-		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
+		clear_bit(ENABLE_BIT(enabler), ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
@@ -440,8 +442,7 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 	struct user_event_enabler *next;
 
 	list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
-		if (enabler->addr == uaddr &&
-		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
+		if (enabler->addr == uaddr && ENABLE_BIT(enabler) == bit)
 			return true;
 	}
 
@@ -2272,7 +2273,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 
 	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
 		if (enabler->addr == reg.disable_addr &&
-		    (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
+		    ENABLE_BIT(enabler) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))

base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1

