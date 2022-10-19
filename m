Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8855604A75
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiJSPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiJSPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196331929A9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:58:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q43bR7EIdzwEejtqYY/+0pBZ/1DlBf/ms3Th4977RU4=;
        b=CJ0wkcfDAIYxYlfRDwtWDHTwKRBKnIGO7mDk96DEhEfPYYF1oPQuNnmaWMjNVFx82t2g2p
        vzwkF94n0h7nEyhv0U93cY/SDg0gFrPMaHBWZPIoWnM4PkhT8ENrt1zwlq56m266UfO6ok
        E2Pf4W9zbKKXLfOeDb67zW0A+t3HCRbpaPaonrDqlLifvlY/UNRbzMHnKW0rU52czq11LU
        2QA4703MQAMlTBiSbe41rKt7kIT0G7svma7Brz2sKaxLCd0oZwJQ/auRydmpv7zgddgQ7Z
        KT6cqgK7jbmb4Yo+LE3H9hyyE9UAia6OLCMO0LrI4vSPeblK36wIq1qdR3Gn5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q43bR7EIdzwEejtqYY/+0pBZ/1DlBf/ms3Th4977RU4=;
        b=4/3XcDP9JpywLbtVPvYMt3perm+LULFBKeOfwGqUTnu4+/A8q5xycmiCMFah2+WEFeLmuc
        PyYB51N0P1g/zmCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH printk v2 10/38] tty: hvc: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:32 +0206
Message-Id: <20221019145600.1282823-11-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/hvc/hvc_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 4802cfaa107f..6d1d7b72488c 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -265,7 +265,7 @@ static void hvc_port_destruct(struct tty_port *port)
 static void hvc_check_console(int index)
 {
 	/* Already enabled, bail out */
-	if (hvc_console.flags & CON_ENABLED)
+	if (console_is_enabled(&hvc_console))
 		return;
 
  	/* If this index is what the user requested, then register
-- 
2.30.2

