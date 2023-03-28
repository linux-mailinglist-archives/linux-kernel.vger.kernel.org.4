Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55E6CC99A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC1RsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC1RsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16727CDF6;
        Tue, 28 Mar 2023 10:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1B3C618DF;
        Tue, 28 Mar 2023 17:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FBAC433D2;
        Tue, 28 Mar 2023 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680025695;
        bh=32/NC1qj5pzM4VmWjHIt+6Z5bu6FnwdwjV4jQTvBriQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=DtyziAyrMXV80hjYX1tJikjNn8VSeb88kiLbovAz36YoLsdfOk3rbhwrgF9pu+kFB
         q9nmm7L6hU3+64Zm7ihDMZYWj7b3yKomtFPeLVUjZF9dnM9n1Xr1dBRkbRNQFUOMAN
         rxtI6G/iJ/xa5cQsN4TOFzqd7vQ32cOIwprP3dbaQkOb7qpj2ba+V4T4NqYV/XEFg9
         9A5gSOxRADGwKAN6ZlPP3XHVCOWI6pVmHQ19GIWHfvKTj0nSyFZgDz1xApWFQVUn6Y
         bnX2W0mp3lQKmmHshywsoNx903DthlZW30zaiO9HkovjzhKZk//8Ihn/05iB2mOi0F
         fgBBUkPfswuag==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9AB661540479; Tue, 28 Mar 2023 10:48:14 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:48:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        douglas.raillard@arm.com, tglx@linutronix.de, rcu@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: [GIT PULL] Fix rcu_torture_read ftrace event
Message-ID: <9f32a8e2-7fc3-427b-b1e2-238fe81ce97e@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URG_BIZ autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This post-merge-window urgent pull request brings the rcu_torture_read
event trace into line with the new trace tools.  Without this commit,
users of those tools perceive a regression.

Just in case there is confusion, the plan is still for Joel Fernandes
and Boqun Feng to send the RCU pull request into the v6.4 merge window.
I will be doing my other pull requests for v6.4, and I will also be
handling the RCU pull request for the v6.5 merge window.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.03.28a

for you to fetch changes up to d18a04157fc171fd48075e3dc96471bd3b87f0dd:

  rcu: Fix rcu_torture_read ftrace event (2023-03-22 14:05:24 -0700)

----------------------------------------------------------------
Urgent RCU pull request for v6.3

This commit brings the rcu_torture_read event trace into line with
the new trace tools by replacing this event trace's __field() with the
corresponding __array().  Without this commit, the new trace tools will
fail when presented wtih an rcu_torture_read event trace, which is a
regression from the viewpoint of trace tools users.

https://lore.kernel.org/all/20230320133650.5388a05e@gandalf.local.home/

----------------------------------------------------------------
Douglas Raillard (1):
      rcu: Fix rcu_torture_read ftrace event

 include/trace/events/rcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
