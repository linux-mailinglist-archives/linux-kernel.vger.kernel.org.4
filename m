Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86567D34C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAZRfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjAZRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:35:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027FF6D5F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:35:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D2B1CE2556
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C96FC4339E;
        Thu, 26 Jan 2023 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674754507;
        bh=8NyZxmmPHwCgj6cNJeb8JMor/gTQfCk0BlHUYGpf2kA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O/uXzuD15fyxZ41lTDj0T7mGEoaRIEgI+RoBWyy5RYHhpIpXNWRJpwWeCB3IkzrjN
         bc2HkwDKq1nuHG7jiWIh96ftHQCPG+cFECKtocOU90Rcq16VXsZYHCMYaf3Mtw0V2t
         642JKNKVQ7f4qsN+V433v+QcOqXEaeWBIfH4yA2bT4vpd8G73yS+D40ZQZv3wAYleB
         TF1mHgCZuL+G5SttZuYtLXmAmqQQL2Ptk60YhmVgz6O0CrCzRSpfSP1bNsufeckCRB
         9njQIJdOT+QJUdDhySigPEW03IfHGY5qFzUyLjBrM0L+K64j1OXMjzLepjzan9u1B9
         +xYKANeYUMtrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2450F5C0510; Thu, 26 Jan 2023 09:35:07 -0800 (PST)
Date:   Thu, 26 Jan 2023 09:35:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
Message-ID: <20230126173507.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
 <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
 <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
 <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:30:14PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 11:52 PM, Alan Stern wrote:
> > On Wed, Jan 25, 2023 at 10:04:29PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/25/2023 9:21 PM, Alan Stern wrote:
> > > >    (* Validate nesting *)
> > > >    flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
> > > >    flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
> > > > +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
> > > [...]
> > > >    // SRCU
> > > > -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > > > +srcu_read_lock(X) __load{srcu-lock}(*X)
> > > > +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > > +srcu_down_read(X) __load{srcu-lock}(*X)
> > > > +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > How do you feel about introducing Srcu-up and Srcu-down with this patch?
> > Why invent new classes for them?  They are literally the same operation
> > as Srcu-lock and Srcu-unlock; the only difference is how the kernel's
> > lockdep checker treats them.
> I don't think they're necessarily implemented in a compatible way, so
> 
> r = srcu_lock(s);
> srcu_up(s,r);
> 
> might not actually work, but would currently be ok'ed by LKMM.

In kernels built with CONFIG_PROVE_LOCKING=y (AKA built with lockdep
enabled), lockdep would complain about having an srcu_read_lock() with
no matching srcu_read_unlock().  Kernels built without lockdep (that is,
kernels actually used in production) would be happy with this.

So as Jonas suspects, this should be classified as not actually working.

>                                                                With
> different classes you could state
>   flag ~empty [Srcu-lock];srcu-rscs;[Srcu-up] as srcu-mismatch-lock-to-up
>   flag ~empty [Srcu-down];srcu-rscs;[Srcu-unlock] as
> srcu-mismatch-down-to-unlock
> 
> I think with the current implementation this code might work, but I don't
> feel like this is inherently true.
> 
> You could then also go ahead and define the "same CPU" requirement as a flag
> for lock and unlock specifically, like
>   flag ~empty [Srcu-lock];srcu-rscs & ext as srcu-lock-unlock-mismatch-CPU
> or so.
> 
> Best wishes, jonas
> 
