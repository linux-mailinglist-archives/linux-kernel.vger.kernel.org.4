Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C165E18D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjAEA0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjAEA0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7894D706;
        Wed,  4 Jan 2023 16:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B84B761881;
        Thu,  5 Jan 2023 00:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A4C433D2;
        Thu,  5 Jan 2023 00:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878282;
        bh=oCquJHQ5qvbPHcFqmzO6M/70tP+Z9dXfhqcaGkWfu5Q=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Gz61bg5OybJWJv4Z+BrMJ1Dz4xBgHeCBOd/bDUJwlmJHjre3N5m8U+N6cMwKmY+tM
         02q7kbl9Pi1NV2sMCv6HdiBWWRSJbFrqvsaar4kHYj1SzsLe2WMMi5Efq/xtKEQcE/
         cQl3MdDjhyQrmmJyXDq+VzYZxULXjzEAkNoEsmrRbc3WAx52+TsvoPNTfbZBNki0/r
         8ID8hd+uD6uP3GoRfHyGh5jV2z8VK4itObbp4JwuQGNDUNpdxwpTOx+ySTAjOSGz9T
         FKwSjSov9/U6rQkxHZk0YaQs0zqJ5xit/g7DFduDKt79JK+RE01def9hXYarg5nXRm
         gS9z+x17VRrFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D591E5C05CA; Wed,  4 Jan 2023 16:24:41 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:24:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/8] kvfree_rcu updates for v6.3
Message-ID: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
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

This series contains a few kvfree_rcu() updates:

1.	Refactor kvfree_call_rcu() and high-level helpers, courtesy of
	"Uladzislau Rezki (Sony)".

2.	Switch to a generic linked list API, courtesy of "Uladzislau Rezki
	(Sony)".

3.	Move bulk/list reclaim to separate functions, courtesy of
	"Uladzislau Rezki (Sony)".

4.	Move need_offload_krc() out of krcp->lock, courtesy of "Uladzislau
	Rezki (Sony)".

5.	Use a polled API to speedup a reclaim process, courtesy of
	"Uladzislau Rezki (Sony)".

6.	Use READ_ONCE() when access to krcp->head, courtesy of "Uladzislau
	Rezki (Sony)".

7.	Carefully reset number of objects in krcp, courtesy of "Uladzislau
	Rezki (Sony)".

8.	Split ready for reclaim objects from a batch, courtesy of
	"Uladzislau Rezki (Sony)".

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    5 
 b/include/linux/rcutiny.h  |   12 -
 b/include/linux/rcutree.h  |    2 
 b/kernel/rcu/tiny.c        |    9 -
 b/kernel/rcu/tree.c        |   29 +--
 kernel/rcu/tree.c          |  392 +++++++++++++++++++++++++++------------------
 6 files changed, 261 insertions(+), 188 deletions(-)
