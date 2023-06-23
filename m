Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1210573BD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjFWRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFWRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:12:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBA19A1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:12:43 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687540361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d174zlUL/lhF0vBTL/OICvsXlNACFuiYhQ7ttHm3uTo=;
        b=wUEukFRuQtWtID4ZOeOhNXoXQ773U6bquwTxJC7s8rOqzIlrm+gZSF7ZYmg1UhYmzJz4qm
        oD5Ysr/0zLXb9jT8ovdKF0Bpnlu+ruuv5VQLGVR9IpQu1tCXNMfKYOdKKjWpQ6kyj38jjk
        A3H8UVBPOl/2QXtQf3GaYd928rVYkoeof+erMEKQc7QMrkdtrWBK1pJnKT5YTlzAhx4C64
        eK4rIHSgqMfZyHITIAvcGigQjrydcs2bQNIuo3JhRnlq9qSlzz3y5lPmbLHw+cWmTyNiTQ
        YRAqhj5dYBPvaNyVjqV0onfE/WhUArwF1Be/lz2+WhLL5yHn/M6an9SWQOwFHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687540361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d174zlUL/lhF0vBTL/OICvsXlNACFuiYhQ7ttHm3uTo=;
        b=crRCrHYhVULMoIjeuCQU0yIWeH3xxFHKwaD5PsqTuAc+qRz2en09xW9R2TKMpVhjpwL/DE
        JSx8UERIkzfTFABA==
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.co>, Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
Date:   Fri, 23 Jun 2023 19:12:31 +0200
Message-Id: <20230623171232.892937-2-bigeasy@linutronix.de>
In-Reply-To: <20230623171232.892937-1-bigeasy@linutronix.de>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was brought up by Tetsuo that the following sequence
   write_seqlock_irqsave()
   printk_deferred_enter()

could lead to a deadlock if the lockdep annotation within
write_seqlock_irqsave() triggers. The problem is that the sequence
counter is incremented before the lockdep annotation is performed. The
lockdep splat would then attempt to invoke printk() but the reader side,
of the same seqcount, could have a tty_port::lock acquired waiting for
the sequence number to become even again.

The other lockdep annotations come before the actual locking because "we
want to see the locking error before it happens". There is no reason why
seqcount should be different here.

Do the lockdep annotation first then perform the locking operation (the
sequence increment).

Fixes: 1ca7d67cf5d5a ("seqcount: Add lockdep functionality to seqcount/seql=
ock structures")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Link: https://lore.kernel.org/20230621130641.-5iueY1I@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e90279477..d778af83c8f36 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -512,8 +512,8 @@ do {									\
=20
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subcl=
ass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
=20
 /**
--=20
2.40.1

