Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1161D7B5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 07:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiKEGCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 02:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKEGBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 02:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF330548
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CFB5609AD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 06:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DB0C43470;
        Sat,  5 Nov 2022 06:01:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orCFk-007OvC-15;
        Sat, 05 Nov 2022 02:02:00 -0400
Message-ID: <20221105060200.173378298@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Nov 2022 02:00:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Tso" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4a 29/38] random: use timer_shutdown_sync() for on stack timers
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

Before a timer is released, timer_shutdown_sync() must be called.

Link: https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/

Cc: "Theodore Ts'o" <tytso@mit.edu>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 69754155300e..943b4b2712a5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1233,7 +1233,7 @@ static void __cold try_to_generate_entropy(void)
 		stack.entropy = random_get_entropy();
 	}
 
-	del_timer_sync(&stack.timer);
+	timer_shutdown_sync(&stack.timer);
 	destroy_timer_on_stack(&stack.timer);
 	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 }
-- 
2.35.1
