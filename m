Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1282D67832F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjAWRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjAWRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:31:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CE2E0F0;
        Mon, 23 Jan 2023 09:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B608B80E36;
        Mon, 23 Jan 2023 17:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3992DC4339E;
        Mon, 23 Jan 2023 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674495030;
        bh=na43+kxJFeZDWTaymCLPJyagmqUGNcq1m9NBHlw/eKk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=koOgW0jYxtuIr+Cj6t4EWeooZ54aGTZHKLDTUP8GXPrOmO1SJQjASSZTuMEVvp9hm
         OBycYItRndnDCia4fTOwcZc7rHEXSPxx5T5gXAVgBIsli6+0wlBnfDSJUsmH81eFm7
         rjbWsZgv7hh7MM+4E4V1jNouFsCLtHW81hs9zoSzy7A1soTBkO+IdKE0VHJoDWf1uQ
         cot+27iDhMs57dtMUF7G6OrcT7/nhMeJoflskf7UDtQHZamJlyisleJFrTCu80Gr8A
         UlkvHX1cZgqjT/eB82mmzvhOeg1K62P7j1e3s3jFV8dHx1lcKvHq3oiCmAlkBC1sHC
         m4243kT9MD/IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C17125C084D; Mon, 23 Jan 2023 09:30:29 -0800 (PST)
Date:   Mon, 23 Jan 2023 09:30:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v3] rcu: Further comment and explain the state space of
 GP sequences
Message-ID: <20230123173029.GS2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y85868Pei9VutSiW@lothringen>
 <A6B13595-00FE-4DF4-A5DC-0B54DD0C4E80@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A6B13595-00FE-4DF4-A5DC-0B54DD0C4E80@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:07:43AM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 23, 2023, at 7:26 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > ﻿On Thu, Jan 19, 2023 at 05:06:27PM +0000, Joel Fernandes wrote:
> >>> On Thu, Jan 19, 2023 at 2:15 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >>> 
> >>> On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
> >>>> The state space of the GP sequence number isn't documented and the
> >>>> definitions of its special values are scattered. Try to gather some
> >>>> common knowledge near the GP seq headers.
> >>>> 
> >>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >>>> ---
> >>>> kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
> >>>> 1 file changed, 33 insertions(+)
> >>>> 
> >>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >>>> index 115616ac3bfa..fb95de039596 100644
> >>>> --- a/kernel/rcu/rcu.h
> >>>> +++ b/kernel/rcu/rcu.h
> >>>> @@ -14,6 +14,39 @@
> >>>> 
> >>>> /*
> >>>>  * Grace-period counter management.
> >>>> + *
> >>>> + * The two lowest significant bits gather the control flags.
> >>>> + * The higher bits form the RCU sequence counter.
> >>>> + *
> >>>> + * About the control flags, a common value of 0 means that no GP is in progress.
> >>>> + * A value of 1 means that a grace period has started and is in progress. When
> >>>> + * the grace period completes, the control flags are reset to 0 and the sequence
> >>>> + * counter is incremented.
> >>>> + *
> >>>> + * However some specific RCU usages make use of custom values.
> >>>> + *
> >>>> + * SRCU special control values:
> >>>> + *
> >>>> + *   SRCU_SNP_INIT_SEQ       :       Invalid/init value set when SRCU node
> >>>> + *                                                   is initialized.
> >>>> + *
> >>>> + *   SRCU_STATE_IDLE         :       No SRCU gp is in progress
> >>>> + *
> >>>> + *   SRCU_STATE_SCAN1        :       State set by rcu_seq_start(). Indicates
> >>>> + *                                                           we are scanning the inactive readers
> >>>> + *                                                           index.
> >> 
> >> The term "inactive reader" is confusing. The readers can very much be
> >> active during scans. During a scan stage, there might be a reader on
> >> any of the 2 indexes that can be right in the middle of their critical
> >> section (and we don't know which index because they could have got
> >> preempted, right after sampling idx). Maybe "inactive slot" is a
> >> better term? And define "inactive slot" as the slot which is no longer
> >> going to be sampled by new readers.
> > 
> > That's why I used "inactive readers index".
> > I guess I should have written "inactive readers' index" to disambiguate
> > the fact that inactive refers to "index" and not "readers" but I almost
> > never observe plural genitive written that way these days.
> > 
> > As for the gory details of "inactive" being actually "bound to become
> > inactive", I'm not sure that belongs here but here is what I can do:
> 
> Sounds good and the below change looks good to me.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you both!

I queued the following wordsmithed version, so please let me know if I
messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit f31701817185b58a6095b74180d1a5b05369f3c3
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Thu Jan 19 14:29:34 2023 +0100

    rcu: Further comment and explain the state space of GP sequences
    
    The state space of the GP sequence number isn't documented and the
    definitions of its special values are scattered.  This commit therefore
    gathers some common knowledge near the grace-period sequence-number
    definitions.
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 115616ac3bfa6..a3adcf9a9919b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -14,6 +14,43 @@
 
 /*
  * Grace-period counter management.
+ *
+ * The two least significant bits contain the control flags.
+ * The most significant bits contain the grace-period sequence counter.
+ *
+ * When both control flags are zero, no grace period is in progress.
+ * When either bit is non-zero, a grace period has started and is in
+ * progress. When the grace period completes, the control flags are reset
+ * to 0 and the grace-period sequence counter is incremented.
+ *
+ * However some specific RCU usages make use of custom values.
+ *
+ * SRCU special control values:
+ *
+ *	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
+ *					is initialized.
+ *
+ *	SRCU_STATE_IDLE		:	No SRCU gp is in progress
+ *
+ *	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
+ *					we are scanning the readers on the slot
+ *					defined as inactive (there might well
+ *					be pending readers that will use that
+ *					index, but their number is bounded).
+ *
+ *	SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
+ *					Indicates we are flipping the readers
+ *					index and then scanning the readers on the
+ *					slot newly designated as inactive (again,
+ *					the number of pending readers that will use
+ *					this inactive index is bounded).
+ *
+ * RCU polled GP special control value:
+ *
+ *	RCU_GET_STATE_COMPLETED :	State value indicating an already-completed
+ *					polled GP has completed.  This value covers
+ *					both the state and the counter of the
+ *					grace-period sequence number.
  */
 
 #define RCU_SEQ_CTR_SHIFT	2
