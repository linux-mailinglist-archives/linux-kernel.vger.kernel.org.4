Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE975649898
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 06:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiLLFK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 00:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiLLFKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 00:10:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EDB95BD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 21:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=POf9oeSms+bzfikKu+9Cuok+QbFIm3n9v/2ZXifOcIM=; b=WiNnPyERFUgb+q9NKdxdiFtJHB
        QYfvR2Z5jWELG4ZSD7IYBSHM0+PKVrf0t79bCI0wpwkbUnXz9UrevRmpJJbnB6TKdDBGtqNgfYeq4
        s4VUZGVGJ0gzwkTxud/JbbREtMc7oSTErM+76T/rdJ30pvAuS6znZeSOClW3LAHbm3VVFE51SJHpw
        xIqfXH4/+mFcd5Y7s+slcFPLSskHOhjDm05cho57/2CluBIqfbcmosWH2wf7LW4MO2bH8Fq89p39H
        HneXSAmdPhuMFFyp/GvSQwOLONbezUfdqUMAwxXjDfZe8C9mftcUdOph/1EIRuPHBBAM9Or6sKu7U
        wUJtmqUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4b4m-00857G-A5; Mon, 12 Dec 2022 05:10:04 +0000
Date:   Sun, 11 Dec 2022 21:10:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Message-ID: <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zgc2vzwx.fsf@gmail.com>
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

On Mon, Dec 05, 2022 at 07:38:21PM +0800, Schspa Shi wrote:
> 
> Schspa Shi <schspa@gmail.com> writes:
> 
> > When the process is killed, wait_for_completion_state will return with
> > -ERESTARTSYS, and the completion variable in the stack will be freed.

There is no free'ing here, it's just not availabel anymore, which is
different.

> > If the user-mode thread is complete at the same time, there will be a UAF.
> >
> > Please refer to the following scenarios.
> >             T1                                  T2
> > ------------------------------------------------------------------
> > call_usermodehelper_exec
> >                                    call_usermodehelper_exec_async
> >                                    << do something >>
> >                                    umh_complete(sub_info);
> >                                    comp = xchg(&sub_info->complete, NULL);
> >                                    /* we got the completion */
> >                                    << context switch >>
> >
> >     << Being killed >>
> > 	retval = wait_for_completion_state(sub_info->complete, state);
> > 	if (!retval)
> > 		goto wait_done;
> >
> > 	if (wait & UMH_KILLABLE) {
> > 		/* umh_complete() will see NULL and free sub_info */
> > 		if (xchg(&sub_info->complete, NULL))
> > 			goto unlock;
> >         << we can't got the completion >>

I'm sorry I don't understand what you tried to say here, we can't got?

> > 	}
> > 	....
> > unlock:
> > 	helper_unlock();
> > 	return retval;
> > }
> >
> > /**
> >  * the completion variable in stack is end of life cycle.
> >  * and maybe freed due to process is recycled.
> >  */
> >                                    --------UAF here----------
> >                                    if (comp)
> >                                        complete(comp);
> >
> > To fix it, we can put the completion variable in the subprocess_info
> > variable.
> >
> > Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
> > Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
> > Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
> >
> > Signed-off-by: Schspa Shi <schspa@gmail.com>
> > ---
> >  include/linux/umh.h | 1 +
> >  kernel/umh.c        | 6 +++---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/umh.h b/include/linux/umh.h
> > index 5d1f6129b847..801f7efbc825 100644
> > --- a/include/linux/umh.h
> > +++ b/include/linux/umh.h
> > @@ -20,6 +20,7 @@ struct file;
> >  struct subprocess_info {
> >  	struct work_struct work;
> >  	struct completion *complete;
> > +	struct completion done;
> >  	const char *path;
> >  	char **argv;
> >  	char **envp;
> > diff --git a/kernel/umh.c b/kernel/umh.c
> > index 850631518665..3ed39956c777 100644
> > --- a/kernel/umh.c
> > +++ b/kernel/umh.c
> > @@ -380,6 +380,7 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
> >  	sub_info->cleanup = cleanup;
> >  	sub_info->init = init;
> >  	sub_info->data = data;
> > +	init_completion(&sub_info->done);
> >    out:
> >  	return sub_info;
> >  }
> > @@ -405,7 +406,6 @@ EXPORT_SYMBOL(call_usermodehelper_setup);
> >  int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> >  {
> >  	unsigned int state = TASK_UNINTERRUPTIBLE;
> > -	DECLARE_COMPLETION_ONSTACK(done);
> >  	int retval = 0;
> >  
> >  	if (!sub_info->path) {
> > @@ -431,7 +431,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> >  	 * This makes it possible to use umh_complete to free
> >  	 * the data structure in case of UMH_NO_WAIT.
> >  	 */
> > -	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
> > +	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &sub_info->done;
> >  	sub_info->wait = wait;
> >  
> >  	queue_work(system_unbound_wq, &sub_info->work);
> > @@ -444,7 +444,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
> >  	if (wait & UMH_FREEZABLE)
> >  		state |= TASK_FREEZABLE;
> >  
> > -	retval = wait_for_completion_state(&done, state);
> > +	retval = wait_for_completion_state(sub_info->complete, state);
> >  	if (!retval)
> >  		goto wait_done;
> 
> Hi Luis Chamberlain:
> 
> Could you help to review this patch? I'm not sure why we define the
> amount of completion here on the stack. But this UAF can be fixed by
> moving the completion variable to the heap.

It would seem to me that if this is an issue other areas would have
similar races as well, so I was hard pressed about the approach / fix.

Wouldn't something like this be a bit more explicit about ensuring
we don't let the work item race beyond?

diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..55fc698115a7 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -447,6 +447,8 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	retval = wait_for_completion_state(&done, state);
 	if (!retval)
 		goto wait_done;
+	else if (retval == -ERESTARTSYS)
+		cancel_work_sync(&sub_info->work);
 
 	if (wait & UMH_KILLABLE) {
 		/* umh_complete() will see NULL and free sub_info */
