Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7E60FB65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiJ0PKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiJ0PJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368FD18F0F0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A4DF6239C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AB3C433D7;
        Thu, 27 Oct 2022 15:09:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Vb-00BvXh-17;
        Thu, 27 Oct 2022 11:09:27 -0400
Message-ID: <20221027150927.162027754@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Theodore Tso" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [RFC][PATCH v2 11/31] timers: random: Use del_timer_shutdown() before freeing timer
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

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2fe28eeb2f38..b774fdefc840 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1233,7 +1233,7 @@ static void __cold try_to_generate_entropy(void)
 		stack.entropy = random_get_entropy();
 	}
 
-	del_timer_sync(&stack.timer);
+	del_timer_shutdown(&stack.timer);
 	destroy_timer_on_stack(&stack.timer);
 	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
 }
-- 
2.35.1
