Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8D6E49E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDQN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjDQN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF905B9D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90A261B0B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01A4C433D2;
        Mon, 17 Apr 2023 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681738114;
        bh=QJ4rjxKkBe8PUyiMdUG5GutRvF2pBSJePJa+Im1ckzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAu84oc//dlmsniw847BFhIEEEujk6e5G91qY13ZuR4iQDOZCBD0J/MidE232Dx39
         wXU6mhFFytYb+tlAoQrwr7IEQDD59jbyrJOnq6eo1EA4M5r1bN/CzA6vLR2iAkkAge
         APzPO/YXCIRhtSN5wj3k7P3YXrIl3O08Mi1qjcATIuTXX1fNq4W6QjsPbcx79S2qEG
         9oJYBHeKZ0V1du3J+hm9zBqPqhhWLDTPTUS0WrxRa4TwlEAeYkw1Es2eGHBTtBkQ7N
         5w5pS8waC4sARXYysFs71Y2TVtgwR1j9nYoSaTICbQDwqqt9pAcvgpOh6C0jw5nm0t
         rsdvHqS7sU6cw==
Date:   Mon, 17 Apr 2023 15:28:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZD1Jfr7TGq/4gabB@localhost.localdomain>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfd0yi4g.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Apr 15, 2023 at 11:01:51PM +0200, Thomas Gleixner a écrit :
> > * CPU 1 stop its tick, next event is in one hour. It calls
> >   tick_broadcast_enter() and goes to sleep.
> 
> So there is already a broadcast device installed, right?

Yes

> 
> > * CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
> >   (note it's not yet actually programmed in the tick device)
> > * CPU 1 call tick_broadcast_exit().
> > * CPU 0 registers new broadcast device and sets CPU 1 in tick_broadcast_oneshot_mask
> 
> This lacks an explanation why CPU0 sets CPU1 in that mask. It does not
> _set_ it explicitely, only implicitely by ORing the periodic broadcast
> cpumask over.
> 
> Now the question is why is CPU1 set in the periodic broadcast mask when
> the CPU already switched over to NOHZ mode?
> 
> That needs to be explained too.

I probably got confused with that tick_broadcast_mask, so it's only set for
periodic broadcast? Should it be renamed to tick_periodic_broadcast_mask to
disambiguate my eternal confusion?

> 
> > * CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
> >   is in one hour (because the recently enqueued timer for CPU 1 hasn't been programmed
> >   yet), so it programs the broadcast to that 1 hour deadline.
> > * CPU 1 runs tick_nohz_idle_stop_tick() which eventually writes and program
> >   dev->next_event to next jiffy
> > * CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
> >   the CPU is already in tick_broadcast_oneshot_mask, so the dev->next_event
> >   change isn't propagated to broadcast.
> > * CPU 1 goes to sleep for 1 hour.
> 
> Also please use tabular style to explain the parallel events as
> explained in the documentation.

Yeah my bad I asked Victor to integrate that scenario that popped out
of me misunderstanding that code. Not even mentioning the form.

Now to review your proposal.

Thanks.
