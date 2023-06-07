Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDD7261B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjFGNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbjFGNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E61BE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8B76355A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7600BC433EF;
        Wed,  7 Jun 2023 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146059;
        bh=zswSACji8RucS+gLsRYsZAQhO7DmmuDGAXs5cJ/+r0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unJaYyJzP5C9G+j3dSb22t9MnD5IWPELBmqG5p9iDgY8dPw1HKGyzNLLV7b4p5MiM
         eniJ18tfmBu+GFEnzpJw1lV0dbHr4rIjkwbGWra59U6Vwo6fjDJQ4bt9Y0VamETjHU
         DO2m1yahmmH6dte0jnCYEeciXxe3rtqrOc9nA+ra7A98invZdx3hlL8/uHmardppK3
         7H9zzEvhNu0/ub/j3r/Og6LW2FidZvlucPNEfYS1DRSWlhdNNumuD7QifLujM0coUC
         62xugHQzdi+Q9G+ERIs4nDq3gHbMAA4RhQZVpgmm/LQeq3M1oYHAa2hN/IQzJsUyoJ
         2SYdrPAFuEEiQ==
Date:   Wed, 7 Jun 2023 15:54:15 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <ZICMBw-Fo-nzqGXb@2a01cb0980007dab8d6b2773c13fd2df.ipv6.abo.wanadoo.fr>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen a écrit :
> +/*
> + * Returns true, if there is nothing to be propagated to the next level
> + *
> + * @data->nextexp is reset to KTIME_MAX; it is reused for first global
> + * event which needs to be handled by migrator (in toplevel group)
> + *
> + * This is the only place where group event expiry value is set.
> + */
> +static bool tmigr_update_events(struct tmigr_group *group,
> +				struct tmigr_group *child,
> +				struct tmigr_walk *data)
> +{
> +	struct tmigr_event *evt, *first_childevt;
> +	bool walk_done, remote = data->remote;
> +	u64 nextexp;
> +
> +	if (child) {
> +		if (data->childstate.active)
> +			return true;
> +
> +		raw_spin_lock(&child->lock);
> +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
> +
> +		first_childevt = tmigr_next_groupevt(child);
> +		nextexp = child->next_expiry;
> +		evt = &child->groupevt;
> +	} else {
> +		nextexp = data->nextexp;
> +
> +		/*
> +		 * Set @data->nextexp to KTIME_MAX; it is reused for first
> +		 * global event which needs to be handled by migrator (in
> +		 * toplevel group)
> +		 */
> +		data->nextexp = KTIME_MAX;
> +
> +		first_childevt = evt = data->evt;
> +
> +		/*
> +		 * Walking the hierarchy is required in any case, when a
> +		 * remote expiry was done before.

You can probably remove that comma because it feels like breaking the condition link.

> +		 * This ensures to not lost

lose

> +		 * already queued events in non active groups (see section
> +		 * "Required event and timerqueue update after remote
> +		 * expiry" in documentation at the top).
> +		 */
> +		if (evt->ignore && !remote)

It looks like in the case of !remote, this branch will never end up
stopping the propagation up because either:

* We come here from tmigr_inactive_up() which takes care of the propagation.

or

* We come here from tmigr_new_timer() and ->ignore can't be set.

If I'm right, can we add a comment about that so that the poor reviewer
doesn't stutter on that for too long?

Thanks.

> +			return true;
