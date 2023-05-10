Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D56FE2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjEJRDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjEJRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FCB358C;
        Wed, 10 May 2023 10:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D1B63F38;
        Wed, 10 May 2023 17:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C5DC433EF;
        Wed, 10 May 2023 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738156;
        bh=a3+oVFXC7npzGJ9ceo4yz5ZhJen4rRawc2jMdc6sqas=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=AoTRYa2Mddp1oeGbUYnUBhwGnT/DrSA0nWEPkx8f2dYgWRXeattR5QMZBMraJraIF
         pxed8Y2J5zn66APLP7bmdHYInB8JTdvnbJ2PVCbKPGTWhK3lkAFe1YvWQAnIAwgvuy
         hQeXgVZXUJPOqanh3+yCzOfpvu40eWgZvn2+wUfyVPJbBvRDCkrq3tsbbrbZ33Y82D
         pOzXnT1FVK06ha/or46zdlfn59LcbOfZNRWkaJMWwWoASZUFhMds7vuJiPMWNr50Pv
         WO6MvOCFYaC6UPonsGGt+2xb3DPcKcgl9h7Vca26AyQocRs8q4EH0vhtHn3Tad269m
         njQHKZskwOyYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C0984CE126E; Wed, 10 May 2023 10:02:35 -0700 (PDT)
Date:   Wed, 10 May 2023 10:02:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/8] kvfree_rcu() changes for v6.5
Message-ID: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains updates for kvfree_rcu(), perhaps most notably
the removal of single-argument k{,v}free_rcu() in favor of the new-ish
k{,v}free_rcu_mightsleep().

1.	rcu/kvfree: Eliminate k[v]free_rcu() single argument macro,
	courtesy of "Uladzislau Rezki (Sony)".

2.	rcu/kvfree: Add debug to check grace periods.

3.	rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu
	list, courtesy of "Uladzislau Rezki (Sony)".

4.	rcu/kvfree: Invoke debug_rcu_bhead_unqueue() after checking
	bnode->gp_snap, courtesy of Zqiang.

5.	rcu/kvfree: Use consistent krcp when growing kfree_rcu() page
	cache, courtesy of Zqiang.

6.	rcu/kvfree: Do not run a page work if a cache is disabled,
	courtesy of "Uladzislau Rezki (Sony)".

7.	rcu/kvfree: Make fill page cache start from krcp->nr_bkv_objs,
	courtesy of Zqiang.

8.	rcu/kvfree: Make drain_page_cache() take early return if cache
	is disabled, courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |   29 ++++++++---------------------
 b/kernel/rcu/tree.c        |   37 +++++++++++++++++++------------------
 kernel/rcu/tree.c          |   21 +++++++++++++++++----
 3 files changed, 44 insertions(+), 43 deletions(-)
