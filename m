Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7841F63C431
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiK2Pxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiK2Pxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:53:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F05A31368;
        Tue, 29 Nov 2022 07:53:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAAFED6E;
        Tue, 29 Nov 2022 07:53:44 -0800 (PST)
Received: from [10.57.7.150] (unknown [10.57.7.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5AD83F67D;
        Tue, 29 Nov 2022 07:53:35 -0800 (PST)
Message-ID: <25658a70-0b37-966d-e46c-f86be2a76a8e@arm.com>
Date:   Tue, 29 Nov 2022 15:53:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 6/7] arm64/perf: Add BRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-7-anshuman.khandual@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221107062514.2851047-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 06:25, Anshuman Khandual wrote:
> This adds a BRBE driver which implements all the required helper functions
> for struct arm_pmu. Following functions are defined by this driver which
> will configure, enable, capture, reset and disable BRBE buffer HW as and
> when requested via perf branch stack sampling framework.

Hi Anshuman,

I've got a rough version of an updated test for branch stacks here [1].
A couple of interesting things that I've noticed running it:

First one is that sometimes I get (null) for the branch type. Debugging
in GDB shows me that the type is actually type == PERF_BR_EXTEND_ABI &&
new_type == 11. I can't see how this is possible looking at the driver
code. I think I saw this on a previous version of the patchset too but
didn't mention it because I thought it wasn't significant, but now I see
that something strange is going on. An interesting pattern is that they
are always after ERET samples and go from userspace to kernel:

41992866945460 0x6e8 [0x360]: PERF_RECORD_SAMPLE(IP, 0x1): 501/501:
0xffff800008010118 period: 1229 addr: 0
... branch stack: nr:34
.. 007a9988 -> 00000000 0 cycles  P   9fbfbfbf IRQ
.. 00000000 -> 007a9988 0 cycles  P   9fbfbfbf ERET
.. 007a9988 -> 00000000 0 cycles  P   9fbfbfbf (null)
.. 00747668 -> 007a9988 0 cycles  P   9fbfbfbf CALL
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00747664 -> 00747660 0 cycles  P   9fbfbfbf COND
.. 00000000 -> 00747658 0 cycles  P   9fbfbfbf ERET
.. 00747658 -> 00000000 0 cycles  P   9fbfbfbf ARM64_DEBUG_DATA
.. 00000000 -> 00747650 0 cycles  P   9fbfbfbf ERET
.. 00747650 -> 00000000 0 cycles  P   9fbfbfbf ARM64_DEBUG_DATA
.. 00747624 -> 00747634 0 cycles  P   9fbfbfbf COND
.. 00000000 -> 007475f4 0 cycles  P   9fbfbfbf ERET
.. 007475f4 -> 00000000 0 cycles  P   9fbfbfbf ARM64_DEBUG_DATA
.. 00000000 -> 007475e8 0 cycles  P   9fbfbfbf ERET
.. 007475e8 -> 00000000 0 cycles  P   9fbfbfbf (null)
.. 004005ac -> 007475e8 0 cycles  P   9fbfbfbf CALL
.. 00000000 -> 00400564 0 cycles  P   9fbfbfbf ERET
.. 00400564 -> 00000000 0 cycles  P   9fbfbfbf (null)
.. 00000000 -> 00400564 0 cycles  P   9fbfbfbf ERET
 .. thread: perf:501
 ...... dso: [kernel.kallsyms]

The second one is that sometimes I get kernel addresses and RET branches
even if the option is any_call,u. The pattern here is that it's the last
non empty branch stack of a run, so maybe there is some disable path
where the filters aren't configured properly:

armv8pmu_brbe_enable+0xc/arm64_pmu_brbe_enable+0x0/P/-/-/0/CALL
armpmu_start+0xe0/armv8pmu_brbe_enable+0x0/P/-/-/0/IND_CALL
armv8pmu_brbe_reset+0x18/armpmu_start+0xd0/P/-/-/0/RET
arm64_pmu_brbe_reset+0x18/armv8pmu_brbe_reset+0x10/P/-/-/0/RET


[1]:
https://gitlab.arm.com/linux-arm/linux-jc/-/commit/7260b7bef06ac161eac88d05266e8c5c303d9881
