Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13367247D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjARRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjARRIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:08:37 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B3701577F0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:08:35 -0800 (PST)
Received: (qmail 214860 invoked by uid 1000); 18 Jan 2023 12:08:34 -0500
Date:   Wed, 18 Jan 2023 12:08:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        npiggin <npiggin@gmail.com>, dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8gnkm1er4XHpPvU@rowland.harvard.edu>
References: <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8dWMyBfz1iiaF8M@rowland.harvard.edu>
 <20230118051704.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gYV81O80BtMvWm@rowland.harvard.edu>
 <Y8gli5C/HqPRYv9Y@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gli5C/HqPRYv9Y@boqun-archlinux>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:59:55AM -0800, Boqun Feng wrote:
> On Wed, Jan 18, 2023 at 11:03:35AM -0500, Alan Stern wrote:
> > On Tue, Jan 17, 2023 at 09:17:04PM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 17, 2023 at 09:15:15PM -0500, Alan Stern wrote:
> > > > Maybe we don't.  Please test the patch below; I think it will do what 
> > > > you want -- and it doesn't rule out nesting.
> > > 
> > > It works like a champ on manual/kernel/C-srcu*.litmus in the litmus
> > > repository on github, good show and thank you!!!
> > > 
> > > I will make more tests, and am checking this against the rest of the
> > > litmus tests in the repo, but in the meantime would you be willing to
> > > have me add your Signed-off-by?
> > 
> > I'll email a real patch submission in the not-too-distant future, 
> > assuming you don't find any problems with the new code.
> 
> I haven't tested the following, but I think we also need it to avoid
> (although rare) mixing srcu_struct with normal memory access?
> 
> Since you are working on a patch, I think I better mention this ;-)
> 
> Regards,
> Boqun
> 
> diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> index 6b52f365d73a..c134c2027224 100644
> --- a/tools/memory-model/lock.cat
> +++ b/tools/memory-model/lock.cat
> @@ -37,7 +37,7 @@ let RU = try RU with emptyset
>  let LF = LF | RL
> 
>  (* There should be no ordinary R or W accesses to spinlocks *)
> -let ALL-LOCKS = LKR | LKW | UL | LF | RU
> +let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock
>  flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> 
>  (* Link Lock-Reads to their RMW-partner Lock-Writes *)

Great point!  I'll at this to the patch, thanks.

Alan
