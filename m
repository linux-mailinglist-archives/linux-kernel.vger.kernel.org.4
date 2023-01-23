Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB9678942
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjAWVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjAWVLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:11:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2ED38029;
        Mon, 23 Jan 2023 13:11:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC64761031;
        Mon, 23 Jan 2023 21:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D7DC433EF;
        Mon, 23 Jan 2023 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674508279;
        bh=BbG3dY26IeajGRUbPvI+8r1NwiIWlgqR9qj+kcxyNFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZXkxIrziRkKSpKhYdGQd4eUy91suEHWBZIbec/D0iB++R0EQkn464fLRV2dA5LcG
         ACDDiTyjkca3l4I0gomy+QuJeJqdgjasLUUdez3sZPzIRCLCFxLPVbtbqrB2dA7Oet
         xWJwXC/XTQtif37sVevOVfH/krVYe3BPbKNrhe1TzbcguirsXHvNPUm7C8EyO4eldt
         DfTonFMfj94LiBIr0EmAIYt5J9ew0kSvMpOx95gpntmyBb1HPrSmHPdOUqR+QFvkA/
         /Pb5oSkNl4BGieyPu/cbxpHhULCmXWaOg75y5LX+OO2SPTEANAWrpmlZCLxxGJ0nng
         dZXMaF1/f/SbQ==
Date:   Mon, 23 Jan 2023 22:11:15 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y873895orjOvPNg9@lothringen>
References: <Y861Xuoa+CrZt9PB@lothringen>
 <375EBA2F-F47A-4BC6-B4D4-2E96D5D15AB6@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <375EBA2F-F47A-4BC6-B4D4-2E96D5D15AB6@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:54:07PM -0500, Joel Fernandes wrote:
> > On Jan 23, 2023, at 11:27 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > ﻿On Mon, Jan 23, 2023 at 10:22:19AM -0500, Joel Fernandes wrote:
> >>> What am I missing?
> >> 
> >> That the acceleration is also done by __note_gp_changes() once the
> >> grace period ends anyway, so if any acceleration was missed as you
> >> say, it will be done anyway.
> >> 
> >> Also it is done by scheduler tick raising softirq:
> >> 
> >> rcu_pending() does this:
> >>        /* Has RCU gone idle with this CPU needing another grace period? */
> >>        if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> >>            !rcu_rdp_is_offloaded(rdp) &&
> >>            !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
> >>                return 1;
> >> 
> >> and rcu_core():
> >>        /* No grace period and unregistered callbacks? */
> >>        if (!rcu_gp_in_progress() &&
> >>            rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
> >>                rcu_nocb_lock_irqsave(rdp, flags);
> >>                if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
> >>                        rcu_accelerate_cbs_unlocked(rnp, rdp);
> >>                rcu_nocb_unlock_irqrestore(rdp, flags);
> >>        }
> >> 
> >> So, I am not sure if you need needacc at all. Those CBs that have not
> >> been assigned grace period numbers will be taken care off :)
> > 
> > But that's only when there is no grace period pending, so it can't happen while
> > we report a QS.
> > 
> > OTOH without the needacc, those callbacks waiting to be accelerated would be
> > eventually processed but only on the next tick following the end of a grace
> > period...if none has started since then. So if someone else starts a new GP
> > before the current CPU, we must wait another GP, etc...
> > 
> > That's potentially dangerous.
> 
> Waiting for just one more GP cannot be dangerous IMO. Anyway there is no
> guarantee that callback will run immediately at end of GP, there may be one or
> more GPs before callback can run, if I remember correctly. That is by
> design.. but please correct me if my understanding is different from yours.

It's not bound to just one GP. If you have N CPUs flooding callbacks for a
long while, your CPU has 1/N chances to be the one starting the next GP on
each turn. Relying on the acceleration to be performed only when no GP is
running may theoretically starve your callbacks forever.

> > And unfortunately we can't do the acceleration from __note_gp_changes() due
> > to lock ordering restrictions: nocb_lock -> rnp_lock
> > 
> 
> Ah. This part I am not sure. Appreciate if point me to any old archive links or documentation detailing that, if possible… 

It's not documented but the code in nocb_gp_wait() or nocb_cb_wait() has that
locking order for example.

Excerpt:

	rcu_nocb_lock_irqsave(rdp, flags);
	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
	}

Thanks.
