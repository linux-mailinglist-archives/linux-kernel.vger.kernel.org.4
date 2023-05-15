Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02F702B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbjEOLGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjEOLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:06:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2113E5B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:06:49 -0700 (PDT)
Date:   Mon, 15 May 2023 13:06:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684148807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4WGQKgL1QOTHZvum0YLMXimHkn7yHZ4VAHjesL2FHk=;
        b=CPG2CdN3Qc0RvdLD2ZNbYWzooc5YGgYLjb32C4mU036uszzYQ0sodeTzX40cizaD4oj60/
        dbTfN+v/Q5YW5J8cDlwZmYsua8hUvoZ74B8d/BgFNsAz5Su3KKK/2sb6DXVtLHmiVnLTOb
        mPXI6h5Ck8TT2AiYTMS5S2osy1UFiSSzL4gGhRafZ4DEy1c36QZfeCTVKHgCSwK+NaKdow
        Yo/wxHW2QpdCQ+S55END5WmluNKcz0rK7I8aF41AJ2KZo1Bstnn0be5rB/sQn8Gs+gjqGx
        uju26Mvor3K1CNWQrWPjCFYPSLGA4TUgXp261hRh4jV0JtTQIGnCMHLlP1RbNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684148807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4WGQKgL1QOTHZvum0YLMXimHkn7yHZ4VAHjesL2FHk=;
        b=a3Q4eYH40s0vSlrRQYG3+cG8RWuv+fH4Ss6ukaK2qOBrUBPZqumFaeGaYyJjWWcxHzXWEp
        KtC+Wop8JTC1kRDQ==
From:   Sebastian Siewior <bigeasy@linutronix.de>
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
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <20230515110646.zQCEzB8f@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230510072817.116056-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-10 09:28:15 [+0200], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..accce2b368f4
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> @@ -0,0 +1,1322 @@
=E2=80=A6
> + * 4. Propagating the changes of step 1 through the hierarchy to GRP1:0
> + *
> + *    LVL 1            [GRP1:0]
> + *                  -> migrator =3D GRP0:1
> + *                  -> active   =3D GRP0:1
> + *                   /                \
> + *    LVL 0  [GRP0:0]                  [GRP0:1]
> + *           migrator =3D CPU1           migrator =3D CPU2
> + *           active   =3D CPU1           active   =3D CPU2
> + *              /         \                /         \
> + *    CPUs     0           1              2           3
> + *             idle        active         active      idle
> + *
> + * Now there is a inconsistent overall state because GRP0:0 is active, b=
ut
                   an

> + * it is marked as idle in the GRP1:0. This is prevented by incrementing
> + * sequence counter whenever changing the state.
> + */
> +
> +#ifdef DEBUG
> +# define DBG_BUG_ON(x) BUG_ON(x)
> +#else
> +# define DBG_BUG_ON(x)
> +#endif

I would make them WARN_ON_ONCE() in !DEBUG case or remove it. There is
nothing that sets DEBUG here, right?

=2E
> +static bool tmigr_update_events(struct tmigr_group *group,
=E2=80=A6
> +	if (nextexp =3D=3D KTIME_MAX) {
> +		evt->ignore =3D 1;
> +
> +		/*
> +		 * When next event could be ignored (nextexp is KTIME MAX)
> +		 * and there was no remote timer handling before or the
> +		 * group is already active, there is no need to walk the
> +		 * hierarchy even if there is a parent group.
> +		 *
> +		 * The other way round: even if the event could be ignored,
> +		 * but if a remote timer handling was executed before and
> +		 * the group is not active, walking the hierarchy is
> +		 * required to not miss a enqueued timer in the non active
                                        an

> +		 * group. The enqueued timer needs to be propagated to a
> +		 * higher level to ensure it is handeld.
=E2=80=A6
> +static struct tmigr_group *tmigr_get_group(unsigned int cpu, unsigned in=
t node,
> +					   unsigned int lvl)
> +{
> +	struct tmigr_group *tmp, *group =3D NULL;
> +	bool first_loop =3D true;
> +
> +	lockdep_assert_held(&tmigr_mutex);
> +
> +reloop:
> +	/* Try to attach to an exisiting group first */
> +	list_for_each_entry(tmp, &tmigr_level_list[lvl], list) {
> +		/*
> +		 * If @lvl is below the cross numa node level, check whether
> +		 * this group belongs to the same numa node.
> +		 */
> +		if (lvl < tmigr_crossnode_level && tmp->numa_node !=3D node)
> +			continue;
> +
> +		/* Capacity left? */
> +		if (tmp->num_children >=3D TMIGR_CHILDS_PER_GROUP)
> +			continue;
> +
> +		/*
> +		 * TODO: A possible further improvement: Make sure that all
> +		 * CPU siblings end up in the same group of lowest level of
> +		 * the hierarchy. Rely on topology sibling mask would be a
> +		 * reasonable solution.
> +		 */
> +
> +		group =3D tmp;
> +		break;
> +	}
> +
> +	if (group) {
> +		return group;
> +	} else if (first_loop =3D=3D true) {
> +		first_loop =3D false;

Why do have this? There is no lock drop or anything that could alter the
outcome of the loop iteration or do I miss something that obvious?

> +		goto reloop;
> +	}
> +
> +	/* Allocate and	set up a new group */
> +	group =3D kzalloc_node(sizeof(*group), GFP_KERNEL, node);
> +	if (!group)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tmigr_init_group(group, lvl, node);
> +
> +	/* Setup successful. Add it to the hierarchy */
> +	list_add(&group->list, &tmigr_level_list[lvl]);

Not sure if it makes any difference if the item is added to the front of
the list or the end but be aware that this adds it to the front.

> +	return group;
> +}
=E2=80=A6
> +static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
> +{
> +	struct tmigr_group *group, *child, **stack;
> +	int top =3D 0, err =3D 0, i =3D 0;
> +	struct list_head *lvllist;
> +	size_t sz;
> +
> +	sz =3D sizeof(struct tmigr_group *) * tmigr_hierarchy_levels;
> +	stack =3D kzalloc(sz, GFP_KERNEL);

kcalloc().

> +	if (!stack)
> +		return -ENOMEM;
> +
> +	do {
> +		group =3D tmigr_get_group(cpu, node, i);
> +		if (IS_ERR(group)) {
> +			err =3D IS_ERR(group);

This needs to be
	err =3D PTR_ERR(group);

since now group is either 1 or 0.
_OR_ you err a bool an replace the check later from
	if (err < 0)
with
	if (err)

since you don't actually care about the error code but need to know if
it failed.

> +			break;
> +		}
> +
> +		top =3D i;
> +		stack[i++] =3D group;
> +
> +		/*
> +		 * When booting only less CPUs of a system than CPUs are
> +		 * available, not all calculated hierarchy levels are required.
> +		 *
> +		 * The loop is aborted as soon as the highest level, which might
> +		 * be different from tmigr_hierarchy_levels, contains only a
> +		 * single group.
> +		 */
> +		if (group->parent || i =3D=3D tmigr_hierarchy_levels ||
> +		    (list_empty(&tmigr_level_list[i]) &&
> +		     list_is_singular(&tmigr_level_list[i - 1])))
> +			break;
> +
> +	} while (i < tmigr_hierarchy_levels);
> +
> +	do {
> +		group =3D stack[--i];
> +
> +		if (err < 0) {
> +			list_del(&group->list);
> +			kfree(group);
> +			continue;
> +		}
=E2=80=A6
> +static int __init tmigr_init(void)
> +{
> +	unsigned int cpulvl, nodelvl, cpus_per_node, i;
> +	unsigned int nnodes =3D num_possible_nodes();
> +	unsigned int ncpus =3D num_possible_cpus();
> +	int ret =3D -ENOMEM;
> +	size_t sz;
=E2=80=A6
> +	sz =3D sizeof(struct list_head) * tmigr_hierarchy_levels;
> +	tmigr_level_list =3D kzalloc(sz, GFP_KERNEL);
kcalloc().

=E2=80=A6
> --- /dev/null
> +++ b/kernel/time/timer_migration.h
> @@ -0,0 +1,138 @@
=E2=80=A6
> +struct tmigr_group {
> +	raw_spinlock_t		lock;
> +	atomic_t		migr_state;
> +	struct tmigr_group	*parent;
> +	struct tmigr_event	groupevt;
> +	u64			next_expiry;
> +	struct timerqueue_head	events;
> +	u8			childmask;
> +	unsigned int		level;
> +	struct list_head	list;
> +	unsigned int		numa_node;

numa_node is usually an int (not unsigned).

> +	unsigned int		num_children;
> +};

Sebastian
