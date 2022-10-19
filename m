Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7B604A58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiJSPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:02:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251D17A964
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:57:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hllJr9Cenmg6tA9bg55xooViBdr/MaRQODlzmP0LypQ=;
        b=mMoqhcUJaer0GASfzyAekKN+pSE8kqodiNK415JtDTtl/yYfijstiMQVyIVGVhbYJ7jiZy
        cKhgwp014bcWywD++czA8VHdfLmMfNHfT9xWvGVzDl1BSXzuTXhemseXYlrav5AHS4+h3b
        iXhswrgzZMfsRkUXSMPESUzJ+rSu3M7/YNj7ejdSKY5Yxhtm11uOmEXTnfiTuvJDajS8Dt
        gDw+WexxNI1DOGL9NoyYoTDrKUOZT02uu7KgiIO9lSmuToUrf/p0DUJZYwHx1FxGqlsn5D
        beK0nlWDHvmI58Iw3MyOaR7HUyvDEIWWDiLi+pCNT0K6BiV6dSSjn9hd4gaF8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hllJr9Cenmg6tA9bg55xooViBdr/MaRQODlzmP0LypQ=;
        b=anaafIfR//UTCpo9Mk4ATxTaSPAW/cLDpNejXqfvkq1eS4iO6NOae6e9TO/xryKwhc8urc
        BQG9YbEHS5/MnBBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 04/38] printk: introduce console_is_enabled() wrapper
Date:   Wed, 19 Oct 2022 17:01:26 +0206
Message-Id: <20221019145600.1282823-5-john.ogness@linutronix.de>
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

After switching to SRCU for console list iteration, some readers
will begin accessing console->flags as a data race. This is safe
because there is at most one CPU modifying console->flags and
using rmw operations.

The primary reason for readers to access console->flags is to
check if the console is enabled. Introduce console_is_enabled()
to mark such access as a data race.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index cff86cc615f8..60195cd086dc 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -172,6 +172,26 @@ extern void console_srcu_read_unlock(int cookie);
 
 extern struct hlist_head console_list;
 
+/**
+ * console_is_enabled - Check if the console is enabled
+ * @con:	struct console pointer of console to check
+ *
+ * This should be used instead of manually testing for the CON_ENABLED
+ * bit in the console->flags.
+ *
+ * Context: Any context.
+ */
+static inline bool console_is_enabled(const struct console *con)
+{
+	/*
+	 * If SRCU is used, reading of console->flags can be a data
+	 * race. However, this is safe because there is at most one
+	 * CPU modifying console->flags and it is using only
+	 * read-modify-write operations to do so.
+	 */
+	return (data_race(READ_ONCE(con->flags)) & CON_ENABLED);
+}
+
 /**
  * for_each_console_srcu() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
-- 
2.30.2

