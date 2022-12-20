Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47236651868
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiLTBma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiLTBmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:42:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B71FCC4;
        Mon, 19 Dec 2022 17:29:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4AC61230;
        Tue, 20 Dec 2022 01:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9334C433D2;
        Tue, 20 Dec 2022 01:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671499746;
        bh=CzMOONJds4355vEVodv5P3MSV2ciisK6U6eGKiAsX+8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=CseRq+aP5oZUpjjA0SyL3jLdIjcIbmWUkE7/hMpLMbChi1mlIKSRG4xPTdk+CsTHA
         tTVg1clRlf3fAMXlSLlWtEmTWlGCGWEDAHIXZHFU5UbFjRqYtRY8kqpKR8XA6LErPF
         zpfaflwN+E19NiTda59iJGGUkVFzqgZ7YyKpnTJHbkjXoQBVpjPUWQfYUF9LY+6tI5
         OgYVyqSdVGOX0xrGMJdn66m6dlxVc3M3QgE1Seg5HKm0Yar/arsd3yRzPsuFa87dCN
         sO62X3XGXyZ5u5Qcj8LazSKhYwRaC5oXAimc9G3wQQFRHlAEq64YlI3yHfboEKaHA5
         N5X1gc1Ox8JUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5CD9C5C09C9; Mon, 19 Dec 2022 17:29:06 -0800 (PST)
Date:   Mon, 19 Dec 2022 17:29:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Subject: [GIT PULL] Avoid synchronize_rcu() false positives in semi-early boot
Message-ID: <20221220012906.GA3102709@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Another merge window, another fix for another regression noted by Steve
Rostedt.  In the true spirit of closing the barn door after the horse
has escaped, the following commit is queued on -rcu to detect this sort
of bug in the future:

f13c14392ebc ("rcu: Test synchronous RCU grace periods at the end of rcu_init()")

The fix simply avoids consulting lockdep about interrupts-disabled
state before the scheduler has been initialized.  After all, before that
time, it is perfectly legal to invoke synchronize_rcu() with interrupts
disabled.

The following changes since commit 31d8aaa87fcef1be5932f3813ea369e21bd3b11d:

  rcu: Keep synchronize_rcu() from enabling irqs in early boot (2022-10-20 15:34:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.12.17a

for you to fetch changes up to 3f6c3d29df58f391cf487b50a24ebd24045ba569:

  rcu: Don't assert interrupts enabled too early in boot (2022-12-17 16:12:20 -0800)

----------------------------------------------------------------
Urgent RCU pull request for v6.2

This commit fixes a lockdep false positive in synchronize_rcu() that
can otherwise occur during early boot.  Theis fix simply avoids invoking
lockdep if the scheduler has not yet been initialized, that is, during
that portion of boot when interrupts are disabled.

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu: Don't assert interrupts enabled too early in boot

 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
