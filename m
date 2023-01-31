Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAF682DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjAaNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAaNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:31:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E084AA76;
        Tue, 31 Jan 2023 05:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OFjEcxHlqGjDIAxo5lEFzTwhM5kWaqa7LpBF+f5WaNU=; b=qzma5HOv731HusGGndSHu2aFHl
        529GeujSBTUqbRC0gTSlumYDAFIu1L+s17z03eD/fgln+NZdClixO9AnKNec96jkVMaNKt7pL4EcS
        jBFXRoWqSQxfOD70T4Wx/eii9MC7f/Bk6fyR4UfZqJAe3rxC3dDOp702aoTV/DhMQ89tICYATNXU3
        60LEhCG+ERIXN2OpwfJ8trOb0oGN3t2jF8i6N4i0cymQ7aBUZr3izMl3ew6Qc/inpT+E0uF1U8efQ
        BVXUKy6G3TdQRqiaA+L2TPIOimOobQn8/5e4iqMSpWqp+1lVA9QmPd3H1Os5DhZCdhe/fiz7TPN8J
        WWlluZPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMqim-004N3P-1T;
        Tue, 31 Jan 2023 13:30:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 653A6300446;
        Tue, 31 Jan 2023 14:31:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F2DE208358EB; Tue, 31 Jan 2023 14:31:20 +0100 (CET)
Date:   Tue, 31 Jan 2023 14:31:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, ravi.bangoria@amd.com,
        syzbot+697196bc0265049822bd@syzkaller.appspotmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf: Fix warning from concurrent read/write of
 perf_event_pmu_context
Message-ID: <Y9kYKBMBEa7j+O3n@hirez.programming.kicks-ass.net>
References: <20230127143141.1782804-1-james.clark@arm.com>
 <20230127143141.1782804-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127143141.1782804-2-james.clark@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:31:41PM +0000, James Clark wrote:

> @@ -4897,32 +4895,32 @@ static void free_epc_rcu(struct rcu_head *head)
>  static void put_pmu_ctx(struct perf_event_pmu_context *epc)
>  {
>  	unsigned long flags;
> +	struct perf_event_context *ctx = epc->ctx;
>  
> -	if (!atomic_dec_and_test(&epc->refcount))
> +	/*
> +	 * XXX
> +	 *
> +	 * lockdep_assert_held(&ctx->mutex);
> +	 *
> +	 * can't because of the call-site in _free_event()/put_event()
> +	 * which isn't always called under ctx->mutex.
> +	 */
> +	raw_spin_lock_irqsave(&ctx->lock, flags);
> +	if (!atomic_dec_and_test(&epc->refcount)) {
> +		raw_spin_unlock_irqrestore(&ctx->lock, flags);
>  		return;
> +	}

This is a bit of an anti-pattern and better donw using dec_and_lock. As
such, I'll fold the below into it.

--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -476,6 +476,15 @@ extern int _atomic_dec_and_lock_irqsave(
 #define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
 		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
 
+extern int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock);
+#define atomic_dec_and_raw_lock(atomic, lock) \
+		__cond_lock(lock, _atomic_dec_and_raw_lock(atomic, lock))
+
+extern int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
+					unsigned long *flags);
+#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) \
+		__cond_lock(lock, _atomic_dec_and_raw_lock_irqsave(atomic, lock, &(flags)))
+
 int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			     size_t max_size, unsigned int cpu_mult,
 			     gfp_t gfp, const char *name,
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4901,11 +4901,8 @@ static void put_pmu_ctx(struct perf_even
 	 * can't because of the call-site in _free_event()/put_event()
 	 * which isn't always called under ctx->mutex.
 	 */
-	raw_spin_lock_irqsave(&ctx->lock, flags);
-	if (!atomic_dec_and_test(&epc->refcount)) {
-		raw_spin_unlock_irqrestore(&ctx->lock, flags);
+	if (!atomic_dec_and_raw_lock_irqsave(&epc->refcount, &ctx->lock, flags))
 		return;
-	}
 
 	WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
 
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -49,3 +49,34 @@ int _atomic_dec_and_lock_irqsave(atomic_
 	return 0;
 }
 EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
+
+int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
+{
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+
+	/* Otherwise do it the slow way */
+	raw_spin_lock(lock);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	raw_spin_unlock(lock);
+	return 0;
+}
+EXPORT_SYMBOL(_atomic_dec_and_raw_lock);
+
+int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
+				     unsigned long *flags)
+{
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+
+	/* Otherwise do it the slow way */
+	raw_spin_lock_irqsave(lock, *flags);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	raw_spin_unlock_irqrestore(lock, *flags);
+	return 0;
+}
+EXPORT_SYMBOL(_atomic_dec_and_raw_lock_irqsave);
