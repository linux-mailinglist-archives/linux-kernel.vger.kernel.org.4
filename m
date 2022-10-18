Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455F6603550
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJRV50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE08F262;
        Tue, 18 Oct 2022 14:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7417C61707;
        Tue, 18 Oct 2022 21:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DADC433C1;
        Tue, 18 Oct 2022 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666130241;
        bh=OlzXQ7NgWM8JuRK8p8xk1ueY1SE8h+aLsBI9zLsj+I0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pneQB9+W31sQfWozK2bhcCgqrQb6IRRrF9dZWSMhNRq67ScnNwFkFNjlWBngNzVkB
         qqNmZMIUVP0Z3I84/NCt+lVgXrR8LCVE5Vt4VU7p9J9MCixm8GLYlzqAY4kh8kClqo
         Lq5GfDV7JIyyupF6g7r2ghC8zDDMHoydzKOCIg4uT78ODw1+jLCZQib962ZjOSTXg0
         fs9PmJHXM/BujZIdIQqWCO3b8UMKUmD6weRgky0mctPQRqsITQe4jAPCTFZQoDywsb
         5pqlVz/FTvfRftVEFtCn9+uZGjzX8POyP8Wch1vxxmmTGkHSexPm1aWKTSfQNs/JEF
         CtvIllAd+Iwwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6FA285C0623; Tue, 18 Oct 2022 14:57:21 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:57:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:59:36AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 18, 2022 at 08:50:57PM +0206, John Ogness wrote:
> > On 2022-10-18, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > Currently, I have this series on -rcu branch srcunmisafe.2022.10.03a,
> > > with Frederic's patches on branch "dev".  I will be producing a shiny
> > > new branch with your fix and Frederic's debug later today, Pacific
> > > Time.  With luck, based on v6.1-rc1.
> > 
> > Perfect!
> > 
> > > I will be incorporating these commits from Frederic:
> > >
> > > 6558b914fc4e ("srcu: Warn when NMI-unsafe API is used in NMI")
> > > 5dc788627109 ("srcu: Explain the reason behind the read side critical section on GP start")
> > > 54a118fce487 ("srcu: Debug NMI safety even on archs that don't require it")
> > >
> > > Are there other patches I should be applying?
> > 
> > Not that I am aware of.
> 
> And if you are in a hurry, the v6.0-rc1 stack is at srcunmisafe.2022.10.18a.
> With luck, the v6.1-rc1 stack will be at srcunmisafe.2022.10.18b before
> the day is over, Pacific Time.

And the v6.1-rc1 stack is now at srcunmisafe.2022.10.18b.  ;-)

								Thanx, Paul
