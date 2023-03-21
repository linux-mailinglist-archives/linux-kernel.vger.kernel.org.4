Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870E06C32D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCUN0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCUN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2D399E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFAF961BB5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C757FC433D2;
        Tue, 21 Mar 2023 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679405132;
        bh=36gCafQ0q2FLae4qzXnlynZ8Lmbai0sr10DwsOBburY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOjGQjSQKKF1AlhvHmi/D2b9wjzEi+1hPv0LmnLPdjB0DvG++SYb2wyvhkYecX37v
         OjvRBltT6LY+FweSQCvgZmb2rJzdiPDchuja09auQGaQnFLQMmxa/386kKcELfOr2V
         0it/6b7of1yakS0dGYr0lo6cFF7XpptddEiSVXui8mgAs8PQiFW77KQMJHEoDm9ohc
         hbgs9zBAHqNGeR1ZnLMdqJ6M9big0WG0y8zp464V0HWLbHzeWHBers6JrwTwpX8l2i
         e0SDZAD9cohBbTbLIo1N0VL+vAurBO7jPnYdJ2JuP7TbxHH67xPLn06vmGacSPNmcQ
         3/yhcR8noNzGg==
Date:   Tue, 21 Mar 2023 14:25:29 +0100
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
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <ZBmwScbfvq5HGSCJ@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
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

Do you need to propagate the changes even if you found a new migrator for the
group?

> +
> +			if (new_migr_bit != BIT_CNT)
> +				newstate.migrator = BIT(new_migr_bit);
> +			else
> +				newstate.migrator = TMIGR_NONE;

Thanks.
