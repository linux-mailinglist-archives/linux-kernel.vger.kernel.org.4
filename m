Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C865D0F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjADKwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjADKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:51:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CC451EEC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:49:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5B21FB;
        Wed,  4 Jan 2023 02:49:46 -0800 (PST)
Received: from bogus (unknown [10.163.75.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED2553F587;
        Wed,  4 Jan 2023 02:49:00 -0800 (PST)
Date:   Wed, 4 Jan 2023 10:49:00 +0000
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
Message-ID: <20230104104900.aohsn6zemfllub7r@bogus>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
 <Y7Rg28suWh1RUbkU@spud>
 <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
 <F86CD957-8B7C-46B9-A14B-AAE67E43CD71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F86CD957-8B7C-46B9-A14B-AAE67E43CD71@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:49:48AM +0000, Conor Dooley wrote:

[...]

> >> Uhh, so where did this "capacity-dmips-mhz" property actually come from?
> >> I had a quick check of qemu with grep & I don't see anything there that
> >> would add this property.
> >> This property should not be valid on anything other than arm AFAICT.
> >
> >This DT parameter is not in default Qemu. I've added it for testing (see test steps in below). 
> >This is preparation to support asymmetric CPU topology for RISC-V.
> 
> The property is only valid on arm, so how does arm64 deal with such
> asymmetric topologies without it?

I don't think we can deal with asymmetric topologies without this.
Yes we can detect the difference in the CPU types but we can only assume
there are symmetric in terms of performance in absence of this property.

> Why should we "fix" something that may never be a valid dts?
>

I would not say invalid. But surely absence of it must be handled and
we do that for sure. IIRC, here the presence of it is causing the issue.
And if it is present means someone is trying to build it(I do understand
this is Qemu but is quite common these days for power and performance
balance in many SoC)


[...]

> >> 
> >> I know arm64 does this, but there is any real reason for us to do so?
> >> @Sudeep, do you know why arm64 calls that each time?
> 
> I got myself mixed up between places I fiddled with storing the topology, so you can ignore that question Sudeep.
> Clearly it's the one in smp_callin() that gets called for each CPU.
> Woops.
> 

Hmm I should have read all the messages in the thread. Doing by date/time
didn't work well for me 😄.

> >> Or if it is worth "saving" that call on riscv, since arm64 is clearly happily calling
> >> it for many years & calling it later would likely head off a good few allocation
> >> issues (like the one we saw with the topology reworking a few months ago).
> 
> ...but is it still worth moving the function call later to head off any allocation failures if core topology code changes?
>

Agreed, given how we faced similar issues with cacheinfo on few RISC-V
platforms.


-- 
Regards,
Sudeep
