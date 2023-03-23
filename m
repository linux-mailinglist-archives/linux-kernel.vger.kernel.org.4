Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E66C7147
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCWTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjCWTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:46:51 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50B23C7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1679600790; bh=Ofo5WnknXu2q4PHMQtHwGNgTsx9PA3GsytL7rSclMoM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=d/RQhi09FV2kGD7zsVGy49E61BrwVVX1p8onsuoJ937QJonp0xESkL1t0xv6efXLs
         6v9HL8quo3/fR0D7I9sVGtQZmExwTGNZ6A+i+nbkaCnf7g2qLRwyi233ZTlNa5pXKI
         3IWFT/21lXvvaEX0neoGaJl9+cXCBpVzlNSPzYdE=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 23 Mar 2023 20:46:30 +0100 (CET)
X-EA-Auth: jRldBc3fw9HBPmS2VhRtuXpKewjU9HPr0zvL+RMjtoTBXoNrOPkyuG56v9mN9SoAFgEQrrgGpYQwP1A4u5xeLZPK9L+o8cFj
Date:   Fri, 24 Mar 2023 01:16:26 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, Alex Elder <elder@ieee.org>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
Message-ID: <ZByskk59KaEZbc6+@ubun2204.myguest.virtualbox.org>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
 <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org>
 <alpine.DEB.2.22.394.2303212140480.2919@hadrien>
 <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org>
 <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
 <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org>
 <eabacc6f-c7fb-ff33-26d1-271537fb4760@inria.fr>
 <ZBvcWkpMJnxea78L@kroah.com>
 <ZBveN3HT96/cktRI@ubun2204.myguest.virtualbox.org>
 <ZBviL+IuY43djHyS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBviL+IuY43djHyS@kroah.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 06:22:55AM +0100, Greg KH wrote:
> On Thu, Mar 23, 2023 at 10:35:59AM +0530, Deepak R Varma wrote:
> > On Thu, Mar 23, 2023 at 05:58:02AM +0100, Greg KH wrote:
> > > Nice, that shows that it is the same both ways as the compiler version
> > > you are using is smart enough
> > > 
> > > Which compiler and version is this?  Does it work the same for all of
> > > the supported versions we have to support (i.e. really old gcc?)
> > > 
> > > For the most part, sysfs files are not on any sort of "fast path" so a
> > 
> > Hello,
> > Is there a guideline/documentation on how to identify if a code is part of
> > fast/slow path?
> 
> Not really, the general rule is if the code is used in a function that
> is time criticial, then it is in the "fast path".
> 
> Normally the code path for I/O or for determining what process to
> schedule next is a "fast path" as you want to do the least amount of
> work in the kernel so as to get the I/O to the hardware or caller, or
> you want to schedule the next process faster so that it can do the real
> work that is wanted.
> 
> But for some I/O, where the hardware is the limiting factor (like slow
> USB or serial connections), no matter how optimized the kernel is, the
> data can not get to the user any faster because the hardware just can
> not provide it, so for that, it's not really that critical.
> 
> Note that "time critical" can change depending on the user of the system
> and as hardware evolves.
> 
> One example would be the creation of a number of sysfs entries for the
> disks in the systems.  On a "normal" system, creating them all is trivial
> as there are not many disks.  But on some "big" systems with many tens
> of thousands of disks, it can become a boot time bottleneck.
> 
> So it's usually "you know it when you see it show up on a profile", use
> the perf tool to test your workload on, to see where in the kernel
> things are taking up too much time so you know what needs to be made
> faster.
> 
> hope this helps,

Thank you Greg.
Yes, it definitely is very helpful. I sincerely appreciate the explanation and
the time you took to write it in so detail. I am Obliged.

Regards,
Deepak.


> 
> greg k-h


