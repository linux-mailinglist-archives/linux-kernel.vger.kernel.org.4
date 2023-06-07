Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF57726992
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjFGTRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjFGTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:16:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5196C19D;
        Wed,  7 Jun 2023 12:16:58 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 73C4520C1440;
        Wed,  7 Jun 2023 12:16:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73C4520C1440
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686165417;
        bh=pYYzhbmZt7Sf9oZRbG0KFxG6URBGYIxxrSNs2hGYJ2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Otze/uJzHUvL8i48n/kF0mN8sq3q2ZphOdehU36zn7kHx0P8VHNbMjp0GAhkMwOuJ
         3Yb7syLKS28tSprq5Rzemogz60k0UCU94KONTb/szKuQmAYivGyBbw0GLb9swPMvB8
         UDzfLfL0O1xxclFqA+XlF0OorjbCAfypF18vRtc8=
Date:   Wed, 7 Jun 2023 12:16:52 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, dcook@linux.microsoft.com
Subject: Re: [PATCH v2 3/5] tracing/user_events: Add auto cleanup and a flag
 to persist events
Message-ID: <20230607191652.GA85@W11-BEAU-MD.localdomain>
References: <20230605233900.2838-1-beaub@linux.microsoft.com>
 <20230605233900.2838-4-beaub@linux.microsoft.com>
 <CAADnVQL3bJaXW6mzTrTFTbAyCaBfiHYet+gNorF1N69a0X5TXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL3bJaXW6mzTrTFTbAyCaBfiHYet+gNorF1N69a0X5TXQ@mail.gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 06:26:56PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 5, 2023 at 4:39 PM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > +       /*
> > +        * When the event is not enabled for auto-delete there will always
> > +        * be at least 1 reference to the event. During the event creation
> > +        * we initially set the refcnt to 2 to achieve this. In those cases
> > +        * the caller must acquire event_mutex and after decrement check if
> > +        * the refcnt is 1, meaning this is the last reference. When auto
> > +        * delete is enabled, there will only be 1 ref, IE: refcnt will be
> > +        * only set to 1 during creation to allow the below checks to go
> > +        * through upon the last put. The last put must always be done with
> > +        * the event mutex held.
> > +        */
> > +       if (!locked) {
> > +               lockdep_assert_not_held(&event_mutex);
> > +               delete = refcount_dec_and_mutex_lock(&user->refcnt, &event_mutex);
> > +       } else {
> > +               lockdep_assert_held(&event_mutex);
> > +               delete = refcount_dec_and_test(&user->refcnt);
> > +       }
> > +
> > +       if (!delete)
> > +               return;
> > +
> > +       /* We now have the event_mutex in all cases */
> > +
> > +       if (user->reg_flags & USER_EVENT_REG_PERSIST) {
> > +               /* We should not get here when persist flag is set */
> > +               pr_alert("BUG: Auto-delete engaged on persistent event\n");
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * Unfortunately we have to attempt the actual destroy in a work
> > +        * queue. This is because not all cases handle a trace_event_call
> > +        * being removed within the class->reg() operation for unregister.
> > +        */
> > +       INIT_WORK(&user->put_work, delayed_destroy_user_event);
> > +
> > +       /*
> > +        * Since the event is still in the hashtable, we have to re-inc
> > +        * the ref count to 1. This count will be decremented and checked
> > +        * in the work queue to ensure it's still the last ref. This is
> > +        * needed because a user-process could register the same event in
> > +        * between the time of event_mutex release and the work queue
> > +        * running the delayed destroy. If we removed the item now from
> > +        * the hashtable, this would result in a timing window where a
> > +        * user process would fail a register because the trace_event_call
> > +        * register would fail in the tracing layers.
> > +        */
> > +       refcount_set(&user->refcnt, 1);
> 
> The recnt-ing scheme is quite unorthodox.

Yes, it's unfortunately because we have to keep the event in the hashtable.

Typically we'd just remove the event from the hashtable, ref_dec and
then upon final ref_dec free it. The problem with that is the event in
the hashtable is an actual trace_event exposed via tracefs/perf. It
prevents us from removing it at this time as the comment tries to
explain.

> Atomically decrementing it to zero and then immediately set it back to 1?
> Smells racy.

Thanks for pointing this out, I likely need another comment in the code
explaining why this is ok.

It might smell that way :) But the only way once it's zero to get
another reference is by acquiring event_mutex and then calling
find_user_event(). This is why it's important that at this phase we hold
the event_mutex in all cases.

> Another process can go through the same code and do another dec and set to 1
> and we'll have two work queued?

Once we set it to 1, we cannot get into this code path again until the
work that was queued is finished. The scheduled work acquires
event_mutex and ensures it's still the last reference before doing any
actual deletion or a refcount_dec that would allow for another work
queue via this path.

> Will mutex_lock help somehow? If yes, then why atomic refcnt?

I hopefully fully explained the mutex_lock above, if it's confusing
still let me know. The rason for the atomic refcnt though is because you
initially get a reference to a user_event via find_user_event() under
the lock, but then each FD (and each enabler) has a reference to the
underlying user_event (and thus the trace_event). Fork() and enablement
registers are done outside of this lock for performance reasons. When
the task exits, we also close down the enablers for that mm/task, and so
the lock is not there either (and why having the less used
refcount_dec_and_mutex_lock being required on put when it's not
acquired).

Thanks,
-Beau
