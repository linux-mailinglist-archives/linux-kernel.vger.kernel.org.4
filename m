Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC268F88D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjBHUD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBHUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:03:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EC6E28D2D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:03:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BB0E1477;
        Wed,  8 Feb 2023 12:04:04 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 282C23F703;
        Wed,  8 Feb 2023 12:03:21 -0800 (PST)
Date:   Wed, 8 Feb 2023 20:03:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 6/6] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Message-ID: <Y+QABvBaXdeU3Vf/@FVFF77S0Q05N.cambridge.arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-7-anshuman.khandual@arm.com>
 <Y8A6rsEXR/rmJY0N@FVFF77S0Q05N>
 <37c41203-f131-91e7-c6bb-17f215d83eb1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c41203-f131-91e7-c6bb-17f215d83eb1@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 08:18:47AM +0530, Anshuman Khandual wrote:
> On 1/12/23 22:21, Mark Rutland wrote:
> > On Thu, Jan 05, 2023 at 08:40:39AM +0530, Anshuman Khandual wrote:
> >> +bool armv8pmu_branch_valid(struct perf_event *event)
> >> +{
> >> +	u64 branch_type = event->attr.branch_sample_type;
> >> +
> >> +	/*
> >> +	 * If the event does not have at least one of the privilege
> >> +	 * branch filters as in PERF_SAMPLE_BRANCH_PLM_ALL, the core
> >> +	 * perf will adjust its value based on perf event's existing
> >> +	 * privilege level via attr.exclude_[user|kernel|hv].
> >> +	 *
> >> +	 * As event->attr.branch_sample_type might have been changed
> >> +	 * when the event reaches here, it is not possible to figure
> >> +	 * out whether the event originally had HV privilege request
> >> +	 * or got added via the core perf. Just report this situation
> >> +	 * once and continue ignoring if there are other instances.
> >> +	 */
> >> +	if ((branch_type & PERF_SAMPLE_BRANCH_HV) && !is_kernel_in_hyp_mode())
> >> +		pr_warn_once("%s - hypervisor privilege\n", branch_filter_error_msg);
> >> +
> >> +	if (branch_type & PERF_SAMPLE_BRANCH_ABORT_TX) {
> >> +		pr_warn_once("%s - aborted transaction\n", branch_filter_error_msg);
> >> +		return false;
> >> +	}
> >> +
> >> +	if (branch_type & PERF_SAMPLE_BRANCH_NO_TX) {
> >> +		pr_warn_once("%s - no transaction\n", branch_filter_error_msg);
> >> +		return false;
> >> +	}
> >> +
> >> +	if (branch_type & PERF_SAMPLE_BRANCH_IN_TX) {
> >> +		pr_warn_once("%s - in transaction\n", branch_filter_error_msg);
> >> +		return false;
> >> +	}
> >> +	return true;
> >> +}
> > 
> > Is this called when validating user input? If so, NAK to printing anything to a
> > higher leval than debug. If there are constraints the user needs to be aware of
> 
> You mean pr_debug() based prints ?

Yes.

> > It would be better to whitelist what we do support rather than blacklisting
> > what we don't.
> 
> But with a negative list, user would know what is not supported via these pr_debug()
> based output when enabled ? But I dont have a strong opinion either way.

With a negative list, when new options are added the driver will erroneously
and silently accept them, which is worse.

> 
> > 
> >> +
> >> +static void branch_records_alloc(struct arm_pmu *armpmu)
> >> +{
> >> +	struct pmu_hw_events *events;
> >> +	int cpu;
> >> +
> >> +	for_each_possible_cpu(cpu) {
> >> +		events = per_cpu_ptr(armpmu->hw_events, cpu);
> >> +
> >> +		events->branches = kzalloc(sizeof(struct branch_records), GFP_KERNEL);
> >> +		WARN_ON(!events->branches);
> >> +	}
> >> +}
> > 
> > It would be simpler for this to be a percpu allocation.
> 
> Could you please be more specific ? alloc_percpu_gfp() cannot be used here
> because 'events->branches' is not a __percpu variable unlike its parent
> 'events' which is derived from armpmu.

You can allocate it per-cpu, then grab each of the cpu's pointers using
per_cpu() and place those into events->branches.

That way you only make one allocation which can fail, which makes the error
path much simpler.

[...]

> >> +static int brbe_attributes_probe(struct arm_pmu *armpmu, u32 brbe)
> >> +{
> >> +	struct brbe_hw_attr *brbe_attr = kzalloc(sizeof(struct brbe_hw_attr), GFP_KERNEL);
> > 
> > Same comments as for the failure path in branch_records_alloc().
> > 
> >> +	u64 brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
> > 
> > Which context is this run in? Unless this is affine to a relevant CPU we can't
> > read the sysreg safely, and if we're in a cross-call we cannot allocate memory,
> > so this doesn't look right to me.
> 
> Called from smp_call_function_any() context via __armv8pmu_probe_pmu().

Ok; so the read is safe, but the allocation is not.

[...]

> >> +	WARN_ON(!brbe_attr);
> >> +	armpmu->private = brbe_attr;
> >> +
> >> +	brbe_attr->brbe_version = brbe;
> >> +	brbe_attr->brbe_format = brbe_fetch_format(brbidr);
> >> +	brbe_attr->brbe_cc = brbe_fetch_cc_bits(brbidr);
> >> +	brbe_attr->brbe_nr = brbe_fetch_numrec(brbidr);
> > 
> > As a minor thing, could we please s/fetch/get/ ? To me, 'fetch' sounds like a
> > memory operation, and elsewhere we use 'get' for this sort of getter function.
> 
> Sure, but shall we change fetch as get for entire BRBE implementation (where ever
> there is a determination of field from a register value) or just the above function ?
> Default, will change all places.

I had meant in all cases, so that's perfect, thanks.


[...]

> >> +			WARN_ON_ONCE(!(brbcr & BRBCR_EL1_MPRED));
> > 
> > Huh? Why does the value of BRBCR matter here?
> 
> This is just a code hardening measure here. Before recording branch record
> cycles or its flags, ensure BRBCR_EL1 was configured correctly to produce
> these additional information along with the branch records.

I don't think that's necessary. Where is brbcr written such that this could be
misconfigured?

At the least, this needs a comment as to why we need to check, and what we're
checking for.

[...]

> >> +/*
> >> + * A branch record with BRBINF_EL1.LASTFAILED set, implies that all
> >> + * preceding consecutive branch records, that were in a transaction
> >> + * (i.e their BRBINF_EL1.TX set) have been aborted.
> >> + *
> >> + * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
> >> + * consecutive branch records upto the last record, which were in a
> >> + * transaction (i.e their BRBINF_EL1.TX set) have been aborted.
> >> + *
> >> + * --------------------------------- -------------------
> >> + * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> >> + * --------------------------------- -------------------
> >> + * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
> >> + * --------------------------------- -------------------
> >> + * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> >> + * --------------------------------- -------------------
> >> + * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
> >> + * --------------------------------- -------------------
> >> + * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
> >> + * --------------------------------- -------------------
> >> + * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> >> + * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
> >> + * --------------------------------- -------------------
> > 
> > Are we guaranteed to have a record between two transactions with TX = 0?
> 
> With TX = 0 i.e no transaction was active, indicates normal sequence of branches
> creating their own branch records. How can there be a transaction with TX = 0 ?
> Could you please be more specific here ?

Consider a sequence of a successful transaction followed by a cancelled
transation, with not branches between the first transation being commited and
the second transaction starting:

	TSTART	// TX=1
	...     // TX=1
	TCOMMIT // TX=1
	TSTART  // TX=1
	...     // TX=1
	<failure>
		// TX=0, LF=1

AFAICT, we are not guaranteed to have a record with TX=0 between that
successful TCOMMIT and the subsequent TSTART, and so the LASTFAILED field
doesn't indicate that *all* preceding records with TX set are part of the
failed transaction.

Am I missing something? e.g. does the TCOMMIT get records with TX=0?

> > AFAICT you could have a sequence where a TCOMMIT is immediately followed by a
> > TSTART, and IIUC in that case you could have back-to-back records for distinct
> > transactions all with TX = 1, where the first transaction could be commited,
> > and the second might fail/cancel.
> > 
> > ... or do TCOMMIT/TCANCEL/TSTART get handled specially?
> 
> I guess these are micro-architectural implementation details which unfortunately
> BRBINF_EL1/BRBCR_EL1 specifications do not capture in detail. But all it says is
> that upon encountering BRBINF_EL1.LASTFAILED or BRBFCR_EL1.LASTFAILED (just for
> the last record) all previous in-transaction branch records (BRBINF_EL1.TX = 1)
> should be considered aborted for branch record reporting purpose.

Ok, so we're throwing away data?

If we're going to do that, it would be good to at least have a comment
explaining why we're forced to do so. Ideally we'd get the architecture
clarified/fixed, since AFAIK no-one has actually built TME yet, and it might be
a simple fix (as above).

[...]

> >> +void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
> >> +{
> >> +	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
> >> +	u64 brbinf, brbfcr, brbcr;
> >> +	int idx;
> >> +
> >> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> >> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> >> +
> >> +	/* Ensure pause on PMU interrupt is enabled */
> >> +	WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
> > 
> > As above, I think this needs commentary in the interrupt handler, since this
> > presumably needs us to keep the IRQ asserted until we're done
> > reading/manipulating records in the IRQ handler.
> 
> The base IRQ handler armv8pmu_handle_irq() is in ARMV8 PMU code inside perf_event.c
> which could/should not access BRBE specific details without adding an another new
> abstraction function. But I guess adding a comment should be fine.

I think it's fine to have a comment there saying that we *must not* do
something that woukd break BRBE.

> >> +
> >> +	/* Save and clear the privilege */
> >> +	write_sysreg_s(brbcr & ~(BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE), SYS_BRBCR_EL1);
> > 
> > Why? Later on we restore this, and AFAICT we don't modify it.
> > 
> > If it's paused, why do we care about the privilege?
> 
> This disables BRBE completely (not only pause) providing confidence that no
> branch record can come in while the existing records are being processed.

I thought from earlier that it was automatically paused by HW upon raising the
IRQ. Have I misunderstood, and we *must* stop it, or is this a belt-and-braces
additional disable?

Is that not the case, or do we not trust the pause for some reason?

Regardless, the comment should expalin *why* we're doing this (i.e. that this
is about ensuring BRBE does not create new records while we're manipulating
it).

> >> +	/* Unpause the buffer */
> >> +	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> >> +	isb();
> >> +	armv8pmu_branch_reset();
> >> +}
> > 
> > Why do we enable it before we reset it?
> 
> This is the last opportunity for a clean slate start for BRBE buffer before it is
> back recording the branches. Basically helps in ensuring a clean start.

My point is why do we start if *before* resetting it, rather than restting it
first? Why give it the opportunity to create records that we're going to
discard immediately thereafter?

> > Surely it would make sense to reset it first, and ammortize the cost of the ISB?
> > 
> > That said, as above, do we actually need to pause/unpause it? Or is it already
> > paused by virtue of the IRQ?
> 
> Yes, it should be paused after an IRQ but it is also enforced before reading along
> with privilege level disable.

I'm very confused as to why we're not trusting the HW to remain paused. Why do
we need to enforce what th e hardware should already be doing?

> Regardless the buffer needs to be un-paused and also
> enabled for required privilege levels before exiting from here.

I agree this needs to be balanced, it just seems to me that we're doing
redundant work here.

Thanks,
Mark.
