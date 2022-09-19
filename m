Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E95BD55E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiISTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912821E30
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663616961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+TheRRU9XSfKLaR1grByaf3EkilJIIZJ6KYOUVnfMU=;
        b=S6x9BMnDs9T45Yd3yBsggyy2698PXs0fuu7fJG5IeU4ift8R9q+R4WRbRv3e5QISlpRdXS
        MEChacgjNFv1h/h1twOen+eVk04NaQ4ZHKcPYLlbyBJ7aMIWacLeN3AY9N9f3bPX1qkv+E
        RcsfBQmHrbz6eiplBMQYSn5WKX/9ZM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-kaRmdpi0N3etDnCiSsfSHw-1; Mon, 19 Sep 2022 15:49:20 -0400
X-MC-Unique: kaRmdpi0N3etDnCiSsfSHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99EDE101A528;
        Mon, 19 Sep 2022 19:49:19 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65F071121314;
        Mon, 19 Sep 2022 19:49:19 +0000 (UTC)
Message-ID: <0d477668-e369-24fa-ffd2-1cb560910d2c@redhat.com>
Date:   Mon, 19 Sep 2022 15:49:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220909192848.963982-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220909192848.963982-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 15:28, Waiman Long wrote:
> It was found that a circular lock dependency can happen with the
> following locking sequence:
>
>     +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
>     |                                                         |
>     +---------------------------------------------------------+
>
> The &p->pi_lock --> &rq->__lock sequence is very common in all the
> task_rq_lock() calls.
>
> The &rq->__lock --> (console_sem).lock sequence happens when the
> scheduler code calling printk() or more likely the various WARN*()
> macros while holding the rq lock. The (console_sem).lock is actually
> a raw spinlock guarding the semaphore. In the particular lockdep splat
> that I saw, it was caused by SCHED_WARN_ON() call in update_rq_clock().
> To work around this locking sequence, we may have to ban all WARN*()
> calls when the rq lock is held, which may be too restrictive, or we
> may have to add a WARN_DEFERRED() call and modify all the call sites
> to use it.
>
> Even then, a deferred printk or WARN function may still call
> console_trylock() which may, in turn, calls up_console_sem() leading
> to this locking sequence.
>
> The other ((console_sem).lock --> &p->pi_lock) locking sequence
> was caused by the fact that the semaphore up() function is calling
> wake_up_process() while holding the semaphore raw spinlock. This lockiing
> sequence can be easily eliminated by moving the wake_up_processs()
> call out of the raw spinlock critical section using wake_q which is
> what this patch implements. That is the easiest and the most certain
> way to break this circular locking sequence.
>
> v1: https://lore.kernel.org/lkml/20220118153254.358748-1-longman@redhat.com/
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Ping!

Note that the current printk_deferred() code path may also hit this 
problem as an up() call of console_sem may be issued.

Cheers,
Longman

