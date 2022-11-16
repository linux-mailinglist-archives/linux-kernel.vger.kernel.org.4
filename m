Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41D762C3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiKPQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiKPQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAC726495;
        Wed, 16 Nov 2022 08:22:00 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpXDwx4HKdMdBWDyluBjDSAFdjedUOkxkf204NlGPAs=;
        b=LqzUIFfWKdEdiyeDT4SA4emyQt7a9a+2ayMhlNuY8oKBxOZ55QB5G2qQqcYfRRW2xlUICW
        tBwDtRYB7JMPPvjHX4UxY5ypgN6jVCNWuE/WjNV6Ur8UrMVRcsBmdQuVxrOQ+dqHuMDUTP
        1qm5jh0qN+dcqhLR8NCFhFcm/ntrqaL7JO1PtX4eXnjEtGvhUa+irm7Cqewqp/dPHWPpir
        loS78h/J/Y2VzMyenoQlqx/7uSrTjLRrp4Z4Gv2Or3yKv4I7e9jJ05pSDNY5sngtzthllA
        BYZqI6OU9WxkkKJuMK1lZhzdDMcEAvjzz7rJiL8FLy2y7oOwam8IlCUML4DVHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpXDwx4HKdMdBWDyluBjDSAFdjedUOkxkf204NlGPAs=;
        b=KpNtEbzlAdwIW6nKnDTQJbZW60PKBRcYjMQXzivs6ATu0YjHy6ToNZTwuGwHb2+Ivz8DwO
        UUVw2DECAzI7ufDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH printk v5 01/40] serial: kgdboc: Lock console list in probe function
Date:   Wed, 16 Nov 2022 17:27:13 +0106
Message-Id: <20221116162152.193147-2-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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

Unprotected list walks are not necessarily safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/kgdboc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7aa37be3216a..e76f0186c335 100644
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
-- 
2.30.2

