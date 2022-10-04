Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78D5F4910
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJDSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJDSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAA2BC0F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664906989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrVoae3tQSDZDIdSDFPTEzED/ITHwNMOxXG7YxVT0Q0=;
        b=KFmZixBmXFg5QHGyL/uLDU/yJvSF6oL2vn8/RgX2YX0pXXRPkcDUNHaxhW0xhRfaJJdOBM
        +22fXgQ4p0Do8bi+4kWiOZR6aHhAky7mzhjRdE/gojG6dvA4vL39rDSjXv5and+bs7rncR
        I85F7O3aXBrGJRHa18x3ihvVxzyveSQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-KNwnebNtOEekXR7-9i6lWw-1; Tue, 04 Oct 2022 14:09:43 -0400
X-MC-Unique: KNwnebNtOEekXR7-9i6lWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CA131C09043;
        Tue,  4 Oct 2022 18:09:42 +0000 (UTC)
Received: from [10.22.10.217] (unknown [10.22.10.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 636D917593;
        Tue,  4 Oct 2022 18:09:40 +0000 (UTC)
Message-ID: <5f853677-874a-2a38-4253-95b2795eb7a8@redhat.com>
Date:   Tue, 4 Oct 2022 14:09:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] locking/lockdep: add debug_show_all_lock_holders()
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
 <3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com>
 <9f42e8a5-f809-3f2c-0fda-b7657bc94eb3@I-love.SAKURA.ne.jp>
 <1fd381e0-03e7-df2a-4865-d157714ce9b2@redhat.com>
 <1f71cfbf-7bee-6a06-dca1-ac94bf542cd7@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <1f71cfbf-7bee-6a06-dca1-ac94bf542cd7@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 18:18, Tetsuo Handa wrote:
> Can this patch go to linux.git ?

It is now up to Peter or Ingo to take it  to tip.

Cheers,
Longman

>
> On 2022/09/17 3:41, Waiman Long wrote:
>> On 9/16/22 11:57, Tetsuo Handa wrote:
>>> Currently, check_hung_uninterruptible_tasks() reports details of locks
>>> held in the system. Also, lockdep_print_held_locks() does not report
>>> details of locks held by a thread if that thread is in TASK_RUNNING state.
>>> Several years of experience of debugging without vmcore tells me that
>>> these limitations have been a barrier for understanding what went wrong
>>> in syzbot's "INFO: task hung in" reports.
>>>
>>> I initially thought that the cause of "INFO: task hung in" reports is
>>> due to over-stressing. But I understood that over-stressing is unlikely.
>>> I now consider that there likely is a deadlock/livelock bug where lockdep
>>> cannot report as a deadlock when "INFO: task hung in" is reported.
>>>
>>> A typical case is that thread-1 is waiting for something to happen (e.g.
>>> wait_event_*()) with a lock held. When thread-2 tries to hold that lock
>>> using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
>>> thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
>>> to hold. But currently check_hung_uninterruptible_tasks() cannot report
>>> the exact location of thread-1 which gives us an important hint for
>>> understanding why thread-1 is holding that lock for so long period.
>>>
>>> When check_hung_uninterruptible_tasks() reports a thread waiting for a
>>> lock, it is important to report backtrace of threads which already held
>>> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
>>> the exact location of threads which is holding any lock.
>>>
>>> To deduplicate code, share debug_show_all_{locks,lock_holders}() using
>>> a flag. As a side effect of sharing, __debug_show_all_locks() skips
>>> current thread if the caller is holding no lock, for reporting RCU lock
>>> taken inside __debug_show_all_locks() is generally useless.
>>>
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Acked-by: Waiman Long <longman@redhat.com>

