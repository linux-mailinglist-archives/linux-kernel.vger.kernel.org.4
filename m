Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3123642CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiLEQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLEQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:18:15 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CE412BCAB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:18:14 -0800 (PST)
Received: (qmail 621638 invoked by uid 1000); 5 Dec 2022 11:18:13 -0500
Date:   Mon, 5 Dec 2022 11:18:13 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y44ZxWYQkMN60a1E@rowland.harvard.edu>
References: <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:42:46PM +0000, Jonas Oberhauser wrote:
> > Besides, could you also explain a little bit why only "data;rfi" can be "carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's because there are special cases when compilers can figure out a condition being true or an address being constant therefore break the dependency
> 
> Oh, good question. A bit hard for me to write down the answer clearly 
> (which some people will claim that I don't understand it well myself, 
> but I beg to differ :) :( :) ).
> 
> In a nutshell, it's because x ->data [Plain] ->rfi y ->... z fulfils 
> the same role as storing something in a register and then using it in 
> a subsequent computation; x ->ctrl y ->... z (and ->addr) don't. So 
> it's not due to smart compilers, just the fact that the other two 
> cases seem unrelated to the problem being solved, and including them 
> might introduce some unsoundness (not that I have checked if they do).

More can be said here.  Consider the following simple example:

	void P0(int *x, int *y)
	{
		int r1, r2;
		int a[10];

		r1 = READ_ONCE(*x);
		a[r1] = 1;
		r2 = a[r1];
		WRITE_ONCE(*y, r2);
	}

There is an address dependency from the READ_ONCE to the plain store in 
a[r1].  Then there is an rfi and a data dependency to the WRITE_ONCE.

But in this example, the WRITE_ONCE is _not_ ordered after the 
READ_ONCE, even though they are linked by (addr ; rfi ; data).  The 
compiler knows that the value of r1 does not change between the two 
plain accesses, so it knows that it can optimize the code to be:

	r1 = READ_ONCE(*x);
	r2 = 1;
	WRITE_ONCE(*y, r2);
	a[r1] = r2;

And then the CPU can execute the WRITE_ONCE before the READ_ONCE.  This 
shows that (addr ; rfi) must not be included in the carry-deps relation.

You may be able to come up with a similar argument for (ctrl ; rfi), 
although it might not be quite as clear.

Alan
