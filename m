Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2469FB99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBVS4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjBVS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:56:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 705FB3B0C4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:56:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3593FEC;
        Wed, 22 Feb 2023 10:43:12 -0800 (PST)
Received: from [10.57.15.137] (unknown [10.57.15.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D68553F587;
        Wed, 22 Feb 2023 10:42:26 -0800 (PST)
Message-ID: <62d945d6-acde-0d26-1014-48b44cf85be8@arm.com>
Date:   Wed, 22 Feb 2023 18:42:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/10] KVM: arm64: switch HCRX_EL2 between host and guest
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-4-kristina.martsenko@arm.com>
 <86o7pty3dm.wl-maz@kernel.org>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <86o7pty3dm.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 16:35, Marc Zyngier wrote:
> On Thu, 16 Feb 2023 16:00:05 +0000,
> Kristina Martsenko <kristina.martsenko@arm.com> wrote:
>>
>> Switch the HCRX_EL2 register between host and guest configurations, in
>> order to enable different features in the host and guest.
>>
>> Note that the guest flags are only set if all CPUs have HCRX_EL2.
>> Asymmetric systems where only some CPUs have HCRX_EL2 are not supported
>> and will result in guests running with the host flags set (and a "SANITY
>> CHECK" warning printed for the host).
>>
>> After this change, SMPME is no longer set for guests, which should have
>> no effect as SME is currently disabled for guests.
> 
> Why not preserve the behaviour by propagating the flag into the guest
> setup?

I thought it made more sense to disable SMPME given that SME is not supported
in guests yet (and that the existing behavior was just a side effect of not
having support for switching HCRX), but I'd misunderstood what SMPME is for,
and following Mark's explanation I'll actually preserve the behavior for
guests, but now disable SMPME for the host instead (as SME priority mapping has
no benefit in the host and is not intended to be used there).

> 
>>
>> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
>> ---
>>
>> I wasn't sure what to do about asymmetric systems. It seems a bit
>> fragile, maybe someone has a better idea?
> 
> I would simply prevent these CPUs from booting if they come after a
> primary CPU that has the feature. 

I considered that but the concern I heard was that since virtualization is an
optional feature then people may still want to use the system without it.

> These hypothetical asymmetric setups
> put a huge complexity on the kernel, and I'm worried that we're just
> giving implementers too much freedom.
> 
> If someone comes up with that sort of stuff, they can write the
> patches themselves... 

I'll make it panic on a mismatch for now and it can be revisited in the future
if such a system actually appears (which does seem very unlikely).

> Or do you know of any braindead setup involving
> an asymmetric FEAT_HCX implementation?

Nope don't know of one, it was just hypothetical.

Thanks,
Kristina

