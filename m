Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020969D672
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjBTWpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjBTWpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:45:52 -0500
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [91.218.175.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC11F926
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:45:51 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676933146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GxvQmtp0871QpaVOzrBBe7brCLTkbOtwmjMLiqEahY8=;
        b=hi/r71Q0yNdxGvtOLDKgb5JM5pyT5wFYdCxjKT6oMKNPibgDoNv1x0Vi3fHvb6Ux1BeCdf
        J1VMwQLe2elTvwg75tbSKWB723cK3IE19GH6obTF6p1QvhkRSlrsZhVBSKW9lTzKgRcmw/
        9hXfLu4F/c0rJrtsWPyqaj9bSuJVXbE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: Re: [PATCH 1/2] lockdep: lock_set_lock_cmp_fn()
Message-ID: <Y/P4FrCj7xzOccJ5@moria.home.lan>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
 <20230218032117.2372071-2-kent.overstreet@linux.dev>
 <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 04:09:33PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 17, 2023 at 10:21:16PM -0500, Kent Overstreet wrote:
> 
> > @@ -2982,6 +2989,10 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
> >  	pr_warn("\nbut task is already holding lock:\n");
> >  	print_lock(prev);
> >  
> > +	if (class->cmp_fn)
> > +		pr_warn("and the lock comparison function returns %i:\n",
> > +			class->cmp_fn(prev->instance, next->instance));
> > +
> 
> Please, use {} for any actual multi-line.
> 
> But is this sufficient data to debug a splat? Given an inversion on this
> class, we'll get something like:
> 
>  A
>  A -a
>  A -b
> 
> vs
> 
>  A
>  A c
> 
> which is I suppose sufficient to say that A messed up, but not much
> more. With subclasses we would've gotten
> 
>  A/0
>  A/1
>  A/2
> 
> vs
> 
>  A/2
>  A/0
> 
> which is much simpler to work with. Can we improve on this? Give the
> cmp_fn an additinoal optional argument of a string pointer or so to fill
> out with actual details to be printed?

Yes. This is where printbufs and %pf() would've been really nice, it'll
be doable but ugly with what we have now for string output. We just need
to add another callback, either .lock_print() or .lock_to_text(), and
that can print the information about the lock that's relevant for lock
ordering.

For bcache, that'd be something like

static void btree_lock_to_text()
{
	struct btree *b = container_of()

	seq_buf_printf("l=%u %llu:%llu", b->level, KEY_INODE(), KEY_OFFSET()...)
}
