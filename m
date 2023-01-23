Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0B677AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjAWM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjAWM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D67ED5;
        Mon, 23 Jan 2023 04:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0027BB80D6F;
        Mon, 23 Jan 2023 12:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE4CC433EF;
        Mon, 23 Jan 2023 12:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674476782;
        bh=REoMVUQMRQ2NqLzeaiL5wyh/jcsd+1lc+rqBF3lyNhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHsq9/PkpIkw75FgfUuG1EIIdCoJVjwC39dTgrQRU3/1NLhnsJZHSG+zO6YdI5J6J
         2R3NtqhZBQFcQux1h/PCdWFkEcR7U4DBQZzwKuhA2ifHp2TUi+zJZp4VqO29Wvg6cN
         CyWlyusH99nGl0q8d82hvSaFo22bTWXVMFW8KY3ewVdbiOGWQtJspAeTXmr9IvkXGx
         HBObGWRU+KXeCE6+56CsCcSwCpt2ULoWSwvLvo25xnaUwUkA5QHwJClRaB6tE07zNp
         1cIt/k3PJl9leiuJe33HEalzElpZDu7WnTmDtekmK3XbZWy/RYQAn4kgItXePvM4x/
         TLU5aEbLTqbpw==
Date:   Mon, 23 Jan 2023 13:26:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v3] rcu: Further comment and explain the state space of GP
 sequences
Message-ID: <Y85868Pei9VutSiW@lothringen>
References: <20230119141134.686626-1-frederic@kernel.org>
 <Y8lQjKKDd0G2zt3F@lothringen>
 <CAEXW_YRhYHZRudo5ano+K4-k54Ts+y2_npcXJNaT28SPCmqNnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRhYHZRudo5ano+K4-k54Ts+y2_npcXJNaT28SPCmqNnw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 05:06:27PM +0000, Joel Fernandes wrote:
> On Thu, Jan 19, 2023 at 2:15 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
> > > The state space of the GP sequence number isn't documented and the
> > > definitions of its special values are scattered. Try to gather some
> > > common knowledge near the GP seq headers.
> > >
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 115616ac3bfa..fb95de039596 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -14,6 +14,39 @@
> > >
> > >  /*
> > >   * Grace-period counter management.
> > > + *
> > > + * The two lowest significant bits gather the control flags.
> > > + * The higher bits form the RCU sequence counter.
> > > + *
> > > + * About the control flags, a common value of 0 means that no GP is in progress.
> > > + * A value of 1 means that a grace period has started and is in progress. When
> > > + * the grace period completes, the control flags are reset to 0 and the sequence
> > > + * counter is incremented.
> > > + *
> > > + * However some specific RCU usages make use of custom values.
> > > + *
> > > + * SRCU special control values:
> > > + *
> > > + *   SRCU_SNP_INIT_SEQ       :       Invalid/init value set when SRCU node
> > > + *                                                   is initialized.
> > > + *
> > > + *   SRCU_STATE_IDLE         :       No SRCU gp is in progress
> > > + *
> > > + *   SRCU_STATE_SCAN1        :       State set by rcu_seq_start(). Indicates
> > > + *                                                           we are scanning the inactive readers
> > > + *                                                           index.
> 
> The term "inactive reader" is confusing. The readers can very much be
> active during scans. During a scan stage, there might be a reader on
> any of the 2 indexes that can be right in the middle of their critical
> section (and we don't know which index because they could have got
> preempted, right after sampling idx). Maybe "inactive slot" is a
> better term? And define "inactive slot" as the slot which is no longer
> going to be sampled by new readers.

That's why I used "inactive readers index".
I guess I should have written "inactive readers' index" to disambiguate
the fact that inactive refers to "index" and not "readers" but I almost
never observe plural genitive written that way these days.

As for the gory details of "inactive" being actually "bound to become
inactive", I'm not sure that belongs here but here is what I can do:

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Thu, 19 Jan 2023 14:29:34 +0100
Subject: [PATCH] rcu: Further comment and explain the state space of GP
 sequences

The state space of the GP sequence number isn't documented and the
definitions of its special values are scattered. Try to gather some
common knowledge near the GP seq headers.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 115616ac3bfa..5be983598b5a 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -14,6 +14,43 @@
 
 /*
  * Grace-period counter management.
+ *
+ * The two lowest significant bits gather the control flags.
+ * The higher bits form the RCU sequence counter.
+ *
+ * About the control flags, a common value of 0 means that no GP is in progress.
+ * A value of 1 means that a grace period has started and is in progress. When
+ * the grace period completes, the control flags are reset to 0 and the sequence
+ * counter is incremented.
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
+ *					defined as inactive (though there might
+ *					be pending readers there but their number
+ *					is bound).
+ *
+ *	SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
+ *					Indicates we are flipping the readers
+ *					index and then scanning the readers on the
+ *					slot newly set as inactive (again there
+ *					might remain a bound amount of pending
+ *					readers there).
+ *
+ * RCU polled GP special control value:
+ *
+ *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
+ *					has completed. It's an absolute value
+ *					covering both the state and the counter of
+ *					the GP sequence.
  */
 
 #define RCU_SEQ_CTR_SHIFT	2
-- 
2.34.1

