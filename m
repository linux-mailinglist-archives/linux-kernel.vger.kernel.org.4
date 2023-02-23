Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E16A020D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjBWEeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBWEeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:34:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26723645
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:34:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593AC615DB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871B6C4339B;
        Thu, 23 Feb 2023 04:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677126851;
        bh=uXbnPrgMFY/kZzjbBX7/Pgj2FdPuldBEDz+GncI+5l8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H4Q/ZDptaDvxBuRA7VR31EVRLtqDHiiJtFJVIUtJmIqrZ/apOyrLEvN35AVj8UuYz
         LKk3ahMFQi8Q53yvA6LGx63fI3WatPe/UJ6jVxvfbr6V75DyOd5WQXdW9OsTGaxoIW
         Jd4apYdQ67qPRHIniYEnYr6kbfypDXDSvGUFKFTTZ5R99aIC1CEs+acg0GlU9RWTKv
         cIbTK9JjI11elO2VeoGbxtscJZ9GGJg9d05kDX1rN0QikhXTxvg/sClcMmApPCdel+
         om0T+/WsIZRGZqINbw+4Ut2DPobu1rrE2dceQQBvXobD0iA/HcBYdBCwt3sQ0aKXsm
         gV4BeNwtzr5YQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 24C805C10B5; Wed, 22 Feb 2023 20:34:11 -0800 (PST)
Date:   Wed, 22 Feb 2023 20:34:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230223043411.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
 <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230222225755.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230223035359.6jgserikqtc3vnra@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223035359.6jgserikqtc3vnra@offworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 07:53:59PM -0800, Davidlohr Bueso wrote:
> On Wed, 22 Feb 2023, Paul E. McKenney wrote:
> 
> > commit edc9d419ee8c22821ffd664466a5cf19208c3f02
> > Author: Zqiang <qiang1.zhang@intel.com>
> > Date:   Wed Feb 15 14:10:35 2023 +0800
> > 
> >    locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels
> > 
> >    In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
> >    to sleepable rt_spin_lock().  This means that the interrupt related suffix
> >    for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect the CPU's
> >    interrupt state. This commit therefore adds raw spin-lock torture tests.
> >    This in turn permits pure spin locks to be tested in PREEMPT_RT kernels.
> > 
> >    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> This is a nice addition, thanks. Just one comment below.
> 
> > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > index 9425aff089365..ed8e5baafe49f 100644
> > --- a/kernel/locking/locktorture.c
> > +++ b/kernel/locking/locktorture.c
> > @@ -257,6 +257,61 @@ static struct lock_torture_ops spin_lock_irq_ops = {
> > 	.name		= "spin_lock_irq"
> > };
> > 
> > +#ifdef CONFIG_PREEMPT_RT
> > +static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);
> 
> How about leaving raw spinlocks regardless of preempt-rt, and instead
> change the default lock (which is spin_lock) based on CONFIG_PREEMPT_RT
> and use the raw one in that case?

That makes a lot of sense to me!  In fact, I tested this by deleting
those #ifdef statements.  ;-)

Zqiang, would you like to take the patch and make that change, with
attribution?

							Thanx, Paul
