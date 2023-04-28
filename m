Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B36F0F91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjD1AY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjD1AY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:24:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF11D2D51;
        Thu, 27 Apr 2023 17:24:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F72D2F4;
        Thu, 27 Apr 2023 17:25:09 -0700 (PDT)
Received: from [10.57.23.190] (unknown [10.57.23.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 665683F587;
        Thu, 27 Apr 2023 17:24:24 -0700 (PDT)
Message-ID: <7d7cafea-37b2-a050-7247-6c0234cb4f4c@arm.com>
Date:   Fri, 28 Apr 2023 01:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf: ampere: Add support for Ampere SoC PMUs
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230427215325.1067752-1-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230427215325.1067752-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-27 22:53, Ilkka Koskinen wrote:
> Add support for Ampere SoC PMUs. This driver supports MCU PMU
> available in the AmpereOne SoC.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../admin-guide/perf/ampere-soc-pmu.rst       |  36 +
>   Documentation/admin-guide/perf/index.rst      |   1 +
>   drivers/perf/Kconfig                          |  10 +
>   drivers/perf/Makefile                         |   1 +
>   drivers/perf/ampere_soc_pmu.c                 | 724 ++++++++++++++++++
>   5 files changed, 772 insertions(+)
>   create mode 100644 Documentation/admin-guide/perf/ampere-soc-pmu.rst
>   create mode 100644 drivers/perf/ampere_soc_pmu.c
> 
> diff --git a/Documentation/admin-guide/perf/ampere-soc-pmu.rst b/Documentation/admin-guide/perf/ampere-soc-pmu.rst
> new file mode 100644
> index 000000000000..5161fbd1c548
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/ampere-soc-pmu.rst
> @@ -0,0 +1,36 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================================
> +Ampere SoC Performance Monitoring Unit (PMU)
> +============================================
> +
> +Ampere SoC PMU is a generic PMU IP. At the first phase it's used for counting
> +MCU events on AmpereOne.
> +
> +MCU PMU events
> +--------------
> +
> +The PMU driver registers a PMU device for every supported PMU instance on each
> +SoC. See /sys/devices/AMPC0100:<nn>/.
> +
> +The PMU driver supports setting filters for "rank", "bank", and "threshold". The
> +filter settings are device specific and shared between all the relevant events.
> +The default value for all the filters is zero. The filters can be modified by
> +setting them with the last event of the particular device. All the previous
> +settings are overwritten.

Yeah, that doesn't really work... what is the "last event" relative to? 
Order of arguments to arbitrary tools? Order of perf_event_open 
syscalls? Order in which events are actually scheduled on the PMU? 
(which users can't even control - think event rotation)

To be practical I think you'll have to handle this the same way as 
arm_smmuv3_pmu's global filtering, and only allow events with matching 
filter configs to be scheduled together.

[...]
> +#define SOC_PMEVCNTR0_LO	0x000
> +#define SOC_PMEVCNTR0_HI	0x004
> +#define SOC_PMCCNTR_LO		0x0F8
> +#define SOC_PMCCNTR_HI		0x0FC
> +
> +#define SOC_PMEVTYPER0		0x400
> +
> +#define SOC_PMELCSR		0xA10
> +
> +#define SOC_PMCNTENSET		0xC00
> +#define SOC_PMCNTENCLR		0xC20
> +#define SOC_PMINTENSET		0xC40
> +#define SOC_PMINTENCLR		0xC60
> +#define SOC_PMOVSCLR		0xC80
> +#define SOC_PMOVSSET		0xCC0
> +
> +#define SOC_PMAUXR0		0xD80
> +#define SOC_PMAUXR1		0xD84
> +#define SOC_PMAUXR2		0xD88
> +#define SOC_PMAUXR3		0xD8C
> +
> +#define SOC_PMCFGR		0xE00
> +#define SOC_PMCR		0xE04
> +#define PMU_PMCR_E		BIT(0)
> +#define PMU_PMCR_P		BIT(1)
> +
> +#define SOC_PMAUTHSTATUS	0xFB8
> +#define SOC_PMDEVARCH		0xFBC
> +#define SOC_PMDEVTYPE		0xFCC
> +#define SOC_PMPIDR4		0xFD0
> +#define SOC_PMPIDR0		0xFE0
> +#define SOC_PMPIDR1		0xFE4
> +#define SOC_PMPIDR2		0xFE8
> +#define SOC_PMPIDR3		0xFEC
> +#define SOC_PMCIDR0		0xFF0
> +#define SOC_PMCIDR1		0xFF4
> +#define SOC_PMCIDR2		0xFF8
> +#define SOC_PMCIDR3		0xFFC

This register map quite clearly follows the Arm CoreSight PMU 
architecture. Nice to see it being used, but would you mind having a go 
at hooking up your imp-def bits to the existing arm_cspmu driver?

Thanks,
Robin.
