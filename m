Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0A6A01BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjBWEQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWEQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:16:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3437B70
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:16:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC99B818E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AA8C433D2;
        Thu, 23 Feb 2023 04:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677125771;
        bh=dTeaMXlEwsDBGbnxOx59GiGII1JytQyuWuLyUm92EKE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J7AVle27olc/xVYf7b+odve7dTbhQloNgKp44IkG9K3rhbHoGV4I055roonsKLnbI
         Y5SNsR+TpYpmjIXQowPRaMUlO7FlTpWEA1o78qrWwlj6ZZFbwoWiBc0CZFAzzrAMFA
         nMeJCT2okw/axacyb1p/Us3+zocURL+I2xklQrRkwmYtcgyxsCVY+Lxb3x4VrxkHor
         x3C0LiV9I4ABx2z7LzBK35qfn/WoMHUFkI43ns4b3tARHj7LojDwaRpsOMh+ZSEVPG
         jvATSwc/KRqGGiPuuhjzqfZESfx3nEH9psA6ksVD19P+8VpBE38wjNdSSUqVnlri/n
         XIOR6WfoYpgtQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B08655C10B5; Wed, 22 Feb 2023 20:16:10 -0800 (PST)
Date:   Wed, 22 Feb 2023 20:16:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and
 wmb to  lwsync
Message-ID: <20230223041610.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
 <20230222174719.GA1400185@paulmck-ThinkPad-P17-Gen-1>
 <Y/blLAj2IcX5jSZU@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/blLAj2IcX5jSZU@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:31:48AM +0530, Kautuk Consul wrote:
> On 2023-02-22 09:47:19, Paul E. McKenney wrote:
> > On Wed, Feb 22, 2023 at 02:33:44PM +0530, Kautuk Consul wrote:
> > > A link from ibm.com states:
> > > "Ensures that all instructions preceding the call to __lwsync
> > >  complete before any subsequent store instructions can be executed
> > >  on the processor that executed the function. Also, it ensures that
> > >  all load instructions preceding the call to __lwsync complete before
> > >  any subsequent load instructions can be executed on the processor
> > >  that executed the function. This allows you to synchronize between
> > >  multiple processors with minimal performance impact, as __lwsync
> > >  does not wait for confirmation from each processor."
> > > 
> > > Thats why smp_rmb() and smp_wmb() are defined to lwsync.
> > > But this same understanding applies to parallel pipeline
> > > execution on each PowerPC processor.
> > > So, use the lwsync instruction for rmb() and wmb() on the PPC
> > > architectures that support it.
> > > 
> > > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/barrier.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> > > index b95b666f0374..e088dacc0ee8 100644
> > > --- a/arch/powerpc/include/asm/barrier.h
> > > +++ b/arch/powerpc/include/asm/barrier.h
> > > @@ -36,8 +36,15 @@
> > >   * heavy-weight sync, so smp_wmb() can be a lighter-weight eieio.
> > >   */
> > >  #define __mb()   __asm__ __volatile__ ("sync" : : : "memory")
> > > +
> > > +/* The sub-arch has lwsync. */
> > > +#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
> > > +#define __rmb() __asm__ __volatile__ ("lwsync" : : : "memory")
> > > +#define __wmb() __asm__ __volatile__ ("lwsync" : : : "memory")
> > 
> > Hmmm...
> > 
> > Does the lwsync instruction now order both cached and uncached accesses?
> > Or have there been changes so that smp_rmb() and smp_wmb() get this
> > definition, while rmb() and wmb() still get the sync instruction?
> > (Not seeing this, but I could easily be missing something.)

> Upfront I don't see any documentation that states that lwsync
> distinguishes between cached and uncached accesses.
> That's why I requested the mailing list for test results with
> kernel load testing.

I suggest giving the reference manual a very careful read.  I wish I
could be more helpful, but I found that a very long time ago, and no
longer recall exactly where it was stated.

But maybe Michael Ellerman has a pointer?

							Thanx, Paul

> > > +#else
> > >  #define __rmb()  __asm__ __volatile__ ("sync" : : : "memory")
> > >  #define __wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> > > +#endif
> > >  
> > >  /* The sub-arch has lwsync */
> > >  #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
> > > -- 
> > > 2.31.1
> > > 
