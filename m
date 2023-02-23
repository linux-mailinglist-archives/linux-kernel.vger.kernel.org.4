Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF746A08A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjBWMcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBWMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:32:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C248E10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A5DvK22+jfOA4mP80mZJt9Zdd9lrU+I+SHy7yta94S4=; b=THnbF9klFuEeM7qAtrWK7//TbE
        0HcFW3GBT2lrEzVIklV0fFuzBy6qV6Ak8n2k1ananbZQgEQB7xyQKPRd1T1UsKbLyldVTxv71i3yD
        8cZ40gF8LZfLq84MWmMb9mFKtRk+iAJysHYNSBB+yQYnucwPN0zx7HwiDzU6UxVzvcv0G+79eJLTU
        I/zPx+uTp3J6Ipso0jkl8TaNKynwU9+jQmYCJehu2wauPyrggUrRxeGbPMyVduOjWitAre1vGpPGP
        ssWrDHo6re71zn5HSHMyHYW9dbDMlU7Fi389DEWbshpsE7ebpEBoZ6LyzT4xMvcp2a/doT73Mt5HL
        +goFTyrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pVAlp-00CuTe-1I;
        Thu, 23 Feb 2023 12:32:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA39130020B;
        Thu, 23 Feb 2023 13:32:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFE5C2C539A0B; Thu, 23 Feb 2023 13:32:19 +0100 (CET)
Date:   Thu, 23 Feb 2023 13:32:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 2/3] locking/rwsem: Enable early rwsem writer lock
 handoff
Message-ID: <Y/dc01A9+k6KuHTc@hirez.programming.kicks-ass.net>
References: <20230216210933.1169097-1-longman@redhat.com>
 <20230216210933.1169097-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216210933.1169097-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:09:32PM -0500, Waiman Long wrote:
> @@ -432,19 +433,39 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>  		 * Mark writer at the front of the queue for wakeup.
>  		 * Until the task is actually later awoken later by
>  		 * the caller, other writers are able to steal it.
> +		 *
> +		 * *Unless* HANDOFF is set, in which case only the
> +		 * first waiter is allowed to take it.
> +		 *
>  		 * Readers, on the other hand, will block as they
>  		 * will notice the queued writer.
>  		 */
>  		wake_q_add(wake_q, waiter->task);
>  		lockevent_inc(rwsem_wake_writer);
> +
> +		if ((count & RWSEM_LOCK_MASK) || !(count & RWSEM_FLAG_HANDOFF))
> +			return;
> +
> +		/*
> +		 * If the rwsem is free and handoff flag is set with wait_lock
> +		 * held, no other CPUs can take an active lock. We can do an
> +		 * early handoff.
> +		 */
> +		adjustment = RWSEM_WRITER_LOCKED - RWSEM_FLAG_HANDOFF;
> +		atomic_long_set(&sem->owner, (long)waiter->task);
> +		waiter->task = NULL;
> +		atomic_long_add(adjustment, &sem->count);
> +		rwsem_del_waiter(sem, waiter);
> +		lockevent_inc(rwsem_wlock_ehandoff);
>  	}

*sigh*... you can't even properly copy/paste from the reader side :/
This is broken, the moment you do waiter->task = NULL, waiter can
dissapear from under you and that rwsem_del_waiter() is a UaF.

Nor did you unify the reader and writer side and still have a giant
trainwreck on your hands..

Surely all that isn't too hard... let me post it.
