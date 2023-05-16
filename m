Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A6704E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjEPMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjEPMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:50:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7845B98
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:50:12 -0700 (PDT)
Date:   Tue, 16 May 2023 14:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684241410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCUAXEAsz8309DJ9AGeQPUzpXuEWHVO6qRyqAWRVdGI=;
        b=QwW4zij8tFKvA6c/0M7cutc/kQAnHfjX3rN4w6viZLaf8nLbCJ1lAeX8tiTktLdLQW4uRk
        RvBzmK7gmYeVMm2lxS+KU0x8oOHoVC8Lor0oT64hb2aj4LapU0jOqA4I6AavOOjwYypXK+
        s4PZoXXpilqtxWjEsoasyYVnNwxcbiTRl0bHiQk/GsXeDd+iQpgtNcXyWrwLNijWvceQp6
        zZ80kqsKd/g2Erb/INHI7y6V451PsVqHZlPDCkco4UMN2AuRcbYbnoFmKgayFKNRMNF7A9
        dAX7BJwz1hjpUDjSbM8OkCPwty9W3ZulqiSwBOi21gyloPxshSEf4ln8jU0sNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684241410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCUAXEAsz8309DJ9AGeQPUzpXuEWHVO6qRyqAWRVdGI=;
        b=FIajb0NAwUZMWmkU1adZPzUriJP4OwIH4AKExWtzhCY/SjU/RnupMeSqqe+cPMeCfvXl8F
        KepY6KNA6OHwxfDw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Sebastian Siewior <bigeasy@linutronix.de>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
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
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
In-Reply-To: <20230515124133.XkKOksjW@linutronix.de>
Message-ID: <52a33c96-70ff-e670-acdf-7fc9b25884d7@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de> <20230510072817.116056-20-anna-maria@linutronix.de> <ZFty1fNMlnuLk4qF@localhost.localdomain> <20230515101936.3amAvw0T@linutronix.de> <398d7731-f5ca-a34-9e4-77da60c49d21@linutronix.de>
 <20230515124133.XkKOksjW@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-901538274-1684241410=:21271"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-901538274-1684241410=:21271
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 15 May 2023, Sebastian Siewior wrote:

> On 2023-05-15 12:50:25 [+0200], Anna-Maria Behnsen wrote:
> > The part will be replaced by:
> > 
> > ---8<----
> > 
> > 	local_irq_disable();
> > 	timer_lock_remote_bases(cpu);
> 
> Do you s/raw_spin_lock_irq/raw_spin_lock/ in timer_lock_remote_bases()?
> Otherwise you disable interrupts twice. Not wrong but not needed.

Yes, I do so. And I also drop the return value and take the locks
unconditianlly.

> > 	raw_spin_lock(&tmc->lock);
> > 
> > 	if (!tmc->online || !tmc->idle) {
> > 		timer_unlock_remote_bases(cpu);
> > 		goto unlock;
> > 	} else {
> > 	        fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
> > 	}
> > 
> > 	timer_unlock_remote_bases(cpu);
> 
> The locking, unlocking and fetch_next_timer_interrupt_remote() is only
> used here. So it if it wouldn't be for tmc-> then you could do
> everything timer.c in once place…

I thought about it, but then the logic has to be moved to timer.c but it is
timer_migration related code... I would like to keep the logic here in
timer_migration code... will send a v7 soon.

Thanks,

	Anna-Maria

--8323329-901538274-1684241410=:21271--
