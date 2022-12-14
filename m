Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B364D09C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLNUE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLNUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:03:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C182ED42
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D4mbWoI/BMsxaMSLndE9NzSrR7QAr2JilFiw1m28l/E=; b=FH/mTlfjS7KPLhJKuJ5YOFmSqd
        R6yFovbOxTsT717WdxIUe0ntmN9V5tF3bQoEe/l1FXtwPM+HqM8Ayk7DB114Hn3NYcbfoZUr22y91
        GANrMH9Wr7tM1cA/UKHCuruxbTgMWUgKYD00AWfqOEBRXfd/Pr4z9Z8uS5wlfZR9fD/8K7drcKMiS
        jr/RpYkPJ0rA34kx38DtvUPw5Y5J7b+ABfgsAWYhaxHR6wCWSShbHSuNExJX9yXCthlIDL0PONKKG
        M8BCnFmUMZolbnVbNPDASsfsA8cbcIDsgbPOiOnfW5RQz5OnhjneTVsa5wP3JVncG0CqWt9YlNCi3
        rBDex6cA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5Xt8-002O5K-Oy; Wed, 14 Dec 2022 19:57:58 +0000
Date:   Wed, 14 Dec 2022 11:57:58 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Message-ID: <Y5oqxh2jnarlEKNG@bombadil.infradead.org>
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com>
 <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com>
 <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Ingo, Steven would like you're review.

On Tue, Dec 13, 2022 at 03:03:53PM -0800, Luis Chamberlain wrote:
> On Mon, Dec 12, 2022 at 09:38:31PM +0800, Schspa Shi wrote:
> > I'd like to upload a V2 patch with the new solution if you prefer the
> > following way.
> > 
> > diff --git a/kernel/umh.c b/kernel/umh.c
> > index 850631518665..8023f11fcfc0 100644
> > --- a/kernel/umh.c
> > +++ b/kernel/umh.c
> > @@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> >                 /* umh_complete() will see NULL and free sub_info */
> >                 if (xchg(&sub_info->complete, NULL))
> >                         goto unlock;
> > +               /*
> > +                * kthreadd (or new kernel thread) will call complete()
> > +                * shortly.
> > +                */
> > +               wait_for_completion(&done);
> >         }
> 
> Yes much better. Did you verify it fixes the splat found by the bots?

Wait, I'm not sure yet why this would fix it... I first started thinking
that this may be a good example of a Coccinelle SmPL rule, something like:

	DECLARE_COMPLETION_ONSTACK(done);
	foo *foo;
	...
	foo->completion = &done;
	...
	queue_work(system_unbound_wq, &foo->work);
	....
	ret = wait_for_completion_state(&done, state);
	...
	if (!ret)
		S
	...
	+wait_for_completion(&done);

But that is pretty complex, and while it may be useful to know how many
patterns we have like this, it begs the question if generalizing this
inside the callers is best for -ERESTARTSYS condition is best. What
do folks think?

The rationale here is that if you queue stuff and give access to the
completion variable but its on-stack obviously you can end up with the
queued stuff complete() on a on-stack variable. The issue seems to
be that wait_for_completion_state() for -ERESTARTSYS still means
that the already scheduled queue'd work is *about* to run and
the process with the completion on-stack completed. So we race with
the end of the routine and the completion on-stack.

It makes me wonder if wait_for_completion() above really is doing
something more, if it is just helping with timing and is still error
prone.

The queued work will try the the completion as follows:

static void umh_complete(struct subprocess_info *sub_info)
{
	struct completion *comp = xchg(&sub_info->complete, NULL);              
	/*
	 * See call_usermodehelper_exec(). If xchg() returns NULL
	 * we own sub_info, the UMH_KILLABLE caller has gone away
	 * or the caller used UMH_NO_WAIT.
	 */
	if (comp)
		complete(comp);
	else
		call_usermodehelper_freeinfo(sub_info);
}

So the race is getting -ERESTARTSYS on the process with completion
on-stack and the above running complete(comp). Why would sprinkling
wait_for_completion(&done) *after* wait_for_completion_state(&done, state)
fix this UAF?
												    }   
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index d57a5c1c1cd9..aa7031faca04 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -205,8 +205,10 @@ int __sched wait_for_completion_interruptible(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
 
-	if (t == -ERESTARTSYS)
+	if (t == -ERESTARTSYS) {
+		wait_for_completion(x);
 		return t;
+	}
 	return 0;
 }
 EXPORT_SYMBOL(wait_for_completion_interruptible);
@@ -243,8 +245,10 @@ int __sched wait_for_completion_killable(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
 
-	if (t == -ERESTARTSYS)
+	if (t == -ERESTARTSYS) {
+		wait_for_completion(x);
 		return t;
+	}
 	return 0;
 }
 EXPORT_SYMBOL(wait_for_completion_killable);
@@ -253,8 +257,10 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
 
-	if (t == -ERESTARTSYS)
+	if (t == -ERESTARTSYS) {
+		wait_for_completion(x);
 		return t;
+	}
 	return 0;
 }
 EXPORT_SYMBOL(wait_for_completion_state);
