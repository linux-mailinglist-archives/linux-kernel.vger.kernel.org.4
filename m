Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542DF604A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiJSPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiJSPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4B13D0F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rxx7a00tnCHfnWXA978Xi0IL/mfHFWoLJumPfZjxuVQ=;
        b=odMAd6jZuExx16Yi0L8xd1hm9Jh9VTjUOvjUUgrX8qFZQuCWOzfAaZvh89StL/uY5ZVjZ4
        7F0py/hns3GzhNljNb4CSr+P5RvwEKeVFVSo7ucX0apDwGWsb+zxnCp4263f8YKJ9a5ej1
        2rV6t+eru8+PT568/dvEv0WiF4bn/adCAwyLxplBuLF8aZHWoHD+n5evDi2JVgnqY8rjNr
        Pt3sSFfwb1FV+WRk5mWlhtAOGR/p0dm76Sw3rc+OGGbhM33YJGS18mUoUTGARbsvXP77z4
        CFsQZ+FmootigSKYJ31Vjh5hqGF6+j1S9tpl8U4eAuAup1tordjr0REfQ7pl7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rxx7a00tnCHfnWXA978Xi0IL/mfHFWoLJumPfZjxuVQ=;
        b=q9rIFA276lgWZLXV5mkpOktuUZD6YWke7bg19dKAJViyJu9A6OrFIkzYrQzLJ2n8EtnLIQ
        id3MWXWGrsWj0ZDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v2 23/38] tty: tty_io: document console_lock usage
Date:   Wed, 19 Oct 2022 17:01:45 +0206
Message-Id: <20221019145600.1282823-24-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

show_cons_active() uses the console_lock to gather information
on registered consoles. Since the console_lock is being used for
multiple reasons, explicitly document these reasons. This will
be useful when the console_lock is split into fine-grained
locking.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/tty_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2050e63963bb..333579bfa335 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3526,6 +3526,14 @@ static ssize_t show_cons_active(struct device *dev,
 	struct console *c;
 	ssize_t count = 0;
 
+	/*
+	 * Hold the console_lock to guarantee that no consoles are
+	 * unregistered until all console processing is complete.
+	 * This also allows safe traversal of the console list.
+	 *
+	 * Stop console printing because the device() callback may
+	 * assume the console is not within its write() callback.
+	 */
 	console_lock();
 	for_each_console(c) {
 		if (!c->device)
-- 
2.30.2

