Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92CA6C5ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCVX5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCVX5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDD28D17;
        Wed, 22 Mar 2023 16:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5089162342;
        Wed, 22 Mar 2023 23:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E1EC433EF;
        Wed, 22 Mar 2023 23:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679529439;
        bh=XkmYsPosw0qTmGT8GUHir49i+HbispJddG1Pr0QKMNw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eMHzhiFi+1mFIkoQFvTsAxp96b99sSfc5/V+HpXBbi7EvaSCIbEJ3D/d0ZHCOyVsM
         /XdtQfF3b2IVkKE2jNbDs0CDJ+LM77sbIcuf8dR1bgt7aOye7gbkc/spNQk2n/jGkn
         zHysWMaG8cXyzSI1thQLmZxl5E3MD7OAonbTjcpbbhZoO55sGYgnP0dn4gt5bcHKL8
         eIs3rjagEfSbYlDoqE8l/ZzpOneFyTL6CQoxtlIRBne3tmS6A79Xpja9Sw4otprHoQ
         aLh+Lq58p1+pUwPxRgF7Xe0ErI/iy0fct4sfDytqovB7eoalrK38Gxx5DmIB14hPYE
         0i0iCje93/2ZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3C14F1540398; Wed, 22 Mar 2023 16:57:19 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:57:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] doc/rcutorture: Add description of
 rcutorture.stall_cpu_block
Message-ID: <5e13d24b-f812-46ad-a614-53b73340e4d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230321021234.51431-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321021234.51431-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:12:34AM +0800, Zqiang wrote:
> For kernels built with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y,
> run the RCU stall tests.
> 
> runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4"
> bootparams="console=ttyS0 rcutorture.stall_cpu=30
> rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_block=1" -d
> 
> [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> [   10.841073] rcu_torture_stall start on CPU 3.
> [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> ....
> [   10.841108] Call Trace:
> [   10.841110]  <TASK>
> [   10.841112]  dump_stack_lvl+0x64/0xb0
> [   10.841118]  dump_stack+0x10/0x20
> [   10.841121]  __schedule_bug+0x8b/0xb0
> [   10.841126]  __schedule+0x2172/0x2940
> [   10.841157]  schedule+0x9b/0x150
> [   10.841160]  schedule_timeout+0x2e8/0x4f0
> [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> [   10.841195]  rcu_torture_stall+0x2e8/0x300
> [   10.841199]  kthread+0x175/0x1a0
> [   10.841206]  ret_from_fork+0x2c/0x50
> 
> Due to invoke schedule_timeout() forces the CPU to go through a
> quiescent state, cause RCU stall not appear and also cause scheduling
> while atomic complaints. so this commit add description of
> rcutorture.stall_cpu_block, it should not to be set in CONFIG_PREEMPTION=n
> kernels.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Very good, thank you!

I did the usual wordsmithing, so please check for any errors that I may
have introduced.

							Thanx, Paul

------------------------------------------------------------------------

commit 1e7cded7383986d788cb2020bd4e56b298518de2
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Mar 21 10:12:34 2023 +0800

    doc/rcutorture: Add description of rcutorture.stall_cpu_block
    
    If you build a kernel with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y,
    then run the rcutorture tests specifying stalls as follows:
    
    runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4" \
            bootparams="console=ttyS0 rcutorture.stall_cpu=30 \
            rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_block=1" -d
    
    The tests will produce the following splat:
    
    [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
    [   10.841073] rcu_torture_stall start on CPU 3.
    [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
    ....
    [   10.841108] Call Trace:
    [   10.841110]  <TASK>
    [   10.841112]  dump_stack_lvl+0x64/0xb0
    [   10.841118]  dump_stack+0x10/0x20
    [   10.841121]  __schedule_bug+0x8b/0xb0
    [   10.841126]  __schedule+0x2172/0x2940
    [   10.841157]  schedule+0x9b/0x150
    [   10.841160]  schedule_timeout+0x2e8/0x4f0
    [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
    [   10.841195]  rcu_torture_stall+0x2e8/0x300
    [   10.841199]  kthread+0x175/0x1a0
    [   10.841206]  ret_from_fork+0x2c/0x50
    
    This is because the rcutorture.stall_cpu_block=1 module parameter causes
    rcu_torture_stall() to invoke schedule_timeout_uninterruptible() within
    an RCU read-side critical section.  This in turn results in a quiescent
    state (which prevents the stall) and a sleep in an atomic context (which
    produces the above splat).
    
    Although this code is operating as designed, the design has proven to
    be counterintuitive to many.  This commit therefore updates the description
    in kernel-parameters.txt accordingly.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 51067903af84..b39a4ab56b95 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5058,8 +5058,16 @@
 
 	rcutorture.stall_cpu_block= [KNL]
 			Sleep while stalling if set.  This will result
-			in warnings from preemptible RCU in addition
-			to any other stall-related activity.
+			in warnings from preemptible RCU in addition to
+			any other stall-related activity.  Note that
+			in kernels built with CONFIG_PREEMPTION=n and
+			CONFIG_PREEMPT_COUNT=y, this parameter will
+			cause the CPU to pass through a quiescent state.
+			Any such quiescent states will suppress RCU CPU
+			stall warnings, but the time-based sleep will
+			also result in scheduling-while-atomic splats.
+			Which might or might not be what you want.
+
 
 	rcutorture.stall_cpu_holdoff= [KNL]
 			Time to wait (s) after boot before inducing stall.
