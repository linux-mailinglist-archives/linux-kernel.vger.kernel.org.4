Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A148652927
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLTWpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLTWpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:45:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1DFCD8;
        Tue, 20 Dec 2022 14:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2875B61502;
        Tue, 20 Dec 2022 22:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A1C433D2;
        Tue, 20 Dec 2022 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671576302;
        bh=5IELGNaBxVETUQUabu4l0UoJNA+N6l/vC4jUFz5K578=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqOFxGduPFwaIXvWUGHJrw+Bk/wQyGVrQ0l4gQf8rIfoxKqmrL1D/sarA9sj68/yf
         lPc8SPAW7Bo+qdpY/sx87YZXOZbFabl3LhFDZHYuXRjTESSxCkj0fr9Up8Hc6tLOTT
         6/WRx+Ho5rKdlqW4lCuxT6UEk5qT60vDQDldrnoRgaYGWw07U4beumuYrIblKtIw50
         c+UFdnzctNI2u7AGMyYwK86z9E36O1549IDqlJ/e8xgF+0mzNmLxermsLfBVNPoGcm
         fCD9LJ81qUN3uWBhR6rQOQlkEAWi0CW10s5dRH/bYYbB1lksptFwaebm+wJFhTwI6z
         YUtj1imCiC8Cg==
Date:   Tue, 20 Dec 2022 23:44:59 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221220224459.GA25175@lothringen>
References: <20221220140714.GB22763@lothringen>
 <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:20:08AM -0500, Joel Fernandes wrote:
> > On Dec 20, 2022, at 9:07 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > ﻿On Tue, Dec 20, 2022 at 08:44:40AM -0500, Joel Fernandes wrote:
> >>> C w-depend-r
> >>> 
> >>> {
> >>>   PLOCK=LOCK0;
> >>> }
> >>> 
> >>> // updater
> >>> P0(int *LOCK1, int **PLOCK)
> >>> {
> >>>   int lock1;
> >>> 
> >>>   lock1 = READ_ONCE(*LOCK1); // READ from inactive idx
> >>>   smp_mb();
> >>>   WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
> >>> }
> >>> 
> >>> // reader
> >>> P1(int **PLOCK)
> >>> {
> >>>   int *plock;
> >>> 
> >>>   plock = READ_ONCE(*PLOCK);    // Read active idx
> >>>   WRITE_ONCE(*plock, 1); // Write to active idx
> >> 
> >> I am a bit lost here, why would the reader want to write to the active idx?
> >> The reader does not update the idx, only the lock count.
> > 
> > So &ssp->sda->srcu_lock_count is the base address and idx is the offset, right?
> > The write is then displayed that way:
> > 
> >     this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
> > 
> > But things could be also thought the other way around with idx being the base address and
> > ssp->sda->srcu_lock_count being the offset.
> > 
> >     this_cpu_inc(idx[ssp->sda->srcu_lock_count].counter);
> > 
> > That would require to change some high level types but the result would be the same from
> > the memory point of view (and even from the ASM point of view). In the end we
> > are dealing with the same address and access.
> > 
> > Now ssp->sda->srcu_lock_count is a constant address value. It doesn't change.
> > So it can be zero for example. Then the above increment becomes:
> > 
> >   this_cpu_inc(idx.counter);
> > 
> > And then it can be modelized as in the above litmus test.
> > 
> > I had to play that trick because litmus doesn't support arrays but I believe
> > it stands. Now of course I may well have got something wrong since I've always
> > been terrible at maths...
> 
> Ah ok, I get where you were going with that. Yes there is address dependency
> between reading idx and writing lock count. But IMHO, the access on the update
> side is trying to order write to index, and reads from a lock count of a
> previous index (as far as E / B+C is concerned). So IMHO, on the read side you
> have to consider 2 consecutive readers and not the same reader in order to
> pair the same accesses correctly. But I could be missing something.

And you're right, for the first part of the comment (let's call that (1)):

	 * Ensure that if this updater saw a given reader's increment
	 * from __srcu_read_lock(), that reader was using an old value
	 * of ->srcu_idx.

My litmus test shows the ordering displayed in the second part of the comment
(call it (2)):

         * Also ensure that if a given reader sees the
	 * new value of ->srcu_idx, this updater's earlier scans cannot
	 * have seen that reader's increments (which is OK, because this
	 * grace period need not wait on that reader).

_ In (1), E indeed pairs with B and C
_ In (2), E pairs with the address-dependency between idx and lock_count.

Thanks.
