Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D025604A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiJSPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiJSPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308211E46A;
        Wed, 19 Oct 2022 07:58:35 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlKWc1Grue9kQfYwJIiewArVOaAkhAK4uRE7V4DMseI=;
        b=Kk2lnB0DeVDuCcQ2SWcnH8R0PgShB2CZwwsounOmf0c7TAxDw35ZfqSbSJ1PexWKje9a+0
        NMoma2X+T0p0buJRG2CD0IdcQ3ox2o2rPGrDdFrPUj49Z35+fPcKgQeojLLcyw6shd+JZ9
        7r6p+CtHoY10o8YGBeUNnQ0FJ053rbDPZzoW8bfvOwNdxeAh5JUrxV2//iLX8tpfhO5B/d
        l3lLWkkazcGkc6qDO/d6aqqwdZkfKULXqPgH+kzjyq67FPhYBElPgpY4K3E1YW+mL8gUT4
        aXnp3oFg8O4sBrVcA7QxClrsqr+RzG3dLrE+NIR5PRiZa07ARtMvihKFdcmmsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlKWc1Grue9kQfYwJIiewArVOaAkhAK4uRE7V4DMseI=;
        b=Hrgpan7bNf/oEJbZZM6hsAcz+zCVZiCrz6fuzTkbXs/R1ESYYwgaiON5lh57jBdACO27c+
        UT3EpQHIZr7qOrCg==
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
Subject: [PATCH printk v2 12/38] tty: serial: kgdboc: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:34 +0206
Message-Id: <20221019145600.1282823-13-john.ogness@linutronix.de>
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
 drivers/tty/serial/kgdboc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index e76f0186c335..b17aa7e49894 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -533,7 +533,7 @@ static int __init kgdboc_earlycon_init(char *opt)
 	console_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
+		    (console_is_enabled(con) || (con->flags & CON_BOOT)) &&
 		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
 			break;
 	}
-- 
2.30.2

