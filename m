Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306961955C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKDLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:30:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C1A329;
        Fri,  4 Nov 2022 04:30:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A3E1FB;
        Fri,  4 Nov 2022 04:30:20 -0700 (PDT)
Received: from [10.57.69.48] (unknown [10.57.69.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB5E3F703;
        Fri,  4 Nov 2022 04:30:10 -0700 (PDT)
Message-ID: <5c410969-2176-49cf-640f-8023c421682e@arm.com>
Date:   Fri, 4 Nov 2022 11:30:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/7] perf: Arm SPEv1.2 support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/2022 20:11, Rob Herring wrote:
> This series adds support for Arm SPEv1.2 which is part of the
> Armv8.7/Armv9.2 architecture. There's 2 new features that affect the 
> kernel: a new event filter bit, branch 'not taken', and an inverted 
> event filter register. 
> 
> Since this support adds new registers and fields, first the SPE register 
> defines are converted to automatic generation.
> 
> Note that the 'config3' addition in sysfs format files causes SPE to 
> break. A stable fix e552b7be12ed ("perf: Skip and warn on unknown format 
> 'configN' attrs") landed in v6.1-rc1.
> 
> The perf tool side changes are available here[1].
> 
> Tested on FVP.
> 
> [1] https://lore.kernel.org/all/20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org/
> 

LGTM. Tested with [1] applied and on N1SDP (where it isn't supported),
and on the FVP. Enabling all the inverted filters results in no trace
and other combinations work as expected.

James

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> - Convert the SPE register defines to automatic generation
> - Fixed access to SYS_PMSNEVFR_EL1 when not present
> - Rebase on v6.1-rc1
> - Link to v1: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org
> 
> ---
> Rob Herring (7):
>       perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
>       arm64: Drop SYS_ from SPE register defines
>       arm64/sysreg: Convert SPE registers to automatic generation
>       perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
>       perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
>       perf: Add perf_event_attr::config3
>       perf: arm_spe: Add support for SPEv1.2 inverted event filtering
> 
>  arch/arm64/include/asm/el2_setup.h |   6 +-
>  arch/arm64/include/asm/sysreg.h    |  99 +++------------------------
>  arch/arm64/kvm/debug.c             |   2 +-
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c |   2 +-
>  arch/arm64/tools/sysreg            | 116 +++++++++++++++++++++++++++++++
>  drivers/perf/arm_spe_pmu.c         | 136 ++++++++++++++++++++++++-------------
>  include/uapi/linux/perf_event.h    |   3 +
>  7 files changed, 224 insertions(+), 140 deletions(-)
> ---
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> change-id: 20220825-arm-spe-v8-7-fedf04e16f23
> 
> Best regards,
