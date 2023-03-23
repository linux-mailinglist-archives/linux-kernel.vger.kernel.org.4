Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6FE6C68CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjCWMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjCWMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:47:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA12B60C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rdkohc+qDKz5KlFA6ANyv2mPHOxIV2qzyndcrHHq5Sk=; b=jXQC0lE/tnLhoVrjsaPGDYT+dk
        4deMCQrZqGhfFkivNqr6KIO631VH/OmcI5RXJrJB+xEiSrR+FDwq8AZg8PMGJifoNfIaqm2GUhf4T
        /dP/CTqJrPhxxXyE0tTROiSueJsFQJHxNAmUjoxPTHZd1GbUJnsL+KV/G5JZxOcIN0QV86Jrbbqx+
        5CzjqU9rne0icOEMR5+HNckvwVscWsMyk1rltFALGXCZ/Feh+ePB8iObEQScFgI95yzO4w9DHiuN8
        eDm9XLj5tCdN9S0ZL21LvJXmHbBt29TwT4dOBtZgyb4cXCzek1PyNbwT+kUXsLa8ojm/gb72zh8VD
        xl4V4fIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfKLY-003x7V-9c; Thu, 23 Mar 2023 12:47:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DCFB3002FC;
        Thu, 23 Mar 2023 13:47:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 726892420A895; Thu, 23 Mar 2023 13:47:11 +0100 (CET)
Date:   Thu, 23 Mar 2023 13:47:11 +0100
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
Message-ID: <20230323124711.GB2512024@hirez.programming.kicks-ass.net>
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

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:

> +static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
> +			     unsigned int node, atomic_t *migr_state)
> +{
> +	union tmigr_state s;
> +
> +	raw_spin_lock_init(&group->lock);
> +
> +	group->level = lvl;
> +	group->numa_node = lvl < tmigr_crossnode_level ? node : NUMA_NO_NODE;
> +
> +	group->num_childs = 0;
> +
> +	/*
> +	 * num_cores is required for level=0 groups only during setup and
> +	 * when siblings exists but it doesn't matter if this value is set
> +	 * in other groups as well
> +	 */
> +	group->num_cores = 1;
> +
> +	s.migrator = TMIGR_NONE;
> +	s.active = 0;
> +	s.seq = 0;
> +	atomic_set(migr_state, s.state);
> +
> +	group->migr_state = migr_state;
> +
> +	timerqueue_init_head(&group->events);
> +	timerqueue_init(&group->groupevt.nextevt);
> +	group->groupevt.nextevt.expires = KTIME_MAX;
> +	group->next_expiry = KTIME_MAX;
> +	group->groupevt.ignore = 1;
> +}

> +static struct tmigr_group *tmigr_get_group(unsigned int cpu, unsigned int node,
> +					   unsigned int lvl)
> +{
> +	struct tmigr_group *tmp, *group = NULL;
> +	bool first_loop = true;
> +	atomic_t *migr_state;
> +

...

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

I'm confused by migr_state.. why is that allocated seperately, if it is
*always* 1:1 related to the group. Why isn't it a direct member?

> +	/* Setup successful. Add it to the hierarchy */
> +	list_add(&group->list, &tmigr_level_list[lvl]);
> +	return group;
> +}
