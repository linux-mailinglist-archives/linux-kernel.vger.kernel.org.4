Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF96A0AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjBWNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjBWNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:38:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7793C37566
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:38:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11AFFC14;
        Thu, 23 Feb 2023 05:39:38 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EDAF3F881;
        Thu, 23 Feb 2023 05:38:54 -0800 (PST)
Date:   Thu, 23 Feb 2023 13:38:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V7 6/6] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Message-ID: <Y/dsaz2C6bnvFZOM@FVFF77S0Q05N.cambridge.arm.com>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-7-anshuman.khandual@arm.com>
 <Y8A6rsEXR/rmJY0N@FVFF77S0Q05N>
 <37c41203-f131-91e7-c6bb-17f215d83eb1@arm.com>
 <Y+QABvBaXdeU3Vf/@FVFF77S0Q05N.cambridge.arm.com>
 <92690dd4-7d71-0beb-2157-b55e478fc281@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92690dd4-7d71-0beb-2157-b55e478fc281@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Following up on some of the bits below, I've tried to read the BRBE section in
the ARM ARM (ARM DDI 0487I.a), and explain my understanding below. Please let
me know if I've misunderstood or missed something.

On Mon, Feb 20, 2023 at 02:08:39PM +0530, Anshuman Khandual wrote:
> On 2/9/23 01:33, Mark Rutland wrote:
> > On Thu, Jan 19, 2023 at 08:18:47AM +0530, Anshuman Khandual wrote:
> >> On 1/12/23 22:21, Mark Rutland wrote:
> >>> On Thu, Jan 05, 2023 at 08:40:39AM +0530, Anshuman Khandual wrote:

> >>>> +	/* Save and clear the privilege */
> >>>> +	write_sysreg_s(brbcr & ~(BRBCR_EL1_E0BRE | BRBCR_EL1_E1BRE), SYS_BRBCR_EL1);
> >>>
> >>> Why? Later on we restore this, and AFAICT we don't modify it.
> >>>
> >>> If it's paused, why do we care about the privilege?
> >>
> >> This disables BRBE completely (not only pause) providing confidence that no
> >> branch record can come in while the existing records are being processed.
> > 
> > I thought from earlier that it was automatically paused by HW upon raising the
> > IRQ. Have I misunderstood, and we *must* stop it, or is this a belt-and-braces
> > additional disable?
> > 
> > Is that not the case, or do we not trust the pause for some reason?
> 
> Yes, this is a belt-and-braces additional disable i.e putting the BRBE in prohibited
> region, which is more effective than a pause.

I'm afraid I don't understand what you mean by "more effective than a pause";
AFAICT the pause should be sufficient for what we're doing.

If there's a particular property that a prohibited region ensures but pausing
does not, could you please say what that property is specifically? e.g. as
below I note some differences w.r.t. the BRB_FILTRATE PMU event, but I'm not
sure if that's what you're referring to.

Per ARM DDI 0487I.a, section D15.3 on pages D15-5511 and D15-5512, we have:

  R_PYBRZ:
  
    Generation of Branch records is paused when BRBFCR_EL1.PAUSED is 1.

  R_SRJND

    If a direct read of BRBFCR_EL1.PAUSED returns 1, then no operations ordered
    after the direct read will generate further Branch records until
    BRBFCR_EL1.PAUSED is cleared by software.

    Note: The subsequent operations can be ordered by a Context synchronization
    event.

So if we read BRBFCR_EL1 and the PAUSED bit is set, then all we need is an ISB
to ensure that no further records will be generated.

Rules R_NXCWF, R_GXGWY, R_RPKTXQ mean that a freeze event is generated when
PMOVSCLR_EL0 bits become set (i.e. when an overflow occurs), and we have:

  R_BHYTD

    On a BRBE freeze event:
    * BRBFCR_EL1.PAUSED is set to 1.
    * The current timestamp is captured in BRBTS_EL1.

So any counter overflow will indirectly set BRBFCR_EL1.PAUSED, and stop the
generation of records. The note in R_SRJND tells us that remains the case until
we explicitly clear BRBFCR_EL1.PAUSED.

The only thing that I can see that potentially justifies placing the BRBE into
a prohibited region is the notes about BRB_FILTRATE, but I don't think that's
all that useful anyway since it's not manipulated atomically w.r.t. the actual
BRBE record management, and there are larger windows where BRBE will be paused
but counters running (e.g. between overflow occurring and poking the BRBE in
the overflow handler). So I think it'd be pointless to do that *just* for
BRB_FILTRATE.

Practically speaking, I expect that if we read PMOVSCLR and find any bits are
set, then issue an ISB, then after that ISB all of the following should be
true:

 (a) BRBFCR_EL1.PAUSED will be set 
 (b) No further records will be generated
 (c) We can safely manipulate the existing records

[...]

> >>> That said, as above, do we actually need to pause/unpause it? Or is it already
> >>> paused by virtue of the IRQ?
> >>
> >> Yes, it should be paused after an IRQ but it is also enforced before reading along
> >> with privilege level disable.
> > 
> > I'm very confused as to why we're not trusting the HW to remain paused. Why do
> > we need to enforce what the hardware should already be doing?
> 
> As have learned from the HW folks, there might be situations where the BRBE buffer has
> been actually paused, ready for extraction in principle, but without BRBFCR_EL1_PAUSED
> being set. 

The ARM ARM is pretty clear that paused means BRBFCR_EL1.PAUSED==1, so I assume
you mean there's a different scenario where it won't generate records (e.g.
such as being in a prohibited region).

Can you please give an example here?

I'm happy to go talk with the HW folk with you for this.

> Setting the bit here explicitly creates consistency across scenarios before
> capturing the branch records. But please do note, that putting the BRBE in prohibited
> region via clearing BRBCR_EL1_E0BRE/E1BRE is the primary construct which ensures that
> no new branch records will make into the buffer while it's being processed.

I agree that's sufficient, but as above I don't believe it's necessary, and all
that we actually require is that no new records are generated.

> >> Regardless the buffer needs to be un-paused and also
> >> enabled for required privilege levels before exiting from here.
> > 
> > I agree this needs to be balanced, it just seems to me that we're doing
> > redundant work here.
> 
> Extracting branch records for an user space only profile session might be faster as it
> would require lesser context synchronization, might not even require prohibited region
> change mechanism (will be already in there, upon a PMU interrupt) etc. I could try and
> update IRQ branch records handling, based on whether current perf session was profiling
> only the user space or not.

For the IRQ handler I do not believe it matters which exception level(s) are
being monitored; if BRBFCR_EL1.PAUSED is set no new records will be generated
regardless. So I don't think that needs any special care.

For the context-switch between tasks I believe we'll need to transiently enter
a prohibited region, but that's a different path.

Thanks,
Mark.
