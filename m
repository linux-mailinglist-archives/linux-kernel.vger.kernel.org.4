Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3136C35AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjCUP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCUP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:29:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5AD5071E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y06UdutCPF8SYEOB9/jbHAuCbNFJmTTbP30R7prcIrM=; b=D8YFl7Ir6dqWLRHCGG0PAR1T3m
        SinvADq3UwGC1L+L314A5V3v8kVfUbLq6mS9CoMaiq2PD1S78+lT+ZQvu7v0RCXe5/4/zKzvQYVgR
        QCJZJ4C9Ehvk6m4q6WLZ9C+s9QDvNdP0vBd8cNy3qBkzRRHgUYWDGDjBsTuimX1tUeCiNQS3mNI8c
        EYupdWMi2oRjUWun2BjXESB0DHlfRF1fCtBZZwAuFCKd1dp9bOvDjGwwMQngi8g1QW9R8ExhbPW8T
        GNuNlEaWaYgq5LT/PZ/fFsgHUMCdR0BIm5hcroix0xn0/rQ6fv0FghCadRbS8KxT4M0mufP1MvGbp
        8tT9QFLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pedv2-0029Os-S3; Tue, 21 Mar 2023 15:29:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C0BF30006D;
        Tue, 21 Mar 2023 16:29:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 257E5240D2A03; Tue, 21 Mar 2023 16:29:00 +0100 (CET)
Date:   Tue, 21 Mar 2023 16:29:00 +0100
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
Message-ID: <20230321152900.GA2272870@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> +static bool tmigr_active_up(struct tmigr_group *group,
> +			    struct tmigr_group *child,
> +			    void *ptr)
> +{
> +	union tmigr_state curstate, newstate;
> +	struct tmigr_walk *data = ptr;
> +	bool walk_done;
> +	u32 childmask;
> +
> +	childmask = data->childmask;
> +	newstate = curstate = data->groupstate;
> +
> +retry:
> +	walk_done = true;
> +
> +	if (newstate.migrator == TMIGR_NONE) {
> +		newstate.migrator = (u8)childmask;
> +
> +		/* Changes need to be propagated */
> +		walk_done = false;
> +	}
> +
> +	newstate.active |= (u8)childmask;
> +
> +	newstate.seq++;
> +
> +	if (atomic_cmpxchg(group->migr_state, curstate.state, newstate.state) != curstate.state) {
> +		newstate.state = curstate.state = atomic_read(group->migr_state);
> +		goto retry;
> +	}

	if (!atomic_try_cmpxchg(group->migr_state, &curstate.state, newstate.state)) {
		newstate.state = curstate.state;
		goto retry;
	}

> +
> +	if (group->parent && (walk_done == false)) {
> +		data->groupstate.state = atomic_read(group->parent->migr_state);
> +		data->childmask = group->childmask;
> +	}
> +
> +	/*
> +	 * Group is active, event will be ignored - bit is updated without
> +	 * holding the lock. In case bit is set while another CPU already
> +	 * handles remote events, nothing happens, because it is clear that
> +	 * CPU became active just in this moment, or in worst case event is
> +	 * handled remote. Nothing to worry about.
> +	 */
> +	group->groupevt.ignore = 1;
> +
> +	return walk_done;
> +}
