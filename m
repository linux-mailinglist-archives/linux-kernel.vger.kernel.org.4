Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EED6280D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiKNNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiKNNJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:09:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010B2AE2D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF3361186
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96728C433C1;
        Mon, 14 Nov 2022 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668431381;
        bh=/7fDZhkdvRbXJMwaZuRKhbTeWaIZox+x02rdxjCpCuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0zBiGwsNcbqrlbWWKnPtPS/7Mv2xnIHCmFDoTD8sAQZvvLfLw+gUmNUUJKt1XrjG
         5P2Abkg7AUAXoDwQPrMt2iwJ/kle8Mamk93o7LEE0iyzprV4PQ7QHiEClG2IkfSZ79
         GTb0iKLmCBNKnJ+Yvmz258jWxOupGB8U1YEKmjSAEgeFZvPoHInb185m9GEg1G4hRM
         RdBYmqRnOnEAxDmh03tm9MWO9pCFQVGg9G1FaKND7EMfXiwJDql90IyJq27l9h4xTq
         OQABqDVa4rMVFo8ycCSG7+vQMIRA34y5CblnsF6UWo0ozf4t8cIF5s+hVOLuskaRdD
         uFMt7odlc25VQ==
Date:   Mon, 14 Nov 2022 14:09:37 +0100
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
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
Message-ID: <20221114130937.GG590078@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-15-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
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
> +	bool walk_done;
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
> +		if (test_bit(0, &evt->ignore))

The bit 0 set/clear/test on that ignore field looks a bit confusing.
Is there any reason why it can't be some plain int/boolean?

Thanks.
