Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5954C673ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjASQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjASQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:28:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7473583;
        Thu, 19 Jan 2023 08:28:53 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:28:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674145730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSJxOY/6fo3NzgfrGyFmvSSdAM8W+liCARNIy2pivbo=;
        b=YIMzvNKahXri42yD5JeF01x8Eqfv+1DuiYSm1Sy4pONAMb9Te/6wXX9XBhmurZDGU78uiX
        Ivx/Nahdmrn6kxKRx32e/vyxHlkxjsbTiyRatVUw9WPJUnc8gwYKgpBrfKWRXnKbR5LAMS
        V1ZxxarS1m6se3HDPjWeXFr82+hNk4+Mj/YkMOHusUVYSx0AnhRIv59/SXDol0gtMRgEzq
        z61I54j7v24KVS8q37MCWzMRp7iaGLz7tmte1UJ+rt/3spoYO/0S/sJL5bQ/3LBGRFxByt
        vGn/mG2peJfOLEMHFXOAE3oqlbTsqprB2ZFIEnA6p3g+NVps/Z7ni5qNscNytw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674145730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSJxOY/6fo3NzgfrGyFmvSSdAM8W+liCARNIy2pivbo=;
        b=CBTxq6QMcx5mZJlDwhB5e5VyLK8DxS6BUydVFDQ+sA3LiZJo3ZoEYDsxX4qgh9L1xZ2k7i
        HKlGJLc/mZk/ByBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8lvwKHmmnikVDgk@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119110220.kphftcehehhi5l5u@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-19 11:02:20 [+0000], Mel Gorman wrote:
> > - Once the writer removes READER_BIAS, it forces the reader into the
> >   slowpath.
> 
> Removed in __rwbase_write_trylock IIUC

And added back in case try trylock failed via __rwbase_write_unlock().
The RTmutex is unlocked and the READER_BIAS is "returned".

> >   At that time the writer does not own the wait_lock meaning
> >   the reader _could_ check the timeout before writer had a chance to set
> >   it. The worst thing is probably that if jiffies does not have the
> >   highest bit set then it will always disable the reader bias here.
> >   The easiest thing is probably to check timeout vs 0 and ensure on the
> >   writer side that the lowest bit is always set (in the unlikely case it
> >   will end up as zero).
> > 
> 
> I am missing something important. On the read side, we have
> 

Look at this side by side:

                writer                                                       reader

| static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
|                                      unsigned int state)
| {
|         /* Force readers into slow path */
|         atomic_sub(READER_BIAS, &rwb->readers);


|                                                               static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
|                                                                                                     unsigned int state)
|                                                               {       
|                                                                       struct rt_mutex_base *rtm = &rwb->rtmutex;
|                                                                       int ret;                         
|                                                               
|                                                                       raw_spin_lock_irq(&rtm->wait_lock);

Reader has the lock, writer will wait.

|                                                                       /*
|                                                                        * Allow readers, as long as the writer has not completely
|                                                                        * acquired the semaphore for write.
|                                                                        */
|                                                                       if (atomic_read(&rwb->readers) != WRITER_BIAS) {

here, the timeout value is not yet populated by the writer so the reader
compares vs 0.

|                                                                               atomic_inc(&rwb->readers);
|                                                                               raw_spin_unlock_irq(&rtm->wait_lock);
|                                                                               return 0;
|                                                                       }
|                                                              

|         raw_spin_lock_irqsave(&rtm->wait_lock, flags);
|         if (__rwbase_write_trylock(rwb))
|                 goto out_unlock;
|

Hope this makes it easier.

Sebastian
