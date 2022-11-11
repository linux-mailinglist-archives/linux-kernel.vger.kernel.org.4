Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE88625E08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiKKPPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiKKPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:14:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 949F043AE2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:13:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E6121FB;
        Fri, 11 Nov 2022 07:13:42 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A273F73D;
        Fri, 11 Nov 2022 07:13:35 -0800 (PST)
Date:   Fri, 11 Nov 2022 15:13:32 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ludvig =?utf-8?Q?P=C3=A4rsson?= <Ludvig.Parsson@axis.com>
Cc:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "etienne.carriere@linaro.org" <etienne.carriere@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
Message-ID: <20221111151332.umzh6hncj43gqzo7@bogus>
References: <20221111095313.2010815-1-sumit.garg@linaro.org>
 <20221111143800.k7xje6g23ujefnye@bogus>
 <7a32a3694ffd6790e4e2a7c5896931cf8f1a7243.camel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a32a3694ffd6790e4e2a7c5896931cf8f1a7243.camel@axis.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:00:29PM +0000, Ludvig Pärsson wrote:
> On Fri, 2022-11-11 at 14:38 +0000, Sudeep Holla wrote:
> > On Fri, Nov 11, 2022 at 03:23:13PM +0530, Sumit Garg wrote:
> > > The OP-TEE SCMI transport channel is dependent on TEE subsystem to
> > > be
> > > initialized first. But currently the Arm SCMI subsystem and TEE
> > > subsystem are invoked on the same initcall level as
> > > subsystem_init().
> > > 
> > > It is observed that the SCMI subsystem initcall is invoked prior to
> > > TEE
> > > subsystem initcall. This leads to unwanted error messages regarding
> > > TEE
> > > bus is not present yet. Although, -EPROBE_DEFER tries to workaround
> > > that
> > > problem.
> > > 
> > > Lets try to resolve inter subsystem dependency problem via shifting
> > > Arm
> > > SCMI subsystem to subsystem_init_sync() initcall level.
> > > 
> > 
> > I would avoid doing that. We already have some implicit dependency
> > with
> > subsys_initcall because this driver creates/registers bus and need to
> > be
> > done early. Now in order to solve the dependency between SCMI and
> > TEE,
> > both of which creates/registers bus and are at same subsys_initcall,
> > we are relying on subsys_initcall_sync.
> > 
> > Me and Ludvig discussed this in private and I suggested him to do
> > something
> > like below patch snippet. He mentioned he did post a patch on the
> > list but
> > I couldn't find it. For this the scmi node must be child node of
> > OPTEE as
> > it is providing the transport.
> > 
> > @Ludvig, ?
> > 
> > Regards,
> > Sudeep
> > 
> > --
> > diff --git i/drivers/tee/optee/smc_abi.c
> > w/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..839feca0def4 100644
> > --- i/drivers/tee/optee/smc_abi.c
> > +++ w/drivers/tee/optee/smc_abi.c
> > @@ -1534,7 +1534,9 @@ static int optee_probe(struct platform_device
> > *pdev)
> >                 goto err_disable_shm_cache;
> > 
> >         pr_info("initialized driver\n");
> > -       return 0;
> > +
> > +       /* Populate any dependent child node(if any) */
> > +       return devm_of_platform_populate(&pdev->dev);
> > 
> >  err_disable_shm_cache:
> >         if (!optee->rpc_param_count)
> > 
> I have answered something similar in my submit [1]. Maybe I should have
> CCed you, or atleast sent you this link when I told you I made the
> submission.
> 
> [1] https://lkml.org/lkml/2022/11/9/803
>

Thanks for the reference.

-- 
Regards,
Sudeep
