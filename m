Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A584A620F74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiKHLtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiKHLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:49:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26E18341
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:49:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4844061526
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CB1C43149;
        Tue,  8 Nov 2022 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667908139;
        bh=vFMqkuDTQrAvm8aLbMnpvM5gGDcEzkAz/hQSIKMOu8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwLni6t2eu4OUSpYr57O5sOfDgYOpM4gfyEkC59cZoFVP44/02Jbkba8FIGsKtHM9
         4ZKBDxJ8STRguE9pm7Rb7Cvv7Q9MM/BZmr0b3fchtv+L1OW8qbLvSx3dcZP4rRO8uG
         7Z1TgvTqhsxsisPDPFD/iwpnOqS4Fl32OwGIDn9BwJVydSRyOV/qfNY4RpI9S1Rz/W
         AbZts0JTK54KmJ9V8D4bDz64bw1p7ynu2cMK+wHdF9pgiEg0pS/vZrxzmGuHDANs45
         RqmKG+21bHQvUIBlF7XGM1EigbUhGfmGOV9FDQAl/uLDeBaDA7e1+00LgcinEB8nd/
         AHeU18ntJHl1Q==
Date:   Tue, 8 Nov 2022 12:48:56 +0100
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
Message-ID: <20221108114856.GA22062@lothringen>
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
> +static bool tmigr_inactive_up(struct tmigr_group *group,
> +			      struct tmigr_group *child,
> +			      void *ptr)
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
> +	/* Reset active bit when child is no longer active */
> +	if (!data->childstate.active)
> +		newstate.active &= ~(u8)childmask;
> +
> +	if (newstate.migrator == (u8)childmask) {
> +		/*
> +		 * Find a new migrator for the group, because child group
> +		 * is idle!
> +		 */
> +		if (!data->childstate.active) {
> +			unsigned long new_migr_bit, active = newstate.active;
> +
> +			new_migr_bit = find_first_bit(&active, BIT_CNT);
> +
> +			/* Changes need to be propagated */
> +			walk_done = false;
> +			data->childmask = group->childmask;
> +
> +			if (new_migr_bit != BIT_CNT)
> +				newstate.migrator = BIT(new_migr_bit);
> +			else
> +				newstate.migrator = TMIGR_NONE;
> +		}
> +	}
> +
> +	newstate.seq++;
> +
> +	DBG_BUG_ON((newstate.migrator != TMIGR_NONE) && !(newstate.active));
> +
> +	if (atomic_cmpxchg(group->migr_state, curstate.state, newstate.state) != curstate.state) {
> +		/*
> +		 * Something changed in child/parent group in the meantime,
> +		 * reread the state of child and parent; Update of
> +		 * data->childstate is required for event handling;
> +		 */
> +		if (child)
> +			data->childstate.state = atomic_read(child->migr_state);
> +		newstate.state = curstate.state = atomic_read(group->migr_state);
> +
> +		goto retry;
> +	}
> +
> +	data->groupstate = newstate;
> +
> +	/* Event Handling */
> +	tmigr_update_events(group, child, data);
> +
> +	if (group->parent && (walk_done == false)) {

Nit: it would be slightly clearer if data->childmask were updated here.

> +		data->childstate = newstate;
> +		data->groupstate.state = atomic_read(group->parent->migr_state);

Thanks.
