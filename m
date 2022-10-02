Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0715F2403
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJBQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJBQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D52A249;
        Sun,  2 Oct 2022 09:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A8760D2D;
        Sun,  2 Oct 2022 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27185C433D6;
        Sun,  2 Oct 2022 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664727050;
        bh=iYSULLafNcLyH9h0uSumzTFii3DipGhG7p0rGpavnlk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NQMfSOwLkQJyTC2+x+GDq3+hya1GlKZ12gtcwDtu2wjRbSuiLN8+EGKT8ULLKbXXR
         WXFYCheLE0Wj65qPQabd2Jsm32bDzM1+/0ENKoa/UiEycH48PeeYAi2RnQ82uy4Idm
         d2IfY9LNbPWTVIsxbjyvpIXUkG2HH2XyU0eEb7BvgrlPwzRwJ4OFb85VUyzQNK/VFw
         IDqFYeIKwajysVzxHXBAlk+1smGBmVYF2AJAQ2bahZSGFs68XG31yUygw2dn8sC0mt
         ct3CQ68aGFJfhY5Ne28SnKyp5OV218F/oCOjXH/bqqQRlVJZrUEdtTJ/rqhpVyJ26l
         aMsZ7cvEaWR7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1B395C086D; Sun,  2 Oct 2022 09:10:49 -0700 (PDT)
Date:   Sun, 2 Oct 2022 09:10:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe()
 and srcu_read_unlock_nmisafe()
Message-ID: <20221002161049.GQ4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
 <20221002155516.GB292620@lothringen>
 <20221002155725.GC292620@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002155725.GC292620@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 05:57:25PM +0200, Frederic Weisbecker wrote:
> On Sun, Oct 02, 2022 at 05:55:16PM +0200, Frederic Weisbecker wrote:
> > On Thu, Sep 29, 2022 at 11:07:25AM -0700, Paul E. McKenney wrote:
> > > @@ -1090,7 +1121,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > >  	int ss_state;
> > >  
> > >  	check_init_srcu_struct(ssp);
> > > -	idx = srcu_read_lock(ssp);
> > > +	idx = __srcu_read_lock_nmisafe(ssp);
> > 
> > Why do we need to force the atomic based version here (even if
> > CONFIG_NEED_SRCU_NMI_SAFE=y)?
> 
> ...even if CONFIG_NEED_SRCU_NMI_SAFE=n that is...

Heh!  I also got it consistently backwards in my reply.  I will trust
your ability to translate.  ;-)

							Thanx, Paul
