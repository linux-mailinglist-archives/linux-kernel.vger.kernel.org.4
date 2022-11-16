Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC6B62BFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKPNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:40:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C01D652
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F322A61DA9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFA2C433C1;
        Wed, 16 Nov 2022 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606049;
        bh=z7L4ZwsP2r0f5F+oDv2xGPaX16u1lFzSpvV90X3HMjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvmUpo5Mfv0YsGRx2tbbam7HKIyguPsH9CTX7t16ZNww2gddTfqf4oVrWSSTzeQyc
         GMw4eX5hhuHfqUiD5cP6RyeSqGbcfu2TK72gKMnsBhsDJVM8mtWOw95A53hnh+HweP
         rFv657FJD+MxPcVPdQ0FniUPmayZWkNuF5M43yAJ9NYtSC6piJpvjlo9yPBeATdzIa
         YWOZkS7CHtxqbp/FC36LQAMogga7ip9Rz6x9kkWNOUDP7jXQ2ku+OFkZOb1pKi2JnI
         A9SFIz6D/e7w/pU0iOWMUrmZP14ovxlizOlDpsf81nPYh1UfANGPzz9/WzN2AsePzB
         +v7NnhpLl4K+g==
Date:   Wed, 16 Nov 2022 14:40:46 +0100
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
Message-ID: <20221116134046.GC816333@lothringen>
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
> +static bool tmigr_handle_remote_up(struct tmigr_group *group,
> +				   struct tmigr_group *child,
> +				   void *ptr)
> +{
> +	struct tmigr_remote_data *data = ptr;
> +	u64 now, next = KTIME_MAX;
> +	unsigned long flags, jif;
> +	struct tmigr_event *evt;
> +	u32 childmask;
> +
> +	jif = data->basej;
> +	now = data->now;
> +
> +	childmask = data->childmask;
> +
> +again:
> +	/*
> +	 * Handle the group only if @childmask is the migrator or if the
> +	 * group has no migrator. Otherwise the group is active and is
> +	 * handled by its own migrator.
> +	 */
> +	if (!tmigr_check_migrator(group, childmask))
> +		return true;
> +
> +	raw_spin_lock_irqsave(&group->lock, flags);
> +
> +	evt = tmigr_next_expired_groupevt(group, now);
> +
> +	if (evt) {
> +		unsigned int remote_cpu;
> +
> +		remote_cpu = READ_ONCE(evt->cpu);

Is that READ_ONCE() really necessary?

Thanks.

> +
> +		raw_spin_unlock_irqrestore(&group->lock, flags);
> +
> +		next = tmigr_handle_remote_cpu(remote_cpu, now, jif);
> +
> +		/* check if there is another event, that needs to be handled */
> +		goto again;
> +	} else {
> +		raw_spin_unlock_irqrestore(&group->lock, flags);
> +	}
> +
> +	/* Update of childmask for next level */
> +	data->childmask = group->childmask;
> +	data->wakeup = next;
> +
> +	return false;
> +}
