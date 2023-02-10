Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD969239E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjBJQso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjBJQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:48:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68EEFA1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:48:42 -0800 (PST)
Date:   Fri, 10 Feb 2023 17:48:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676047720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7J/wQKfiNWiYCHK4w1PhxeDGC2vnarydlqDSmyt1BQ=;
        b=349veFs0VqWMS8xPQ45GBMNcrvJO5aIhmlnk34FZks4O9NW1v5WiG0QSqwqegW1zKlPrPE
        m5opX9oNH6eMCkIW4jLaj7zJ8z8ZdVn7iHkyO2rMtsJ/VR2FoQyXSbOlJI52soysjFO/Z1
        tDo1tSmSooEXpm714HhweduLqeRmN8nOvtXvCItV+HYPzZvjr1zJzzoLxtgoeR6K1yuxiq
        HjTTVR6qaaiIAw1uEsegLJ4CNaJzTUdZrn5hfxarNL5M0bo6IMLj8G6krxPoph0dvMuYzl
        oSP6X8PT1rR7DYQh9wXWyGxidqln5zhrcrwQfJDVw+vwv8z5fOQ26TTi976epQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676047720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7J/wQKfiNWiYCHK4w1PhxeDGC2vnarydlqDSmyt1BQ=;
        b=a4NHqNh4k1pJp2zuzU1s61B0Hv2fDNbsrMUe2ZDT5oL2fPyWqwMzmjnzm4+1P+M4nM+TQZ
        clGp+L9pLThK9yAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <Y+Z1Z85htbmMtsmH@linutronix.de>
References: <20230206130449.41360-1-wander@redhat.com>
 <Y+EVNz4ORkFSvTfP@linutronix.de>
 <20230206152712.GA1487@redhat.com>
 <Y+Ek98n1xUhTP+8a@linutronix.de>
 <20230206162758.GB1487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206162758.GB1487@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 17:27:58 [+0100], Oleg Nesterov wrote:
> On 02/06, Sebastian Andrzej Siewior wrote:
> >
> > On 2023-02-06 16:27:12 [+0100], Oleg Nesterov wrote:
> >
> > > > If so why not use it
> > > > unconditionally?
> > >
> > > performance ?
> >
> > All the free() part is moved from the caller into rcu.
> 
> sorry, I don't understand,

That callback does mostly free() and it is batched with other free()
invocations. This also is moved away from the caller which _might_
benefit.

> > > And... I still don't like the name of delayed_put_task_struct_rcu() to me
> > > ___put_task_struct_rcu() looks a bit less confusing, note that we already
> > > have delayed_put_task_struct(). But this is minor.
> >
> > So if we do it unconditionally then we could get rid of
> > put_task_struct_rcu_user().
> 
> Yes. But the whole purpose of rcu_users is that we want to avoid the unconditional
> rcu grace period before free_task() ?

Oh, this is usage vs rcu_users. Okay, mixed that up.

> Just in case... please note that delayed_put_task_struct() delays
> refcount_sub(t->usage), not free_task().

Just noticed ;)

> Why do we need this? Consider
> 
> 	rcu_read_lock();
> 
> 	task = find-task-in-rcu-protected-list;
> 
> 	// Safe, task->usage can't be zero
> 	get_task_struct(task);
> 
> 	rcu_read_unlock();
> 
> 
> > Otherwise we could use put_task_struct_rcu_user() in that timer
> > callback because it will lead to lockdep warnings once printk is fixed.
> 
> IIUC there are more in-atomic callers of put_task_struct(). But perhaps
> I misunderstood you...

That is true. So you are saying that we don't what to use RCU for
put_task_struct() unconditionally?

> Oleg.

Sebastian
