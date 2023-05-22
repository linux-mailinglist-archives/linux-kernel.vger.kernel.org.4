Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE970C190
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEVO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEVO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5ABB;
        Mon, 22 May 2023 07:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93B1A61D10;
        Mon, 22 May 2023 14:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D3BC433EF;
        Mon, 22 May 2023 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767423;
        bh=krocsysGoIXxLWD9pW6Qf8J+32ovtqIzJVZ7ME9VaEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=giBMrd5zO+PzXemVJU9bzw3JV7YEMj6LtSjS2ch66s70cUv4R+k/L67x+YO1YKD+4
         eVOrdb0w2jM6fCS0ArFkvXRyFyFaAjDAdWawDS5PQ0mD99yBdM+XWzlA+hGcMz3eBQ
         JdLn6RQAXBGngCUdTOgJIQMdKXoCnc5l5osmb+WjZGt8wOEw7iLE1Xf+UgUIi6gRJj
         VCDv8U0NRDFrZCCUPEbKjNe6d0OQcVWlhxDeKWx9iOEy9avejYU2w2jL+oibP99YZ3
         Z2KYhR7yDoUAiOKVj9UIoWcQTX7X5kP6GHpPQSPlmVDQNKfSR24nt6hh/JJ2wI8ufa
         qGi10OHF0wnhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AD084CE0CC3; Mon, 22 May 2023 07:57:00 -0700 (PDT)
Date:   Mon, 22 May 2023 07:57:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <2a55ce77-75ec-461d-9050-696c2537619b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230519105950.2d021e86@canb.auug.org.au>
 <cc4ab028-cad3-413b-8360-ea34f6914ec7@paulmck-laptop>
 <20230522114503.7404d59c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522114503.7404d59c@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:45:03AM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Thu, 18 May 2023 19:12:52 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > On Fri, May 19, 2023 at 10:59:50AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> > > failed like this:
> > > 
> > > kernel/rcu/rcuscale.c:340:27: error: 'get_rcu_tasks_trace_gp_kthread' undeclared here (not in a function); did you mean 'show_rcu_tasks_trace_gp_kthread'?
> > >   340 |         .rso_gp_kthread = get_rcu_tasks_trace_gp_kthread,
> > >       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       |                           show_rcu_tasks_trace_gp_kthread
> > > 
> > > Caused by commit
> > > 
> > >   9bb839a83e1b ("rcuscale: Measure grace-period kthread CPU time")
> > > 
> > > CONFIG_RCU_SCALE_TEST=m
> > > 
> > > I have used the rcu tree from next-20230518 for today.  
> > 
> > Huh.  Modules and #ifdefs trip me up again.  Will fix, and thank you
> > for catching it!
> 
> This is now:
> 
> ERROR: modpost: "get_rcu_tasks_trace_gp_kthread" [kernel/rcu/rcuscale.ko] undefined!
> 
> I have used the rcu tree from next-20230518 again for today.

-ENOREPRODUCE

Perhaps the #ifdef around its definition is causing trouble in your
environment.  And to be fair, the small-memory systems that might not
want that function unconditionally defined could do even better by not
configuring anything requiring Tasks Trace RCU.

I will adjust.  Here is hoping!

							Thanx, Paul
