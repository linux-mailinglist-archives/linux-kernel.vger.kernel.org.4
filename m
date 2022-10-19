Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF70E604A93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJSPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiJSPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FCD38A0;
        Wed, 19 Oct 2022 07:59:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQcHjaE6CQfq7iO6zRmu96wMYI8aMwb9KZsnUEYxyHY=;
        b=uJxwQf34Ytc+E+xlVFr+QJdkNyrMOfUvwvaZcWKOsw0HPBVGrb4yMLRvikG5fD7cUCCc3C
        28HKnPfM+uG1Z5z4L56fxWXyrRIKTZSVZptsjItATwqm3Q4MhzYIPKqCJpyLB7fFVS0j6u
        /X9PqMg8IxzzFdciI7TDe8A+OYuDmG+ME1toyuS2fFqmqa1hTm+YBUxQV3oCJZHXuqalbQ
        QU8S/p/3lIK/8LUUToUovSXE4jfY76zMpDU7MTtRzM++2mNnVj7bKvcl8AgTMdYYD4YXz3
        z8y5puCaOyxnbNpSsfsdnnyyPts9YXiBFHfz2EsNyXbwpHaTQcRNqZA6iu/ZOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQcHjaE6CQfq7iO6zRmu96wMYI8aMwb9KZsnUEYxyHY=;
        b=FnIygPB0dsrSCCUyaFzWqQi5S8pnwh8nD/V378wLSKMrAbys4FHt9SsFaYaowHj8t+QBgh
        QwF/uqpaFI+ppICQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Tom Rix <trix@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH printk v2 24/38] xen: fbfront: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:46 +0206
Message-Id: <20221019145600.1282823-25-john.ogness@linutronix.de>
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

Since the console_lock is not being used for anything other than
safe console list traversal, use srcu console list iteration instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/video/fbdev/xen-fbfront.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 4d2694d904aa..2552c853c6c2 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -500,16 +500,18 @@ static int xenfb_probe(struct xenbus_device *dev,
 static void xenfb_make_preferred_console(void)
 {
 	struct console *c;
+	int cookie;
 
 	if (console_set_on_cmdline)
 		return;
 
-	console_lock();
-	for_each_console(c) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
 		if (!strcmp(c->name, "tty") && c->index == 0)
 			break;
 	}
-	console_unlock();
+	console_srcu_read_unlock(cookie);
+
 	if (c) {
 		unregister_console(c);
 		c->flags |= CON_CONSDEV;
-- 
2.30.2

