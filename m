Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD76C5996
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCVWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:48:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9F10D4;
        Wed, 22 Mar 2023 15:48:52 -0700 (PDT)
Date:   Wed, 22 Mar 2023 22:48:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679525330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opTgGltOQ81osAuycnrX2jYx3YroST+C6v5OaNUDXD0=;
        b=hZEWOjG5R7lgIaQUwzMTW9ONBcGSB+czQoRbOgxnbL6/xb1M1CFT1A/XTn5wk1mRq+5gjU
        AAtQxiqJGg/RWuNN1PQDjONfqx+EKULn47XHnBOS04sh+fcud7BQgWQkpFg+voVJGPDMk3
        SJH8Kv7AEkD1BmPSNzT0a4Bm0W7+My1R86B+kek6dk9itTWSRUvWbLxjZyjER0jDt1ovX6
        G50jUKNGj8nYTkWbztoN2txvcfhwhl0FqxksCGwJdSZFYg2cueTpQHr+gTEreyxLI89cB3
        MenSBEkr/ge7xil4K60qaod5v/wsUnD5/7rl21vue2JWA/0P3P96WNwfQ8TunA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679525330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opTgGltOQ81osAuycnrX2jYx3YroST+C6v5OaNUDXD0=;
        b=HwkziF28Rl92ozifWjhJZKRaj58imJyeT5qCUJClRLuBNtn60VjDAiehJJmZ6SfXCoAAe4
        qY7WrUg7uPavTNCw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] vhost: Fix livepatch timeouts in vhost_worker()
Cc:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <509f6ea6fe6505f0a75a66026ba531c765ef922f.1677257135.git.jpoimboe@kernel.org>
References: <509f6ea6fe6505f0a75a66026ba531c765ef922f.1677257135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167952533012.5837.8095153662215148655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     05bfb338fa8dd40b008ce443e397fc374f6bd107
Gitweb:        https://git.kernel.org/tip/05bfb338fa8dd40b008ce443e397fc374f6bd107
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 24 Feb 2023 08:50:01 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 17:09:29 +01:00

vhost: Fix livepatch timeouts in vhost_worker()

Livepatch timeouts were reported due to busy vhost_worker() kthreads.
Now that cond_resched() can do livepatch task switching, use
cond_resched() in vhost_worker().  That's the better way to
conditionally call schedule() anyway.

Reported-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Link: https://lore.kernel.org/r/509f6ea6fe6505f0a75a66026ba531c765ef922f.1677257135.git.jpoimboe@kernel.org
---
 drivers/vhost/vhost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f11bdbe..822fbdb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -363,8 +363,7 @@ static int vhost_worker(void *data)
 			kcov_remote_start_common(dev->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
-			if (need_resched())
-				schedule();
+			cond_resched();
 		}
 	}
 	kthread_unuse_mm(dev->mm);
