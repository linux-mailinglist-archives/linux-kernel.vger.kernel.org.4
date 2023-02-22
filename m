Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA269FECB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBVW6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBVW57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:57:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE97CA28
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:57:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06B5AB818CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF7C433D2;
        Wed, 22 Feb 2023 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677106675;
        bh=9tE/wgpXvogiaeLXJQodhfnLaFOmj/Lz3sBgGnYP3gY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OTt/hY67JW3Y64FbX8Vsh1Oh16R0atqvHWNRqKjLlNDtLyICywIPhdcxXCiphR4Im
         V3ljGKWxyoaj+/x+4mwdtWpmrvRGmza2k0xUYJsGOFjuzc1MHjMKhpYPsM/YH6JUgn
         +ms9yTGCIZgSkZSWuA2PJzCu3l3708szxdtGEyho0stvriNP/8gDeAgb567szZ9KuR
         TZXgi01j0q+52aXI84409DY2/zidFmTE+Hr3kb784N2q2whip9GuD4IOJHFo+O2HDj
         HTlR9VEwIzmwRN6IrtzvZCb7+A7/nFy7TDtHCnRDbHXuYI41G0daLWdfDu8zfkidoL
         Y077uLFQx9nMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 327C85C0C88; Wed, 22 Feb 2023 14:57:55 -0800 (PST)
Date:   Wed, 22 Feb 2023 14:57:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230222225755.GW2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
 <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 05:04:41AM +0000, Zhang, Qiang1 wrote:
> 
> >On Wed, Feb 15, 2023 at 02:10:35PM +0800, Zqiang wrote:
> > For PREEMPT_RT kernel, the spin_lock, spin_lock_irq will converted
> > to sleepable rt_spin_lock and the interrupt related suffix for
> > spin_lock/unlock(_irq, irqsave/irqrestore) do not affect CPU's
> > interrupt state. this commit therefore add raw_spin_lock torture
> > tests, this is a strict spin lock implementation in RT kernels.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >A nice addition!  Is this something you will be testing regularly?
> >If not, should there be additional locktorture scenarios, perhaps prefixed
> >by "RT-" to hint that they are not normally available?
> >
> >Or did you have some other plan for making use of these?
> 
> Hi Paul
> 
> Thanks for reply,  in fact, I want to enrich the test of locktorture, 
> after all, under the PREEMPT_RT kernel, we lost the test of the
> real spin lock. 

Very well, how does the following look?

							Thanx, Paul

------------------------------------------------------------------------

commit edc9d419ee8c22821ffd664466a5cf19208c3f02
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Feb 15 14:10:35 2023 +0800

    locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels
    
    In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
    to sleepable rt_spin_lock().  This means that the interrupt related suffix
    for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect the CPU's
    interrupt state. This commit therefore adds raw spin-lock torture tests.
    This in turn permits pure spin locks to be tested in PREEMPT_RT kernels.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 9425aff089365..ed8e5baafe49f 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -257,6 +257,61 @@ static struct lock_torture_ops spin_lock_irq_ops = {
 	.name		= "spin_lock_irq"
 };
 
+#ifdef CONFIG_PREEMPT_RT
+static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);
+
+static int torture_raw_spin_lock_write_lock(int tid __maybe_unused)
+__acquires(torture_raw_spinlock)
+{
+	raw_spin_lock(&torture_raw_spinlock);
+	return 0;
+}
+
+static void torture_raw_spin_lock_write_unlock(int tid __maybe_unused)
+__releases(torture_raw_spinlock)
+{
+	raw_spin_unlock(&torture_raw_spinlock);
+}
+
+static struct lock_torture_ops raw_spin_lock_ops = {
+	.writelock	= torture_raw_spin_lock_write_lock,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost	= torture_rt_boost,
+	.writeunlock	= torture_raw_spin_lock_write_unlock,
+	.readlock	= NULL,
+	.read_delay	= NULL,
+	.readunlock	= NULL,
+	.name		= "raw_spin_lock"
+};
+
+static int torture_raw_spin_lock_write_lock_irq(int tid __maybe_unused)
+__acquires(torture_raw_spinlock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&torture_raw_spinlock, flags);
+	cxt.cur_ops->flags = flags;
+	return 0;
+}
+
+static void torture_raw_spin_lock_write_unlock_irq(int tid __maybe_unused)
+__releases(torture_raw_spinlock)
+{
+	raw_spin_unlock_irqrestore(&torture_raw_spinlock, cxt.cur_ops->flags);
+}
+
+static struct lock_torture_ops raw_spin_lock_irq_ops = {
+	.writelock	= torture_raw_spin_lock_write_lock_irq,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost	= torture_rt_boost,
+	.writeunlock	= torture_raw_spin_lock_write_unlock_irq,
+	.readlock	= NULL,
+	.read_delay	= NULL,
+	.readunlock	= NULL,
+	.name		= "raw_spin_lock_irq"
+};
+#endif // #ifdef CONFIG_PREEMPT_RT
+
 static DEFINE_RWLOCK(torture_rwlock);
 
 static int torture_rwlock_write_lock(int tid __maybe_unused)
@@ -1017,6 +1072,9 @@ static int __init lock_torture_init(void)
 	static struct lock_torture_ops *torture_ops[] = {
 		&lock_busted_ops,
 		&spin_lock_ops, &spin_lock_irq_ops,
+#ifdef CONFIG_PREEMPT_RT
+		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
+#endif // #ifdef CONFIG_PREEMPT_RT
 		&rw_lock_ops, &rw_lock_irq_ops,
 		&mutex_lock_ops,
 		&ww_mutex_lock_ops,
