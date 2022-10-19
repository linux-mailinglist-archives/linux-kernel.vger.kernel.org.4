Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62B604A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJSPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiJSPF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA86192D9F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1RFx/v+hUfcDGQrJ2jjINSDPUuF1n3qxJyJC8w20Fo=;
        b=Na76VoWVvHR8U/NeE5ZW4Qj/8y6x7pe9hXOgikZ8soMx+eMpjEC1D0Ljtsuf7gKOPi1SDV
        O3H/i2rcTIQgphMFvzlgRv/uQQZ/LEqst5WRZnTXPkWrOxFhCP0cC+X4xmwV9QwQt8kwca
        JYqIAB/VA0uqLjmgRGxiFV3y2r4MhAxXTUQjFEifIzKwTlsUDV55eIk4i97ma0O49fC/xv
        vZIf5vcZpREDTpUHMQcJcVIUftRDZvqEiNVhEF4yBmFJvpLY8XZrmnW3/QU04Bt97BGLkB
        AELofnWb5Zk+quDqxs23odjOpZ43C65y97abkXno++P/O3VWUEZmj6ZrHjrAFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1RFx/v+hUfcDGQrJ2jjINSDPUuF1n3qxJyJC8w20Fo=;
        b=bXJPsQ9Ibdzn9lP6cPILeOojpe35Hpu6UnYqHQ3BjsYI2l13B6GR71QgyJ9Uqh17/ObVif
        drEUXkAw21hR9pBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v2 19/38] kdb: kdb_io: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:41 +0206
Message-Id: <20221019145600.1282823-20-john.ogness@linutronix.de>
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
 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 67d3c48a1522..550fe8b456ec 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -559,7 +559,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	}
 
 	for_each_console(c) {
-		if (!(c->flags & CON_ENABLED))
+		if (!console_is_enabled(c))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
-- 
2.30.2

