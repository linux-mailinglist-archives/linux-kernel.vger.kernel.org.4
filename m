Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5546A89DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCBT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EF54743A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bn4hK/pc8yfuTHf2lVQ6K39OCmfHLmDwBEQ4LD+VvX8=;
        b=sVHSx/LE7UqM7m9QqJqsI82I3YhkAegnS1wj0KV1SpI9PJKxnb/I07juk3E23hRkXfc2D6
        E93VCEpd5hBOfkTcqtKMqdM9Bqq4/eZi6MzoPvWe4psYtIkpoQu60kDH0sLmcaiU7QkY0X
        oDq5R/XP1V0TGr6dCS4tfdp9e3DMGiTaUD1jcFG32b1bHe9GxpBVT+NeVHY6xsi7tXZV5h
        z81xAF0OvvZ4rAgVg7Rm83bheDM1no0axFc4D6eWG0otXxz5IZgHm1Xf85D/23B5Hs4Njo
        BlNGym9rw1vlZ2oDc+dInihAYTmNb2UuXy5Ssxs8wXPTFtkEMuf3GwXXZdlUQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bn4hK/pc8yfuTHf2lVQ6K39OCmfHLmDwBEQ4LD+VvX8=;
        b=95Ms7ku4PtEVQkCu9sJ1bRajCtfp7nzS53jwqnhi/CkI9LIirtg2epuND9iUDCiYb5LQd8
        TSNC5vetA4XLnrDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v1 01/18] kdb: do not assume write() callback available
Date:   Thu,  2 Mar 2023 21:02:01 +0106
Message-Id: <20230302195618.156940-2-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
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

It is allowed for consoles to provide no write() callback. For
example ttynull does this.

Check if a write() callback is available before using it.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/debug/kdb/kdb_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 5c7e9ba7cd6b..e9139dfc1f0a 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -576,6 +576,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
+		if (!c->write)
+			continue;
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
-- 
2.30.2

