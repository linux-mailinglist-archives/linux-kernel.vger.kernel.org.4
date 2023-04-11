Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2011B6DCE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDKAGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDKAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85526AB;
        Mon, 10 Apr 2023 17:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A68661D4D;
        Tue, 11 Apr 2023 00:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B143DC4339B;
        Tue, 11 Apr 2023 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681171576;
        bh=bWRz8OyAWyQZif69js29490nzzm0uqWpXjQqYdYUP7E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pb46S1J+ffLTBdLF7BBE5derRzv62t49YqZpGPwjvS3iKDkgKfAe1aoUsUPckTRgt
         sp3opna6qsXx6VOjMlX8Yzk6rhCEiDy4q+Orz7umpEuzFpeQvUpvOxIVocUluGm2S0
         rQKSMGSsC8Wp1rOZiqRmEiUJfNuRADiI6J7J6RIQ0kBdXuWePUJQOy9q+6QSvxO+Oo
         DVWiEc2L9oZ1rxoy+LyxEf1Zp7OGIedslcrP5dMzM3xYo8p9baVYFGJ9gFGY7AY13s
         wjX+VsiNVg7e8AZDBZIAtvUyUoA0sR/Ps6d3tsAqVnMuN/v2jtubbf/DSpvGCsyFXB
         6PSSue3BdLzfQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4FC7B1540478; Mon, 10 Apr 2023 17:06:16 -0700 (PDT)
Date:   Mon, 10 Apr 2023 17:06:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Make page cache growing happen on the
 correct krcp
Message-ID: <628ee057-d957-431b-be4a-0bf893bf56ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230408142530.800612-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408142530.800612-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 10:25:30PM +0800, Zqiang wrote:
> When invoke add_ptr_to_bulk_krc_lock() to queue ptr, will invoke
> krc_this_cpu_lock() return current CPU's krcp structure and get a
> bnode object from the krcp structure's ->bulk_head, if return is
> empty or the returned bnode object's nr_records is KVFREE_BULK_MAX_ENTR,
> when the can_alloc is set, will unlock current CPU's krcp->lock and
> allocate bnode, after that, will invoke krc_this_cpu_lock() again to
> return current CPU's krcp structure, if the CPU migration occurs,
> the krcp obtained at this time will not be consistent with the previous
> one, this causes the bnode will be added to the wrong krcp structure's
> ->bulk_head or trigger fill page work on wrong krcp.
> 
> This commit therefore re-hold krcp->lock after allocated page instead
> of re-call krc_this_cpu_lock() to ensure the consistency of krcp.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Very good, thank you!  Queued for testing and further review, but
please check my wordsmithing.

							Thanx, Paul

------------------------------------------------------------------------

commit a0bbb5785539ed846f4769368f24a296d54bc801
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Sat Apr 8 22:25:30 2023 +0800

    rcu/kvfree: Use consistent krcp when growing kfree_rcu() page cache
    
    The add_ptr_to_bulk_krc_lock() function is invoked to allocate a new
    kfree_rcu() page, also known as a kvfree_rcu_bulk_data structure.
    The kfree_rcu_cpu structure's lock is used to protect this operation,
    except that this lock must be momentarily dropped when allocating memory.
    It is clearly important that the lock that is reacquired be the same
    lock that was acquired initially via krc_this_cpu_lock().
    
    Unfortunately, this same krc_this_cpu_lock() function is used to
    re-acquire this lock, and if the task migrated to some other CPU during
    the memory allocation, this will result in the kvfree_rcu_bulk_data
    structure being added to the wrong CPU's kfree_rcu_cpu structure.
    
    This commit therefore replaces that second call to krc_this_cpu_lock()
    with raw_spin_lock_irqsave() in order to explicitly acquire the lock on
    the correct kfree_rcu_cpu structure, thus keeping things straight even
    when the task migrates.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2699b7acf0e3..41daae3239b5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3301,7 +3301,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
-			*krcp = krc_this_cpu_lock(flags);
+			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
 		}
 
 		if (!bnode)
