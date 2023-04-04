Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987D6D5B78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjDDJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjDDJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:05:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF1AE62
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=72ruK2mNbys8PIyy35QTUdR95rFv5PixX6W/SrUuWJw=; b=DURlYlueYIkrRxJcf9zNnwLPPg
        PPHqKqMRKMJNRVr/xAtnalqVCbDOY/16XfC6V780xTynhn2ccs45RDjg6lCqOY2Ln7EA1/RYMB7Gn
        x6iMnMnZcS9L/2R0EYml0+4LnLW3t/Iio/7fzFqoW9ZHebfLCu5TBlPUT14zuUqyNsXgeKweyk2Yh
        t+if8w4iOu4gyZLO170sw9xfXg6FhbJY0RoQeD63P54RVMtfPbzfzpjvRkgu92LLbwkvBHXTo7Yvm
        mQPJHLHuFOOIMeTEGwHpxDlaSwYm+05PwZE7TNO/SnwnX03x1HUP3mkK+p1T/Vcov6Xs3PP4qI6Ej
        cAIxEvhQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjcbD-00FD8a-VI; Tue, 04 Apr 2023 09:05:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8881530003A;
        Tue,  4 Apr 2023 11:05:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 711252B6E1F53; Tue,  4 Apr 2023 11:05:07 +0200 (CEST)
Date:   Tue, 4 Apr 2023 11:05:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230404090507.GB284733@hirez.programming.kicks-ass.net>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:13:42PM -0400, Mathieu Desnoyers wrote:
>  void sched_mm_cid_exit_signals(struct task_struct *t)
>  {
>  	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct rq_flags rf;
> +	struct rq *rq;
>  
>  	if (!mm)
>  		return;
> -	local_irq_save(flags);
> +
> +	preempt_disable();
> +	rq = this_rq();
> +	rq_lock_irqsave(rq, &rf);
>  	mm_cid_put(mm, t->mm_cid);
> -	t->mm_cid = -1;
> +	t->last_mm_cid = t->mm_cid = -1;
>  	t->mm_cid_active = 0;
> -	local_irq_restore(flags);
> +	rq_unlock_irqrestore(rq, &rf);
> +	preempt_enable();
>  }

FWIW a *slightly* cheaper form is:

	preempt_disable();
	rq = this_rq();
	rq_lock_irqsave(rq, &rf);
	preempt_enable_noresched(); /* holding spinlock */
	...
	rq_unlock_irqrestore(rq, &rf);

