Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BFF640E55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiLBTVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiLBTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:21:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FFBF1156;
        Fri,  2 Dec 2022 11:21:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0523B8223F;
        Fri,  2 Dec 2022 19:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6811CC433D6;
        Fri,  2 Dec 2022 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670008858;
        bh=TEIw1cUY2lL5Hetl818aWjhxu/AHsDNsxwU9jftNBDY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ajegUGXgCAj8lULf+7C5iA1QhBhCf/V7xkPU80JXTF6SMXZG5hlSvmr6sm3LGbHE3
         PwtNlnGaJwXbSPYUdj4baBNACRXaKE4TdSl1PosPZJVdTMg/+5OVvGzxcV0CZ+E8Ou
         O6DXmeSCPn0BYp/kjyjvQbcRm9WZBNjag4oWUvUt7VxGOXd75tR3dRPLNsJu6cHO8U
         zbmSLRdOFJPgPYNgM93D2QdcLZUxsgbgavuwTVmFt/xI1y9o3Ji5ZCSTX/P1GOZZwL
         K4vm+HUNEvClSJ3m/CAQY6ubdMaii+I80NXgXPHpfHqUVx2EDDc91boUCQs4kUelsy
         2fgUO8CxrwTiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06CD15C095D; Fri,  2 Dec 2022 11:20:58 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:20:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] rcu/kvfree: Use READ_ONCE() when access to krcp->head
Message-ID: <20221202192058.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221202131837.375341-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202131837.375341-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:18:37PM +0100, Uladzislau Rezki (Sony) wrote:
> A need_offload_krc() function is now lock-free. A compiler
> can optimize readers in way that they see an old value even
> though writers already updated the krcp->head from another
> path.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued, thank you!!!

With the usual wordsmithing, so please let me know if I messed something
up.

							Thanx, Paul

------------------------------------------------------------------------

commit 9615ca28bc2c94cf2e092f06baace941fbf3b7e8
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Fri Dec 2 14:18:37 2022 +0100

    rcu/kvfree: Use READ_ONCE() when access to krcp->head
    
    The need_offload_krc() function is now lock-free, which gives the
    compiler freedom to load old values from plain C-language loads from
    the kfree_rcu_cpu struture's ->head pointer.  This commit therefore
    applied READ_ONCE() to these loads.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2d16a0eee792d..ee8a6a711719a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3029,7 +3029,7 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 		if (!list_empty(&krcp->bulk_head[i]))
 			return true;
 
-	return !!krcp->head;
+	return !!READ_ONCE(krcp->head);
 }
 
 static void
@@ -3070,7 +3070,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		// in that case the monitor work is rearmed.
 		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
 			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
-				(krcp->head && !krwp->head_free)) {
+				(READ_ONCE(krcp->head) && !krwp->head_free)) {
 
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
