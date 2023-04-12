Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB86DEACC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDLEyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDLEyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788ADA;
        Tue, 11 Apr 2023 21:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C1A62DF0;
        Wed, 12 Apr 2023 04:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9EDC433EF;
        Wed, 12 Apr 2023 04:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681275275;
        bh=5dzqspqBqW9N0X1M96v/Nc4a0ynkDyFPXVvD+yHp/tg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QpS13f7eTWFWAZQybWf2+gKbEU3zT90WUQbawMyM8C0DZAYea9GZmP10G4udzXs2C
         vYFtMRdQpxWNXbxXomW0KVP5ZDLJ7AA5l96ybkCM9xK+pw4jIyD18CRqCV1Qe56ddj
         /zQo04M4zCi0HYRetLOKLi1gMl+gbmVKnxA2GA3N1CIZ05/0ycFsIaTGfGHpmwGC7k
         QZ0/E7ZwK+KrtN/HQftmGvI5L1EDUXSf1CJry+Oiqq2pP6pecl6JGGCBZ0exmHhxrn
         4iwg2KNSgFSC53kr6el2V3q4VgJRenvhMe0iNhOSQNPPyyGlEB6z708qc73sVRB7c+
         w2F/luw/BCd4Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C730D1540478; Tue, 11 Apr 2023 21:54:34 -0700 (PDT)
Date:   Tue, 11 Apr 2023 21:54:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     zhouzhouyi@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH] rcu/torture replace wait_event with
 wait_event_interruptible
Message-ID: <0e334497-fbc1-49f7-87ef-8dbf6d25d6a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1681264483-5208-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681264483-5208-1-git-send-email-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:54:43AM +0800, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
> if kfree_loops is too big. Replace wait_event with wait_event_interruptible
> to avoid false positive.
> 
> Tested in the PPC VM of Open Source Lab of Oregon State University.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                
> ---
>  kernel/rcu/rcuscale.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 91fb5905a008..b37eec94957c 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
>  static int
>  kfree_scale_shutdown(void *arg)
>  {
> -	wait_event(shutdown_wq,
> +	wait_event_interruptible(shutdown_wq,

Good catch!!!

Would wait_event_idle() work in this case?  The _interruptible()
variant indicates that wakeups due to things like POSIX signals is
permitted.

							Thanx, Paul

>  		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
>  
>  	smp_mb(); /* Wake before output. */
> -- 
> 2.34.1
> 
