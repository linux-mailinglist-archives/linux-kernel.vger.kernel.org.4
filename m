Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B616410EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiLBWzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiLBWzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:55:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF351E9898;
        Fri,  2 Dec 2022 14:55:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB856235E;
        Fri,  2 Dec 2022 22:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426F3C433D6;
        Fri,  2 Dec 2022 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670021737;
        bh=KJTHUzqclFtDCzciMQmEBUQWMMcxoS6RrbXN49EzJgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmuPGtilld0QwflQqgLJ/izaoJbIuksuhkNhjPGWdwIsPqVf6xHg4nF71LsVxSRTV
         guRA80BeWKAOjP4v7qsgyPPMTLMxMbyIvsGIDVdOKg8HcbXc8zzn5KUZmNenewUiaf
         KKDBIxkKzmuyBXI/NGnzXvvaS+6QGgLe6Y+T3nWbPv2WNkGiY1Q50/W1aPomw4oLIS
         xp3f7JtKXaIJHcYxLalg8sHZpwfeLqXV3QlC5P2X8jdUk1zEjO5mPlPF6+dYlgYmpz
         Ys0BxQtbL7t/npIYlCjO4SiioBrGIRRTZaUGyMdouKNWOrEBWska3tJTCAovUbsy91
         dYk3SUFgn8RCg==
Date:   Fri, 2 Dec 2022 23:55:34 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu-tasks: Fix race against exiting pid_ns
Message-ID: <20221202225534.GB1754872@lothringen>
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221129002240.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <20221129095500.GA1706373@lothringen>
 <20221129144834.GW4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129144834.GW4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:48:34AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 29, 2022 at 10:55:00AM +0100, Frederic Weisbecker wrote:
> > On Mon, Nov 28, 2022 at 04:22:40PM -0800, Paul E. McKenney wrote:
> > > On Fri, Nov 25, 2022 at 02:54:57PM +0100, Frederic Weisbecker wrote:
> > > > Pengfei Xu has reported a deadlock involving calls to unshare(),
> > > > perf_event_open() and clone3() calls. It requires CAP_SYS_ADMIN
> > > > to reproduce (at least I don't see a way for a non privilege process to
> > > > reproduce).
> > > > 
> > > > See this thread for details: https://lore.kernel.org/all/Y3sOgrOmMQqPMItu@xpf.sh.intel.com/
> > > > And this document for the collaborative analysis with Boqun, Paul and Neeraj:
> > > > https://docs.google.com/document/d/1hJxgiZ5TMZ4YJkdJPLAkRvq7sYQ-A7svgA8no6i-v8k
> > > > 
> > > > The two first patches are small improvements. The fix is in the last patch.
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > > 	rcu/dev
> > > > 
> > > > HEAD: 45ef5a0a4be4e0db9eadcc86e8f346d34c62e744
> > > 
> > > Hearing no objections, queued for further review and testing.
> > > 
> > > And thank you very much!  That race between synchronize_rcu_tasks() and
> > > zap_pid_ns_processes() certainly was more than a bit on the non-trivial
> > > side.  Good show!!!
> > 
> > Thanks!
> > 
> > Also please replace the last patch with the following to fix
> > a !CONFIG_RCU_TASKS issue:
> 
> Like this?  ;-)
> 
> a0c355bbdfee ("squash! rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()")

You got it! :)
