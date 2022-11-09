Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91501623125
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiKIRMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKIRM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:12:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC117882
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D319361B97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC3EC433D6;
        Wed,  9 Nov 2022 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668013948;
        bh=3vd49ukae8zqaQGFhhI5nKYPSFH2xOZx47twfXi5kN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrUA3vAVX1cqpe0NlU3gcWXwLZPtJNqcBfXircUxx/pZ2V2iyiFaIkN+NP/UlPdso
         y1yAYg1NH2zmDhzTHaI7mFFVnvQ8FH1xmEiD1obxY2Roou/RMMPu06QSrbOBjSOQ7R
         tMuGbLLH5mlFEXot26GhYpacgIOVfcnXMGFHHQfAcNnQr2iGUktjXJuRzngDx6WQ58
         9w0VM0WiJCp/mtsaQFcW3jNrwz7VNmHO8NxdO392VVt7woKpflZFvtSt9jlIIG0dUn
         BAEdAA/IbZj/BFCeBA8iqE2INQokntTw+tZt8OoRwmt1ZRKfMmmAnKNZTFqMQOmygm
         9Ot5+4O9Y+BrQ==
Date:   Wed, 9 Nov 2022 18:12:25 +0100
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
Message-ID: <20221109171225.GB300561@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
 <20221107220727.GA10939@lothringen>
 <c0afb1-2a23-f595-3e30-bb95c39e8e65@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0afb1-2a23-f595-3e30-bb95c39e8e65@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 05:16:11PM +0100, Anna-Maria Behnsen wrote:
> On Mon, 7 Nov 2022, Frederic Weisbecker wrote:
> > > +		}
> > > +	}
> > > +
> > >  	/* We need to mark both bases in sync */
> > >  	base_local->is_idle = base_global->is_idle = is_idle;
> > 
> > Do we still need to maintain base_global->is_idle ?
> 
> is_idle information is required in trigger_dyntick_cpu(). I made a mistake
> with the hunk in trigger_dyntick_cpu() introduced in this patch. Because
> after this patch, global timers are still enqueued on any CPU because
> crystallball still exists. trigger_dyntick_cpu() is also required for non
> pinned timers. I need to move the hunk of trigger_dyntick_cpu() into the
> last patch of the queue where crystallball is removed during enqueue and
> there update also this line. Then I will drop the update of
> base_global->is_idle in timer_clear_idle() as well.
> 
> Sorry. This went wrong during splitting and folding the queue back and
> forwards...

Sure, no problem, just asked because I wanted to be sure I wasn't missing
something. I suggest waiting for broader testing after the current batch
lands upstream before removing the crystalball :-)

> 
> > (I'm going to do daily reviews on this patch because it's quite dense :)
> 
> Thanks! I try to answer your questions fast. Let me know when you are done
> or when you need an updated version for further review :)

You have at least one week ahead of you, the time for me to recollect my brain
throughout that patch. Indeed no need to repost now, I'll have some more questions
for sure.

I like the design, so I'm merely just chasing correctness issues and things that
might be made clearer.

I'm more afraid of what testing will tell wrt. performance and powersaving but,
fortunately, the world will scale much better than me to do this :)

Thanks!

> 
> Thanks,
> 
> 	Anna-Maria
> 
