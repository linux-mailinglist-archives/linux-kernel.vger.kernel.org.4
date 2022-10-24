Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96A60B7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiJXTf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiJXTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:34:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A929D532;
        Mon, 24 Oct 2022 11:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 286C7B811C2;
        Mon, 24 Oct 2022 16:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2746C433D7;
        Mon, 24 Oct 2022 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666630461;
        bh=rARJVaCycV3Lh7fwN+ZA5IhIb9PpP1Hw7Aw8GOMPGZs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=BYDTAdWJkpneuy2ZhHojlRm5xdM0V1LGrrfKUfR547bxIihfH3oJQKxlgu1s0WcbV
         FGkoeku1HnTrpVe0p4rv+wAcdQY5gRpsr9V1saLYKybih+ac+IGF8cPiOWEgds5muQ
         opiXUooSJ1tMhwZDsr1yIEKwgHMz82e6ve/EEE+E/AEIhV5Ygq2q2QocE2uF3WvIHU
         kOyeg18FMXZ+WmhmhsHZoO51r/7wrrc7awdIxe3X8SA+EsrTAFbX3uFP4fXdtTRTho
         s8Tf4VkovjgozLtAUFUNNPgOS4gAoAXwt+jiNpc5T175Rv8UsKzy7oQsDKxR+tYl8C
         RDCjT+cVw1jyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AE5F5C05FB; Mon, 24 Oct 2022 09:54:21 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:54:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Subject: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early boot
Message-ID: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This pull request fixes a merge-window regression noted by Steve Rostedt.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.10.20a

for you to fetch changes up to 31d8aaa87fcef1be5932f3813ea369e21bd3b11d:

  rcu: Keep synchronize_rcu() from enabling irqs in early boot (2022-10-20 15:34:49 -0700)

----------------------------------------------------------------
Urgent RCU pull request for v6.1

This pull request contains a commit that fixes bf95b2bc3e42 ("rcu: Switch
polled grace-period APIs to ->gp_seq_polled"), which could incorrectly
leave interrupts enabled after an early-boot call to synchronize_rcu().
Such synchronize_rcu() calls must acquire leaf rcu_node locks in order to
properly interact with polled grace periods, but the code did not take
into account the possibility of synchronize_rcu() being invoked from
the portion of the boot sequence during which interrupts are disabled.
This commit therefore switches the lock acquisition and release from
irq to irqsave/irqrestore.

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu: Keep synchronize_rcu() from enabling irqs in early boot

 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
