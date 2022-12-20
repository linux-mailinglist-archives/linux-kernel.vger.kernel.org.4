Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4B652201
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiLTOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiLTOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:07:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DDCDF95;
        Tue, 20 Dec 2022 06:07:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E87EE61468;
        Tue, 20 Dec 2022 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCE5C433EF;
        Tue, 20 Dec 2022 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545237;
        bh=kjxsA1RKba1sAwK7HkKMsn1Ci5sL+fSF3MvywZYYKxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEBs1w7WNlsh7yDburfMLoIzQ5V2rqciIrYUzki1SZHyoAydD6E0iyjn559MuR0x/
         TIM5Z/KtR0YkQagzYRs2UshkbwS/CCNptGIYNEoDGZlhHLQYEYv9Cl7ZqcHz8NT+Y0
         D+JYfXdrR+LcqxHalVQI73Ow94IS1aIvmFV0qtglqHunk73e7+mz2ln99fEpxaFb6U
         FQRDfCTUVeNdFbIuRlKGQgCrtrecDbjm5sbjb2z0Oo0upnOlJOvCxOV+5JJeKzkIGN
         B9ZfuOGdtCrL8ThvXOHVDTMJCxmIpD9ewWqK18dgb82sotvAkZUjX43q4z+pcTTVGK
         9bwSbkuQxt9MA==
Date:   Tue, 20 Dec 2022 15:07:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221220140714.GB22763@lothringen>
References: <20221220124033.GA22763@lothringen>
 <D358FF0F-6F7C-413A-8CA6-7D36E9A64DB6@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D358FF0F-6F7C-413A-8CA6-7D36E9A64DB6@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:44:40AM -0500, Joel Fernandes wrote:
> > C w-depend-r
> > 
> > {
> >    PLOCK=LOCK0;
> > }
> > 
> > // updater
> > P0(int *LOCK1, int **PLOCK)
> > {
> >    int lock1;
> > 
> >    lock1 = READ_ONCE(*LOCK1); // READ from inactive idx
> >    smp_mb();
> >    WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
> > }
> > 
> > // reader
> > P1(int **PLOCK)
> > {
> >    int *plock;
> > 
> >    plock = READ_ONCE(*PLOCK);    // Read active idx
> >    WRITE_ONCE(*plock, 1); // Write to active idx
> 
> I am a bit lost here, why would the reader want to write to the active idx?
> The reader does not update the idx, only the lock count.

So &ssp->sda->srcu_lock_count is the base address and idx is the offset, right?
The write is then displayed that way:

     this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);

But things could be also thought the other way around with idx being the base address and
ssp->sda->srcu_lock_count being the offset.

     this_cpu_inc(idx[ssp->sda->srcu_lock_count].counter);

That would require to change some high level types but the result would be the same from
the memory point of view (and even from the ASM point of view). In the end we
are dealing with the same address and access.

Now ssp->sda->srcu_lock_count is a constant address value. It doesn't change.
So it can be zero for example. Then the above increment becomes:

   this_cpu_inc(idx.counter);

And then it can be modelized as in the above litmus test.

I had to play that trick because litmus doesn't support arrays but I believe
it stands. Now of course I may well have got something wrong since I've always
been terrible at maths...

> 
> Further, the comment does not talk about implicit memory ordering, it’s talking about explicit ordering due to B+C on one side, and E on the other.

Not arguing I'm also still confused by the comment...

Thanks.
