Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712073DC72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFZKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFZKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:49:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0381AB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KPR4Pvi5WUrVNlNKwoDKt99z94KfDRPb9X9tpIhV/SQ=; b=GiwgVqpTSY0vY2SKRSak7ePJsG
        8GFfvo/fbOS07buXsdP6E2tCiQ7tsvjwrkbXzX0e6dxmr2Q4GaRKl9TtUwEcq+M1iud7ZnvH2chO3
        m8p5UKwTuFfFq022mZrJvxb3q5IyoogODhhM0Oa3CVNBw2XkIKn/naiH0zfqpu4KzRE0O+gWsxjae
        yP1sZVIg+psw3DoF6n9GlxHS1myaY6L4zeiDxeC1dDJZkf+gYyMIY0ccJHLTMO2EeR/dbZGQz6u71
        A8RPhWQzmqYwYL5ow+CNm2uOXFuoKZNdKzlQwslIG7CfGX9d9vYzNmxnWKghntB17C2QHWy6WVdCM
        KnTbqvZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qDjlp-003xN7-22;
        Mon, 26 Jun 2023 10:48:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30A9E300118;
        Mon, 26 Jun 2023 12:48:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 179312439687E; Mon, 26 Jun 2023 12:48:31 +0200 (CEST)
Date:   Mon, 26 Jun 2023 12:48:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <20230626104831.GT4253@hirez.programming.kicks-ass.net>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:25:56PM +0900, Tetsuo Handa wrote:
> On 2023/06/26 17:12, Sebastian Andrzej Siewior wrote:
> > On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
> >> Why not to do the same on the end side?
> >>
> >>  static inline void do_write_seqcount_end(seqcount_t *s)
> >>  {
> >> - 	seqcount_release(&s->dep_map, _RET_IP_);
> >>  	do_raw_write_seqcount_end(s);
> >> +	seqcount_release(&s->dep_map, _RET_IP_);
> >>  }
> > 
> > I don't have a compelling argument for doing it. It is probably better
> > to release the lock from lockdep's point of view and then really release
> > it (so it can't be acquired before it is released).
> 
> We must do it because this is a source of possible printk() deadlock.
> Otherwise, I will nack on PATCH 2/2.

Don't be like that... just hate on prink like the rest of us. In fact,
i've been patching out the actual printk code for years because its
unusable garbage.

Will this actually still be a problem once all the fancy printk stuff
lands? That shouldn't do synchronous prints except to 'atomic' consoles
by default IIRC.
