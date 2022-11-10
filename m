Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ABD623C07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiKJGln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiKJGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:41:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D812CDFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E27A61D9D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E606C4314B;
        Thu, 10 Nov 2022 06:41:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ot1Fz-009EgZ-2p;
        Thu, 10 Nov 2022 01:41:47 -0500
Message-ID: <20221110064147.712934793@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 01:41:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH v6 6/6] timers: Update the documentation to reflect on the new
 timer_shutdown() API
References: <20221110064101.429013735@goodmis.org>
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

In order to make sure that a timer is not re-armed after it is stopped
before freeing, a new shutdown state is added to the timer code. The API
timer_shutdown_sync() and timer_shutdown() must be called before the
object that holds the timer can be freed.

Update the documentation to reflect this new workflow.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 Documentation/core-api/local_ops.rst                   | 2 +-
 Documentation/kernel-hacking/locking.rst               | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a0f8164c8513..ec6de88846b9 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via timer_shutdown_sync().
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index 2ac3f9f29845..0b42ceaaf3c4 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..eb341b69fd15 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1009,6 +1009,11 @@ use del_timer_sync() (``include/linux/timer.h``) to
 handle this case. It returns the number of times the timer had to be
 deleted before we finally stopped it from adding itself back in.
 
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed, although if it is rearmed, it
+will produce a warning.
+
+
 Locking Speed
 =============
 
-- 
2.35.1
