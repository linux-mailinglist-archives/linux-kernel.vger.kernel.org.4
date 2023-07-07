Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2C74B782
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGGTy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6C19A5;
        Fri,  7 Jul 2023 12:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A730C61A34;
        Fri,  7 Jul 2023 19:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE70C433C8;
        Fri,  7 Jul 2023 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688759694;
        bh=wdUqdpRF/SKerHOFXhjdav6c/7lqS9b7DIwJzkdkCM0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pNDK3/yYC+eEal/D8caLdAsHQPYDGnl1vqJhFKK/NfonlaATvI0HRe+vSt1LBpbKB
         L609xmrPS6qmm+LmFrX4A+1LEOCFN4LG1jpD8g3ZrgNmaqZqyaZSjZ49xQHECJ9zDO
         8iHB+sOSwpis4C14vqJdS1PYCmdFqNAJTjHwXnnD6hx4Cx/cwCOX+R+RaQz0tegdCD
         WvwEBKAnRJ+na0pe99YOQjJQrhDxNsown/PBdIfxvX75q/bHxCaGTFJKI/ehg38iz4
         qBLnO1MsIkdIwSOE8sHidafDRrd1Kos0PlT2HO+ENysR11IUB8cmR3ioaN0u7i7DY5
         og1EwBPakaYFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9874BCE007B; Fri,  7 Jul 2023 12:54:53 -0700 (PDT)
Date:   Fri, 7 Jul 2023 12:54:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v2] refscale: Fix use of uninitalized wait_queue_head_t
Message-ID: <37d52a42-c6d5-4c4d-9879-53578c154d1f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230707175355.2442933-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707175355.2442933-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 01:53:55PM -0400, Waiman Long wrote:
> It was found that running the refscale test might crash the kernel once
> in a while with the following error:
> 
> [ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
> [ 8569.952900] #PF: supervisor read access in kernel mode
> [ 8569.952902] #PF: error_code(0x0000) - not-present page
> [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
> [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
> [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
> [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>   :
> [ 8569.952940] Call Trace:
> [ 8569.952941]  <TASK>
> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
> [ 8569.952959]  kthread+0x10e/0x130
> [ 8569.952966]  ret_from_fork+0x1f/0x30
> [ 8569.952973]  </TASK>
> 
> This is likely caused by the fact that init_waitqueue_head() is
> called after the ref_scale_reader kthread is created. The kthread
> can potentially try to use the waitqueue head before it is properly
> initialized. The crash happened at
> 
> 	static inline void __add_wait_queue(...)
> 	{
> 		:
> 		if (!(wq->flags & WQ_FLAG_PRIORITY)) <=== Crash here
> 
> The offset of flags from list_head entry in wait_queue_entry is -0x18. If
> reader_tasks[i].wq.head.next is NULL as allocated reader_task structure
> is zero initialized, the instruction will try to access address
> 0xffffffffffffffe8 which is the fault address listed above.
> 
> Fix this by initializing the waitqueue head first before kthread
> creation.
> 
> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Queued and pushed, thank you all!

As always, I could not resist wordsmithing the commit log, please see
below.

							Thanx, Paul

------------------------------------------------------------------------

commit 933d3bf8f96d7cedf78081030e004d23aee2b56c
Author: Waiman Long <longman@redhat.com>
Date:   Fri Jul 7 13:53:55 2023 -0400

    refscale: Fix uninitalized use of wait_queue_head_t
    
    Running the refscale test occasionally crashes the kernel with the
    following error:
    
    [ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
    [ 8569.952900] #PF: supervisor read access in kernel mode
    [ 8569.952902] #PF: error_code(0x0000) - not-present page
    [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
    [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
    [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
    [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
      :
    [ 8569.952940] Call Trace:
    [ 8569.952941]  <TASK>
    [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
    [ 8569.952959]  kthread+0x10e/0x130
    [ 8569.952966]  ret_from_fork+0x1f/0x30
    [ 8569.952973]  </TASK>
    
    The likely cause is that init_waitqueue_head() is called after the call to
    the torture_create_kthread() function that creates the ref_scale_reader
    kthread.  Although this init_waitqueue_head() call will very likely
    complete before this kthread is created and starts running, it is
    possible that the calling kthread will be delayed between the calls to
    torture_create_kthread() and init_waitqueue_head().  In this case, the
    new kthread will use the waitqueue head before it is properly initialized,
    which is not good for the kernel's health and well-being.
    
    The above crash happened here:
    
            static inline void __add_wait_queue(...)
            {
                    :
                    if (!(wq->flags & WQ_FLAG_PRIORITY)) <=== Crash here
    
    The offset of flags from list_head entry in wait_queue_entry is
    -0x18. If reader_tasks[i].wq.head.next is NULL as allocated reader_task
    structure is zero initialized, the instruction will try to access address
    0xffffffffffffffe8, which is exactly the fault address listed above.
    
    This commit therefore invokes init_waitqueue_head() before creating
    the kthread.
    
    Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
    Signed-off-by: Waiman Long <longman@redhat.com>
    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
    Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1970ce5f22d4..71d138573856 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1107,12 +1107,11 @@ ref_scale_init(void)
 	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
+		init_waitqueue_head(&reader_tasks[i].wq);
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
 		if (torture_init_error(firsterr))
 			goto unwind;
-
-		init_waitqueue_head(&(reader_tasks[i].wq));
 	}
 
 	// Main Task
