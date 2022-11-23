Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E4636CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKWWRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKWWRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:17:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992A421BB;
        Wed, 23 Nov 2022 14:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 616C561F4B;
        Wed, 23 Nov 2022 22:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE67AC433C1;
        Wed, 23 Nov 2022 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669241850;
        bh=btg/2FUCoDNEAFPa3hm5+j+MaoLTsn2TxcmjRmx15vU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pp6MYLpO/6xD7CfM6XlhBQCayufBQ4jG0jC5E68OYEwprmmUJ2giWuTGwbwE+hS9K
         Z65KBPOF0AHoBKOTrpqkk+VdKP10CNMb8BX3+//XPiU/9cKBvp0TR65IPvP71ChBKO
         XChe4M0XCwhTw8BG4rHpdsps4DpmgAfW096Hw9dmHYUqEDxNnXiqGkMzaWl9UygZFG
         +Soge1IYE0M7p/9BgfdOipW5pSJNAztUg/LZqKkGD0zRNb0qVYuUwCL7qDwovLySwX
         v2fnFgoyN3Fbduyctyg+OO3R+rXyViORu5/omV3VkkINXUvEmlo+WK27SQ6Wkima6p
         b8NVqkEzgwJPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 668B25C0C71; Wed, 23 Nov 2022 14:17:30 -0800 (PST)
Date:   Wed, 23 Nov 2022 14:17:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        rcu@vger.kernel.org
Subject: Re: PID_NS unshare VS synchronize_rcu_tasks() (was: Re: [Syzkaller &
 bisect] There is task hung in "synchronize_rcu" in v6.1-rc5 kernel)
Message-ID: <20221123221730.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y3sOgrOmMQqPMItu@xpf.sh.intel.com>
 <20221123143758.GA1387380@lothringen>
 <Y35ALpl8borkSHjy@xpf.sh.intel.com>
 <20221123220648.GA1395324@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123220648.GA1395324@lothringen>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:06:48PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 23, 2022 at 11:45:50PM +0800, Pengfei Xu wrote:
> > On 2022-11-23 at 15:37:58 +0100, Frederic Weisbecker wrote:
> > > I have no idea how to solve the situation without violating the pid_namespace
> > > rules and unshare() semantics (although I wish unshare(CLONE_NEWPID) had a less
> > > error prone behaviour with allowing creating more than one task belonging to the
> > > same namespace).
> > > 
> > > So probably having an SRCU read side critical section within exit_notify() is
> > > not a good idea, is there a solution to work around that for rcu tasks?
> > > 
> >   Thanks for the analysis!
> >   Add one more information: I tried to revert this commit only on top of
> >   v6.1-rc5 mainline by script, but it caused kernel make to fail, it could not
> >   confirm the bisect information is 100% accurate if I could not pass the
> >   revert step verification. I just provide all the information I could.
> 
> No problem, I managed to reproduce with latest upstream.
> I don't think the bisected commit is the culprit though, it may perhaps just make
> the issue more likely to happen.

Frederic, Boqun, Neeraj, and I dug through this earlier today, and
record of our wanderings may be found here:

https://docs.google.com/document/d/1hJxgiZ5TMZ4YJkdJPLAkRvq7sYQ-A7svgA8no6i-v8k/edit?usp=sharing

It looks like we can break the deadlock within RCU Tasks, but it also
looks like the namespace-PID semantics are at best an accident waiting
to happen.  ;-)

							Thanx, Paul

> Thanks.
> 
> > 
> >   And this issue is too difficult to me.
> >   If I find more clue, I will update the eamil.
> > 
> >   Thanks!
> >   BR.
> > 
> > > Thanks.
