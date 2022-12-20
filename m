Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1410B652993
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiLTXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTXF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:05:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBC1EEE9;
        Tue, 20 Dec 2022 15:05:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06CDFB81A52;
        Tue, 20 Dec 2022 23:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33817C433EF;
        Tue, 20 Dec 2022 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671577524;
        bh=rMikaFC2i5Sq8/9qOrsykFHBkwjk4NkB/GCAN55ieQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqNJad/CCU03ruRHzQo7qvBQAg7VQXCk/2vjESpO4UYBvAC/iXKzGWLh/vRm0Ux8R
         hSR/kEOkd1tathgoc2IEVK1sHHkPzNjR7NY90mSVL9P4yRqADXeBmxhEi8VIQDQtuK
         M8cr2Eb8VsHAMlUGWfZh+cUB3s3SHRfroZMYooXxowDvcK4WY3knu7Vfhbb8GGiI0G
         qBfTYan4+wAp5k/44/hzb4E1KorBALZzpL3YKn3ZMTnoJ9D27yFHdsVpEtpV/welb6
         3bYcDX0KKzGDCF8yAUu/lYr/YmwaEyz9Hm4qw+w8NpAHV7PBsS4XR78JWN7GbW6YrW
         qDJBOtt0LRRxw==
Date:   Wed, 21 Dec 2022 00:05:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221220230521.GC26563@lothringen>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <CAEXW_YRFbsCzT9iPdVfmeZ5qK+2fnVAwSzxbj1EXmU+vepOKdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRFbsCzT9iPdVfmeZ5qK+2fnVAwSzxbj1EXmU+vepOKdg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:06:57PM +0000, Joel Fernandes wrote:
> On Tue, Dec 20, 2022 at 7:01 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2022-12-20 13:29, Joel Fernandes wrote:
> > >
> >
> > > I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…
> >
> > I strongly suspect the memory barrier after flip is useless for the same
> > reasons I mentioned explaining why the barrier before the flip is useless.
> >
> > However, we need to double-check that we have memory barriers at the
> > beginning and end of synchronize_srcu, and between load of "unlock"
> > counters and load of "lock" counters.
> >
> > Where is the barrier at the beginning of synchronize_srcu ?
> 
> I believe we don't need another memory barrier at the beginning of
> synchronize_srcu() (but this part of my SRCU study is still pending
> ;)) . The grace period guarantee (read-side critical sections don't
> span the GP) is already enforced by the memory barrier between
> scanning for all unlocks, and scanning for all locks (Paired with
> corresponding memory barriers on the read-side).
> 
> Accordingly, before we scan all locks and match lock == unlock, there
> is an smp_mb(). Why is that not sufficient?

That's not enough, you still need a barrier between the updater's pre-GP
accesses and the scans, so that post-GP read side sees the updater's pre-GP
accesses:


            UPDATER                        READER
            -------                        ------
            WRITE A                        WRITE srcu_read_lock
            smp_mb() //rcu_seq_snap()      smp_mb()
            READ srcu_read_lock //scans    READ A

Thanks.

> 
> Thanks,
> 
>  - Joel
> 
> >
> > Thanks,
> >
> > Mathieu
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
> >
