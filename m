Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2649C5B4A94
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiIJW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIJW1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFA3DF2E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:48 -0700 (PDT)
Message-ID: <20220910222300.906633712@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rf4oVT0IACM5+HOOtRh8ktCU4mJox5gT3mFbY4X0ro4=;
        b=xtXfpQ6xb7JeebjIdPGSmF2S7V4YMW5PUyCRbpQ0AjBGRT7a1eyRCqZU8zY8pvGVlwzW+5
        KoezmY0Btk93Trb9iWm3Agn5nLEbQn5g3XmuIjd0lOeYB/5P2UX61czgUd3Kvi3h7ZBWVJ
        Cj3/AOCXU4iesBaoy+fB0bxD8TsUJHkXeA8xxatSKxKi5DOlKV0kE0Fe/659drk7Z1L9K2
        jYHhGdbT35Te3z6ESKqbZ/mYJHCNdRA7+acOLTPI514y1itsZlSys2SwtquG+niT0XMroF
        D9Pwl67aWngtgHgJXXw8gcJZYzg71y+S5JF2Sa5g5UlbvgGGH70v3NTVgkwW8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rf4oVT0IACM5+HOOtRh8ktCU4mJox5gT3mFbY4X0ro4=;
        b=MlUd/ANlzRpMXw1CNhR9CQYjifzNbwfkl52XRDH07kXzghewtr+0JfNxo8jDgBhHgMHnGE
        +qYj4H//NJlD87Dw==
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
Subject: [patch RFC 09/29] serial: kgdboc: Lock consoles in probe function
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unprotected list walks are not necessarily safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/serial/kgdboc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -193,6 +193,7 @@ static int configure_kgdboc(void)
 	if (!p)
 		goto noconfig;
 
+	console_lock();
 	for_each_console(cons) {
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
@@ -201,6 +202,7 @@ static int configure_kgdboc(void)
 			break;
 		}
 	}
+	console_unlock();
 
 	kgdb_tty_driver = p;
 	kgdb_tty_line = tty_line;

