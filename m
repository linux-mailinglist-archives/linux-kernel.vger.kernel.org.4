Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD365D385
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjADM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbjADM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:56:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6962613EA3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:56:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11261042;
        Wed,  4 Jan 2023 04:57:16 -0800 (PST)
Received: from bogus (unknown [10.163.75.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3BB63F587;
        Wed,  4 Jan 2023 04:56:31 -0800 (PST)
Date:   Wed, 4 Jan 2023 12:56:32 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Message-ID: <20230104125632.ktoyt7mxjjxq5udm@bogus>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
 <Y7Rg28suWh1RUbkU@spud>
 <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
 <F86CD957-8B7C-46B9-A14B-AAE67E43CD71@kernel.org>
 <20230104104900.aohsn6zemfllub7r@bogus>
 <Y7VulIcGwuXvBES6@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7VulIcGwuXvBES6@spud>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:18:28PM +0000, Conor Dooley wrote:
> Hey Sudeep,
> 
> On Wed, Jan 04, 2023 at 10:49:00AM +0000, Sudeep Holla wrote:
> > On Wed, Jan 04, 2023 at 09:49:48AM +0000, Conor Dooley wrote:
> > 
> > [...]
> > 
> > > >> Uhh, so where did this "capacity-dmips-mhz" property actually come from?
> > > >> I had a quick check of qemu with grep & I don't see anything there that
> > > >> would add this property.
> > > >> This property should not be valid on anything other than arm AFAICT.
> > > >
> > > >This DT parameter is not in default Qemu. I've added it for testing (see test steps in below). 
> > > >This is preparation to support asymmetric CPU topology for RISC-V.
> > > 
> > > The property is only valid on arm, so how does arm64 deal with such
> > > asymmetric topologies without it?
> > 
> > I don't think we can deal with asymmetric topologies without this.
> > Yes we can detect the difference in the CPU types but we can only assume
> > there are symmetric in terms of performance in absence of this property.
> 
> 
> I looked at the bindings for it and forgot that the arm directory of
> bindings applies to both arm and arm64. I see now that it is also used
> on arm64.
> 
> > 
> > > Why should we "fix" something that may never be a valid dts?
> > >
> > 
> > I would not say invalid. But surely absence of it must be handled and
> > we do that for sure. IIRC, here the presence of it is causing the issue.
> > And if it is present means someone is trying to build it(I do understand
> > this is Qemu but is quite common these days for power and performance
> > balance in many SoC)
> 
> I said "invalid" as the binding is defined for arm{,64} in arm/cpus.yaml
> & documented in the same directory in cpu-capacity.txt, but not yet on
> riscv. All bets are off if your cpu node is using invalid properties
> IMO, at least this one will fail to boot!
> 
> However, I see no reason (at this point) that we should deviate from
> what arm{,64} is doing & that documenation should probably move to a
> shared location at some point.
>

I prefer making this binding generic rather than patching to handle RISC-V
differently in the generic code. Since it is optional, the platform
need not use it if it is not needed.

-- 
Regards,
Sudeep
