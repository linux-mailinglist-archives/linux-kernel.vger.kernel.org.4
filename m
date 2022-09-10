Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F195B4A83
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIJW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIJW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088638454
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:38 -0700 (PDT)
Message-ID: <20220910222300.524466942@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LscXlV1rkfiGC1iyhRF8H7x4yCrolRpccYbWcMWLptc=;
        b=2nOZDMNEQCdfpEbpssXSxl/1NxSLAxk9cE2s/LMpzA6P7inlIJV9Bm+gYBM1ko/cn2AEXJ
        H54xOqeXV5EKksTluT+KQv2Q6+eia6bqZIKj4c53mQws/3Q76cYab6UQ+d3X7QwNa1r9kq
        O3OWn6YxT59J89uNmG3nIg79xaIgx8Hh2wlOrfTpASFb8U9MUITu8DfxSVOTGCz1oOM/iU
        XmoI6D1ja3tTp+ppLwi0RKZrofTNiFWuYoCeGLMBMB8KB4tInmFiugcpiOC3XjMonbXcva
        Lux42ac/A0bRBJZI4KDd3OjF2r9uv/SwQFSgzOsjvgX7/pRo5Xv2b4SLS8p5aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LscXlV1rkfiGC1iyhRF8H7x4yCrolRpccYbWcMWLptc=;
        b=ej4Id8FFr5usQbn+Iedp/mRjjlbohRQD3qzmoGgBw5CqirPF8W3Kk80tOxPC1JbmD3dAz2
        mbTh8mVJ+eZ3mVCw==
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
Subject: [patch RFC 03/29] printk: Remove write only variable nr_ext_console_drivers
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/printk/printk.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -220,9 +220,6 @@ int devkmsg_sysctl_set_loglvl(struct ctl
 }
 #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
-/* Number of registered extended console drivers. */
-static int nr_ext_console_drivers;
-
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -3188,9 +3185,6 @@ void register_console(struct console *ne
 		console_drivers->next = newcon;
 	}
 
-	if (newcon->flags & CON_EXTENDED)
-		nr_ext_console_drivers++;
-
 	newcon->dropped = 0;
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/* Get a consistent copy of @syslog_seq. */
@@ -3256,9 +3250,6 @@ int unregister_console(struct console *c
 	if (res)
 		goto out_disable_unlock;
 
-	if (console->flags & CON_EXTENDED)
-		nr_ext_console_drivers--;
-
 	/*
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.

