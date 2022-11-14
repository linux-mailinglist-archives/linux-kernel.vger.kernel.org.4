Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D866627A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKNK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiKNK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:26:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5863F1D334
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:26:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649C623A;
        Mon, 14 Nov 2022 02:27:01 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1A73F534;
        Mon, 14 Nov 2022 02:26:53 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:26:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, cristian.marussi@arm.com,
        Ludvig.Parsson@axis.com, jens.wiklander@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Message-ID: <20221114102650.qwkaxtnstujaiu6u@bogus>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus>
 <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:01:32PM +0530, Sumit Garg wrote:
> Hi Sudeep,
> 
> On Fri, 11 Nov 2022 at 20:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Nov 11, 2022 at 03:23:13PM +0530, Sumit Garg wrote:
> > > The OP-TEE SCMI transport channel is dependent on TEE subsystem to be
> > > initialized first. But currently the Arm SCMI subsystem and TEE
> > > subsystem are invoked on the same initcall level as subsystem_init().
> > >
> > > It is observed that the SCMI subsystem initcall is invoked prior to TEE
> > > subsystem initcall. This leads to unwanted error messages regarding TEE
> > > bus is not present yet. Although, -EPROBE_DEFER tries to workaround that
> > > problem.
> > >
> > > Lets try to resolve inter subsystem dependency problem via shifting Arm
> > > SCMI subsystem to subsystem_init_sync() initcall level.
> > >
> >
> > I would avoid doing that. We already have some implicit dependency with
> > subsys_initcall because this driver creates/registers bus and need to be
> > done early.
> 
> Yeah but that should work fine with subsystem_init_sync() too unless
> you have drivers being registered on the bus at subsystem_init_sync()
> initcall which doesn't seem to be the case in mainline. Have a look at
> usage of subsystem_init_sync() elsewhere to see its similar usage to
> resolve dependencies among different subsystems.
> 
> However, if you are too skeptical regarding this change then we can
> limit it to OP-TEE transport only as follows:
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index f43e52541da4..19c1222b3dfc 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2667,7 +2667,11 @@ static int __init scmi_driver_init(void)
> 
>         return platform_driver_register(&scmi_driver);
>  }
> +#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
>  subsys_initcall_sync(scmi_driver_init);
> +#else
> +subsys_initcall(scmi_driver_init);
> +#endif
>

If this is the only way to solve, I would prefer to keep it unconditional.

>  static void __exit scmi_driver_exit(void)
>  {
> 
> > Now in order to solve the dependency between SCMI and TEE,
> > both of which creates/registers bus and are at same subsys_initcall,
> > we are relying on subsys_initcall_sync.
> 
> True.
> 
> >
> > Me and Ludvig discussed this in private and I suggested him to do something
> > like below patch snippet. He mentioned he did post a patch on the list but
> > I couldn't find it. For this the scmi node must be child node of OPTEE as
> > it is providing the transport.
> 
> TBH, the first thought that came to mind after looking at SCMI OP-TEE
> DT node was that why do we need it when those properties can be probed
> from SCMI pseudo TA at runtime? Maybe I am missing something as I
> wasn't involved in its review process.
>

I don't have internal details OPTEE and may be it could be probed. Etienne
can comment on that. But we need SCMI node in general as the consumers of
the SCMI are in the DT and they need to link to the provider.

> The whole idea of TEE bus evolved from the idea that if the firmware
> bits can be probed at runtime then we shouldn't use DT as a dumping
> ground for those. I hope you remember discussions around discoverable
> FF-A bus too.
> 

Exactly this is what I thought of initially when I proposed the solution.
And yes we won't even have DT node for TEE in that case, so it shouldn't
be a problem. When both SCMI and TEE are present in DT and SCMI used OPTEE
as a transport I see it is correct to represent them as child and parent
and it can be utilised here to solved the problem with respect to the driver
model without having to play around with the initcall levels which is always
going to bite us back with one extra dependency.

And with FF-A, TEE and SCMI all in the mix we might have that dependency
already, so I really want to avoid playing with initcall levels just to solve
this problem.

> However, the change below is simply an incorrect way to fix the actual
> inter subsystem dependency problem via DT. How would this fix the
> problem in the case OP-TEE driver registers on FF-A bus? There won't
> be any DT node for OP-TEE in that case.
>

Agreed and this is why I thought it in the first place. As I mention in this
case there are no DT nodes and hence we can't use this at all. I am suggesting
this only when both DT nodes are present and SCMI depends on OPTEE transport
which fits the child/parent hierarchy irrespective of this solution. This
is just ensuring any dependent DT nodes are populated only after OPTEE is
ready. I don't see this to be an issue or see this as incorrect.


Also I am not sure this initcall juggling will help if there are 3 or more
at the same level, we need to rely on driver model and/or proper hierarchy
in the DT node. The whole links between devices is modelled on that and
I don't see that as any issue and we are not dumping any more information
that it is already in DT. We are just using the correct hierarchical
representation here IMO.

-- 
Regards,
Sudeep
