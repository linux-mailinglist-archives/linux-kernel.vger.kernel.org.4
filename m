Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56917610199
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiJ0T1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiJ0T1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:27:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA578239
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78BA3B827D4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FD8C433D7;
        Thu, 27 Oct 2022 19:27:25 +0000 (UTC)
Date:   Thu, 27 Oct 2022 15:27:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221027152740.532ff26f@gandalf.local.home>
In-Reply-To: <20221027152058.5f75cfd1@gandalf.local.home>
References: <20221027150525.753064657@goodmis.org>
        <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
        <20221027152058.5f75cfd1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 15:20:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > (many more of those)
> > ...
> > [   16.329989]  timer_fixup_free+0x40/0x54  
> 
> Ah, I see the issue here. Looks like the timer_fixup_free() is calling
> itself and crashing.
> 
> Let me take a look into that. I didn't touch the fixup code, and there
> could be an assumption there that it's behaving with the old approach.

Can you add this and see if it makes this issue go away?

-- Steve

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1d17552b3ede..7305c65ad0eb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -691,7 +691,7 @@ static bool timer_fixup_init(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		del_timer_shutdown(timer);
 		debug_object_init(timer, &timer_debug_descr);
 		return true;
 	default:
@@ -737,7 +737,7 @@ static bool timer_fixup_free(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		del_timer_shutdown(timer);
 		debug_object_free(timer, &timer_debug_descr);
 		return true;
 	default:
