Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2587F6D08DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjC3O4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjC3O4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:56:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB0CC1D;
        Thu, 30 Mar 2023 07:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70D96B82923;
        Thu, 30 Mar 2023 14:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F371C433D2;
        Thu, 30 Mar 2023 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680188112;
        bh=FHLtPlDgAi9TMDXORFSOOGlYeZicSFqCxScdEUp354U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HRZrUIY+GC+w0z8tNpSlgNGGzxhVW+1DD0SdyLO9O+Z9+nkfgZeN+as9wLD3yZ0Iv
         9jcroKlQrUwV0KU9/Qibp4dLwKzfQp5jyUGtB6k5mUHfQ6tCYZqxcnFNkFvBYtqYoE
         ga3+EB6ogbl6sKDrwHmUTXSb/Zca9d8mP2/UCh/K7B7uQ+VC3YNj0aWNYdCbuSwyHr
         TSR78FZzQJvlzJkwU+EhdHuLqgKIHXuao4fcto55jmYXiD4WZIOcXu8gnxnEnReinO
         IUhJqNgN0E2UJgAg5LKNQaTF29UXFh81pPMT+pnQCV48TFxEei33R+2zfX0D8PVLHD
         Rs1rwrDVrkmYw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 865E01540476; Thu, 30 Mar 2023 07:55:11 -0700 (PDT)
Date:   Thu, 30 Mar 2023 07:55:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hch@lst.de" <hch@lst.de>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH RFC rcu 02/19] srcu: Use static init for statically
 allocated in-module srcu_struct
Message-ID: <b66d52cb-ed73-4c7f-bab0-201dc13d164a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-2-paulmck@kernel.org>
 <PH0PR11MB5880CA682074874FF64B3412DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880CA682074874FF64B3412DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:11:05AM +0000, Zhang, Qiang1 wrote:
> >
> >Further shrinking the srcu_struct structure is eased by requiring
> >that in-module srcu_struct structures rely more heavily on static
> >initialization.  In particular, this preserves the property that
> >a module-load-time srcu_struct initialization can fail only due
> >to memory-allocation failure of the per-CPU srcu_data structures.
> >It might also slightly improve robustness by keeping the number of memory
> >allocations that must succeed down percpu_alloc() call.
> >
> >This is in preparation for splitting an srcu_usage structure out
> >of the srcu_struct structure.
> >
> >[ paulmck: Fold in qiang1.zhang@intel.com feedback. ]
> >
> >Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >Cc: Christoph Hellwig <hch@lst.de>
> >---
> > include/linux/srcutree.h | 19 ++++++++++++++-----
> > kernel/rcu/srcutree.c    | 19 +++++++++++++------
> > 2 files changed, 27 insertions(+), 11 deletions(-)
> >
> >diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> >index ac8af12f93b3..428480152375 100644
> >--- a/include/linux/srcutree.h
> >+++ b/include/linux/srcutree.h
> >@@ -121,15 +121,24 @@ struct srcu_struct {
> > #define SRCU_STATE_SCAN1	1
> > #define SRCU_STATE_SCAN2	2
> > 
> >-#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
> >-{												\
> >-	.sda = &pcpu_name,									\
> >+#define __SRCU_STRUCT_INIT_COMMON(name)								\
> > 	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
> > 	.srcu_gp_seq_needed = -1UL,								\
> > 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
> >-	__SRCU_DEP_MAP_INIT(name)								\
> >+	__SRCU_DEP_MAP_INIT(name)
> >+
> >+#define __SRCU_STRUCT_INIT_MODULE(name)								\
> >+{												\
> >+	__SRCU_STRUCT_INIT_COMMON(name)								\
> > }
> > 
> >+#define __SRCU_STRUCT_INIT(name, pcpu_name)							\
> >+{												\
> >+	.sda = &pcpu_name,									\
> >+	__SRCU_STRUCT_INIT_COMMON(name)								\
> >+}
> >+
> >+
> > /*
> >  * Define and initialize a srcu struct at build time.
> >  * Do -not- call init_srcu_struct() nor cleanup_srcu_struct() on it.
> >@@ -151,7 +160,7 @@ struct srcu_struct {
> >  */
> > #ifdef MODULE
> > # define __DEFINE_SRCU(name, is_static)								\
> >-	is_static struct srcu_struct name;							\
> >+	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name);			\
> > 	extern struct srcu_struct * const __srcu_struct_##name;					\
> > 	struct srcu_struct * const __srcu_struct_##name						\
> > 		__section("___srcu_struct_ptrs") = &name
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index cd46fe063e50..7a6d9452a5d0 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -1895,13 +1895,14 @@ void __init srcu_init(void)
> > static int srcu_module_coming(struct module *mod)
> > {
> > 	int i;
> >+	struct srcu_struct *ssp;
> > 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> >-	int ret;
> > 
> > 	for (i = 0; i < mod->num_srcu_structs; i++) {
> >-		ret = init_srcu_struct(*(sspp++));
> >-		if (WARN_ON_ONCE(ret))
> >-			return ret;
> >+		ssp = *(sspp++);
> >+		ssp->sda = alloc_percpu(struct srcu_data);
> >+		if (WARN_ON_ONCE(!ssp->sda))
> >+			return -ENOMEM;
> > 	}
> > 	return 0;
> > }
> >@@ -1910,10 +1911,16 @@ static int srcu_module_coming(struct module *mod)
> > static void srcu_module_going(struct module *mod)
> > {
> > 	int i;
> >+	struct srcu_struct *ssp;
> > 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> > 
> >-	for (i = 0; i < mod->num_srcu_structs; i++)
> >-		cleanup_srcu_struct(*(sspp++));
> >+	for (i = 0; i < mod->num_srcu_structs; i++) {
> >+		ssp = *(sspp++);
> >+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
> >+		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
> >+				cleanup_srcu_struct(ssp);
> >+		free_percpu(ssp->sda);
> 
> 
> Hi Paul
> 
> About 037b80b8865fb ("srcu: Check for readers at module-exit time ")
> 
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1911,7 +1911,8 @@ static void srcu_module_going(struct module *mod)
>                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>                     !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
>                         cleanup_srcu_struct(ssp);
> -               free_percpu(ssp->sda);
> +               else if (!WARN_ON(srcu_readers_active(ssp)))
> +                       free_percpu(ssp->sda);
> 
> Should the else statement be removed?  like this:
> 
> if (!WARN_ON(srcu_readers_active(ssp)))
> 	free_percpu(ssp->sda);

Mightn't that cause us to double-free ssp->sda?  Once in free_percpu(),
and before that in cleanup_srcu_struct()?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >+	}
> > }
> > 
> > /* Handle one module, either coming or going. */
> >-- 
> >2.40.0.rc2
> >
