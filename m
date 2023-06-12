Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74B72C41F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjFLMaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjFLMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:30:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FA318C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:29:27 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686572966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnIGxyCzH2Bgu9IDHI1uaYgbgALe2T60xMPIq5c3BAk=;
        b=Fj66CTuBwWspLsTZgZy8EDEGpbqEgY6C0fvEyuR/FjGqlZbQzZYJfGtAHxIovsZzKIxD/0
        onZBDiA+U1bFEMksy2sQiky6CBijD5dF8vZZa18CQFoW26NLqxiDy/VQp8SU8WlAQ8fI10
        heGF1fvNanW9B0xNjIMV06CNv8npJMM/cjdGh8towwdaPsx2hxB4l9sSaFLHRGi/PXcBYd
        vdwCGVHTCMjQb35dcU2AaUaIedVJ8zJ+yx5gectp9F2K7+FWkdt/Ix+4Nu6wR6J1lMB8Wr
        cxnhKoj0DYtFuz84PS0QfMiXttm3n2hyEdULUwpmSAsfmbsajVGlEGB625F+YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686572966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnIGxyCzH2Bgu9IDHI1uaYgbgALe2T60xMPIq5c3BAk=;
        b=rGQ9fpGCfd3F9VQ1ROqXyCGjjdHLLXUsQavhX1f5QxSKlxxJIeCdTIa6oD3K1mM+ZMytUm
        9aqGsOCsiGTyU2BA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v7 19/21] timer: Implement the hierarchical pull model
In-Reply-To: <ZICMBw-Fo-nzqGXb@2a01cb0980007dab8d6b2773c13fd2df.ipv6.abo.wanadoo.fr>
Message-ID: <46bb6830-660-f9ff-db1c-f67d680ea8c@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de> <20230524070629.6377-20-anna-maria@linutronix.de> <ZICMBw-Fo-nzqGXb@2a01cb0980007dab8d6b2773c13fd2df.ipv6.abo.wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1942744613-1686572966=:2279"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1942744613-1686572966=:2279
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 7 Jun 2023, Frederic Weisbecker wrote:

> Le Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen a écrit :
> > +/*
> > + * Returns true, if there is nothing to be propagated to the next level
> > + *
> > + * @data->nextexp is reset to KTIME_MAX; it is reused for first global
> > + * event which needs to be handled by migrator (in toplevel group)
> > + *
> > + * This is the only place where group event expiry value is set.
> > + */
> > +static bool tmigr_update_events(struct tmigr_group *group,
> > +				struct tmigr_group *child,
> > +				struct tmigr_walk *data)
> > +{
> > +	struct tmigr_event *evt, *first_childevt;
> > +	bool walk_done, remote = data->remote;
> > +	u64 nextexp;
> > +
> > +	if (child) {
> > +		if (data->childstate.active)
> > +			return true;
> > +
> > +		raw_spin_lock(&child->lock);
> > +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
> > +
> > +		first_childevt = tmigr_next_groupevt(child);
> > +		nextexp = child->next_expiry;
> > +		evt = &child->groupevt;
> > +	} else {
> > +		nextexp = data->nextexp;
> > +
> > +		/*
> > +		 * Set @data->nextexp to KTIME_MAX; it is reused for first
> > +		 * global event which needs to be handled by migrator (in
> > +		 * toplevel group)
> > +		 */
> > +		data->nextexp = KTIME_MAX;
> > +
> > +		first_childevt = evt = data->evt;
> > +
> > +		/*
> > +		 * Walking the hierarchy is required in any case, when a
> > +		 * remote expiry was done before.
> 
> You can probably remove that comma because it feels like breaking the condition link.
> 
> > +		 * This ensures to not lost
> 
> lose
> 
> > +		 * already queued events in non active groups (see section
> > +		 * "Required event and timerqueue update after remote
> > +		 * expiry" in documentation at the top).
> > +		 */
> > +		if (evt->ignore && !remote)
> 
> It looks like in the case of !remote, this branch will never end up
> stopping the propagation up because either:
> 
> * We come here from tmigr_inactive_up() which takes care of the propagation.
> 
> or
> 
> * We come here from tmigr_new_timer() and ->ignore can't be set.
> 
> If I'm right, can we add a comment about that so that the poor reviewer
> doesn't stutter on that for too long?
> 

Right. It will never stop the propagation - but the condition could be
fulfilled when call site is tmigr_inactive_up(). My proposal for expanding
the comment is the following:

	/*
	 * Walking the hierarchy is required in any case when a
	 * remote expiry was done before. This ensures to not lose
	 * already queued events in non active groups (see section
	 * "Required event and timerqueue update after remote
	 * expiry" in documentation at the top).
	 *
	 * The two call sites which are executed without a remote expiry
	 * before, are not prevented from propagating changes through
	 * the hierarchy by the return:
	 *  - When entering this path by tmigr_new_timer(), evt->ignore
	 *    is never set.
	 *  - tmigr_inactive_up() takes care of propagation by itself
	 *    and ignores return value. But an immediate return is
	 *    required because nothing has to be done in this level as
	 *    event could be ignored.
	 */

Thanks,

	Anna-Maria

--8323329-1942744613-1686572966=:2279--
