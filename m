Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA41967809B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjAWPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAWPzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:55:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C89A44680
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:55:17 -0800 (PST)
Received: (qmail 130373 invoked by uid 1000); 23 Jan 2023 10:55:17 -0500
Date:   Mon, 23 Jan 2023 10:55:17 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, Andrea Parri <parri.andrea@gmail.com>,
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
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y86t5ST3TcUl/rQd@rowland.harvard.edu>
References: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
 <Y8wimpMpajLudrYb@rowland.harvard.edu>
 <1e77c538-d04b-62b7-a859-1589bab0ddef@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e77c538-d04b-62b7-a859-1589bab0ddef@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:48:42PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/21/2023 6:36 PM, Alan Stern wrote:
> > On Fri, Jan 20, 2023 at 10:41:14PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/20/2023 5:18 PM, Alan Stern wrote:
> > > > On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
> > > > > Perhaps we could say that reading an index without using it later is
> > > > > forbidden?
> > > > > 
> > > > > flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
> > > > > thrown-srcu-cookie-on-floor
> > > > We already flag locks that don't have a matching unlock.
> > > Of course, but as you know this is completely orthogonal.
> > Yeah, okay.  It doesn't hurt to add this check, but the check isn't
> > complete.  For example, it won't catch the invalid usage here:
> > 
> > P0(srcu_struct *ss)
> > {
> > 	int r1, r2;
> > 
> > 	r1 = srcu_read_lock(ss);
> > 	srcu_read_unlock(&ss, r1);
> > 	r2 = srcu_read_lock(ss);
> > 	srcu_read_unlock(&ss, r2);
> > }
> > 
> > exists (~0:r1=0:r2)
> > 
> > On the other hand, how often will people make this sort of mistake in
> > their litmus tests?  My guess is not very.
> I currently don't care too much about the incorrect usage of herd (by
> inspecting some final state incorrectly), only incorrect usage in the code.

I'm inclined to add this check to the memory model.  Would you prefer to 
submit it yourself as a separate patch?  Or are you happy to have it 
merged with my patch, and if so, do you have a final, preferred form for 
the check?

Alan
