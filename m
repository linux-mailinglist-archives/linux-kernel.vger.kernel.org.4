Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B465E17A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjAEAXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjAEAXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A71AD9E;
        Wed,  4 Jan 2023 16:22:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98DE61770;
        Thu,  5 Jan 2023 00:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594E7C433EF;
        Thu,  5 Jan 2023 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878178;
        bh=LxE8tI528Th4z3BZTcrakTt7R1fnoroB1j0wBhc5vtA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lN6MwCXk2nlMvzfhlmfejozgA2SRyV/vGyk9kntbYAab5kJqFxv5Dy9f+boWNIic+
         qN5tlloA/DM3Kf9c0vNcap3d7GCXRXbdWL6ne/XKv5ixAppPrmjZ3WYEu68cvuzDjM
         203GSm3h/WKbJq/Qu4dE+G3r/krzEHhW2H45yDJkxf4ajSaIR4noPj0ytj/nvVeS5b
         i+zMmpqo6bFpEikhhQ+oGk7TASvSLMSmNEt6JcXwa3KgKpfL9jg6dBCMdBHAZg3E0d
         Dqj3ECNEAZYNxKjeNUydNaLa7r/T4ChB0LcBxoVJHPQj0uO2Ts+Ulbq5beGIJWHPH6
         54wVpZqwOXWvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EB1C95C05CA; Wed,  4 Jan 2023 16:22:57 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:22:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/10] Miscellaneous fixes for v6.3
Message-ID: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
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

This series contains miscellaneous fixes:

1.	Use hlist_nulls_next_rcu() in hlist_nulls_add_tail_rcu(),
	courtesy of Zhao Mengmeng.

2.	Consolidate initialization and CPU-hotplug code.

3.	Throttle callback invocation based on number of ready callbacks.

4.	Upgrade header comment for poll_state_synchronize_rcu().

5.	Make RCU_LOCKDEP_WARN() avoid early lockdep checks.

6.	Suppress smp_processor_id() complaint in
	synchronize_rcu_expedited_wait().

7.	Make rcu_blocking_is_gp() stop early-boot might_sleep(), courtesy
	of Zqiang.

8.	Test synchronous RCU grace periods at the end of rcu_init().

9.	Allow expedited RCU CPU stall warnings to dump task stacks.

10.	Remove redundant call to rcu_boost_kthread_setaffinity(),
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    5 
 b/include/linux/rculist_nulls.h                   |    2 
 b/include/linux/rcupdate.h                        |    9 
 b/kernel/rcu/rcu.h                                |    1 
 b/kernel/rcu/rcu_segcblist.c                      |    2 
 b/kernel/rcu/rcu_segcblist.h                      |    2 
 b/kernel/rcu/tree.c                               |  314 +++++++++++-----------
 b/kernel/rcu/tree_exp.h                           |    2 
 b/kernel/rcu/update.c                             |    1 
 kernel/rcu/tree.c                                 |   24 +
 kernel/rcu/tree_exp.h                             |   41 ++
 kernel/rcu/update.c                               |    2 
 12 files changed, 237 insertions(+), 168 deletions(-)
