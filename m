Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E606065EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJTQfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJTQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:35:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631EA12A346;
        Thu, 20 Oct 2022 09:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D47B826C4;
        Thu, 20 Oct 2022 16:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C10C433D6;
        Thu, 20 Oct 2022 16:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666283703;
        bh=1D50o0naBc2gRDAfGm82dEQ7o6F3FtNqy0eWFByAG7M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JJgVs/jKQbha1MJ/tMXRUd38n/8JTRLH+incUHDo585lwYHRAA6HCxLmU+XWNsA/P
         O9MlU3/sW93OUer5A0lh61+uX7y8HzkYAF8X28Ezi7qmmCT4HeR69+NZTS+sG2RrPq
         7ZodZ5+qo3R0IA7QIDDqBAG9ALtgH2uCX67JwZpuYFoiKJheECrHlbMzkPvQHtQ+6o
         jNUoIBkKzkJA4jxIcJIsk+y4y24gDDvqAB/nYS6s/K8sXFCvveK6esE89jutTyMAEQ
         RWEDcP5BEzU16xhGxoY+WMA1JnzrfSi7lp/2n+YOyug/biSIVB5xVkIFLy0tMS4nbg
         Te8MCGbG6KCjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BF0C5C04D0; Thu, 20 Oct 2022 09:35:03 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:35:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 rcu 08/11] arch/s390: Add
 ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Message-ID: <20221020163503.GQ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
 <20221019225846.2501109-8-paulmck@kernel.org>
 <b74752cc-5833-c1b5-3697-262c523e794b@linux.ibm.com>
 <Y1D3hReCp/9C9gD3@osiris>
 <Y1D4aYbjRJjUEelZ@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1D4aYbjRJjUEelZ@osiris>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:27:37AM +0200, Heiko Carstens wrote:
> On Thu, Oct 20, 2022 at 09:23:49AM +0200, Heiko Carstens wrote:
> > On Thu, Oct 20, 2022 at 07:16:44AM +0200, Christian Borntraeger wrote:
> > > Am 20.10.22 um 00:58 schrieb Paul E. McKenney:
> > > > The s390 architecture uses either a cmpxchg loop (old systems)
> > > > or the laa add-to-memory instruction (new systems) to implement
> > > > this_cpu_add(), both of which are NMI safe.  This means that the old
> > > > and more-efficient srcu_read_lock() may be used in NMI context, without
> > > > the need for srcu_read_lock_nmisafe().  Therefore, add the new Kconfig
> > > > option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to arch/arm64/Kconfig, which will
> > > 						s390 ?
> 
> Ah, this typo is what Christian pointed out; missed that.
> 
> > > > cause NEED_SRCU_NMI_SAFE to be deselected, thus preserving the current
> > > > srcu_read_lock() behavior.
> > > > 
> > > > Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> > > > 
> > > > Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ...
> > > > ---
> > > >   arch/s390/Kconfig | 1 +
> > > >   1 file changed, 1 insertion(+)
> > 
> > Not sure what Christian was trying to say with his empty reply :)
> > In any case:
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>

I will apply the fix and the ack on my next rebase, thank you both!

							Thanx, Paul
