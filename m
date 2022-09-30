Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457795F0A60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiI3L3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiI3L14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:27:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD8617E13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:19:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F9B244B;
        Fri, 30 Sep 2022 04:19:55 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E18C73F73B;
        Fri, 30 Sep 2022 04:19:47 -0700 (PDT)
Date:   Fri, 30 Sep 2022 12:19:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] arm_pmu: acpi: Pre-allocate pmu structures
Message-ID: <YzbQzq65SDihekj7@FVFF77S0Q05N>
References: <20220912155105.1443303-1-pierre.gondois@arm.com>
 <20220912155105.1443303-2-pierre.gondois@arm.com>
 <YzRsibv4Iqw2Kk0T@FVFF77S0Q05N>
 <c262795e-c84c-3f8f-db1c-e46268525750@arm.com>
 <YzXAFz7+pOZdPoWq@FVFF77S0Q05N>
 <a0275123-2c80-9f18-5716-7fe38b9f110c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0275123-2c80-9f18-5716-7fe38b9f110c@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:01:12AM +0200, Pierre Gondois wrote:
> On 9/29/22 17:56, Mark Rutland wrote:
> > On Thu, Sep 29, 2022 at 04:08:19PM +0200, Pierre Gondois wrote:
> > The big problem here is that while we can detect those PMUs late, we only
> > register them with the core perf code in arm_pmu_acpi_probe(), so even if we
> > detect PMUs after that, those PMUs won't become usable.
> > 
> > I don't think we can support the case where none of the CPUs associated with a
> > PMU are booted at startup unless we make more substantial changes to the way we
> > register the PMUs with perf (and that would be going firther than what we
> > support with DT).
> > 
> > We can support bringing those CPUs online, just not registering them with perf.
> > 
> > > I tried the patch on a Juno-r2 with the 'maxcpus=1 apci=force' parameters. When late
> > > hotplugging CPU1 (which has a different pmu than CPU0), no pmu structure is found and
> > > the cpuhp state machine fails (since arm_pmu_acpi_cpu_starting() failed).
> > 
> > Ah, sorry, I missed that returning an error here would completely halt bringing
> > the CPU online. We arm_pmu_acpi_cpu_starting() to return 0 rather than -ENOENT
> > when it doesn't find a matching PMU, which would permit the CPU to come online.
> > 
> > I've made that change (and pushed that out to the branch), and it seems to work
> > for me, testing in a UEFI+ACPI VM on a ThunderX2, with the arm_pmu_acpi code
> > hacked to use the cpu index (rather than the MIDR) as the identifier for the
> > type of CPU.
> > 
> > With that change, booting a 64-vCPU VM with 'maxcpus=8', I see each of the
> > boot-time CPUs had its PMU registered:
> > 
> > | # ls /sys/bus/event_source/devices/
> > | armv8_pmuv3_0  armv8_pmuv3_3  armv8_pmuv3_6  software
> > | armv8_pmuv3_1  armv8_pmuv3_4  armv8_pmuv3_7  tracepoint
> > | armv8_pmuv3_2  armv8_pmuv3_5  breakpoint
> > 
> > ... and if I try to online a non-matching CPU the CPU will come up, but I get a
> > notification that we couldn't associate with a PMU:
> > 
> > | # echo 1 > /sys/devices/system/cpu/cpu8/online
> > | Detected PIPT I-cache on CPU8
> > | GICv3: CPU8: found redistributor 8 region 0:0x00000000081a0000
> > | GICv3: CPU8: using allocated LPI pending table @0x0000000040290000
> > | Unable to associate CPU8 with a PMU
> > | CPU8: Booted secondary processor 0x0000000008 [0x431f0af1]
> > 
> > If I do the same thing but without the MIDR hack, it also seems to work:
> > 
> > | # ls /sys/bus/event_source/devices/
> > | armv8_pmuv3_0  breakpoint     software       tracepoint
> > | # cat /sys/bus/event_source/devices/armv8_pmuv3_0/cpus
> > | 0-7
> > | # echo 1 > /sys/devices/system/cpu/cpu10/online
> > | Detected PIPT I-cache on CPU10
> > | GICv3: CPU10: found redistributor a region 0:0x00000000081e0000
> > | GICv3: CPU10: using allocated LPI pending table @0x00000000402b0000
> > | CPU10: Booted secondary processor 0x000000000a [0x431f0af1]
> > | # ls /sys/bus/event_source/devices/
> > | armv8_pmuv3_0  breakpoint     software       tracepoint
> > | # cat /sys/bus/event_source/devices/armv8_pmuv3_0/cpus
> > | 0-7,10
> > 
> > ... so I think that should be ok?
> 
> Ok yes, thanks for the explanation. I tried it aswel and everything
> was as expected.Just some typos:

Great!

> patch 1:
> factor out PMU<->CPU assocition
> -> association
> A subsequeqnt patch will rework the ACPI probing of PMUs, and we'll need
> -> subsequent
> 
> patch 2:
> A subsequeqnt patch will rework the ACPI probing of PMUs, and we'll need
> -> subsequent
> 
> patch 3:
> The current ACPI PMU probing logic tries to aassociate PMUs with CPUs
> works. The arm_pmu_acpi_cpu_starting() callback only tries to assocaite
> though we will now warn when we cannot assocaite a CPU with a PMU.
> -> associate (for the 3 lines)

Sorry; those were particularly typo-ridden. Thanks for the corrections!

I'll send these out as a series shortly.

Thanks,
Mark.
