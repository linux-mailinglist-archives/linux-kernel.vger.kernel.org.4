Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27BD5E6395
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiIVN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiIVN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:27:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DAEFF59
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD6C5B836CD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4932C433C1;
        Thu, 22 Sep 2022 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663853266;
        bh=DY9TxgTImIQyAvfjUKkwmtdipv1ptGHWjBTLeLlMbB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsfGjl89b10o7QazXb/UMOXL152YEI1ALY2l/UwlpEFd+vQ22bUvM774RApxPUdSx
         Ep3x/n9+MkdNWw75RyB19eMtuJkjszXKdMjZYIuf26qazJFfFM9ftJs+KoTs395LKT
         tHZE9hcr3F7NcIs6FeutZO2M5VfDq+4+t5kmolxwSfvL7fIEv2KnF/gljm/4BCl339
         K0tD+jbNgCdru1fEvRbecQV+4YNvQcobaC8LmegR47PMSeVKEWcRtSOL6Hpro7PQDn
         j7YL2R+WqrE+QDqTT0MFD94hTZy4plbINXWwCECJ6ZKeywkc5D8hBidZHvIJ0m52t2
         9Gi51w1+0uY2Q==
Date:   Thu, 22 Sep 2022 14:27:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/1] arm_pmu: acpi: Pre-allocate pmu structures
Message-ID: <20220922132740.GB12095@willie-the-truck>
References: <20220912155105.1443303-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912155105.1443303-1-pierre.gondois@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 05:51:03PM +0200, Pierre Gondois wrote:
> Sleeping inside arm_pmu_acpi_cpu_starting() while running a preemp_rt
> kernel was reported at [1], and a solution was suggested at [2].
> 
> It seems [2] doesn't work because of the following:
> """PREPARE: The callbacks are invoked on a control CPU before the
> hotplugged CPU is started up or after the hotplugged CPU has died."""
> 
> Indeed the 'prepare' callbacks are executed on the control CPU and
> this CPU cannot remotely read the cpuid (cf read_cpuid_id()) of the
> other CPUs.
> 
> Another solution:
> 1. count the number of different PMU IRQs (#IRQs)
> 2. allocate #IRQs pmu structures. There is at most #IRQs PMUs
> 3. in arm_pmu_acpi_cpu_starting() subcalls, after checking the cpuid,
>    decide to use or re-use a pre-allocated pmu structure.
>    Thus the pre-allocated pmu struct can be seen as a pool and all
>    the struct might not be used.
> 4. free the unused pmu structures when probing
> is suggested in this patch.
> 
> Freeing the unused pmu structures (4.) could maybe be done in a
> CPUHP_AP_ONLINE_DYN hotplug callback instead, but only one CPU is
> needed to search/free unused pre-allocated pmu structures.

I vaguely remember Mark R having a look at this at the time, so I'd like
his Ack on your approach before I queue anything.

Will
