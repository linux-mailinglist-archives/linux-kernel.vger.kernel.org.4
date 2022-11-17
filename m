Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227562D942
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiKQLTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKQLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:19:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01C5611463
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:19:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5091D6E;
        Thu, 17 Nov 2022 03:19:14 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBE563F73B;
        Thu, 17 Nov 2022 03:19:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:19:04 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-arm-kernel@lists.infradead.org, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, Ludvig.Parsson@axis.com,
        jens.wiklander@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Message-ID: <20221117111904.2gro52wb43kyuuhe@bogus>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus>
 <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
 <20221114102650.qwkaxtnstujaiu6u@bogus>
 <CAN5uoS8SArNmaxwhJ=tRCPD8ue1D8VvQyLacDDS2sunfg4gLbw@mail.gmail.com>
 <CAFA6WYPwku8d7EiJ8rF5pVh568oy+jXMXLdxSr6r476e0SD2nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPwku8d7EiJ8rF5pVh568oy+jXMXLdxSr6r476e0SD2nw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:11:32PM +0530, Sumit Garg wrote:
>
> So it's the DT legacy we want to maintain for the SCMI subsystem even
> if the underlying transport is discoverable?

Not sure what exactly you mean here by "DT legacy". The SCMI consumers
needing SCMI info from DT is not legacy for sure. The creation of SCMI
platform device from DT for TEE can be considered as legacy.

> This simply undermines the benefits of a discoverable TEE bus over the
> non-discoverable platform bus. Also, the reluctance to carry forward SCMI
> subsystem DT legacy has resulted in misrepresentation of SCMI OP-TEE
> transport as follows:
>

Agreed on using DT for creation of SCMI platform device.

>     First represented as a platform device via DT (compatible =
> "linaro,scmi-optee";) and then
>     Migrated to being a TEE bus device (UUID: 0xa8cfe406, 0xd4f5,
> 0x4a2e, 0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)
>

I am fine with SCMI platform device not created by TEE/OPTEE by
of_populate_device(). It can create one by matching the service(IIUC).

> This misrepresentation is the reason for the indirect DT hack that
> Sudeep suggested to fix the error message while registering a driver
> on TEE bus.
>

Again, sorry. We are mixing up things here I think. The DT representation
of SCMI node as child of TEE/OPTEE is *not* hack. I agree creating the
platform device from DT w/o checking the service is hack. Let me know
if we are on the same page here.

> Is it not possible for SCMI subsystem to evolve and support underlying
> transport on a discoverable TEE bus?
>

It must, and as I mentioned we need to create SCMI platform device only
once the SCMI service is discovered. For that reason, the SCMI node in
that case must not be in /firmware but inside /firmware/optee.

Now it is up to OPTEE or even FF-A to create the devices for the service
it provides when ready.

> 
> Why? The SCMI OP-TEE transport driver will still be registered on TEE
> bus via subsys_initcall() prior to TEE bus being registered via
> subsys_initcall().
>

Not if SCMI platform device is not created before TEE has discovered SCMI
service.

> > > When both SCMI and TEE are present in DT and SCMI used OPTEE
> > > as a transport I see it is correct to represent them as child and parent
> 
> No it's not the correct representation. Devices on the TEE bus have
> nothing to do with DT.

I disagree, the whole child/parent hierarchy in DT is for such a dependency.
That said, I am not asking to create SCMI device via of_populate_devices()
from TEE. It can choose to do in whatever is the right ways especially if
it can be discovered.

> The OP-TEE node in DT represents a particular
> TEE implementation whereas there are other ways to represent OP-TEE
> implementation as a device on FF-A bus.
>

Agreed again.

> Your suggested change only works due to misrepresentation of SCMI
> OP-TEE transport as highlighted above while it won't fix the case with
> OP-TEE device on FF-A bus.
>

Incorrect. As I mentioned before I don't care how we create SCMI device,
whether it has to be SCMI platform device or it can be SCMI TEE device with
all these managed within probe.

> > > and it can be utilised here to solved the problem with respect to the driver
> > > model without having to play around with the initcall levels which is always
> > > going to bite us back with one extra dependency.
> > >
> 
> As I mentioned in the patch description, it's an inter-subsystem
> dependency. It has to be solved via initcall levels.

A big NACK again. What you think will solve problem on this problem may cause
issue on some other platform or some other config. We definitely need a
solution which is not fiddling with initcall levels. I am sure others agree
with that as we have had enough issues with that in the past and the whole
probe deferral is result of that. But in this case it is not working and 
we can't go back to initcall for sure.

> I am unsure which
> extra dependency you have in mind but the one mentioned below doesn't
> fall into that category. Have you looked at other places within the
> kernel for usage of subsys_initcall_sync()?
>

Yes, but still I don't agree with that. For me it is hack just to solve
the issue at hand instead of thinking what is wrong with the design. The
whole point of all these discoverable buses was to get rid of such initcall
and deferred probe dependency and we must not use them to solve the issue
here.

> > > And with FF-A, TEE and SCMI all in the mix we might have that dependency
> > > already, so I really want to avoid playing with initcall levels just to solve
> > > this problem.
> 
> There isn't a three level dependency here. The only dependency we have
> to solve is that the SCMI OP-TEE transport shouldn't register on TEE
> bus prior to registration of TEE bus. And switching SCMI subsystem to
> subsys_initcall_sync() fixes that dependency even with OP-TEE FF-A
> ABI.
>

NACK again. I won't accept that unless we have explore right options
and get agreement with Greg or others that this is the only way.

> >
> > Even with FFA, the optee driver still registers from module_init level
> > (== device_init level initcall), as when using legacy OP-TE SMC ABI.
> > SCMI firmware driver is initialized from subsys_init level hence
> > before optee driver. So I think SCMI optee transport relies on the
> > same dependencies whatever OP-TEE is using FFA ABI or its legacy SCM
> > ABI.
> >
> 
> I guess here you are confusing the TEE subsystem driver invoked at
> subsys_initcall() versus OP-TEE driver invoked at module_init(). The
> TEE bus is registered by the TEE subsystem driver rather than the
> OP-TEE driver.
>

I agree. One option I could think of as I read this is to have SCMI optee
to be proper driver at appropriate level and the probe can add the platform
SCMI device needed to prove SCMI driver from scmi_optee_service_probe.
That should work IMO. I will try to hack up something and share.

> So there is *no* dependency among SCMI firmware driver and OP-TEE
> driver but rather the dependency is with TEE subsystem driver instead.
>

Agreed.

> > Device discovery from OP-TEE bus will always need to wait for the
> > OP-TEE bus to be ready.
> 
> It isn't an OP-TEE bus but rather a TEE bus with underlying TEE
> implementations like OP-TEE etc. registering their corresponding
> devices.
> 

+1

-- 
Regards,
Sudeep
