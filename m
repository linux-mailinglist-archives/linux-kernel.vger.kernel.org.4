Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A608F697F29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBOPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBOPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:10:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3AF825976
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:10:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3061042;
        Wed, 15 Feb 2023 07:11:36 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22CB83F881;
        Wed, 15 Feb 2023 07:10:52 -0800 (PST)
Date:   Wed, 15 Feb 2023 15:10:48 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oliver.upton@linux.dev>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Save and restore distributor and
 re-distributor
Message-ID: <20230215151048.xxmpvfre2xdngowr@bogus>
References: <20230214233426.2994501-1-f.fainelli@gmail.com>
 <20230214233426.2994501-4-f.fainelli@gmail.com>
 <87o7pvz78z.wl-maz@kernel.org>
 <20230215121050.d57tnfh7wzpyqzti@bogus>
 <86ttznxa9n.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86ttznxa9n.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 02:40:04PM +0000, Marc Zyngier wrote:
> On Wed, 15 Feb 2023 12:10:50 +0000,
> Sudeep Holla <sudeep.holla@arm.com> wrote:
> > 
> > On Wed, Feb 15, 2023 at 08:02:20AM +0000, Marc Zyngier wrote:
> > > On Tue, 14 Feb 2023 23:34:26 +0000,
> > > Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > >
> > > > On platforms implementing Suspend to RAM where the GIC loses power, we
> > > > are not properly saving and restoring the GIC distributor and
> > > > re-distributor registers thus leading to the system resuming without any
> > > > functional interrupts.
> > >
> > > The real question is *why* we need any of this. On any decent system,
> > > this is the firmware's job.  It was *never* the OS GIC driver's job
> > > the first place.
> > >
> > 
> > Completely agreed on the points you have made here, no disagreement.
> > However I would like to iterate some of the arguments/concerns the
> > firmware teams I have interacted in the past have made around this.
> > And this is while ago(couple of years) and they may have different
> > views. I am repeating them as I think it may be still valid on some
> > systems so that we can make some suggestions if we have here.
> > 
> > > Importantly, the OS cannot save the full state: a large part of it is
> > > only accessible via secure, and Linux doesn't run in secure mode. How
> > > do you restore the group configuration, for example? Oh wait, you
> > > don't even save it.
> > >
> > 
> > Agreed, we can't manage secure side configurations. But one of the concern
> > was about the large memory footprint to save the larger non-secure GIC
> > context in the smaller secure memory.
> > 
> > One of the suggestion at the time was to carve out a chunk of non-secure
> > memory and let the secure side use the same for context save and restore.
> > Not sure if this was tried out especially for the GIC. I may need to
> > chase that with the concerned teams.
> 
> The main issue is that you still need secure memory to save the secure
> state, as leaving it in NS memory would be an interesting attack
> vector! Other than that, I see no issue with FW carving out the memory
> it needs to save/restore the NS state of the GIC.
>

Yes I meant NS memory for only NS state of GIC.

> Note that this isn't only the (re-)distributor(s) PPI/SPI registers.
> The LPI setup must also be saved, and that includes all the ITS
> registers. I'm surprised the FW folks are, all of a sudden,
> discovering this requirements. It isn't like the GIC architecture is a
> novelty, and they have had ample time to review the spec...
>

I understand your concern about late realisation 😄.

Another issue in general I see with reference firmware stack(like
Trusted Firmware in this case) is that the requirements are driven from
the reference platforms which may not have this GIC save/restore
requirement as they are in always on domain and it is then made platform
specific problem in that project which may not be ideal and may result
in somewhat misleading indirectly other firmware developers using it.

Also remember some firmware folks asking about LPI context, I am not sure
if there was any work done in that area.

> >
> > Thanks Florian for starting this thread and sorry that I couldn't recollect
> > lots of the information when we chatted in the private about this. Marc
> > response triggered all the memory back.
> > 
> > > So unless you have a single security state system, this cannot
> > > work. And apart from VMs (which by the way do not need any of this),
> > > there is no GICv3-based system without EL3. If you know of one, please
> > > let me know. And if it existed, then all the save/restore should
> > > happen only when GICD_CTLR.DS==1.
> > >
> > 
> > Yes, now I remember the discussion we had probably almost 9-10 years
> > back when I first added the CPU PM notifiers for GICv3. I am sure we
> > would have discussed this at-least couple of times after that. Yet I
> > just got carried away by the fact that GICv2 does the save/restore and
> > this should also be possible. Sorry for that.
> 
> GICv2 is just as fsck'd. It is just that we pretend it works for the
> sake of 32bit that may run in secure mode. On a 64bit machine, or in a
> NS setup, it is doomed for the same reasons. There really isn't any
> substitute for secure firmware here.

Fair enough and thanks for refreshing my memory on this.

Hi Florian,

I did little bit digging in the TF-A and found this.
plat_arm_gic_{save,resume}()in plat/arm/common/arm_gicv3.c which I assume
makes it platform specific code and hence not used on any other platform.
I also missed to see this earlier as I explicitly ignored the plat/ directory
assuming it is all platform specific code not shared across.

Not sure if the firmware on your platform is not using that or is it
different firmware altogether or may be TF-A forked before this change.
If it is missing anything, it would be good to get that fixed and look
at ways to generalise it.

--
Regards,
Sudeep
