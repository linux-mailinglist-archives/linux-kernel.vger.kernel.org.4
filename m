Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EDE74D80B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjGJNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGJNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:45:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E31FB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:45:29 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688996727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9NLpZDV0rDJscklMexuqubYAOrVOVFP5G0SfhKaC40=;
        b=mPH34seK6EKd96789117404thhQ8iF13OLpNr8Rr4KlkQwNJABW99gTYK+7HnIjltRHnN+
        2yJBLZcArEG9Xrwkd0d3MiWAydDpHP2tGyam99KieBiEmInY5CgsIn9vHkwsUk48Ee7eTR
        zNXJ3sN2/CVr6hYmUfI8t+JcrOZTuJDijmKzFRqMq5CrrEl6NacvXqO8OgPDyAx+LvFEt1
        ubf3eSzQxZ1WFEW5moucTAYNP/I+xcORGxd3pkhprECltFA9rFynae9SUdxlVFYQRNtgXP
        7eZX3/eMHsZSZlnvQUf8ctTN32aOL3r+d9aTnkOWLj0gjRn2yIF/TpORQgS1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688996727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9NLpZDV0rDJscklMexuqubYAOrVOVFP5G0SfhKaC40=;
        b=MimllhStnyB8UVIm3i7qxoahyZlF7eOmcJSKU+Xf2Frp7wMCiRdG+vr3tcFXyKXVdnFhAQ
        reR+NH86j4GeIbDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v2 1/5] kdb: do not assume write() callback available
Date:   Mon, 10 Jul 2023 15:51:20 +0206
Message-Id: <20230710134524.25232-2-john.ogness@linutronix.de>
In-Reply-To: <20230710134524.25232-1-john.ogness@linutronix.de>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is allowed for consoles to provide no write() callback. For
example ttynull does this.

Check if a write() callback is available before using it.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
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

