Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B36EFA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjDZTBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDZTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:01:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA36E46;
        Wed, 26 Apr 2023 12:01:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1622F4;
        Wed, 26 Apr 2023 12:02:28 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB253F64C;
        Wed, 26 Apr 2023 12:01:43 -0700 (PDT)
Date:   Wed, 26 Apr 2023 20:01:42 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Yang Shi <yang@os.amperecomputing.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, viresh.kumar@linaro.org,
        scott@os.amperecomputing.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Message-ID: <ZEl1Fms/JmdEZsVn@arm.com>
References: <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
 <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
 <cc32f950-ea78-87cb-e708-6d42d1e58cc8@arm.com>
 <f0fd057e-95cb-4a85-00fc-9eb25ef7b9b3@os.amperecomputing.com>
 <ZEZrnWUc2y0w9yY8@arm.com>
 <06ca8066-fce6-d3cf-db37-584c3666f7df@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06ca8066-fce6-d3cf-db37-584c3666f7df@os.amperecomputing.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+ Sumit

On Tuesday 25 Apr 2023 at 18:32:55 (-0700), Yang Shi wrote:
> 
> 
> On 4/24/23 4:44 AM, Ionela Voinescu wrote:
> > Hey,
> > 
> > On Thursday 20 Apr 2023 at 13:49:24 (-0700), Yang Shi wrote:
> > > On 4/20/23 9:01 AM, Pierre Gondois wrote:
> > > > > > You say that the cause of this is a congestion in the interconnect. I
> > > > > > don't
> > > > > > see a way to check that right now.
> > > > > > However your trace is on the CPU0, so maybe all the other cores were
> > > > > > shutdown
> > > > > > in your test. If this is the case, do you think a congestion could
> > > > > > happen with
> > > > > > only one CPU ?
> > > > > No, other CPUs were not shut down in my test. I just ran "yes" on all
> > > > > cores except CPU 0, then ran the reading freq script. Since all other
> > > > > cores are busy, so the script should be always running on CPU 0.
> > > > > 
> > > > > Since the counters, memory and other devices are on the interconnect, so
> > > > > the congestion may be caused by plenty of factors IIUC.
> > > > +Ionela
> > > > 
> > > > Ionela pointed me to the following patch-set, which seems realated:
> > > > https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/
> > > Thanks for the information. I think we do have the similar syndrome. But I'm
> > > not sure how their counters are implemented, we may not have similar root
> > > cause.
> > Yes, my bad, I did not get the chance to read this full thread before
> > talking with Pierre. In your case you have AMUs accessed via MMIO and in that
> > case they are accessed though FFH (IPIs and system registers). The root
> > cause is indeed different.
> 
> Yeah, but it seems like using larger delay could mitigate both issues.

Yes, there is a minimum delay required there of 25us due to the way that
the counters accumulate, which is not too bad even with interrupts
disabled (to cater to cpufreq_quick_get()).

>
[..]
> > > > > Yeah, we should be able to find a smaller irq disable section.
> > > > > 
> > > > > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > > > > index c51d3ccb4cca..105a7e2ffffa 100644
> > > > > > --- a/drivers/acpi/cppc_acpi.c
> > > > > > +++ b/drivers/acpi/cppc_acpi.c
> > > > > > @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
> > > > > > cppc_perf_fb_ctrs *perf_fb_ctrs)
> > > > > >           struct cppc_pcc_data *pcc_ss_data = NULL;
> > > > > >           u64 delivered, reference, ref_perf, ctr_wrap_time;
> > > > > >           int ret = 0, regs_in_pcc = 0;
> > > > > > +       unsigned long flags;
> > > > > > 
> > > > > >           if (!cpc_desc) {
> > > > > >                   pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> > > > > > @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct
> > > > > > cppc_perf_fb_ctrs *perf_fb_ctrs)
> > > > > >                   }
> > > > > >           }
> > > > > > 
> > > > > > +       local_irq_save(flags);
> > > > > > +
> > > > > >           cpc_read(cpunum, delivered_reg, &delivered);
> > > > > >           cpc_read(cpunum, reference_reg, &reference);
> > > > > >           cpc_read(cpunum, ref_perf_reg, &ref_perf);
> > > > > > 
> > > > > > +       local_irq_restore(flags);
> > > > > > +
> > > > > cpc_read_ffh() would return -EPERM if irq is disabled.
> > > > > 
> > > > > So, the irq disabling must happen for mmio only in cpc_read(), for
> > > > > example:
> > > > I thought the issue was that irqs could happen in between cpc_read()
> > > > functions,
> > > > the patch below would not cover it. If the frequency is more accurate
> > > > with this patch, I think I don't understand something.
> > > Yeah, you are correct. The irq disabling window has to cover all the
> > > cpc_read(). I didn't test with this patch. My test was done conceptually
> > > with:
> > > 
> > > disable irq
> > > cppc_get_perf_ctrs(t0)
> > > udelay(2)
> > > cppc_get_perf_ctrs(t1)
> > > enable irq
> > > 
> > > But this will break cpc_read_ffh().
> > Can you not disable IRQs in cppc_get_perf_ctrs() only if the registers
> > are CPC_IN_SYSTEM_MEMORY? Only spanning the reads of the delivered
> > register and the reference register, which should have minimal delay in
> > between?
> > 
> > As in:
> > 
> > if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
> >      CPC_IN_SYSTEM_MEMORY(reference_reg))
> > 	...
> > 
> > This will and should not affect FFH - the fix for that would have to be
> > different.
> 
> It won't work, right? The problem is cppc_get_perf_ctrs() calls cpc_read()s
> to read delivered and reference respectively, we just can tell whether they
> are CPC_IN_SYSTEM_MEMORY in cpc_read() instead of in cppc_get_perf_ctrs().
> So the resulting code should conceptually look like:
> 
> disable irq
> read delivered
> enable irq
> 
> disable irq
> read reference
> enable irq
> 
> But there still may be interrupts between the two reads. We actually want:
> 
> disable irq
> read delivered
> read reference
> enable irq

Yes, this is what I was suggesting above.

I've hacked up the following code. It covers the FFH case as well, with a
modified solution that Sumit proposed on the other thread:

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 0f17b1c32718..7e828aed3693 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -110,6 +110,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(cpc)->cpc_entry.reg.space_id ==	\
 				ACPI_ADR_SPACE_SYSTEM_IO)
 
+/* Check if a CPC register is in FFH */
+#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&	\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_FIXED_HARDWARE)
+
 /* Evaluates to True if reg is a NULL register descriptor */
 #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
 				(reg)->address == 0 &&			\
@@ -1292,6 +1297,24 @@ EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
  *
  * Return: 0 for success with perf_fb_ctrs populated else -ERRNO.
  */
+
+struct cycle_counters {
+	int cpunum;
+	struct cpc_register_resource *delivered_reg;
+	struct cpc_register_resource *reference_reg;
+	u64 *delivered;
+	u64 *reference;
+};
+
+static int cppc_get_cycle_ctrs(void *cycle_ctrs) {
+	struct cycle_counters *ctrs = cycle_ctrs;
+
+	cpc_read(ctrs->cpunum, ctrs->delivered_reg, ctrs->delivered);
+	cpc_read(ctrs->cpunum, ctrs->reference_reg, ctrs->reference);
+
+	return 0;
+}
+
 int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
@@ -1300,7 +1323,9 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	u64 delivered, reference, ref_perf, ctr_wrap_time;
+	struct cycle_counters ctrs = {0};
 	int ret = 0, regs_in_pcc = 0;
+	unsigned long flags;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1336,8 +1361,25 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(cpunum, delivered_reg, &delivered);
-	cpc_read(cpunum, reference_reg, &reference);
+	ctrs.cpunum = cpunum;
+	ctrs.delivered_reg = delivered_reg;
+	ctrs.reference_reg = reference_reg;
+	ctrs.delivered = &delivered;
+	ctrs.reference = &reference;
+
+	if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
+		ret = smp_call_on_cpu(cpunum, cppc_get_cycle_ctrs, &ctrs, false);
+	} else {
+		if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
+		    CPC_IN_SYSTEM_MEMORY(reference_reg)) {
+			local_irq_save(flags);
+			cppc_get_cycle_ctrs(&ctrs);
+			local_irq_restore(flags);
+		} else {
+			cppc_get_cycle_ctrs(&ctrs);
+		}
+	}
+
 	cpc_read(cpunum, ref_perf_reg, &ref_perf);
 
 	/*

I've only tested this on a model using FFH, with 10us delay, and it
worked well for me. Yang, Sumit, could you give it a try?

Even with a solution like the above (more refined, of course) there is an
additional improvement possible: we can implement arch_freq_get_on_cpu()
for arm64 systems that will use cached (on the tick) AMU cycle counter
samples and have this function called from show_cpuinfo_cur_freq()
before/instead of calling the .get() function. But this will only help
arm64 systems with AMUs accessible though system registers. We'll try to
submit patches on this soon. But as I mentioned to Sumit on the other
thread, the returned frequency value from this will be an average over 4ms
(with CONFIG_HZ=250) and could be up to 4ms old (more than that only if the
CPU was idle/isolated).

Thanks,
Ionela.
