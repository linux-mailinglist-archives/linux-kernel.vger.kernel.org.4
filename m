Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D906628840
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiKNSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiKNSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:22:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF4F1F626;
        Mon, 14 Nov 2022 10:22:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so2338841edc.12;
        Mon, 14 Nov 2022 10:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDXxKHLRFv/x+7OmfIE6j1OewWDmroQlwdA1n+DR15E=;
        b=Iwf/EpGF9e3LON/9bPkgkoP4a09wFYSD9Mvl1Ae2bduouD20bTp8BNiziDl6T5uHth
         tfUg6I5gFVnswDS6IGOdReiSZvhcIyLX+/ls/d0okJP+J9C7tZ3calFUgBDRG5ewBg/j
         eF3bqzLNLaFJ4YR8z9ddQkJJD52JTaqAXtVaUxzTrx3g291NV7CrmkDBocCceYCB+46U
         1aEhy2dzJk2LHi2GPbO0NsbZvUncPpm4r/N8VCWHrXmt0targU2+d39dKmkhh88WtcRw
         rjmNRQWgD6waMgRTMKqKHdHU6+NGwGMdMHtNkHillKAlN6TDUyibUYnZP8E+2ke2HPjK
         XhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDXxKHLRFv/x+7OmfIE6j1OewWDmroQlwdA1n+DR15E=;
        b=eXsj742v5o72EPKs4k3qCUMKfTwyZtej3p44zDDo6PckERMi5MbcL9E7LVGpipgV2n
         oKcHfwjGGGAJrQTI/tRzNsVltcCpp7N20dFQWR50zL29I5N1xIY8VO0f91m+2/JH7QcQ
         Sc8ZwFVRRGp3psWtyaWjLXiC12Og0egS9ZyDO/l1BlOwX0mxKf7DZTxyrFK+Xj0Wui8X
         zuXBP6Zs36SVq1jwDS/mQaQMJfGeXlMTt52lrCs2pLRm4nXdj9cEbsyLaK5CpsX3tDKh
         g5qxUtgJocbKYgbsu1ctlM1YTe+127cbdHnuJXfEGBxBabgFhegWdOrr2yqxKHAtrei2
         9plA==
X-Gm-Message-State: ANoB5pmHXr0aLnf0b85nK1u1BiPSRr8LcuXP5rAHTF3Sp3H9r7sNLbcC
        qRsxnmaoYW0kdAcr3NCaALg=
X-Google-Smtp-Source: AA0mqf6agzknSq9KfT81rxs/0Jtp+LQ9+rWmLK+bBpPUCaQR52uNQT5+Q8C1PTxdmh8AhIzVFIP7Vw==
X-Received: by 2002:aa7:c6d0:0:b0:461:ee90:3d77 with SMTP id b16-20020aa7c6d0000000b00461ee903d77mr11940466eds.322.1668450166445;
        Mon, 14 Nov 2022 10:22:46 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id em3-20020a056402364300b00458b41d9460sm5100416edb.92.2022.11.14.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:22:46 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 14 Nov 2022 19:22:44 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>, Zhang@pc638.lan,
        Qiang1 <qiang1.zhang@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Message-ID: <Y3KHdBjAIR3FNKpS@pc638.lan>
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
 <PH0PR11MB5880FEAD72BAE59185256195DA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221111184238.GX725751@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111184238.GX725751@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 11, 2022 at 01:05:56PM +0000, Zhang, Qiang1 wrote:
> > On 2022/11/11 19:54, Zhang, Qiang1 wrote:
> > >> When a structure containing an RCU callback rhp is (incorrectly) 
> > >> freed and reallocated after rhp is passed to call_rcu(), it is not 
> > >> unusual for
> > >> rhp->func to be set to NULL. This defeats the debugging prints used 
> > >> rhp->by
> > >> __call_rcu_common() in kernels built with 
> > >> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, which expect to identify the 
> > >> offending code using the identity of this function.
> > >>
> > >> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things 
> > >> are even worse, as can be seen from this splat:
> > >>
> > >> Unable to handle kernel NULL pointer dereference at virtual address 0 
> > >> ... ...
> > >> PC is at 0x0
> > >> LR is at rcu_do_batch+0x1c0/0x3b8
> > >> ... ...
> > >> (rcu_do_batch) from (rcu_core+0x1d4/0x284)
> > >> (rcu_core) from (__do_softirq+0x24c/0x344)
> > >> (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
> > >> (__irq_exit_rcu) from (irq_exit+0x8/0x10)
> > >> (irq_exit) from (__handle_domain_irq+0x74/0x9c)
> > >> (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
> > >> (gic_handle_irq) from (__irq_svc+0x5c/0x94)
> > >> (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
> > >> (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
> > >> (default_idle_call) from (do_idle+0xf8/0x150)
> > >> (do_idle) from (cpu_startup_entry+0x18/0x20)
> > >> (cpu_startup_entry) from (0xc01530)
> > >>
> > >> This commit therefore adds calls to mem_dump_obj(rhp) to output some 
> > >> information, for example:
> > >>
> > >>  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
> > >>
> > >> This provides the rough size of the memory block and the offset of 
> > >> the rcu_head structure, which as least provides at least a few clues 
> > >> to help locate the problem. If the problem is reproducible, 
> > >> additional slab debugging can be enabled, for example, 
> > >> CONFIG_DEBUG_SLAB=y, which can provide significantly more information.
> > >>
> > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > >> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >> ---
> > >> kernel/rcu/rcu.h      | 7 +++++++
> > >> kernel/rcu/srcutiny.c | 1 +
> > >> kernel/rcu/srcutree.c | 1 +
> > >> kernel/rcu/tasks.h    | 1 +
> > >> kernel/rcu/tiny.c     | 1 +
> > >> kernel/rcu/tree.c     | 1 +
> > >> 6 files changed, 12 insertions(+)
> > >>
> > >> v1 --> v2:
> > >> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
> > >> 2. Paul E. McKenney helped me update the commit message, thanks.
> > >>
> > > 
> > > Hi, Zhen Lei
> > > 
> > > Maybe the following scenarios should be considered:
> > > 
> > >                 CPU 0
> > > tasks context
> > >    spin_lock(&vmap_area_lock)
> > >           Interrupt 
> > > 	 RCU softirq
> > > 	      rcu_do_batch
> > > 		mem_dump_obj
> > >                                   vmalloc_dump_obj
> > >                                        spin_lock(&vmap_area_lock)   <--  deadlock     
> > 
> > >Right, thanks. I just saw the robot's report. So this patch should be dropped.
> > >I'll try to add an helper in mm, where I can check whether the lock has been held, and dump the content of memory object.
> > 
> > This is a workaround, or maybe try a modification like the following, 
> > of course, need to ask Paul's opinion.
> 
> Another approach is to schedule a workqueue handler to do the
> mem_dump_obj().  This would allow mem_dump_obj() to run in a clean
> environment.
> 
> This would allow vmalloc_dump_obj() to be called unconditionally.
> 
> Other thoughts?
> 
<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7c9d77..956eb28f9c77 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2591,6 +2591,19 @@ struct vm_struct *find_vm_area(const void *addr)
 	return va->vm;
 }
 
+static struct vm_struct *
+find_vm_area_trylock(const void *addr)
+{
+	struct vmap_area *va = NULL;
+
+	if (spin_trylock(&vmap_area_lock)) {
+		va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
+		spin_unlock(&vmap_area_lock);
+	}
+
+	return va ? va->vm : NULL;
+}
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -4048,7 +4061,7 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
-	vm = find_vm_area(objp);
+	vm = find_vm_area_trylock(objp);
 	if (!vm)
 		return false;
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
<snip>

There is one issue though, it is not correct to reference vm->members
after a lock is dropped because of: use after free bugs. It is better
to embed the search and read out: nr_pages, addr, caller and drop the
lock.

--
Uladzislau Rezki
