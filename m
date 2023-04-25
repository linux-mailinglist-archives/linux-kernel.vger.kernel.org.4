Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296D6EE7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjDYStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjDYStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638916F37
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:03 -0700 (PDT)
Message-ID: <20230425183313.038444551@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sVsp5iAcrwxZBIrimSxBovV+M8RO8rU2VAcGB3fBiwg=;
        b=PCa5afvfvzY72u9eR4fiO0w2I8nAar7gB/x7UavqUI0iYMcJPI7IXO0ovNOgK9cfLOvMMq
        1+BTaIx9uMF2Gm+tliGSaJi+fkD0IMvavt2Jezswr5aJbZaI/6HWR249IovyQvhcIH70EF
        j6LdQGfZfvkFId6obyKy4/21gmO+S+31Z3wwgPEA8o9yt2KwDwr46dcHE8c4Ye5+FXOCXv
        eYiTGoe65UvQMb0kzL5VSR+JZ2I8x78nvX2yPIr9LiApXo5spGZqdmlEqpQYiknG36NY79
        JAXcOruEzimbUog6x6LR4NWwLczxBZ7WsuHqtr4IFYAJi57+aOrH7IyArJaibw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sVsp5iAcrwxZBIrimSxBovV+M8RO8rU2VAcGB3fBiwg=;
        b=uv++84Hxg7ky5/7UmzfIOgCn4aivjVTP1XJV0etONmsK8sJlc3ApL4pQgS+2KoXXo8duoi
        nD8UDE5LgeNZrLCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 04/20] posix-timers: Cleanup comments about timer ID tracking
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the hash table properly and remove the IDR leftover comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -35,20 +35,17 @@
 #include "timekeeping.h"
 #include "posix-timers.h"
 
-/*
- * Management arrays for POSIX timers. Timers are now kept in static hash table
- * with 512 entries.
- * Timer ids are allocated by local routine, which selects proper hash head by
- * key, constructed from current->signal address and per signal struct counter.
- * This keeps timer ids unique per process, but now they can intersect between
- * processes.
- */
+static struct kmem_cache *posix_timers_cache;
 
 /*
- * Lets keep our timers in a slab cache :-)
+ * Timers are managed in a hash table for lockless lookup. The hash key is
+ * constructed from current::signal and the timer ID and the timer is
+ * matched against current::signal and the timer ID when walking the hash
+ * bucket list.
+ *
+ * This allows checkpoint/restore to reconstruct the exact timer IDs for
+ * a process.
  */
-static struct kmem_cache *posix_timers_cache;
-
 static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
 static DEFINE_SPINLOCK(hash_lock);
 
@@ -66,15 +63,6 @@ static const struct k_clock clock_realti
 #endif
 
 /*
- * The timer ID is turned into a timer address by idr_find().
- * Verifying a valid ID consists of:
- *
- * a) checking that idr_find() returns other than -1.
- * b) checking that the timer id matches the one in the timer itself.
- * c) that the timer owner is in the callers thread group.
- */
-
-/*
  * CLOCKs: The POSIX standard calls for a couple of clocks and allows us
  *	    to implement others.  This structure defines the various
  *	    clocks.

