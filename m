Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3E61EFFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiKGKLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiKGKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:10:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D687618B0C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:10:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667815857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJz2ooychjBsKMZBl04F3l2gQeHKKq6YHrxTeMQ600g=;
        b=C+9+sbSajSMFIbT4q21lRn9bRksRO/EsPHUOIed9bl+CI/bCwrGzqKaKJIMbTJ3OrM6uJ1
        1eDjRguh0Zc/TExv8YoH7rTab2GarJqMFatQUc1G9TkPoMK/dbMqUOZuWde5eZNpqxTHqx
        6JQjW+sk4tPr+xal39nM2/R3Ftu0Ekm29kGtmV6wgdiEniRd+zIF4kGJDy5ZlSTm1XN/I5
        In8yEGsiodZQP0Nd+7WPau+H7KtFqoYErn6HcZqYfgBAZhTYI64ulTvzqfF7c4hzaGOZhK
        9kVlA/aQkJ2lvC4pZ7tVVdNRFLln3CzvIJh5zIfnO5M5yAZye5xuFbkU0HcBfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667815857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJz2ooychjBsKMZBl04F3l2gQeHKKq6YHrxTeMQ600g=;
        b=R3XyG3gPTBWCXcDWL2NyrsGbGS/q24oaZTmhB8yw7fAdcJx+Sbz09aPHNxzftY+jLENndn
        wiy1xV4+8HRxeRCw==
To:     paulmck@kernel.org, Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        boqun.feng@gmail.com
Subject: Re: [PATCH printk v2 33/38] printk: introduce console_list_lock
In-Reply-To: <20221027185007.GG5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-34-john.ogness@linutronix.de>
 <Y1pY3I1ufABvroYj@alley>
 <20221027185007.GG5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 07 Nov 2022 11:16:56 +0106
Message-ID: <87a6539irz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-27, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> One way to save a line is as follows:
>
> 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
> 		     debug_lockdep_rcu_enabled() &&
> 		     srcu_read_lock_held(&console_srcu));

Unfortunately this suggestion does not work because
debug_lockdep_rcu_enabled() only exists if CONFIG_DEBUG_LOCK_ALLOC is
enabled. Would you be interested in having an empty implementation?
Then my check would not need to be concerned about
CONFIG_DEBUG_LOCK_ALLOC at all. It would become:

 	WARN_ON_ONCE(debug_lockdep_rcu_enabled() &&
 		     srcu_read_lock_held(&console_srcu));

The patch below could be used to achieve that.

John

--------8<-------------
From 71d9e484d5128cd1e57e5bff5391d91789f444fa Mon Sep 17 00:00:00 2001
From: John Ogness <john.ogness@linutronix.de>
Date: Mon, 7 Nov 2022 11:06:40 +0106
Subject: [PATCH] rcu: implement lockdep_rcu_enabled for
 !CONFIG_DEBUG_LOCK_ALLOC

Provide an implementation for debug_lockdep_rcu_enabled() when
CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
if rcu lockdep debugging is available without needing an extra
check if CONFIG_DEBUG_LOCK_ALLOC is enabled.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/rcupdate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 08605ce7379d..65178c40ab6f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -340,6 +340,11 @@ static inline int rcu_read_lock_any_held(void)
 	return !preemptible();
 }
 
+static inline int debug_lockdep_rcu_enabled(void)
+{
+	return 0;
+}
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 #ifdef CONFIG_PROVE_RCU
-- 
2.30.2
