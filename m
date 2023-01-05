Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B865E210
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjAEAzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAEAye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607949167;
        Wed,  4 Jan 2023 16:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D3A617E1;
        Thu,  5 Jan 2023 00:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B54C433D2;
        Thu,  5 Jan 2023 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879866;
        bh=+SBGJcW5NM+jwceWVhNAhuUN+/+/UkOjdZBLUpdiCc0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LycCrF9oDneYfT1T9HIFikIqZak9IVe3LsiWKHUozuRW7SlUiWrjGhPa4SKJi4bbD
         JfDnVMdbl7yv+38zbVAIU8r9adn0b1xdAeqK93TqDfVn5KAWGuiknwSScg8MgoYtaz
         4LQTanwmwffwSwEC3aQGNrjUgjrH3duAOfJY7DKmWKu2QZaif9+ZLO+AvCOcQZZ89R
         US0qLFIrwe0wL9BqE4ZKkgOz/+k5hL6VJMgR3e2TKJ6VjHfDMGCksZdZgmUKp5qIlx
         mTDREfBPeVw3jaxcfcESjuWFP2mhtUbsP7+O8M1NtP66KhU6aTd6gE0WRVR35uxJpC
         sg/ntPgLwLB+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7EBB5C05CA; Wed,  4 Jan 2023 16:51:05 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:51:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/6] RCU CPU stall-warning updates for v6.3
Message-ID: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains RCU CPU stall-warning updates:

1.	Fix the return type of kstat_cpu_irqs_sum(), courtesy of Zhen Lei.

2.	Add helper kstat_cpu_softirqs_sum(), courtesy of Zhen Lei.

3.	Add helper nr_context_switches_cpu(), courtesy of Zhen Lei.

4.	Add RCU stall diagnosis information, courtesy of Zhen Lei.

5.	Align the output of RCU CPU stall warning messages, courtesy of
	Zhen Lei.

6.	Allow up to five minutes expedited RCU CPU stall-warning timeouts.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    6 ++++
 b/include/linux/kernel_stat.h                     |    2 -
 b/kernel/rcu/Kconfig.debug                        |   13 +++++++++
 b/kernel/rcu/rcu.h                                |    1 
 b/kernel/rcu/tree.c                               |   18 ++++++++++++
 b/kernel/rcu/tree.h                               |   19 +++++++++++++
 b/kernel/rcu/tree_stall.h                         |   31 ++++++++++++++++++++++
 b/kernel/rcu/update.c                             |    2 +
 b/kernel/sched/core.c                             |    5 +++
 include/linux/kernel_stat.h                       |   12 ++++++++
 kernel/rcu/Kconfig.debug                          |    2 -
 kernel/rcu/tree_stall.h                           |    6 ++--
 12 files changed, 112 insertions(+), 5 deletions(-)
