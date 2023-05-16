Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FC704D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjEPMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjEPMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3C4C13
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B396392B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EEAC433EF;
        Tue, 16 May 2023 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684239477;
        bh=sP9gNr70JhVah2PxtGLjXPjgrkId19Xw0B/4W82U6Qo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DmiuJEhjigE9MaqcXF9VZ4sWQJB36J2eUJZrHX6Ca8BFifZt4T2m0YfQ5fVNO4RZO
         pB05XuJB9Wel9zois5Zrg98NoweZ/9AXGSb53/EYtKHr6wOin4M5a+TjHhc3MZzqDL
         ILFn6AfGXeh0aANY+gEsUK3NHIeYmEuppLsH9dqFDIYdwLIuYpsWUwK1fL0puTaeKV
         u1WJURX+geSw+/yzHhoxP9RTxQoP1H1TFXdTiftOd54Y1A4ac8H8SCKrKP2F5ogRY5
         hGyV4nC7eB8H1n+UmlZ5PAlDnRJvowTRt3eZxeXsNfdfyaFRO3F6bYiaNU21G0G8xi
         yLE6r+MqxAVoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 644B5CE1432; Tue, 16 May 2023 05:17:57 -0700 (PDT)
Date:   Tue, 16 May 2023 05:17:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: kernel/rcu/srcutree.c:1644 srcu_advance_state() warn:
 inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.
Message-ID: <2ef061eb-e82d-4c16-a333-e499095a7162@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c0937326-1cf1-429a-9883-30d9d79b01d0@kili.mountain>
 <c33b0348-7f86-47ce-913c-f1ebc6431f93@paulmck-laptop>
 <30f2e760-e2f3-4941-be9b-b9c5624fd861@kili.mountain>
 <4bdbbcd3-6620-4320-ada5-02b71a54106c@paulmck-laptop>
 <782b3fa6-576d-4c26-888e-5dc151feaaa8@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782b3fa6-576d-4c26-888e-5dc151feaaa8@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 06:13:02PM +0300, Dan Carpenter wrote:
> On Tue, May 09, 2023 at 07:08:05AM -0700, Paul E. McKenney wrote:
> > On Tue, May 09, 2023 at 08:40:33AM +0300, Dan Carpenter wrote:
> > > On Sat, May 06, 2023 at 11:45:35AM -0700, Paul E. McKenney wrote:
> > > > On Sat, May 06, 2023 at 10:22:04AM +0300, Dan Carpenter wrote:
> > > > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1632  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
> > > > > 
> > > > > We don't mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex) if this if
> > > > > statement is false.
> > > > 
> > > > Hmmm...
> > > > 
> > > > I could make the above line read something like the following:
> > > > 
> > > > 	if (!WARN_ON_ONCE(rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) != SRCU_STATE_SCAN2)) {
> > > 
> > > Smatch ignores WARN_ON().  WARNings are triggered all the time, so it's
> > > not like a BUG() which stops the code flow.
> > > 
> > > > 
> > > > The theory is that there are only three legal values for ->srcu_gp_seq.
> > > > Because we hold ->srcu_gp_mutex, no one else can change it.   The first
> > > > "if" statement either returns or sets that state to SRCU_STATE_SCAN1.
> > > > The second "if" statement also either returns or sets that state to
> > > > SRCU_STATE_SCAN2.  So that statement should not be false.
> > > 
> > > Smatch can't figure out that the statement is true.  The issue there is
> > > that ssp->srcu_sup->srcu_gp_seq stores a value in the low bits and a
> > > different value in the high bits.  This seems like something that might
> > > be worth handling correctly at some point, but that point is in the
> > > distant future...
> > > 
> > > Just ignore this one.
> > 
> > Fair enough!  Yeah, I could imagine that this would be non-trivial.
> > 
> > Is there a not-reached annotation that Smatch pays attention to?
> 
> Hm...  Yeah.  If you wanted you could do this.  I'm not sure it improves
> the readability.  Also for some reason my private Smatch build doesn't
> print a warning...  I need to investigate why that is...

There does seem to be a fair number of instances of unreachable() in
the kernel, so why not?

May I add your Signed-off-by?

							Thanx, Paul

> regards,
> dan carpenter
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..58e13d3c5a6a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1669,6 +1669,8 @@ static void srcu_advance_state(struct srcu_struct *ssp)
>  		}
>  		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
>  		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
> +	} else {
> +		unreachable();
>  	}
>  }
>  
