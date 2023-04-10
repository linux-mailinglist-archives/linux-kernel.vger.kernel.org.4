Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E686DC951
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDJQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDJQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D53E54;
        Mon, 10 Apr 2023 09:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE6660C7A;
        Mon, 10 Apr 2023 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C01C433EF;
        Mon, 10 Apr 2023 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681144233;
        bh=sR6n/qvfkC94IMl9pOR6cp2mpmZqT/XtG23wRekNYd0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tKexRDq2ys+ZWaofhBuFP7xMe0L72F2Y8H1rgFHCDuIJv571NwDZB3lVsQvGO8FUk
         IF+/lG8vWNKe/V8SBsgocZD18hFuKBVQhIvYZKScATD1zYneSjhBfwibetdAV1uI3Q
         tG69nwO+B80IyZ07tCamX5MRFtrUYddGBIhz3HbAVAibRA1/kyyhVm96UUPC/in5I1
         KWksETgQIp4oJz+molYMmqSk0HHsAY/lEePKcPOLi/cXX0hwsxvomA4MSfG/1NCFnE
         V9JbVrn3Dgc3MUmqUhpZ6SOYMlnkGpV6wqKJHt40F2YdCwui1cUJfRubaQ/oV0qJEw
         cdOK0SGIYLY3A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F7D31540478; Mon, 10 Apr 2023 09:30:33 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:30:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Subject: [GIT PULL] Fix too-short kfree_rcu() grace period for v6.3
Message-ID: <5c2748db-4811-4d3d-bdd3-0f005ffa275c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URG_BIZ autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This fixes an old bug rather than a v6.3 regression, but it is starting
to appear in the wild and has nasty memory-corruption consequences.
Please consider pulling this for v6.3.

The following changes since commit d18a04157fc171fd48075e3dc96471bd3b87f0dd:

  rcu: Fix rcu_torture_read ftrace event (2023-03-22 14:05:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.04.07a

for you to fetch changes up to 5da7cb193db32da783a3f3e77d8b639989321d48:

  rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period (2023-04-06 10:04:23 -0700)

----------------------------------------------------------------
Urgent RCU pull request for v6.3

This commit fixes a pair of bugs in which an improbable but very real
sequence of events can cause kfree_rcu() to be a bit too quick about
freeing the memory passed to it.  It turns out that this pair of bugs
is about two years old, and so this is not a v6.3 regression.  However:
(1) It just started showing up in the wild and (2) Its consequences are
dire, so its fix needs to go in sooner rather than later.

Testing is of course being upgraded, and the upgraded tests detect this
situation very quickly.  But to the best of my knowledge right now, the
tests are not particularly urgent and will thus most likely show up in
the v6.5 merge window (the one after this coming one).

Kudos to Ziwei Dai and his group for tracking this one down the hard way!

----------------------------------------------------------------
Ziwei Dai (1):
      rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period

 kernel/rcu/tree.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)
