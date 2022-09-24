Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E911A5E8687
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiIXAF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiIXAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BC9E8A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMMv3ujjFTuj7Yj8Tuz38djTJjcTqnAf2UGtNPcHZZ8=;
        b=BTT8x0Z/8tuiYDkMQCoydRasISqP+nkfk5473rWmNxM69PeQFni1HtvbT+ohwJ2f0N1xIe
        HI5gSnGguvwL3mgFJaUlR83KCn4NAOOy4rLfPKzOTDgiF4BOSRgdyiTmStqMoNRzSR7KiR
        /UEJwlFKMJXZDUTOfT/elHMNKQ73Sqafj3+KSbS+IVC84fCS5m4MrqiZP1uJyJvDOG4Y1Z
        3e70/ThbfXyATHV/RpaH/ILeVZgxQq8/XSR/Hhh8tDkiy0xgViJeo+55vljOHhrwcOTXkS
        gJMJtKUjBoaSEZjOKWYCFZoeyuW9J3HaCTEFFZfT9mEoLXJC8hgyDQWrOqK1ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMMv3ujjFTuj7Yj8Tuz38djTJjcTqnAf2UGtNPcHZZ8=;
        b=Ghlq7f9+kXjKdt8w5EojdUKNMT8lt5kHGZkYWVpkGFRuJBYCIBM2sP3pSR2hDgRE6DvahN
        jA/bgS1Bja5v6ADw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 05/18] printk: Mark __printk percpu data ready __ro_after_init
Date:   Sat, 24 Sep 2022 02:10:41 +0206
Message-Id: <20220924000454.3319186-6-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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

This variable cannot change post boot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 770511b89504..e4f1e7478b52 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -430,7 +430,7 @@ static struct printk_ringbuffer *prb = &printk_rb_static;
  * per_cpu_areas are initialised. This variable is set to true when
  * it's safe to access per-CPU data.
  */
-static bool __printk_percpu_data_ready __read_mostly;
+static bool __printk_percpu_data_ready __ro_after_init;
 
 bool printk_percpu_data_ready(void)
 {
-- 
2.30.2

