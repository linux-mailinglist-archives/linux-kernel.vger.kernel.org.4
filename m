Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D756A32C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBZQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:15:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697B199FF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=I/vNKcv8YFn/TMDGw57ceVhj7ZgaN7emxI2MAl5HQpw=; b=G4K/GhqVAsA6spj/BLXM4HObnc
        WW82tRNF9tckyMuoBAydUmZkQOLXUeS5EqkuLfuQikSYLTgCaI3Zm/BtJHsXLrTIWM83d/hRHJkpr
        SXFGnwbvNet5rDfTOPWgTgcXtcPonG/CfdugA/pcXvchW4Yf9IGVfwwDRxhZXCtu9b9UEBc82QYJy
        bGZEz7sFAQZQMncL2LIceEnPT+Wpsojfmo9whKfZatuuiGUDFW8y9M34xmCOlUN3y1trCLkml8PMC
        VzSYqioxzZM4HPn2vRB/khd5fWnHr0eV1mWH7v3iDlosn5Xe4Yu2Cn+YXTC4vRXjNzaI1aXDUH2kB
        rvP1EMug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWJgR-00DxAP-0a;
        Sun, 26 Feb 2023 16:15:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0371F300269;
        Sun, 26 Feb 2023 17:15:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC16B20C0F373; Sun, 26 Feb 2023 17:15:27 +0100 (CET)
Date:   Sun, 26 Feb 2023 17:15:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH 5/6] locking/rwsem: Unify wait loop
Message-ID: <Y/uFn4WwZ8R3Dh4S@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.608133045@infradead.org>
 <0be586e4-8c08-63ff-a78d-ffb5ae37adc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0be586e4-8c08-63ff-a78d-ffb5ae37adc3@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 05:45:56PM -0500, Waiman Long wrote:

> Unfortunately, lockevent_inc() doesn't work with waiter_type() like that as
> the compilation will fail if CONFIG_LOCK_EVENT_COUNTS is enabled.  Could you
> include the attached patch in your series and make the following changes?

Yeah, robot told me; fixed it like so:

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -995,13 +995,16 @@ static inline void rwsem_cond_wake_waite
 	rwsem_mark_wake(sem, wake_type, wake_q);
 }
 
-#define waiter_type(_waiter, _r, _w)	\
-	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
+#define lockevent_rw_inc(rd, evr, evw)	do {	\
+	lockevent_cond_inc(evr, (rd));		\
+	lockevent_cond_inc(evw, !(rd));		\
+} while (0)
 
 static __always_inline struct rw_semaphore *
-rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
+rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
+		  int state, bool reader)
 {
-	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
+	trace_contention_begin(sem, reader ? LCB_F_READ : LCB_F_WRITE);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -1019,18 +1022,19 @@ rwsem_waiter_wait(struct rw_semaphore *s
 			break;
 		}
 		schedule_preempt_disabled();
-		lockevent_inc(waiter_type(waiter, rwsem_sleep_reader, rwsem_sleep_writer));
+		lockevent_rw_inc(reader, rwsem_sleep_reader, rwsem_sleep_writer);
 	}
 
 	__set_current_state(TASK_RUNNING);
-	lockevent_inc(waiter_type(waiter, rwsem_rlock, rwsem_wlock));
+
+	lockevent_rw_inc(reader, rwsem_rlock, rwsem_wlock);
 	trace_contention_end(sem, 0);
 	return sem;
 
 out_nolock:
 	rwsem_del_wake_waiter(sem, waiter);
 	__set_current_state(TASK_RUNNING);
-	lockevent_inc(waiter_type(waiter, rwsem_rlock_fail, rwsem_wlock_fail));
+	lockevent_rw_inc(reader, rwem_rlock_fail, rwsem_wlock_fail);
 	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
 }
@@ -1112,7 +1116,7 @@ rwsem_down_read_slowpath(struct rw_semap
 	if (!wake_q_empty(&wake_q))
 		wake_up_q(&wake_q);
 
-	return rwsem_waiter_wait(sem, &waiter, state);
+	return rwsem_waiter_wait(sem, &waiter, state, true);
 }
 
 /*
@@ -1162,7 +1166,7 @@ rwsem_down_write_slowpath(struct rw_sema
 	}
 	raw_spin_unlock_irq(&sem->wait_lock);
 
-	return rwsem_waiter_wait(sem, &waiter, state);
+	return rwsem_waiter_wait(sem, &waiter, state, false);
 }
 
 /*
