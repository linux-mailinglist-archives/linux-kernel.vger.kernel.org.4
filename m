Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2757E671223
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjARDwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:51:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12135539A7;
        Tue, 17 Jan 2023 19:51:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F406160E;
        Wed, 18 Jan 2023 03:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F796C433EF;
        Wed, 18 Jan 2023 03:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674013916;
        bh=dEYSGboa3dhu7pdkXCLnOttQPHIftJ4RL4c/3phyXj8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g6O1VY5KvR5PVCMIrj8wTYpNZDiH4um1Syj3SMdAk1vL60ltZ6SEuAo7+tpherwDK
         yNNnSQnlw8AyG26rl+Jg7F02Qm3adakl22hP1WcuqSmVmE7hi4bupDxBHaY+q5jg66
         0JpuJr+96wzGx2hDeEGO1YsOJWwytU+3DbwBCnUAtVgxca88zKOyl2y2QdyBsujkVl
         kjPUVqjwRLvzq7WmOo9Rb/r4BvyyBwPK15m2vmsAlYqiYCZnzkMLapA6Wb5S31FSmK
         mt9s1pxnamZDVsAe0Zk//IQhTuvixZHfDgAanOQXid6aCdnQ6i57szBPW2GPG2sS9S
         J/P0NxMZqaSvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B57175C1052; Tue, 17 Jan 2023 19:51:55 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:51:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230118035155.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230115162504.08ef72b0@rorschach.local.home>
 <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
 <20230117143224.6fbf7da8@gandalf.local.home>
 <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230117164029.434a2336@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117164029.434a2336@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:40:29PM -0500, Steven Rostedt wrote:
> On Tue, 17 Jan 2023 11:37:34 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > The reason for the export should have been mentioned in the change log if
> > > the patch is not obvious to why it is being exported.  
> > 
> > Would something like this suffice?  With attribution, of course.
> > 
> > 	Export rcu_async_should_hurry(), rcu_async_hurry(), and
> > 	rcu_async_relax() for later use by rcutorture.
> 
> Yes thanks. That way, at least a git blame will give some rationale for the
> export.

Very well, I will apply this on my next rebase.

							Thanx, Paul
