Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D173E25E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFZOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFZOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:44:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868EA10E2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:44:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2D6DD211E2;
        Mon, 26 Jun 2023 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687790656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjE5mo/g8PWKT/06H0flzBZRZN1qowN9ixnd893I27M=;
        b=hiNpbD7fKe/Q2KeECWUlgTPDoRf1JL3wcXC8r7kQwxX/H/qC9lNMlPdZjIqWc8C8ASV91A
        BV2NZ38SYt7NuWTKVUlhDOJr6Ms7v0upm6vWI+FR8DoBcPAtGwQEYwslBpTVrJU1Fj4Eog
        WIbuK13bnTCbXnOWyL7DsBFU1zDqZiA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6921C2C141;
        Mon, 26 Jun 2023 14:44:15 +0000 (UTC)
Date:   Mon, 26 Jun 2023 16:44:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <ZJmkPuqpW-wQAyNz@alley>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626081254.XmorFrhs@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-06-26 10:12:54, Sebastian Andrzej Siewior wrote:
> On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
> > Why not to do the same on the end side?
> > 
> >  static inline void do_write_seqcount_end(seqcount_t *s)
> >  {
> > - 	seqcount_release(&s->dep_map, _RET_IP_);
> >  	do_raw_write_seqcount_end(s);
> > +	seqcount_release(&s->dep_map, _RET_IP_);
> >  }
> 
> I don't have a compelling argument for doing it. It is probably better
> to release the lock from lockdep's point of view and then really release
> it (so it can't be acquired before it is released).

If this is true then we should not change the ordering on the _begin
side either. I mean that we should call the lockdep code only
after the lock is taken. Anyway, both sides should be symmetric.

That said, lockdep is about chains of locks and not about timing.
We must not call lockdep annotation when the lock is still available
for a nested context. So the ordering is probably important only when
the lock might be taken from both normal and interrupt context.

Anyway, please do not do this change only because of printk().
IMHO, the current ordering is more logical and the printk() problem
should be solved another way.

Best Regards,
Petr
