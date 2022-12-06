Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A105644D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLFUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLFUw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:52:56 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD22A974
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:52:54 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id x24so7873987qkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 12:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z082q9H8x+I0C+JBqrrvETEcCGqREcSPWghZnm/MjQc=;
        b=al34RvvQSj6pRq2pB6vfH46SEc2HepnL84qdOMtPygd+CTyEynkvPY3Fz1K934+GRd
         5KPHXIcAGyQq765AuysahiokGX3771ttPal4UA9N2QNTNR30nNCJO6D0nZHgktXw24Li
         v6lJtfy+knTWckqY4ArobJb1lw/F2IKPMf566hbazlH5mIUwkWfIHmwMMI/18lq6YmFS
         vJrLZasirw9O0a2S4Aw5pF9OptMk0Q8BKRHbVRGXthoLEkjfK9UPtdFuap3Vfs3BDAnT
         OYcrzkH3GW6YIPxpenoQ1UR4F8XUC61itbCI/mq9bRj7NhcfItZF9yX6ehaL7vF4v76V
         UxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z082q9H8x+I0C+JBqrrvETEcCGqREcSPWghZnm/MjQc=;
        b=nBhZsWgQ9K/UdJ/8koNVFVp0vqBWG86D6XQs7FqNwbPgjvBMoNJP6NR9ljnkcrJLfw
         K4vVs6PBtmN4ED/V0Y8gznMsXJcDR+cMV2gJDND94kyoyHt8rUbxuaesq7Br27yBSIE3
         sV/tG8Tsp2ZaoQn7hFSQn5JhGaHbqUTe4G++jXZGUKDhcZYzWIEDNIeNPaC8cNDZKjkG
         sCDxc2VEQpmEEmjelncAUlZz38y2VRhzVTGCu160luOisCZ91r3uXUydhg9k1io8pD1c
         18IcNXYdjsjGJKoXKDlZZa7rHMNzewY6a/FAeCcbWr9JoAOjD7grJVNXE2xmC8wdHTyZ
         I82Q==
X-Gm-Message-State: ANoB5pktBL6Etcaj+AHxgRZMQAN2u6t8EBuIt16WcdQ/NWskGK536SOX
        E6Ercyk4Hbc8XSGIX3jJ1NipP8dx8/0=
X-Google-Smtp-Source: AA0mqf4fODRXfs4KvJiAOpPS0fhOMqhJprGGVLitS/IoMegqBjQnrPrgjhre1yi/qIb5fMh9h29h+A==
X-Received: by 2002:ae9:c017:0:b0:6fc:65f8:33d9 with SMTP id u23-20020ae9c017000000b006fc65f833d9mr42584709qkk.39.1670359973921;
        Tue, 06 Dec 2022 12:52:53 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bb4-20020a05622a1b0400b003a51e8ef03dsm11849392qtb.62.2022.12.06.12.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:52:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C2A3727C0054;
        Tue,  6 Dec 2022 15:52:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Dec 2022 15:52:52 -0500
X-ME-Sender: <xms:o6uPY7t-jX6Py2Z9dL3UeZ7QWhUDxGd6HQ6Ycnj5gPYL-rTFwH8i8A>
    <xme:o6uPY8cTdUhgqETZRc7MZbDQPPh0oNbC1AVoBnVFhRorrRYqLx9qtP6_SseZrrMMK
    NKzcuXTKfYenk9Aog>
X-ME-Received: <xmr:o6uPY-yNcs7yIMntvdaNCZHo0ihibokasmzm4ZSBHNmvu028UCE4l0ck2rE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:o6uPY6Phu5TJLvoZAbrE6BNWBgvDhNi8ywRHrZTkwWa3A7-EQdeMVQ>
    <xmx:o6uPY79IP7mHDIz6xOt7FvoRIl3SOTpR2zHFRqYgOCnf_M7snFpQNA>
    <xmx:o6uPY6UvSO4xntqKyTWie8J1CaqOUjGb7R_4XeRoukOpoaDo2mOsHA>
    <xmx:pKuPYzNuc2m4FuCFMh1RL9hjNAMW3391IuJbYR3ZAsrL_1me6cbIhQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Dec 2022 15:52:51 -0500 (EST)
Date:   Tue, 6 Dec 2022 12:52:47 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
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
Message-ID: <Y4+rn0lsrdCB3pMj@boqun-archlinux>
References: <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
 <Y44ZxWYQkMN60a1E@rowland.harvard.edu>
 <Y4+qQrhxrcqOUolZ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4+qQrhxrcqOUolZ@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:46:58PM -0800, Boqun Feng wrote:
> On Mon, Dec 05, 2022 at 11:18:13AM -0500, stern@rowland.harvard.edu wrote:
> > On Mon, Dec 05, 2022 at 01:42:46PM +0000, Jonas Oberhauser wrote:
> > > > Besides, could you also explain a little bit why only "data;rfi" can be "carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's because there are special cases when compilers can figure out a condition being true or an address being constant therefore break the dependency
> > > 
> > > Oh, good question. A bit hard for me to write down the answer clearly 
> > > (which some people will claim that I don't understand it well myself, 
> > > but I beg to differ :) :( :) ).
> 
> Nah, I think your answer is clear to me ;-)
> 
> > > 
> > > In a nutshell, it's because x ->data [Plain] ->rfi y ->... z fulfils 
> > > the same role as storing something in a register and then using it in 
> > > a subsequent computation; x ->ctrl y ->... z (and ->addr) don't. So 
> > > it's not due to smart compilers, just the fact that the other two 
> > > cases seem unrelated to the problem being solved, and including them 
> > > might introduce some unsoundness (not that I have checked if they do).
> 
> So it's about whether a value can have a dataflow from x to y, right? In
> that case registers and memory cells should be treated the same by
> compilers, therefore we can extend the dependencies.
> > 
> > More can be said here.  Consider the following simple example:
> > 
> > 	void P0(int *x, int *y)
> > 	{
> > 		int r1, r2;
> > 		int a[10];
> > 
> > 		r1 = READ_ONCE(*x);
> > 		a[r1] = 1;
> > 		r2 = a[r1];
> > 		WRITE_ONCE(*y, r2);
> > 	}
> > 
> > There is an address dependency from the READ_ONCE to the plain store in 
> > a[r1].  Then there is an rfi and a data dependency to the WRITE_ONCE.
> > 
> > But in this example, the WRITE_ONCE is _not_ ordered after the 
> > READ_ONCE, even though they are linked by (addr ; rfi ; data).  The 
> > compiler knows that the value of r1 does not change between the two 
> > plain accesses, so it knows that it can optimize the code to be:
> > 
> > 	r1 = READ_ONCE(*x);
> > 	r2 = 1;
> > 	WRITE_ONCE(*y, r2);
> > 	a[r1] = r2;
> > 
> > And then the CPU can execute the WRITE_ONCE before the READ_ONCE.  This 
> > shows that (addr ; rfi) must not be included in the carry-deps relation.
> > 
> > You may be able to come up with a similar argument for (ctrl ; rfi), 
> > although it might not be quite as clear.
> > 
> 
> Thank you, Alan! One question though, can a "smart" compiler optimize
> out the case below, with the same logic?
> 
> 	void P0(int *x, int *y, int *a)
> 	{
> 		int r1, r2;
> 
> 		r1 = READ_ONCE(*x); // A
> 
> 		*a = r1 & 0xffff; // B
> 
> 		r2 = *a & 0xffff0000; // C
> 
> 		WRITE_ONCE(*y, r2); // D
> 
> 	}
> 
> I think we have A ->data B ->rfi C ->data D, however a "smart" compiler
> can figure out that r2 is actually zero, right? And the code get
> optimized to:
> 
> 	r1 = READ_ONCE(*x);
> 	r2 = 0;
> 	WRITE_ONCE(*y, r2);
> 	*a = r1 & 0xffff;
> 
> and break the dependency.
> 
> I know that our memory model is actually unware of the differences of
> syntatics dependencies vs semantics syntatics, so one may argue that in
> the (data; rfi) example above the compiler optimization is outside the
> scope of LKMM, but won't the same reasoning apply to the (addr; rfi)
> example from you? The WRITE_ONCE() _syntatically_ depends on load of
> a[r1], therefore even a "smart" compiler can figure out the value, LKMM

I guess it should be that r2 (i.e. the load of a[r1]) _syntatically_
depends on the value of r1.

Regards,
Boqun

> won't take that into consideration.
> 
> Am I missing something subtle here?
> 
> Regards,
> Boqun
> 
> > Alan
