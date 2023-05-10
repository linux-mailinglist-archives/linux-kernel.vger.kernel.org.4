Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B786FE2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjEJQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbjEJQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE835A9;
        Wed, 10 May 2023 09:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841E063E9F;
        Wed, 10 May 2023 16:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB57EC4339B;
        Wed, 10 May 2023 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737908;
        bh=0MTkatJ7kgJgaZCFLKN9q20Wq6EuzATenzLJddk8ug0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Uob4DUVlHU3yo7oHYnCnhaAh8N9EA2pvxZ8bRU+NHJ3QP8ici949apy1b0s29HW+c
         osaiJgOYPAXuekXEW0fr3H+0wknw/+KI235nH2Im8EFl5Uluae0tfVZg4ITLYBIUTw
         gI9at4ATdkOjoxfHJcDPi4g3SOy7FWnNiZSOwO8lWst6lpb/Go/kfDERY3f29gCWTl
         c7617wJzoOl4yfRASQsfhJ/ozqhmOs9Xk5W/nvVuMApb++YO3yf0PHZ5YuzscqtuX/
         XmXCXYOkOGYjuG4G1pcYCjLf1o76aiWWL/cmlzDlDwYcnYqSNER8Pr7/2BEBeGeUEa
         ubXEFgJjWms/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 90450CE126E; Wed, 10 May 2023 09:58:27 -0700 (PDT)
Date:   Wed, 10 May 2023 09:58:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/8] Miscellaneous fixes for v6.5
Message-ID: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series has miscellaneous fixes:

1.	Remove extraneous parentheses from srcu_read_lock() etc..

2.	Remove RCU_NONIDLE(), courtesy of Peter Zijlstra.

3.	Check callback-invocation time limit for rcuc kthreads.

4.	Employ jiffies-based backstop to callback time limit.

5.	Mark additional concurrent load from ->cpu_no_qs.b.exp.

6.	Mark rcu_cpu_kthread() accesses to ->rcu_cpu_has_work.

7.	Make rcu_cpu_starting() rely on interrupts being disabled.

8.	rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined
	CPUs.  This would normally be in the rcu-tasks category, but
	its change to RCU's CPU-hotplug logic results in a source-code
	dependency that puts it here in order to avoid a merge conflict.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Requirements/Requirements.rst |   36 ---------
 b/Documentation/RCU/whatisRCU.rst                        |    1 
 b/include/linux/rcupdate.h                               |   25 ------
 b/include/linux/srcu.h                                   |    8 +-
 b/kernel/rcu/Kconfig                                     |   18 ++++
 b/kernel/rcu/rcu.h                                       |    6 +
 b/kernel/rcu/tasks.h                                     |    7 +
 b/kernel/rcu/tree.c                                      |   28 +++++--
 b/kernel/rcu/tree_exp.h                                  |    2 
 b/kernel/rcu/tree_plugin.h                               |    4 -
 kernel/rcu/tree.c                                        |   55 ++++++++++-----
 11 files changed, 95 insertions(+), 95 deletions(-)
