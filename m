Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9F6D710B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjDEAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjDEAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B00421E;
        Tue,  4 Apr 2023 17:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F02776220D;
        Wed,  5 Apr 2023 00:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF55C4339B;
        Wed,  5 Apr 2023 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680652814;
        bh=yx7REri00Y2sl3gyrssI0xdF1WIY6vCQEt4sdApMSpo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DE3YTRK+0cmnp72T0eaFhLdh55G6dFBhDTGfX+MLsagdkaL0ZLZwmVlMKRXcFt/KW
         V1EF5fo/MJ15LWVZb2zEGCdCOTb9eX0bxEIAuWIifvn3Y6hLijdOC1Tj25BKjPDzNC
         5FMD6SrDVyo+9YuYYUCxEWQIGaU8fFBJguUNCKC7jchlEf/LpHiEzLkHS+Jsx0VXoH
         m4y4eBq3ouTzsjRnkhxqyMNkRssEiCPGWPIN7+2LDR5ZMPv72wxxQTfvMo8RLwM/H/
         mPrEnKv0Owx0hhVCQPygmpTMjlazC7wxxYPP8rF6i1BZXetP6hAd++TAypkuEyUB6o
         qKrSLDMaXWE0Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E70FC15404B4; Tue,  4 Apr 2023 17:00:13 -0700 (PDT)
Date:   Tue, 4 Apr 2023 17:00:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] rcu/kvfree: Add debug check of GP ready for ptrs in
 a list
Message-ID: <f92cb016-b978-40ab-b025-bf2410b0537d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230404141300.908202-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404141300.908202-1-urezki@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:13:00PM +0200, Uladzislau Rezki (Sony) wrote:
> Triiger a warning if a grace period is not passed yet for
> objects queued on a linked list via rcu_head structures.
> 
> Once detached, take a full snapsot of GP sequnces to check
> later that a grace period is passed and it is safe to free
> all pointers.
> 
> Based on latest 'dev' branch.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Very good, thank you!

I queued the patch wordsmithed as shown below for review and further
testing.  Please check for any errors.

How should we go about testing this code?  The way that it would get
exercised in production would be during an out-of-memory event, correct?

							Thanx, Paul

------------------------------------------------------------------------

commit 900093e6ea97d9ff5be2dee062f93a72437ca3a5
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Apr 4 16:13:00 2023 +0200

    rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list
    
    Under low-memory conditions, kvfree_rcu() will use each object's
    rcu_head structure to queue objects in a singly linked list headed by
    the kfree_rcu_cpu structure's ->head field.  This list is passed to
    call_rcu() as a unit, but there is no indication of which grace period
    this list needs to wait for.  This in turn prevents adding debug checks
    in the kfree_rcu_work() as was done for the two page-of-pointers channels
    in the kfree_rcu_cpu structure.
    
    This commit therefore adds a ->head_free_gp_snap field to the
    kfree_rcu_cpu_work structure to record this grace-period number.  It also
    adds a WARN_ON_ONCE() to kfree_rcu_monitor() that checks to make sure
    that the required grace period has in fact elapsed.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4838a55da34f..35be35f8236b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2802,6 +2802,7 @@ struct kvfree_rcu_bulk_data {
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
+	struct rcu_gp_oldstate head_free_gp_snap;
 	struct list_head bulk_head_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
@@ -3007,6 +3008,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	struct rcu_gp_oldstate head_gp_snap;
 	int i;
 
 	krwp = container_of(to_rcu_work(work),
@@ -3021,6 +3023,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	head_gp_snap = krwp->head_free_gp_snap;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
@@ -3037,7 +3040,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	kvfree_rcu_list(head);
+	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
+		kvfree_rcu_list(head);
 }
 
 static bool
@@ -3169,6 +3173,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
+				get_state_synchronize_rcu_full(&krwp->head_free_gp_snap);
 				atomic_set(&krcp->head_count, 0);
 				WRITE_ONCE(krcp->head, NULL);
 			}
