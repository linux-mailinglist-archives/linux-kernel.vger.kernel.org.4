Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12C36C634D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCWJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjCWJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:23:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2640B35B5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5dWilORB0zLMtzSdBMtj12Lj1FQDInyA7EOQ2cLKIE=; b=LRdCCtHv+zxfyv2WnNxm2MUSAa
        Pi625yi0vG0rRrTGy1ip6pfsbbcZ1As44PCZpYwaJx//MaZoOlhskqe8Pjfj+yfFDckZa/gEqCVM4
        sRRmunH56ztHlnudN6b5za5WTvFWqvq0GFLSorjl4QXH0UaXinQAIH6wLLRcgCZUtL0ocNSmy1HRf
        EfTpIEHaj/RaMsy0udp6wXdkcS4y+QdV35zEMdnJ92pNVn0V2opYVzv4XoMzvgDwZxxs8lU7YtZoU
        jAaW/BFWSZ+0MYwOQmjJpuk7RVWg66Zh7Wghh/E2bE1HZooRBIIn1HlxcLSvegj+snTTcIg4g5ZM6
        qw2nhWDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfH9R-004p44-0S;
        Thu, 23 Mar 2023 09:22:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 106BB300237;
        Thu, 23 Mar 2023 10:22:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8CA920218DB0; Thu, 23 Mar 2023 10:22:21 +0100 (CET)
Date:   Thu, 23 Mar 2023 10:22:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <20230323092221.GA2508414@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(since the code is structured such, I also wrote the comments bottom-up)

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:

> +static struct tmigr_group *tmigr_get_group(unsigned int cpu, unsigned int node,
> +					   unsigned int lvl)
> +{
> +	struct tmigr_group *tmp, *group = NULL;
> +	bool first_loop = true;
> +	atomic_t *migr_state;

When first reading this I was wondering what was protecting the lists;
since this is at least 2 deep from where you take the lock. Perhaps add:

	lockdep_assert_held(&tmigr_mutex);

to clarify the locking context.

> +
> +reloop:
> +	/* Try to attach to an exisiting group first */
> +	list_for_each_entry(tmp, &tmigr_level_list[lvl], list) {
> +		/*
> +		 * If @lvl is below the cross numa node level, check whether
> +		 * this group belongs to the same numa node.
> +		 */
> +		if (lvl < tmigr_crossnode_level && tmp->numa_node != node)
> +			continue;
> +
> +		/* Capacity left? */
> +		if (tmp->num_childs >= TMIGR_CHILDS_PER_GROUP)
> +			continue;
> +
> +		/*
> +		 * If this is the lowest level of the hierarchy, make sure
> +		 * that thread siblings share a group. It is only executed
> +		 * when siblings exist. ALL groups of lowest level needs to
> +		 * be checked for thread sibling, before thread cpu is
> +		 * added to a random group with capacity. When all groups
> +		 * are checked and no thread sibling was found, reloop of
> +		 * level zero groups is required to get a group with
> +		 * capacity.
> +		 */
> +		if (!lvl && (tmigr_cores_per_group != TMIGR_CHILDS_PER_GROUP)) {
> +			if (first_loop == true && !sibling_in_group(cpu, tmp)) {
> +				continue;
> +			} else if (first_loop == false) {
> +				if (tmp->num_cores >= tmigr_cores_per_group)
> +					continue;
> +				else
> +					tmp->num_cores++;
> +			}
> +		}
> +
> +		group = tmp;
> +		break;
> +	}
> +
> +	if (group) {
> +		return group;
> +	} else if (first_loop == true) {
> +		first_loop = false;
> +		goto reloop;
> +	}
> +
> +	/* Allocate and	set up a new group with corresponding migr_state */
> +	group = kzalloc_node(sizeof(*group), GFP_KERNEL, node);
> +	if (!group)
> +		return ERR_PTR(-ENOMEM);
> +
> +	migr_state = kzalloc_node(sizeof(atomic_t), GFP_KERNEL, node);
> +	if (!migr_state) {
> +		kfree(group);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	tmigr_init_group(group, lvl, node, migr_state);
> +	/* Setup successful. Add it to the hierarchy */
> +	list_add(&group->list, &tmigr_level_list[lvl]);
> +	return group;
> +}
> +
> +static void tmigr_connect_child_parent(struct tmigr_group *child,
> +				       struct tmigr_group *parent)
> +{
> +	union tmigr_state childstate;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&child->lock, flags);

Both callsites are in tmigr_setup_groups(), which must be ran in
preemptible context due to GFP_KERNEL allocations. Please use
raw_spin_lock_irq().

> +	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
> +
> +	child->parent = parent;
> +	child->childmask = BIT(parent->num_childs++);
> +
> +	raw_spin_unlock(&parent->lock);
> +	raw_spin_unlock_irqrestore(&child->lock, flags);
> +
> +	/*
> +	 * To prevent inconsistent states, active childs needs to be active
> +	 * in new parent as well. Inactive childs are already marked
> +	 * inactive in parent group.
> +	 */
> +	childstate.state = atomic_read(child->migr_state);
> +	if (childstate.migrator != TMIGR_NONE) {
> +		struct tmigr_walk data;
> +
> +		data.childmask = child->childmask;
> +		data.groupstate.state = atomic_read(parent->migr_state);
> +
> +		/*
> +		 * There is only one new level per time. When connecting
> +		 * child and parent and set child active when parent is
> +		 * inactive, parent needs to be the upperst
> +		 * level. Otherwise there went something wrong!
> +		 */
> +		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
> +	}
> +}
> +
> +static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
> +{
> +	struct tmigr_group *group, *child, **stack;
> +	int top = 0, err = 0, i = 0;
> +	struct list_head *lvllist;
> +	size_t sz;
> +
> +	sz = sizeof(struct tmigr_group *) * tmigr_hierarchy_levels;
> +	stack = kzalloc(sz, GFP_KERNEL);
> +	if (!stack)
> +		return -ENOMEM;
> +
> +	do {
> +		group = tmigr_get_group(cpu, node, i);
> +		if (IS_ERR(group)) {
> +			err = IS_ERR(group);
> +			break;
> +		}
> +
> +		top = i;
> +		stack[i++] = group;
> +
> +		/*
> +		 * When booting only less CPUs of a system than CPUs are
> +		 * available, not all calculated hierarchy levels are required.
> +		 *
> +		 * The loop is aborted as soon as the highest level, which might
> +		 * be different from tmigr_hierarchy_levels, contains only a
> +		 * single group.
> +		 */
> +		if (group->parent || i == tmigr_hierarchy_levels ||
> +		    (list_empty(&tmigr_level_list[i]) &&
> +		     list_is_singular(&tmigr_level_list[i - 1])))
> +			break;
> +
> +	} while (i < tmigr_hierarchy_levels);
> +
> +	do {
> +		group = stack[--i];
> +
> +		if (err < 0) {
> +			list_del(&group->list);
> +			kfree(group);
> +			continue;
> +		}
> +
> +		DBG_BUG_ON(i != group->level);
> +
> +		/*
> +		 * Update tmc -> group / child -> group connection
> +		 */
> +		if (i == 0) {
> +			struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +			unsigned long flags;
> +
> +			raw_spin_lock_irqsave(&group->lock, flags);

You're holding a mutex, you just did a GFP_KERNEL allocation; there is
no way IRQs are already disabled here, please use raw_spin_lock_irq() to
reduce confusion.

> +
> +			tmc->tmgroup = group;
> +			tmc->childmask = BIT(group->num_childs);
> +
> +			group->cpus[group->num_childs++] = cpu;
> +
> +			raw_spin_unlock_irqrestore(&group->lock, flags);
> +
> +			/* There are no childs that needs to be connected */
> +			continue;
> +		} else {
> +			child = stack[i - 1];
> +			tmigr_connect_child_parent(child, group);
> +		}
> +
> +		/* check if upperst level was newly created */
> +		if (top != i)
> +			continue;
> +
> +		DBG_BUG_ON(top == 0);
> +
> +		lvllist = &tmigr_level_list[top];
> +		if (group->num_childs == 1 && list_is_singular(lvllist)) {
> +			lvllist = &tmigr_level_list[top - 1];
> +			list_for_each_entry(child, lvllist, list) {
> +				if (child->parent)
> +					continue;
> +
> +				tmigr_connect_child_parent(child, group);
> +			}
> +		}
> +	} while (i > 0);
> +
> +	kfree(stack);
> +
> +	return err;
> +}
> +
> +static int tmigr_add_cpu(unsigned int cpu)
> +{
> +	unsigned int node = cpu_to_node(cpu);
> +	int ret;
> +	mutex_lock(&tmigr_mutex);
> +	ret = tmigr_setup_groups(cpu, node);
> +	mutex_unlock(&tmigr_mutex);
> +
> +	return ret;
> +}
> +
> +static int tmigr_cpu_online(unsigned int cpu)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	unsigned long flags;
> +	unsigned int ret;
> +
> +	/* First online attempt? Initialize CPU data */
> +	if (!tmc->tmgroup) {
> +		raw_spin_lock_init(&tmc->lock);
> +
> +		ret = tmigr_add_cpu(cpu);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (tmc->childmask == 0)
> +			return -EINVAL;
> +
> +		timerqueue_init(&tmc->cpuevt.nextevt);
> +		tmc->cpuevt.nextevt.expires = KTIME_MAX;
> +		tmc->cpuevt.ignore = 1;
> +		tmc->cpuevt.cpu = cpu;
> +
> +		tmc->remote = 0;
> +		tmc->idle = 0;
> +		tmc->wakeup = KTIME_MAX;
> +	}
> +	raw_spin_lock_irqsave(&tmc->lock, flags);

You just called tmigr_add_cpu() which takes a mutex, there is no
possible way this can be called with IRQs already disabled. Please use
raw_spin_lock_irq() to reduce confusion.

Also, offline below does that and this is just inconsistent.

> +	__tmigr_cpu_activate(tmc);
> +	tmc->online = 1;
> +	raw_spin_unlock_irqrestore(&tmc->lock, flags);
> +	return 0;
> +}
> +
> +static int tmigr_cpu_offline(unsigned int cpu)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	tmc->online = 0;
> +	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
> +	raw_spin_unlock_irq(&tmc->lock);
> +
> +	return 0;
> +}
