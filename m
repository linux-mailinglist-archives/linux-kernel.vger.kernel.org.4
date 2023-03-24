Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D4E6C746D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCXATM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCXATK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC361CC05;
        Thu, 23 Mar 2023 17:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E956280C;
        Fri, 24 Mar 2023 00:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDBC433EF;
        Fri, 24 Mar 2023 00:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617148;
        bh=IT1NxcXw2pAVasDPEQHbwE+mpHcOER7ahsHXYZ2RRJU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YNUC1KV7PPaLp93YVhVlnR9dfxSOQ0WEOoKPTsw1KgEkzFS52OxMD9wiiEqjruYFA
         IAsi6DHiQe6BGt6xJbz+dnKKpyz7m04AgbC1nDXhW56uYkb5nTUyJf/daRx0Cgd2Q5
         XEJPhWnEb1bY+BqDDOr3fH3jxNTWPai2sh68ZmZkkvLnXWX2MW64vTbnxxE509Nisw
         513/q2+HMmw9uiG+3MrHwLza6XzvEc9Iqe8CLrdDIivd5b0xDL5Z0Nzdl5pn5zOg3m
         BFT80JWN/SUs493CzakatMdKabQboRPGTDgyfnK6Mgz2dqsfrkCJCFVnuZcuVzXY3E
         Ke5RfvWuJn0ag==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5626F1540379; Thu, 23 Mar 2023 17:19:08 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:19:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de
Subject: [PATCH RFC rcu 0/19] Further shrink srcu_struct to promote cache
 locality
Message-ID: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
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

This RFC series shrinks the srcu_struct structure to the bare minimum
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

1.	Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU().

2.	Use static init for statically allocated in-module srcu_struct.

3.	Begin offloading srcu_struct fields to srcu_update.  Note that
	this affects notifiers, which open-code static allocation of
	an srcu_struct structure.  (And no, I still do not see a way to
	abstract this, sorry!)

4.	Move ->level from srcu_struct to srcu_usage.

5.	Move ->srcu_size_state from srcu_struct to srcu_usage.

6.	Move ->srcu_cb_mutex from srcu_struct to srcu_usage.

7.	Move ->lock initialization after srcu_usage allocation.

8.	Move ->lock from srcu_struct to srcu_usage.

9.	Move ->srcu_gp_mutex from srcu_struct to srcu_usage.

10.	Move grace-period fields from srcu_struct to srcu_usage.

11.	Move heuristics fields from srcu_struct to srcu_usage.

12.	Move ->sda_is_static from srcu_struct to srcu_usage.

13.	Move srcu_barrier() fields from srcu_struct to srcu_usage.

14.	Move work-scheduling fields from srcu_struct to srcu_usage.

15.	Fix long lines in srcu_get_delay().

16.	Fix long lines in cleanup_srcu_struct().

17.	Fix long lines in srcu_gp_end().

18.	Fix long lines in srcu_funnel_gp_start().

19.	Remove extraneous parentheses from srcu_read_lock() etc.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/notifier.h |    5 
 b/include/linux/srcu.h     |    8 
 b/include/linux/srcutiny.h |    6 
 b/include/linux/srcutree.h |   28 +-
 b/kernel/rcu/rcu.h         |    6 
 b/kernel/rcu/srcutree.c    |   19 +
 include/linux/srcutree.h   |  123 ++++++-----
 kernel/rcu/srcutree.c      |  488 +++++++++++++++++++++++----------------------
 8 files changed, 368 insertions(+), 315 deletions(-)
