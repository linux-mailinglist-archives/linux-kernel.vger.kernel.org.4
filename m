Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964E45E867F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiIXAF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiIXAFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364DA50C5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:04:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AsqRBJKkojptCjVN+/9KUBsCalgAOrjbKzUf0AGU4sQ=;
        b=IWFjD1IWPGbwSq1Yr9k8bqwJQpfi7e1GcVgHtChWxHDfAgAzQXMn8Yb7k205GL8Yj3oyxW
        E5Cxa2BHjWcjcwdafY4HFYPMr26krLWmprZMbdoGJBVpTh07aYuFaa02HkEgNdg0oTZxNW
        ZK1n9cUWXJpqqCuiXwi0tzFTUQZAK8vuTZwvOIucbaDWFc52vBlePLPH9Zh6/sDh82awvt
        2pRIoc00UjU8DQUsMkiJTYuO9uecetoc7P3AuNOvXjJ4NPubm0Q1GyzC1lkIpbYww5+7/l
        u3yf+OiyGfqrZVX76Y2sDQnZ7AFqgqgwr7iv90+1XgmaUIORSFQZlIcc/wOOVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AsqRBJKkojptCjVN+/9KUBsCalgAOrjbKzUf0AGU4sQ=;
        b=f2AkD2lCoI9N9yB73ZnCGPZwbiWUyJkAqjH9LguSpaHRi7eazC7NsAhQXDY9ht2VLRnOom
        Nfy/TzgiB4V2GiDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 04/18] printk: Remove bogus comment vs. boot consoles
Date:   Sat, 24 Sep 2022 02:10:40 +0206
Message-Id: <20220924000454.3319186-5-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The comment about unregistering boot consoles is just not matching the
reality. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/printk/printk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d6bba2ea14e8..770511b89504 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3209,9 +3209,6 @@ void register_console(struct console *newcon)
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		/* We need to iterate through all boot consoles, to make
-		 * sure we print everything out, before we unregister them.
-		 */
 		for_each_console(con)
 			if (con->flags & CON_BOOT)
 				unregister_console(con);
-- 
2.30.2

