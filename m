Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC45BAF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiIPOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiIPOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B309ABF2A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663339881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGfkTbjbj4y5weWbQls4Bj+fqmdi3Ct4eOPhYuCk3vQ=;
        b=AbI1xZMOZq9pwygrBSBpCHxskxQd+gPrEOKvzanQsEiXhQ/tw8A3G6dE01LZMenqPv27Hs
        bnTWJHm3YlTPnVM7aez8x+UHveazy2+LylHB6ZAx5g3JLUkg69uMFPPygTuIKEHpBMVw/j
        PvosH1aYFDcXb347bp0Ivg0oPX2oZK0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-U-7YQjNvOnej_pdIg_YMNQ-1; Fri, 16 Sep 2022 10:51:18 -0400
X-MC-Unique: U-7YQjNvOnej_pdIg_YMNQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C442D1C0759E;
        Fri, 16 Sep 2022 14:51:16 +0000 (UTC)
Received: from [10.22.17.61] (unknown [10.22.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E166F580458;
        Fri, 16 Sep 2022 14:51:14 +0000 (UTC)
Message-ID: <3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com>
Date:   Fri, 16 Sep 2022 10:51:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <d5393b0e-a296-3296-d376-c9178669747b@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <d5393b0e-a296-3296-d376-c9178669747b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 10:15, Tetsuo Handa wrote:
> Currently, check_hung_uninterruptible_tasks() reports details of locks
> held in the system. Also, lockdep_print_held_locks() does not report
> details of locks held by a thread if that thread is in TASK_RUNNING state.
> Several years of experience of debugging without vmcore tells me that
> these limitations have been a barrier for understanding what went wrong
> in syzbot's "INFO: task hung in" reports.
>
> I initially thought that the cause of "INFO: task hung in" reports is
> due to over-stressing. But I understood that over-stressing is unlikely.
> I now consider that there likely is a deadlock/livelock bug where lockdep
> cannot report as a deadlock when "INFO: task hung in" is reported.
>
> A typical case is that thread-1 is waiting for something to happen (e.g.
> wait_event_*()) with a lock held. When thread-2 tries to hold that lock
> using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
> thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
> to hold. But currently check_hung_uninterruptible_tasks() cannot report
> the exact location of thread-1 which gives us an important hint for
> understanding why thread-1 is holding that lock for so long period.
>
> When check_hung_uninterruptible_tasks() reports a thread waiting for a
> lock, it is important to report backtrace of threads which already held
> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
> the exact location of threads which is holding any lock.

I am not against this patch, but I do like to see you wrapping your code 
in a __debug_show_all_locks() wrapper, for instance, with flags and make 
debug_show_all_locks() uses the new wrapper to avoid code redundancy.


> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This is repost of https://lkml.kernel.org/r/82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp .
> I think there was no critical objection which blocks this change.
>
> I wish that lockdep continues tracking locks (i.e. debug_locks remains 1)
> even after something went wrong, for recently I sometimes encounter problems
> that disable lockdep during boot stage.
>
> It would be noisy to report possibility of e.g. circular locking dependency
> every time due to keeping debug_locks enabled. But tracking locks even after
> something went wrong will help debug_show_all_lock_holders() to survive
> problems during boot stage.
>
> I'm not expecting lockdep to report the same problem forever.
> Reporting possibility of each problem pattern (e.g. circular locking dependency)
> up to once, by using cmpxchg() inside reporting functions that call printk(),
> would be enough.
>
> I'm expecting lockdep to continue working without calling printk() even after
> one of problem patterns (e.g. circular locking dependency) was printk()ed, so that
> debug_show_all_locks()/debug_show_all_lock_holders() can call printk() when needed.
>
> Changing debug_locks behavior is a future patch. For now, this patch alone
> will help debugging Greg's usb.git#usb-testing tree which is generating
> many "INFO: task hung in" reports.

Boqun is actually working on a modularization patch to make some lockdep 
checking still active even after a lockdep bug is reported. I think he 
will take into consideration about this request.

Cheers,
Longman

