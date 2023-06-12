Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A534C72C961
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjFLPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbjFLPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46A98
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167E862A7D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A78C433D2;
        Mon, 12 Jun 2023 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686582577;
        bh=yHpwszDJKxvhh9kHKd1+9o1DQKwq7k79zriIO/7dL3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxPuah6k8N0yx3Q5kQY93p9A2tqwz2UdyroBE17TNbrguqM18YC7L/BaOmXdBTqp+
         duqKA0RMS1JJ+fEE32b78LTpqR7SqtMitxZsIfP/ido1kpKEzj6yjWGRRBqWtMcxab
         noIyfNEPXTvu90z9NKBqQZMOzZEU+oKwRnZNUHT6rxZRbxD9kjKctySmb2RobbJqhy
         GoAbrwcojqC6n4BUtlrJpcmmpbKSrvzEe8JXHVoJPUF/76WCK0c2vFIjbcbF9yJD1P
         mrLYpo31GkWhPIEfUGYsJTE1tnUWla48C/eWL59U7gBSNuWoI9beyfSTYLAMXQUaBp
         GhYdF/wkBWYTA==
Date:   Mon, 12 Jun 2023 17:09:33 +0200
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
Message-ID: <ZIc1LX4Dm2HJ70bZ@2a01cb0980221ec3a67fd23915238df5.ipv6.abo.wanadoo.fr>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen a écrit :
> +void tmigr_handle_remote(void)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	struct tmigr_remote_data data;
> +
> +	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online)
> +		return;
> +
> +	/*
> +	 * NOTE: This is a doubled check because migrator test will be done
> +	 * in tmigr_handle_remote_up() anyway. Keep this check to fasten
> +	 * the return when nothing has to be done.
> +	 */
> +	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
> +		return;
> +
> +	data.now = get_jiffies_update(&data.basej);
> +	data.childmask = tmc->childmask;
> +	data.wakeup = KTIME_MAX;
> +
> +	__walk_groups(&tmigr_handle_remote_up, &data, tmc);
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	if (tmc->idle)
> +		tmc->wakeup = data.wakeup;

So this assumes there will be a timer re-eavluation right after
in the idle path but this is not true in the case of nohz_full.

If the softirq happens at the tail of the timer interrupt, you're
good because the dynticks is re-evaluated right after. But if the
softirq happens in ksoftirqd, you'll have no timer re-evaluation.

The crude trick used by nohz_full in order to re-evaluate the dynticks when
a timer is queued from the timer softirq is to launch a self IPI (from
trigger_dyntick_cpu()). Here you would need something like that but
that's not something we wish either.

In fact we don't want any nohz_full CPU to perform an idle migrator job.
And the problem here is that whenever a timer interrupt occurs while
tmc->idle == 1 (and that _might_ happen in nohz_full), it will go up the
hierarchy as long as there is no active migrator on a given level and
check for remote expiry. And if something expired it will not only perform
the remote callbacks handling but also reprogram the next tick to fire in
the next expiry. That's a potential disturbance on a nohz_full CPU.

There is always an active CPU in nohz_full so there is always an active
migrator at least at the top level. Therefore you can spare concurrent
idle migrators if they are nohz_full.

My suggestion is to make tmigr_requires_handle_remote() return 0 if
tick_nohz_full_cpu(smp_processor_id()), so that we don't even bother
raising the softirq. But if the timer softirq happens nevertheless, due
to some local timer to process, also make tmigr_handle_remote() to
return early.

Thanks.
