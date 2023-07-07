Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA96374B500
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGGQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGGQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9E1FC6;
        Fri,  7 Jul 2023 09:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80CD619F4;
        Fri,  7 Jul 2023 16:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA0C433C7;
        Fri,  7 Jul 2023 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688746566;
        bh=Psq+MWPRLnkbm+5dY5Hpkk/UK5icgJossc/0TJsSnLg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gQYRsgmqESxIcuTv+Q8bgKan4bnssSc8tcAaoftDFJhh6+wlsDlJjSc670AOesF7U
         NQA8mR7o5wFG51rwXXaI84Lyrrli6XM8WSj5CMGD6OOsZwrkG5ijDremST4LecrNwY
         mNG9n2vI/LBOf/Hscu2P0ANiOw/8XGZv3rfw6Snkj3mK5K9hED8lqKczRJHZxJugeH
         DEen0kpwWuD5OHrZnDN2MxBhWamG9Spt/Wnev0G0AsOp9M0kmBcCEXA7+fvx1n5yCi
         esBPATBCay7GhW6jI4OLkIvbGe8DzlOAN4mC2fJ7aZcLVWwwl4X0vSrx1eTAEdvX51
         GBckUNHL0BBKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AEC9CCE0073; Fri,  7 Jul 2023 09:16:05 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:16:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Message-ID: <8b827d44-b19b-4eb2-8860-f419cc61084e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230707000117.2371697-1-longman@redhat.com>
 <y5g37s3yhsqtmdoqziwnsd4kxtudlpqwv2iunt372abpmdzrry@43e54c374j4s>
 <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 10:56:51AM -0400, Waiman Long wrote:
> On 7/7/23 10:07, Davidlohr Bueso wrote:
> > On Thu, 06 Jul 2023, Waiman Long wrote:
> > 
> > > It was found that running the refscale test might sometimes crash the
> > > kernel with the following error:
> > > 
> > > [ 8569.952896] BUG: unable to handle page fault for address:
> > > ffffffffffffffe8
> > > [ 8569.952900] #PF: supervisor read access in kernel mode
> > > [ 8569.952902] #PF: error_code(0x0000) - not-present page
> > > [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
> > > [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
> > > [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS
> > > 1.2.4 05/28/2021
> > > [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
> > >  :
> > > [ 8569.952940] Call Trace:
> > > [ 8569.952941]  <TASK>
> > > [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
> > > [ 8569.952959]  kthread+0x10e/0x130
> > > [ 8569.952966]  ret_from_fork+0x1f/0x30
> > > [ 8569.952973]  </TASK>
> > > 
> > > This is likely caused by the fact that init_waitqueue_head() is called
> > > after the ref_scale_reader kthread is created. So the kthread may try
> > > to use the waitqueue head before it is properly initialized. Fix this
> > > by initializing the waitqueue head first before kthread creation.
> > > 
> > > Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of
> > > read-side synchronization")
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > 
> > Strange this wasn't reported sooner.
> 
> Red Hat does have a pretty large QE organization that run all sort of tests
> include this one pretty frequently. The race window is pretty small, but
> they did hit this once in a while.

I do run this fairly frequently, but haven't managed to hit it.

Good show on making it happen, and looking forward to the updated patch!

							Thanx, Paul
