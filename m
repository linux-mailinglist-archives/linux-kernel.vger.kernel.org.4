Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DF5B4A8F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIJW2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIJW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E229813
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:40 -0700 (PDT)
Message-ID: <20220910222300.582492276@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Qm8taPkDgEoKYe5N6xRe6zt5ZBhN+tYNXGldQ0AU8dU=;
        b=DAOnF5V7GsRIYCsAWcMF1QYSh3uPjaAT/M8bbYwUZXXXMRZDKJgK0w72mJK7/5itjSBpwX
        LHxmMSiK+Vj4pLeTMTdiMo2YnfUa9JGpXmd3wc2vPtLKEFjem3bdOU1deHANaWTiuIUYOM
        7rxUPlwWwpe8EDpMUtb6V7VI5NdAe+GPHLhDHcGqK74otmGuQAlnuVgl+hBKZpFMQb/ZTM
        Gm18WpBDcQtg8Tb5WfoVHX1f3Y3a+4lXPO4PbgUgfX2zu0EFe4rrVcsc+EAIZ7Kc+a+Me1
        V8s20L7mQjgMTKg+rJxc6e4sk8lPeh5i7EQ9o7l4miUeYuROMI1o8OUa0B4bSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Qm8taPkDgEoKYe5N6xRe6zt5ZBhN+tYNXGldQ0AU8dU=;
        b=0LrrLymEtqK9JVYyAU5j/AMdhRbGsZJsreYsPz22AEviwF+82xS47W9nlG+WytpvcO4txs
        OR5KLGnMAZLm0GCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 04/29] printk: Remove bogus comment vs. boot consoles
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:38 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment about unregistering boot consoles is just not matching the
reality. Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/printk/printk.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3213,9 +3213,6 @@ void register_console(struct console *ne
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		/* We need to iterate through all boot consoles, to make
-		 * sure we print everything out, before we unregister them.
-		 */
 		for_each_console(con)
 			if (con->flags & CON_BOOT)
 				unregister_console(con);

