Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C345F2EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJCKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:13:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869D64E1;
        Mon,  3 Oct 2022 03:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 082CEB80E8F;
        Mon,  3 Oct 2022 10:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C79AC433C1;
        Mon,  3 Oct 2022 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664792014;
        bh=D0vrOM+dkmOE9+JCjti7doYDFzRF2uz8SfzwCZ2cwd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJjLdIoBKNRgoyYRA9JwoK5kt9if3fN4qNZvWlJjy+KMa/nFmrjZbfxFccdlxqDIn
         bo/tf8vw7l/qp1Jwfi1enH9rvHrtx1J2oUYmXK9WTf74qGMOqHqZGY2MIp8tEMiWHP
         nNEH0IvNyji4wQBh6tGi/D1SoDyqH0H5Dbv5Z06melg1Hp2VDzFhOnTdgy8TxjLti/
         C2JYZHLVcxGTFnGWvxEyujhbziN+ao8xKsCF7kn5smJZWHG2DRmor5p0r1BRXqM1zT
         wt/kh7hrpn50qb2o0wQOxB8H3gXz6nU0kSKpRSd6L2HnVs8NuuS8FlFtf3stdyMt7U
         frlqNEAWIQmcg==
Date:   Mon, 3 Oct 2022 12:13:31 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 3/8] srcu: Check for consistent per-CPU
 per-srcu_struct NMI safety
Message-ID: <20221003101331.GA304186@lothringen>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-3-paulmck@kernel.org>
 <20221002220619.GA298433@lothringen>
 <20221002235103.GW4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002235103.GW4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 04:51:03PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 03, 2022 at 12:06:19AM +0200, Frederic Weisbecker wrote:
> > On Thu, Sep 29, 2022 at 11:07:26AM -0700, Paul E. McKenney wrote:
> > > This commit adds runtime checks to verify that a given srcu_struct uses
> > > consistent NMI-safe (or not) read-side primitives on a per-CPU basis.
> > > 
> > > Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: John Ogness <john.ogness@linutronix.de>
> > > Cc: Petr Mladek <pmladek@suse.com>
> > > ---
> > >  include/linux/srcu.h     |  4 ++--
> > >  include/linux/srcutiny.h |  4 ++--
> > >  include/linux/srcutree.h |  9 +++++++--
> > >  kernel/rcu/srcutree.c    | 38 ++++++++++++++++++++++++++++++++------
> > >  4 files changed, 43 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > index 2cc8321c0c86..565f60d57484 100644
> > > --- a/include/linux/srcu.h
> > > +++ b/include/linux/srcu.h
> > > @@ -180,7 +180,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
> > >  	int retval;
> > >  
> > >  	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> > > -		retval = __srcu_read_lock_nmisafe(ssp);
> > > +		retval = __srcu_read_lock_nmisafe(ssp, true);
> > >  	else
> > >  		retval = __srcu_read_lock(ssp);
> > 
> > Shouldn't it be checked also when CONFIG_NEED_SRCU_NMI_SAFE=n ?
> 
> You are asking why there is no "true" argument to __srcu_read_lock()?
> That is because it checks unconditionally.

It checks unconditionally but it always assumes not to be called as nmisafe.

For example on x86/arm64/loongarch, the same ssp used with both srcu_read_lock() and
srcu_read_lock_nmisafe() won't report an issue. But on powerpc it will.

My point is that strong archs should warn as well on behalf of others, to detect
mistakes early.

Thanks.
