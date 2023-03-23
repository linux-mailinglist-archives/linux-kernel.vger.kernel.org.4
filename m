Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2446C5EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCWFXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCWFXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:23:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03E30E7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F88B81EDF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A1EC433EF;
        Thu, 23 Mar 2023 05:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679548978;
        bh=rNrfvpy2HzWHkPct+hqcH/KHmu0jX3CjJR2Do9AOHJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgrgNI0cDyF3ZNRmaWnY2X7ueTcKguDOFF5iF9ow8yzOgFRTM10RxUOrTaQH1raSK
         RzrxkkxCrqmwYc/60v4B3OK0NUahknbh8dei7XWdD1wE/uSHO6eq1AUCevajuiKOIU
         pEXUUmqrMv1mjH0XGv1RnG9MsAIxmcmZnHMC6TDs=
Date:   Thu, 23 Mar 2023 06:22:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, Alex Elder <elder@ieee.org>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
Message-ID: <ZBviL+IuY43djHyS@kroah.com>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
 <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org>
 <alpine.DEB.2.22.394.2303212140480.2919@hadrien>
 <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org>
 <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
 <48674d8f-9753-780c-f37c-f83ea2855ae6@ieee.org>
 <eabacc6f-c7fb-ff33-26d1-271537fb4760@inria.fr>
 <ZBvcWkpMJnxea78L@kroah.com>
 <ZBveN3HT96/cktRI@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBveN3HT96/cktRI@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:35:59AM +0530, Deepak R Varma wrote:
> On Thu, Mar 23, 2023 at 05:58:02AM +0100, Greg KH wrote:
> > Nice, that shows that it is the same both ways as the compiler version
> > you are using is smart enough
> > 
> > Which compiler and version is this?  Does it work the same for all of
> > the supported versions we have to support (i.e. really old gcc?)
> > 
> > For the most part, sysfs files are not on any sort of "fast path" so a
> 
> Hello,
> Is there a guideline/documentation on how to identify if a code is part of
> fast/slow path?

Not really, the general rule is if the code is used in a function that
is time criticial, then it is in the "fast path".

Normally the code path for I/O or for determining what process to
schedule next is a "fast path" as you want to do the least amount of
work in the kernel so as to get the I/O to the hardware or caller, or
you want to schedule the next process faster so that it can do the real
work that is wanted.

But for some I/O, where the hardware is the limiting factor (like slow
USB or serial connections), no matter how optimized the kernel is, the
data can not get to the user any faster because the hardware just can
not provide it, so for that, it's not really that critical.

Note that "time critical" can change depending on the user of the system
and as hardware evolves.

One example would be the creation of a number of sysfs entries for the
disks in the systems.  On a "normal" system, creating them all is trivial
as there are not many disks.  But on some "big" systems with many tens
of thousands of disks, it can become a boot time bottleneck.

So it's usually "you know it when you see it show up on a profile", use
the perf tool to test your workload on, to see where in the kernel
things are taking up too much time so you know what needs to be made
faster.

hope this helps,

greg k-h
