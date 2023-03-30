Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA366D127E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjC3Wrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjC3Wrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF79810260;
        Thu, 30 Mar 2023 15:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98133621B6;
        Thu, 30 Mar 2023 22:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF273C433D2;
        Thu, 30 Mar 2023 22:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216423;
        bh=4jYmhmp47uOvZtdHQ0v//zemjNfZtnZjGHBhC5uAjH4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=GUinQEY5wUkcVKqQXVUPhdjIYsJgmOVeiSHzfTNUqk/yqyUzzVZuGynKUPFllOWXr
         DyvY8fm8360BN3oelhk0WBJMHhNhqhr1SSS4WXSduXQrbmhBXIG116utuEma4DGvOI
         rqehKwxAw1nusqImrnUFV2rf3pKBrygJ8C6OUbqMglys69t+FQTlHEkr3hDG9Abz6t
         ieRmRbCGKAovAnSQrXytpaVAw416TSqo4dURH7jJ4P20alVoQg98yx2SlymdU8Cx/3
         lB/Z6LqWF0n/EC5p3Ue8TNyCnb6qg9Tc2jNBYQS3S9by4+qEIxexVcvYaRPA6j78NH
         pKqZe5mF9YNyg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8B0551540476; Thu, 30 Mar 2023 15:47:02 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:47:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de
Subject: [PATCH rcu 0/20] Further shrink srcu_struct to promote cache locality
Message-ID: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This post-RFC series shrinks the srcu_struct structure to the bare minimum
required to support SRCU readers, relegating the remaining fields to a new
srcu_usage structure.  Statically allocated srcu_struct structures created
by DEFINE_SRCU() and DEFINE_STATIC_SRCU() have statically allocated
srcu_usage structures, but those required for dynamically allocated
srcu_struct structures that are initialized using init_srcu_struct()
are dynamically allocated.

The results is a reduction in the size of an srcu_struct structure from
a couple hundred bytes to just 24 bytes on x86_64 systems.  This can be
helpful when SRCU readers are used in a fastpath for which the srcu_struct
structure must be embedded in another structure, and especially where
that fastpath also needs to access fields both before and after the
srcu_struct structure.

This series takes baby steps, in part because breaking SRCU means that
you get absolutely no console output.  Yes, I did learn this the hard way.
Why do you ask?  ;-)

Here are those baby steps:

1.	rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu.

2.	Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU().

3.	Use static init for statically allocated in-module srcu_struct.

4.	Begin offloading srcu_struct fields to srcu_update.

5.	Move ->level from srcu_struct to srcu_usage.

6.	Move ->srcu_size_state from srcu_struct to srcu_usage.

7.	Move ->srcu_cb_mutex from srcu_struct to srcu_usage.

8.	Move ->lock initialization after srcu_usage allocation.

9.	Move ->lock from srcu_struct to srcu_usage.

10.	Move ->srcu_gp_mutex from srcu_struct to srcu_usage.

11.	Move grace-period fields from srcu_struct to srcu_usage.

12.	Move heuristics fields from srcu_struct to srcu_usage.

13.	Move ->sda_is_static from srcu_struct to srcu_usage.

14.	Move srcu_barrier() fields from srcu_struct to srcu_usage.

15.	Move work-scheduling fields from srcu_struct to srcu_usage.

16.	Check for readers at module-exit time.

17.	Fix long lines in srcu_get_delay().

18.	Fix long lines in cleanup_srcu_struct().

19.	Fix long lines in srcu_gp_end().

20.	Fix long lines in srcu_funnel_gp_start().

Changes since the RFC series:
https://lore.kernel.org/all/3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop/

1.	Add checks for readers of in-module statically allocated
	srcu_struct structures persisting past module unload.

2.	Apply Tested-by tags.

3.	Apply feedback from "Zhang, Qiang1" and kernel test robot,
	perhaps most notably getting rid of memory leaks and improving
	the handling of statically allocated srcu_struct structures
	defined within modules.

4.	Drop the commit removing extraneous parentheses given the desire
	to push this into the v6.4 merge window, the fact that this
	commit generates conflicts with other v6.4 RCU commits, and the
	low value of this commit.  It therefore remains in the v6.5 pile.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/notifier.h |    5 
 b/include/linux/srcutiny.h |    6 
 b/include/linux/srcutree.h |   28 +-
 b/kernel/rcu/rcu.h         |    6 
 b/kernel/rcu/srcutree.c    |   19 +
 b/kernel/rcu/tasks.h       |    2 
 include/linux/srcutree.h   |  123 ++++++-----
 kernel/rcu/srcutree.c      |  495 +++++++++++++++++++++++----------------------
 8 files changed, 370 insertions(+), 314 deletions(-)
