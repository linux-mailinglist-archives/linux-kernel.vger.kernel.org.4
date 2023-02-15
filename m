Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03529697B81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjBOMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjBOMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:10:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8AA2A987
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:10:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8E3FEC;
        Wed, 15 Feb 2023 04:11:37 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5253D3F703;
        Wed, 15 Feb 2023 04:10:53 -0800 (PST)
Date:   Wed, 15 Feb 2023 12:10:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oliver.upton@linux.dev>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Save and restore distributor and
 re-distributor
Message-ID: <20230215121050.d57tnfh7wzpyqzti@bogus>
References: <20230214233426.2994501-1-f.fainelli@gmail.com>
 <20230214233426.2994501-4-f.fainelli@gmail.com>
 <87o7pvz78z.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7pvz78z.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 08:02:20AM +0000, Marc Zyngier wrote:
> On Tue, 14 Feb 2023 23:34:26 +0000,
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On platforms implementing Suspend to RAM where the GIC loses power, we
> > are not properly saving and restoring the GIC distributor and
> > re-distributor registers thus leading to the system resuming without any
> > functional interrupts.
>
> The real question is *why* we need any of this. On any decent system,
> this is the firmware's job.  It was *never* the OS GIC driver's job
> the first place.
>

Completely agreed on the points you have made here, no disagreement.
However I would like to iterate some of the arguments/concerns the
firmware teams I have interacted in the past have made around this.
And this is while ago(couple of years) and they may have different
views. I am repeating them as I think it may be still valid on some
systems so that we can make some suggestions if we have here.

> Importantly, the OS cannot save the full state: a large part of it is
> only accessible via secure, and Linux doesn't run in secure mode. How
> do you restore the group configuration, for example? Oh wait, you
> don't even save it.
>

Agreed, we can't manage secure side configurations. But one of the concern
was about the large memory footprint to save the larger non-secure GIC
context in the smaller secure memory.

One of the suggestion at the time was to carve out a chunk of non-secure
memory and let the secure side use the same for context save and restore.
Not sure if this was tried out especially for the GIC. I may need to
chase that with the concerned teams.

Thanks Florian for starting this thread and sorry that I couldn't recollect
lots of the information when we chatted in the private about this. Marc
response triggered all the memory back.

> So unless you have a single security state system, this cannot
> work. And apart from VMs (which by the way do not need any of this),
> there is no GICv3-based system without EL3. If you know of one, please
> let me know. And if it existed, then all the save/restore should
> happen only when GICD_CTLR.DS==1.
>

Yes, now I remember the discussion we had probably almost 9-10 years
back when I first added the CPU PM notifiers for GICv3. I am sure we
would have discussed this at-least couple of times after that. Yet I
just got carried away by the fact that GICv2 does the save/restore and
this should also be possible. Sorry for that.

--
Regards,
Sudeep
